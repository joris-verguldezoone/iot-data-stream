import "dotenv/config";
import mqtt from "mqtt";
import { PrismaClient } from "../prisma/generated/prisma/index.js";

const prisma = new PrismaClient();
const client = mqtt.connect(process.env.MQTT_BROKER_URL || "mqtt://localhost:1883");

client.on("connect", () => {
  console.log("📥 Consumer LIGHT connecté (Mode: Update Only)");
  client.subscribe("v1/gateway/telemetry/#");
});

client.on("message", async (topic, message) => {
  try {
    const payload = JSON.parse(message.toString());
    
    // On met à jour chaque capteur présent dans le message
    const updates = payload.sensors.map((s: any) => 
      prisma.sensor.update({
        where: { sensor_id: s.id },
        data: { last_value: parseFloat(s.value) }
      })
    );

    await Promise.all(updates);
    console.log(`[RT] ${payload.hostname} mis à jour.`);
  } catch (err) {
    console.error("❌ Erreur traitement message:", err);
  }
});