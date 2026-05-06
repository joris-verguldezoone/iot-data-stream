"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
require("dotenv/config");
const mqtt_1 = __importDefault(require("mqtt"));
const pg_1 = __importDefault(require("pg"));
const adapter_pg_1 = require("@prisma/adapter-pg");
const index_js_1 = require("../prisma/generated/prisma/index.js");
const pool = new pg_1.default.Pool({ connectionString: process.env.DATABASE_URL });
const adapter = new adapter_pg_1.PrismaPg(pool);
const prisma = new index_js_1.PrismaClient({ adapter });
const BROKER_URL = process.env.MQTT_URL || "mqtt://localhost:1883";
const client = mqtt_1.default.connect(BROKER_URL);
// --- PARAMÈTRES ---
const TELEMETRY_INTERVAL = 10000; // 10 secondes (Envoi MQTT)
const WEATHER_REFRESH_INTERVAL = 20 * 60 * 1000; // 20 minutes (Appel API)
const AC_TARGET = 20.0;
const AC_EFFICIENCY = 0.92;
// État global de la météo (température par ville)
const globalWeather = {};
/**
 * Met à jour la météo pour toutes les villes uniques du parc
 */
async function refreshAllCitiesWeather(cities) {
    console.log(`☁️  Mise à jour météo pour ${cities.length} villes...`);
    for (const city of cities) {
        try {
            const url = `https://api.openweathermap.org/data/2.5/weather?q=${city}&units=metric&appid=${process.env.OPENWEATHER_API_KEY}`;
            const response = await fetch(url);
            if (response.status === 429) {
                console.error("🚫 TROP DE REQUÊTES : Ta clé est limitée. Attends 1h.");
                return;
            }
            if (!response.ok)
                throw new Error(`Erreur API pour ${city}`);
            const data = (await response.json());
            globalWeather[city] = data.main.temp;
            console.log(`📍 ${city} : ${data.main.temp}°C`);
            // Petit délai de sécurité entre chaque ville pour ne pas spammer
            await new Promise(resolve => setTimeout(resolve, 500));
        }
        catch (err) {
            console.error(`❌ Échec météo ${city}, utilisation valeur par défaut.`);
            globalWeather[city] = globalWeather[city] || 18.0;
        }
    }
}
function getAmbientTemp(externalTemp) {
    if (externalTemp <= AC_TARGET)
        return AC_TARGET;
    return AC_TARGET + (externalTemp - AC_TARGET) * (1 - AC_EFFICIENCY);
}
async function startSimulation() {
    console.log("📡 Connexion au Broker MQTT...");
    client.on("connect", async () => {
        console.log("✅ Connecté au Broker.");
        const servers = await prisma.server.findMany({
            include: {
                configuration: { include: { load_profile: true } },
                sensors: true,
                cluster: { include: { clusterLocation: true } }
            }
        });
        // 1. Extraire les villes uniques
        const uniqueCities = Array.from(new Set(servers.map(s => s.cluster.clusterLocation.location || "Paris")));
        // 2. Premier appel météo IMMÉDIAT
        await refreshAllCitiesWeather(uniqueCities);
        // 3. Cycle de mise à jour météo (Toutes les 20 minutes)
        setInterval(() => refreshAllCitiesWeather(uniqueCities), WEATHER_REFRESH_INTERVAL);
        console.log(`🚀 Simulation lancée pour ${servers.length} serveurs.`);
        // 4. Cycle de télémétrie (Toutes les 10 secondes)
        setInterval(async () => {
            const currentHour = new Date().getHours();
            for (const server of servers) {
                const city = server.cluster.clusterLocation.location || "Paris";
                // On lit la température dans l'objet global (Pas d'appel API ici !)
                const tExt = globalWeather[city] || 18.0;
                const tAmb = getAmbientTemp(tExt);
                const profileName = server.configuration?.load_profile?.name || "Standard_Cycle";
                const currentProfile = await prisma.loadProfile.findUnique({
                    where: { name_hour: { name: profileName, hour: currentHour } }
                });
                const load = currentProfile?.expected_load_percent || 0.2;
                const targetMax = currentProfile?.target_temp_celsius || 70;
                const baseTemp = tAmb + (load * (targetMax - tAmb));
                const payload = {
                    timestamp: new Date().toISOString(),
                    hostname: server.hostname,
                    environment: {
                        external_city: city,
                        external_temp: tExt.toFixed(1),
                        ambient_dc_temp: tAmb.toFixed(1)
                    },
                    load_percent: (load * 100).toFixed(2),
                    sensors: server.sensors.map(s => ({
                        id: s.sensor_id,
                        type: s.sensor_type,
                        value: (baseTemp + (Math.random() - 0.5) * 2).toFixed(2),
                        unit: s.unit
                    }))
                };
                client.publish(`v1/gateway/telemetry/${server.hostname}`, JSON.stringify(payload));
            }
            console.log(`[${new Date().toLocaleTimeString()}] 📤 Batch envoyé.`);
        }, TELEMETRY_INTERVAL);
    });
}
startSimulation().catch(console.error);
