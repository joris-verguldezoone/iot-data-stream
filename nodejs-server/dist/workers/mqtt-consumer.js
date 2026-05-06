"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
// nodejs-server/src/workers/consumer.ts
const mqtt_1 = __importDefault(require("mqtt"));
const prisma_1 = require("../prisma/prisma");
const client = mqtt_1.default.connect(process.env.MQTT_BROKER_URL || 'mqtt://mosquitto:1883');
client.on('connect', () => {
    console.log('📥 Consumer connecté et en écoute...');
    client.subscribe('sensors/#');
});
client.on('message', async (topic, message) => {
    try {
        const data = JSON.parse(message.toString());
        await prisma_1.prisma.sensorData.create({
            data: {
                sensor_id: data.sensor_id,
                value: data.value,
                time: new Date(data.timestamp)
            }
        });
        await prisma_1.prisma.sensor.update({
            where: { sensor_id: data.sensor_id },
            data: { last_value: data.value }
        });
    }
    catch (err) {
        console.error('❌ Erreur d\'ingestion :', err);
    }
});
