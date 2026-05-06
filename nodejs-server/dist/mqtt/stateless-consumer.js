"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
require("dotenv/config");
const mqtt_1 = __importDefault(require("mqtt"));
const index_js_1 = require("../prisma/generated/prisma/index.js");
const prisma = new index_js_1.PrismaClient();
const client = mqtt_1.default.connect(process.env.MQTT_BROKER_URL || "mqtt://localhost:1883");
client.on("connect", () => {
    console.log("📥 Consumer LIGHT connecté (Mode: Update Only)");
    client.subscribe("v1/gateway/telemetry/#");
});
client.on("message", async (topic, message) => {
    try {
        const payload = JSON.parse(message.toString());
        // On met à jour chaque capteur présent dans le message
        const updates = payload.sensors.map((s) => prisma.sensor.update({
            where: { sensor_id: s.id },
            data: { last_value: parseFloat(s.value) }
        }));
        await Promise.all(updates);
        console.log(`[RT] ${payload.hostname} mis à jour.`);
    }
    catch (err) {
        console.error("❌ Erreur traitement message:", err);
    }
});
