"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
require("dotenv/config");
const mqtt_1 = __importDefault(require("mqtt"));
const pg_1 = __importDefault(require("pg"));
const adapter_pg_1 = require("@prisma/adapter-pg");
const client_1 = require("@prisma/client");
const pool = new pg_1.default.Pool({ connectionString: process.env.DATABASE_URL });
const adapter = new adapter_pg_1.PrismaPg(pool);
const prisma = new client_1.PrismaClient({ adapter });
const BROKER_URL = process.env.MQTT_URL || "mqtt://mosquitto:1883";
const client = mqtt_1.default.connect(BROKER_URL);
const WEATHER_REFRESH_INTERVAL = 20 * 60 * 1000;
const AC_TARGET = 20.0;
const AC_EFFICIENCY = 0.92;
const globalWeather = {};
let dynamicTelemetryInterval = 5000; // Cadence adaptative initiale (5s)
async function refreshAllCitiesWeather(cities) {
    console.log(`☁️  Mise à jour météo pour ${cities.length} villes...`);
    for (const city of cities) {
        try {
            const url = `https://api.openweathermap.org/data/2.5/weather?q=${city}&units=metric&appid=${process.env.OPENWEATHER_API_KEY}`;
            const response = await fetch(url);
            if (!response.ok)
                throw new Error(`Erreur API pour ${city}`);
            const data = (await response.json());
            globalWeather[city] = data.main.temp;
            console.log(`📍 ${city} : ${data.main.temp}°C`);
            await new Promise(resolve => setTimeout(resolve, 500));
        }
        catch (err) {
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
        try {
            // @ts-ignore
            await prisma.cluster_configuration.updateMany({ where: { name: { contains: 'PARIS' } }, data: { pue: 1.25 } });
            // @ts-ignore
            await prisma.cluster_configuration.updateMany({ where: { name: { contains: 'MARSEILLE' } }, data: { pue: 1.40 } });
            // @ts-ignore
            await prisma.cluster_configuration.updateMany({ where: { name: { contains: 'OSLO' } }, data: { pue: 1.15 } });
            console.log("🛡️  [SELF-HEALING] Valeurs des PUE corrigées avec succès !");
        }
        catch (e) { }
        // 🌟 SÉCURITÉ MÉTEO : On s'affranchit de la base au démarrage en chargeant toutes les villes possibles du TP
        const ALL_POSSIBLE_CITIES = ['Paris', 'Marseille', 'Frankfurt', 'Oslo', 'Dublin'];
        await refreshAllCitiesWeather(ALL_POSSIBLE_CITIES);
        setInterval(() => refreshAllCitiesWeather(ALL_POSSIBLE_CITIES), WEATHER_REFRESH_INTERVAL);
        console.log(`🚀 Simulation initialisée et parée aux changements de topologies dynamiques.`);
        // 🌟 INITIALISATION DE L'HORLOGE VIRTUELLE PROGRESSIVE
        const simulatedDate = new Date();
        const localThermalCache = {};
        // 🌟 BOUCLE THERMIQUE DYNAMIQUE
        async function tick() {
            try {
                // À chaque impulsion, on ajoute 1 heure artificielle dans le futur
                simulatedDate.setHours(simulatedDate.getHours() + 1);
                const currentHour = simulatedDate.getHours();
                // 🌟 CORRECTION MAJEURE : On récupère la topologie en direct de la DB à chaque tick
                const activeServers = await prisma.server.findMany({
                    include: {
                        configuration: { include: { load_profile: true } },
                        sensors: true,
                        cluster: { include: { clusterLocation: true } }
                    }
                });
                // Si l'étudiant purge la base ou reconstruit son exercice, on attend proprement sans crasher
                if (activeServers.length === 0) {
                    console.log(`[${simulatedDate.toLocaleString()}] ⚠️ [PRODUCER] Base de données vide ou en cours de reconstruction... En attente du seeding.`);
                    return;
                }
                // 1. Récupération de la cadence
                try {
                    const cadenceResponse = await fetch("http://api-node:3333/internal/cadence");
                    if (cadenceResponse.ok) {
                        const cadenceData = (await cadenceResponse.json());
                        if (cadenceData.cadenceMs)
                            dynamicTelemetryInterval = cadenceData.cadenceMs;
                    }
                }
                catch (err) { }
                // 2. Récupération des registres de ventilation
                let coolingRegistry = {};
                try {
                    const response = await fetch("http://api-node:3333/internal/control");
                    if (response.ok)
                        coolingRegistry = (await response.json());
                }
                catch (err) { }
                // 3. Génération de la physique asymétrique
                for (const server of activeServers) {
                    const city = server.cluster.clusterLocation.location || "Paris";
                    const location = city.toLowerCase();
                    let tExt = globalWeather[city] || 18.0;
                    if (location.includes("marseille"))
                        tExt = 35.0;
                    else if (location.includes("oslo"))
                        tExt = 12.0;
                    const tAmb = getAmbientTemp(tExt);
                    const profileName = server.configuration?.load_profile?.name || "Standard_Cycle";
                    const currentProfile = await prisma.loadProfile.findUnique({
                        where: { name_hour: { name: profileName, hour: currentHour % 24 } }
                    });
                    let load = currentProfile?.expected_load_percent;
                    if (load === undefined || load === null) {
                        if (location.includes("paris")) {
                            load = 0.25 + 0.55 * Math.sin((((currentHour % 24) - 6) / 24) * 2 * Math.PI);
                        }
                        else if (location.includes("marseille")) {
                            load = 0.45 + 0.15 * Math.sin(((currentHour % 24) / 24) * 2 * Math.PI);
                        }
                        else {
                            load = 0.25 + 0.05 * Math.sin(((currentHour % 24) / 24) * 2 * Math.PI);
                        }
                    }
                    load = Math.max(0.05, Math.min(0.95, load));
                    const targetMax = currentProfile?.target_temp_celsius || 70;
                    const fanSpeed = coolingRegistry[server.hostname] ?? 30;
                    const coolingImpact = (fanSpeed - 30) * 0.25;
                    const targetTemp = tAmb + (load * (targetMax - tAmb)) - coolingImpact;
                    let inertiaFactor = 0.70;
                    if (location.includes("paris"))
                        inertiaFactor = 0.92;
                    else if (location.includes("oslo"))
                        inertiaFactor = 0.40;
                    const previousTemp = localThermalCache[server.hostname];
                    const computedTemp = previousTemp !== undefined
                        ? (previousTemp * inertiaFactor) + (targetTemp * (1 - inertiaFactor))
                        : targetTemp;
                    localThermalCache[server.hostname] = computedTemp;
                    // @ts-ignore
                    const maxConsumption = server.is_master ? (server.configuration?.consomation_per_master || 300) : (server.configuration?.consomation_per_worker || 250);
                    const baseConsumption = maxConsumption * 0.15;
                    const payload = {
                        timestamp: simulatedDate.toISOString(),
                        hostname: server.hostname,
                        environment: { external_city: city, external_temp: tExt.toFixed(1), ambient_dc_temp: tAmb.toFixed(1) },
                        current_fan_speed: fanSpeed,
                        load_percent: (load * 100).toFixed(2),
                        sensors: server.sensors.map(s => {
                            let finalValue = 0;
                            if (s.sensor_type === "CPU_TEMP")
                                finalValue = computedTemp + (Math.random() - 0.5) * 0.4;
                            else if (s.sensor_type === "LOAD")
                                finalValue = load * 100 + (Math.random() - 0.5) * 1.5;
                            else if (s.sensor_type.startsWith("FAN_SPEED"))
                                finalValue = fanSpeed;
                            else if (s.sensor_type === "TOTAL_POWER")
                                finalValue = baseConsumption + (load * (maxConsumption - baseConsumption)) + (fanSpeed * 0.4);
                            return { id: s.sensor_id, type: s.sensor_type, value: finalValue.toFixed(2), unit: s.unit };
                        })
                    };
                    client.publish(`v1/gateway/telemetry/${server.hostname}`, JSON.stringify(payload));
                }
                console.log(`[${simulatedDate.toLocaleString()}] 📤 Batch MQTT transmis avec succès (${activeServers.length} serveurs).`);
            }
            catch (globalError) {
                console.error("❌ CRASH DANS LE TICK DU PRODUCER :", globalError);
            }
            finally {
                setTimeout(tick, dynamicTelemetryInterval);
            }
        }
        setTimeout(tick, dynamicTelemetryInterval);
    });
}
startSimulation().catch(console.error);
