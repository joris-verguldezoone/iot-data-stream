// nodejs-server/src/workers/producer.ts
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

function getAmbientTemp(externalTemp: number): number {
  if (externalTemp <= AC_TARGET) return AC_TARGET;
  return AC_TARGET + (externalTemp - AC_TARGET) * (1 - AC_EFFICIENCY);
}

async function startSimulation() {
  console.log("📡 Connexion au Broker MQTT...");

  client.on("connect", async () => {
    console.log("✅ Connecté au Broker.");

    const ALL_POSSIBLE_CITIES = ['Paris', 'Marseille', 'Frankfurt', 'Oslo', 'Dublin'];
    await refreshAllCitiesWeather(ALL_POSSIBLE_CITIES);
    setInterval(() => refreshAllCitiesWeather(ALL_POSSIBLE_CITIES), WEATHER_REFRESH_INTERVAL);
    
    // 🌟 FIXE : La date simulée commence à minuit pour s'aligner sur l'heure 0 du profil de charge
    const simulatedDate = new Date();
    simulatedDate.setHours(0, 0, 0, 0); 
    
    const localThermalCache: Record<string, number> = {};

    async function tick() {
      try {
        // Variables locales pour stocker l'influence du scénario dynamique en cours
        let loadMultiplier = 1.0;
        let scenarioThermalDrift = 0.0;

        // Vérification du statut de l'API (US 1 + Récupération des modificateurs de scénario)
        try {
          const cadenceResponse = await fetch("http://api-node:3333/internal/cadence");
          if (cadenceResponse.ok) {
            // 🌟 On enrichit le typage pour intercepter les forces du scénario actif
            const cadenceData = (await cadenceResponse.json()) as { 
              cadenceMs: number; 
              isRunning: boolean;
              loadMultiplier?: number;
              thermalDrift?: number;
            };
            
            if (cadenceData.cadenceMs) dynamicTelemetryInterval = cadenceData.cadenceMs;
            if (!cadenceData.isRunning) {
              console.log("💤 [PRODUCER] Simulation en pause. En attente...");
              return; 
            }

            // 🌟 Extraction des modificateurs d'anomalies
            if (cadenceData.loadMultiplier !== undefined) loadMultiplier = cadenceData.loadMultiplier;
            if (cadenceData.thermalDrift !== undefined) scenarioThermalDrift = cadenceData.thermalDrift;
          }
        } catch (err) {
          return;
        }

        simulatedDate.setHours(simulatedDate.getHours() + 1);
        const currentHour = simulatedDate.getHours();

        const activeServers = await prisma.server.findMany({
          include: {
            configuration: { include: { load_profile: true } },
            sensors: true,
            cluster: { include: { clusterLocation: true } }
          }
        });

        if (activeServers.length === 0) return;

        let coolingRegistry: Record<string, number> = {};
        try {
          const response = await fetch("http://api-node:3333/internal/control");
          if (response.ok) coolingRegistry = (await response.json()) as Record<string, number>;
        } catch (err) {}

        for (const server of activeServers) {
          const city = server.cluster.clusterLocation.location || "Paris";
          const location = city.toLowerCase();
          
          let tExt = globalWeather[city] || 18.0;
          if (location.includes("marseille")) tExt = 35.0;
          else if (location.includes("oslo")) tExt = 12.0;
          
          const tAmb = getAmbientTemp(tExt);

          // 🌟 1. DÉCOUPLAGE DE LA CHARGE (MASTER VS WORKER)
          let finalLoad = 0.10; // Par défaut, un Master dort à 10% de charge stable

          if (!server.is_master) {
            // Seuls les Workers subissent les courbes sinusoïdales et les profils de charge lourds
            const profileName = server.configuration?.load_profile?.name || "Standard_Cycle";
            const currentProfile = await prisma.loadProfile.findUnique({
              where: { name_hour: { name: profileName, hour: currentHour % 24 } }
            });

            finalLoad = currentProfile?.expected_load_percent ?? 0.25;
            if (currentProfile?.expected_load_percent === undefined) {
              if (location.includes("paris")) {
                finalLoad = 0.25 + 0.55 * Math.sin((((currentHour % 24) - 6) / 24) * 2 * Math.PI); 
              } else if (location.includes("marseille")) {
                finalLoad = 0.45 + 0.15 * Math.sin(((currentHour % 24) / 24) * 2 * Math.PI);
              }
            }

            // 🌟 MODIFICATEUR DE SCÉNARIO : On applique le pic de charge (ex: op_traffic_surge)
            finalLoad = finalLoad * loadMultiplier;
          }
          finalLoad = Math.max(0.05, Math.min(0.95, finalLoad));

          // 🌟 2. LE PIMENT THERMIQUE (US 3)
          const targetMax = server.is_master ? 55 : (server.configuration?.load_profile?.target_temp_celsius || 92);
          const fanSpeed = coolingRegistry[server.hostname] ?? 30; 
          
          const coolingImpact = (fanSpeed - 30) * 0.4;
          let targetTemp = tAmb + (finalLoad * (targetMax - tAmb)) - coolingImpact;

          const previousTemp = localThermalCache[server.hostname] || 32.0;
          
          let inertiaFactor = server.is_master ? 0.50 : (location.includes("paris") ? 0.92 : 0.60);
          let computedTemp = (previousTemp * inertiaFactor) + (targetTemp * (1 - inertiaFactor));

          // Simulateur de panne matérielle / Surchauffe non régulée
          if (fanSpeed <= 20) { 
            computedTemp = previousTemp + (finalLoad * 8.0);
          }

          // 🌟 MODIFICATEUR DE SCÉNARIO : Injection directe de la dérive thermique (ex: canicule/panne de climatisation)
          computedTemp = computedTemp + scenarioThermalDrift;

          // Limitation physique supérieure (Protection silicium avant destruction)
          computedTemp = Math.min(105.0, Math.max(28.0, computedTemp));
          localThermalCache[server.hostname] = computedTemp;

          // Consommation électrique
          // @ts-ignore
          const maxConsumption = server.is_master ? (server.configuration?.consomation_per_master || 350) : (server.configuration?.consomation_per_worker || 220);
          const baseConsumption = maxConsumption * 0.20; 
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
        
        console.log(`[${simulatedDate.toLocaleString()}] 📤 Télémétrie asymétrique transmise (Masters stables, Workers dynamiques).`);

      } catch (globalError) {
        console.error("❌ CRASH TICK :", globalError);
      } finally {
        setTimeout(tick, dynamicTelemetryInterval);
      }
    }

    setTimeout(tick, dynamicTelemetryInterval);
  });
}

startSimulation().catch(console.error);