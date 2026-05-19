// src/mqtt/producer.ts
import "dotenv/config";
import mqtt from "mqtt";
import pg from "pg";
import { PrismaPg } from "@prisma/adapter-pg";
import { PrismaClient } from '@prisma/client';
import { OpenWeatherResponse } from "../openweatherapi/interfaces.js";

const pool = new pg.Pool({ connectionString: process.env.DATABASE_URL });
const adapter = new PrismaPg(pool);
const prisma = new PrismaClient({ adapter });

const BROKER_URL = process.env.MQTT_URL || "mqtt://mosquitto:1883";
const client = mqtt.connect(BROKER_URL);

const WEATHER_REFRESH_INTERVAL = 20 * 60 * 1000; 
const AC_TARGET = 20.0;
const AC_EFFICIENCY = 0.92;

const globalWeather: Record<string, number> = {};
let dynamicTelemetryInterval = 5000; 

let fallbackSimulatedDate = new Date("2026-05-18T00:00:00.000Z");

async function refreshAllCitiesWeather(cities: string[]) {
  for (const city of cities) {
    try {
      const url = `https://api.openweathermap.org/data/2.5/weather?q=${city}&units=metric&appid=${process.env.OPENWEATHER_API_KEY}`;
      const response = await fetch(url);
      if (!response.ok) throw new Error();
      const data = (await response.json()) as OpenWeatherResponse;
      globalWeather[city] = data.main.temp;
    } catch (err) {
      globalWeather[city] = globalWeather[city] || 18.0;
    }
  }
}

client.on("connect", async () => {
  console.log("✅ [MQTT-PRODUCER] Connecté au Broker Mosquitto.");

  const ALL_POSSIBLE_CITIES = ['Paris', 'Marseille', 'Frankfurt', 'Oslo', 'Dublin'];
  await refreshAllCitiesWeather(ALL_POSSIBLE_CITIES);
  setInterval(() => refreshAllCitiesWeather(ALL_POSSIBLE_CITIES), WEATHER_REFRESH_INTERVAL);

const runLoop = async () => {
    try {
      let simulatedDate: Date;
      let loadMultiplier = 1.0;
      let thermalDrifts: Record<number, number> = {};
      let isRunning = false; // 🌟 On ajoute le flag d'état

      try {
        const response = await fetch("http://api-node:3333/internal/cadence");
        if (response.ok) {
          const syncData = (await response.json()) as any;
          dynamicTelemetryInterval = syncData.cadenceMs ?? 5000;
          loadMultiplier = syncData.loadMultiplier ?? 1.0;
          thermalDrifts = syncData.thermalDrifts ?? {};
          isRunning = syncData.isRunning ?? false; // 🌟 Récupération du flag depuis l'API Node

          if (syncData.currentSimulatedDate) {
            simulatedDate = new Date(syncData.currentSimulatedDate);
            fallbackSimulatedDate = new Date(simulatedDate); 
          } else {
            fallbackSimulatedDate.setHours(fallbackSimulatedDate.getHours() + 1);
            simulatedDate = new Date(fallbackSimulatedDate);
          }
        } else {
          fallbackSimulatedDate.setHours(fallbackSimulatedDate.getHours() + 1);
          simulatedDate = new Date(fallbackSimulatedDate);
        }
      } catch (apiError) {
        fallbackSimulatedDate.setHours(fallbackSimulatedDate.getHours() + 1);
        simulatedDate = new Date(fallbackSimulatedDate);
      }

      // 🌟 SÉCURITÉ ABSOLUE : Si l'API Node dit que la simulation est sur PAUSE, on n'envoie RIEN !
      if (!isRunning) {
        console.log("💤 [MQTT-PRODUCER] Le jumeau numérique est en pause. En attente d'un top départ...");
        return; // On stoppe l'itération ici, le bloc "finally" replanifiera la vérification au prochain coup
      }

      const activeClusters = await prisma.cluster.findMany({
        include: {
          clusterLocation: true,
          servers: { include: { sensors: true, fans: true } }
        }
      });

      const currentHour = simulatedDate.getHours();

      for (const cluster of activeClusters) {
        const city = cluster.clusterLocation.name;
        const tExt = globalWeather[city] || 18.0;
        const tAmb = AC_TARGET + (tExt - AC_TARGET) * (1 - AC_EFFICIENCY);

        // 🌟 Requête corrigée conforme à la table pivot du schéma
        const profileRow = await prisma.loadProfile.findFirst({
          where: {
            hour: currentHour,
            cluster_configurations: {
              some: {
                cluster_config_id: cluster.cluster_id
              }
            }
          }
        });
        const profileLoadFactor = (profileRow?.expected_load_percent ?? 20) / 100;

        for (const server of cluster.servers) {
          const isMaster = server.hostname.toLowerCase().includes("master");
          
          let finalLoad = isMaster ? 0.12 : profileLoadFactor * loadMultiplier;
          if (finalLoad > 1.0) finalLoad = 1.0;
          if (finalLoad < 0.0) finalLoad = 0.0;

          let totalSpeed = 0;
          let activeFansCount = 0;
          for (const f of server.fans) {
            if (f.status === "ON") {
              totalSpeed += f.speed_percent;
              activeFansCount++;
            }
          }
          const fanSpeed = activeFansCount > 0 ? totalSpeed / server.fans.length : 0;
          const drift = thermalDrifts[server.server_id] ?? 0.0;

          // 🌟 PHYSIQUE THERMIQUE PIMENTÉE ET RÉALISTE DU PRODUCTEUR
          let computedTemp = tAmb + (finalLoad * 55) + drift;

          if (fanSpeed > 0) {
            const coolingPower = (fanSpeed / 100) * 25 * (finalLoad + 0.3);
            computedTemp -= coolingPower;
          }

          if (computedTemp < tAmb) computedTemp = tAmb;
          if (computedTemp > 105.0) computedTemp = 105.0;

          const baseConsumption = 120; 
          const maxConsumption = 450;  
          const currentPower = baseConsumption + (finalLoad * (maxConsumption - baseConsumption)) + (fanSpeed * 0.6);

          const payload = {
            timestamp: simulatedDate.toISOString(),
            hostname: server.hostname,
            environment: { external_city: city, external_temp: tExt.toFixed(1), ambient_dc_temp: tAmb.toFixed(1) },
            current_fan_speed: fanSpeed, 
            load_percent: (finalLoad * 100).toFixed(2),
            sensors: server.sensors.map(s => {
              let finalValue = 0;
              if (s.sensor_type === "CPU_TEMP") finalValue = computedTemp + (Math.random() - 0.5) * 0.3;
              else if (s.sensor_type === "LOAD") finalValue = finalLoad * 100;
              else if (s.sensor_type.startsWith("FAN_SPEED")) finalValue = fanSpeed; 
              else if (s.sensor_type === "TOTAL_POWER") finalValue = currentPower;

              return { id: s.sensor_id, type: s.sensor_type, value: finalValue.toFixed(2), unit: s.unit };
            })
          };

          client.publish(`v1/gateway/telemetry/${server.hostname}`, JSON.stringify(payload));
        }
      }
      
      console.log(`[📤 MQTT] Télémétrie transmise pour la date virtuelle : ${simulatedDate.toISOString()}`);

    } catch (globalError) {
      console.error("❌ CRASH TICK PRODUCER MQTT :", globalError);
    } finally {
      setTimeout(runLoop, dynamicTelemetryInterval);
    }
  };

  setTimeout(runLoop, dynamicTelemetryInterval);
});