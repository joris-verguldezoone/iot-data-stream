import mqtt from 'mqtt';
import { prisma } from '../prisma/prisma';

const client = mqtt.connect(process.env.MQTT_URL || 'mqtt://mosquitto:1883');
const TOPIC_TELEMETRIE = 'v1/gateway/telemetry/#';

// Structure de controle de la memoire tampon
let telemetryBuffer: Array<{ value: number; sensor_id: number; time: Date }> = [];
const BUFFER_MAX_SIZE = 1000;
const FLUSH_INTERVAL_MS = 2000;
let isFlushing = false; // Verrou anti-empilement asynchrone

client.on('connect', () => {
  console.log('📥 Consumer connecte et en ecoute du jumeau numerique...');
  client.subscribe(TOPIC_TELEMETRIE); 
});

// Fonction d'ecriture de masse optimisee
async function flushTelemetryBuffer() {
  // Si le buffer est vide ou qu'un flush est deja en cours, on passe notre tour
  if (telemetryBuffer.length === 0 || isFlushing) return;
  
  isFlushing = true;
  const chunkToWrite = [...telemetryBuffer];
  telemetryBuffer = []; 

  try {
    console.log(`[DB FLUSH] Decoupage et ecriture de ${chunkToWrite.length} points...`);

    // 1. Preparation des valeurs pour l'insertion de l'historique
    const valuesForInsert = chunkToWrite.map(d => 
      `(${d.value}, '${d.time.toISOString()}', ${d.sensor_id})`
    ).join(',');
    
    // Insertion de masse dans sensor_data (Tres rapide)
    await prisma.$executeRawUnsafe(
        `INSERT INTO "sensor_data" (value, time, sensor_id) VALUES ${valuesForInsert}`
    );

    // 2. MISE A JOUR EN MASSE (Bulk Update) de la table sensor
    // On regroupe les valeurs pour faire une mise a jour via une jointure de donnees
    const valuesForUpdate = chunkToWrite.map(d => 
      `(${d.sensor_id}, ${d.value})`
    ).join(',');

    // Cette unique requete met a jour les 1000 capteurs d'un seul coup sans boucler
    await prisma.$executeRawUnsafe(`
      UPDATE "sensor" AS s 
      SET last_value = v.new_value
      FROM (VALUES ${valuesForUpdate}) AS v(sensor_id, new_value)
      WHERE s.sensor_id = v.sensor_id;
    `);

    console.log(`  ✔ [DB SUCCESS] Synchronisation de ${chunkToWrite.length} points complete.`);

  } catch (dbError: any) {
    console.error("[DB ERROR] Echec du traitement du lot :", dbError.message);
  } finally {
    isFlushing = false; // Liberation du verrou
  }
}

// Interception des payloads MQTT en flux tendu
client.on('message', async (topic, message) => {
  try {
    const payload = JSON.parse(message.toString());
    const virtualTime = new Date(payload.timestamp);

    if (!payload.sensors || !Array.isArray(payload.sensors)) {
      return; 
    }

    for (const sensor of payload.sensors) {
      const sensorId = Number(sensor.id);
      const sensorValue = parseFloat(sensor.value);

      if (isNaN(sensorId) || isNaN(sensorValue)) continue;

      telemetryBuffer.push({
        value: sensorValue,
        sensor_id: sensorId,
        time: virtualTime
      });

      // Si le lot est plein, on execute le flush de maniere asynchrone non bloquante
      if (telemetryBuffer.length >= BUFFER_MAX_SIZE) {
        flushTelemetryBuffer();
      }
    }

  } catch (err) {
    console.error('❌ Erreur generale d\'analyse du batch MQTT :', err);
  }
});

// Securite temporelle : Force l'ecriture reguliere
setInterval(async () => {
  await flushTelemetryBuffer();
}, FLUSH_INTERVAL_MS);