import "dotenv/config";
import mqtt from "mqtt";
import { PrismaClient } from "../prisma/generated/prisma/index.js";

const prisma = new PrismaClient();
const client = mqtt.connect(process.env.MQTT_BROKER_URL || "mqtt://localhost:1883");

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
  } catch (err) {
    console.error("❌ Erreur stockage complet:", err);
  }
});