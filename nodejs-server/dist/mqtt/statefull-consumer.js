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
// 🌟 ON REPREND LA CONFIG DU PRODUCER QUI FONCTIONNE
const pool = new pg_1.default.Pool({ connectionString: process.env.DATABASE_URL });
const adapter = new adapter_pg_1.PrismaPg(pool);
const prisma = new client_1.PrismaClient({ adapter });
// Connexion MQTT
const BROKER_URL = process.env.MQTT_BROKER_URL || "mqtt://mosquitto:1883";
const client = mqtt_1.default.connect(BROKER_URL);
client.on("connect", () => {
    console.log("📥 Consumer FULL connecté (Mode: Update + Insert)");
    client.subscribe("v1/gateway/telemetry/#");
});
client.on("message", async (topic, message) => {
    try {
        const payload = JSON.parse(message.toString());
        const timestamp = new Date(payload.timestamp);
        for (const s of payload.sensors) {
            const val = parseFloat(s.value);
            // 1. Mise à jour temps réel
            await prisma.sensor.update({
                where: { sensor_id: s.id },
                data: { last_value: val }
            });
            // 2. Insertion dans l'historique (Time Series)
            await prisma.sensorData.create({
                data: {
                    sensor_id: s.id,
                    value: val,
                    time: timestamp
                }
            });
        }
        console.log(`[HIST] ${payload.hostname} enregistré.`);
    }
    catch (err) {
        console.error("❌ Erreur stockage complet:", err);
    }
});
