// nodejs-server/src/workers/consumer.ts
import mqtt from 'mqtt';
import { prisma } from '../prisma/prisma';

const client = mqtt.connect(process.env.MQTT_BROKER_URL || 'mqtt://mosquitto:1883');

client.on('connect', () => {
  console.log('📥 Consumer connecté et en écoute...');
  client.subscribe('sensors/#'); 
});

client.on('message', async (topic, message) => {
  try {
    const data = JSON.parse(message.toString());

    await prisma.sensorData.create({
      data: {
        sensor_id: data.sensor_id,
        value: data.value,
        time: new Date(data.timestamp)
      }
    });

    await prisma.sensor.update({
      where: { sensor_id: data.sensor_id },
      data: { last_value: data.value }
    });

  } catch (err) {
    console.error('❌ Erreur d\'ingestion :', err);
  }
});