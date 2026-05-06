"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
// nodejs-server/src/workers/producer.ts
const mqtt_1 = __importDefault(require("mqtt"));
const prisma_1 = require("../prisma/prisma");
const lodash_1 = __importDefault(require("lodash"));
const client = mqtt_1.default.connect(process.env.MQTT_BROKER_URL || 'mqtt://mosquitto:1883');
// nodejs-server/src/workers/producer.ts
async function simulate() {
    console.log("📡 Démarrage du moteur de simulation...");
    setInterval(async () => {
        // ON RECHERCHE LES CAPTEURS À CHAQUE CYCLE
        const sensors = await prisma_1.prisma.sensor.findMany({
            include: { server: { include: { cluster: { include: { clusterLocation: true } } } } }
        });
        if (sensors.length === 0) {
            console.log("⏳ En attente de capteurs en base (Lance /build-exercise)...");
            return;
        }
        for (const sensor of sensors) {
            const baseValue = sensor.last_value || 25;
            const newValue = baseValue + lodash_1.default.random(-1, 1, true);
            const topic = `sensors/${sensor.server.cluster.clusterLocation.name}/${sensor.server.hostname}/${sensor.sensor_type}`;
            const payload = JSON.stringify({
                sensor_id: sensor.sensor_id,
                value: parseFloat(newValue.toFixed(2)),
                timestamp: new Date().toISOString()
            });
            client.publish(topic, payload); // C'EST ICI QUE MQTT EST APPELÉ
        }
    }, 5000);
}
