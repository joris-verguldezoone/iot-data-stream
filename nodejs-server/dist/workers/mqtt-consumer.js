"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const mqtt_1 = __importDefault(require("mqtt"));
const prisma_1 = require("../prisma/prisma");
const client = mqtt_1.default.connect(process.env.MQTT_BROKER_URL || 'mqtt://mosquitto:1883');
// 🌟 On écoute le topic de la passerelle
const TOPIC_TELEMETRIE = 'v1/gateway/telemetry/#';
client.on('connect', () => {
    console.log('📥 Consumer connecté et en écoute du jumeau numérique...');
    client.subscribe(TOPIC_TELEMETRIE);
});
client.on('message', async (topic, message) => {
    try {
        const payload = JSON.parse(message.toString());
        const virtualTime = new Date(payload.timestamp);
        if (!payload.sensors || !Array.isArray(payload.sensors)) {
            return; // Si le format ne correspond pas, on évite le crash
        }
        // 🌟 On boucle sur les capteurs du tableau
        // 🌟 On boucle sur les capteurs du tableau
        for (const sensor of payload.sensors) {
            const sensorId = Number(sensor.id);
            const sensorValue = parseFloat(sensor.value);
            if (isNaN(sensorId) || isNaN(sensorValue))
                continue;
            console.log(`➔ [DB TRY] Tentative d'insertion pour le capteur ${sensorId} (Valeur: ${sensorValue})...`);
            // Insertion de chaque métrique
            await prisma_1.prisma.sensorData.create({
                data: { sensor_id: sensorId, value: sensorValue, time: virtualTime }
            });
            console.log(`  ✔ [DB SUCCESS] Capteur ${sensorId} inséré avec succès !`);
            await prisma_1.prisma.sensor.update({
                where: { sensor_id: sensorId },
                data: { last_value: sensorValue }
            });
        }
    }
    catch (err) {
        console.error('❌ Erreur d\'ingestion du batch MQTT :', err);
    }
});
