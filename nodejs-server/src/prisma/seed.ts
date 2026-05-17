import "dotenv/config";
import process from "node:process";
import pg from "pg";
import { PrismaPg } from "@prisma/adapter-pg";
import { PrismaClient } from "./generated/prisma/index.js";

// --- CONFIGURATION DE LA CONNEXION (PRISMA 7) ---
const connectionString = process.env.DATABASE_URL;
if (!connectionString) throw new Error("DATABASE_URL manquante dans le .env");

const pool = new pg.Pool({ connectionString });
const adapter = new PrismaPg(pool);
const prisma = new PrismaClient({ adapter });

// --- PARAMÈTRES DU VOLUME ---
const NB_SERVERS = 70;
const SENSORS_PER_SERVER = 10;
const FANS_PER_SERVER = 2; 
const DAYS_HISTORY = 7;
const MINUTES_STEP = 5; 
const POINTS_PER_SENSOR = (DAYS_HISTORY * 24 * 60) / MINUTES_STEP; // 2016 points par capteur

async function main() {
  console.log("🧨 Nettoyage intégral de la base...");
  // Suppression ordonnée pour respecter les contraintes de clés étrangères
  const tables = [
    "sensor_data",
    "sensor",
    "fan",
    "server",
    "cluster",
    "cluster_configuration",
    "fan_configuration",
    "fan_catalog",
    "cpucooler_catalog",
    "load_profile",
    "cluster_location"
  ];

  // On vide tout et on force le RESTART IDENTITY
  for (const table of tables) {
    await prisma.$executeRawUnsafe(`TRUNCATE TABLE "${table}" RESTART IDENTITY CASCADE;`);
  }

  console.log("🏗️  Reconstruction du monde IoT avec des IDs tout neufs (commençant à 1)...");
  // 1. Profils de Charge (24h)
  console.log("📈 Génération des profils horaires...");
  let firstProfileId: number | undefined;

  for (let h = 0; h < 24; h++) {
    const profile = await prisma.loadProfile.create({
      data: {
        name: "Standard_Cycle",
        hour: h,
        expected_load_percent: (h >= 9 && h <= 18) ? 0.85 : 0.25,
        target_temp_celsius: (h >= 9 && h <= 18) ? 75 : 42,
        standard_fan_speed: (h >= 9 && h <= 18) ? "HIGH" : "LOW"
      }
    });
    
    // On capture l'ID de l'heure 0 pour l'associer à la config
    if (h === 0) firstProfileId = profile.id;
  }

  // 2. Catalogues et Localisation
  console.log("📦 Création des catalogues...");
  const fanCat = await prisma.fanCatalog.create({
    data: { model_name: "Noctua_NF_A12", consomation: 12.0 }
  });

  const coolerCat = await prisma.cpuCoolerCatalog.create({
    data: { model_name: "BeQuiet_Dark_Rock_4", type: "AIR", thermal_capacity: 200 }
  });

  const fanConfig = await prisma.fanConfiguration.create({
    data: { name: "Adaptive_Silent_Mode", consomation: 6.5 }
  });

  const loc = await prisma.clusterLocation.create({
    data: { name: "Datacenter_Paris_Sud", cluster_count: 1 }
  });

  // 3. Configuration du Cluster (Correction du load_profile_id NULL)
  const clusterConfig = await prisma.clusterConfiguration.create({
    data: {
      name: "Standard_Compute_Node",
      master: 0,
      worker: 1,
      cpu_cooler_catalog_id: coolerCat.cpu_cooler_catalog_id,
      fan_catalog_id: fanCat.fan_catalog_id,
      fan_id: fanConfig.fan_id, 
      location_id: loc.location_id,
      load_profile_id: firstProfileId // FIX : Plus de NULL ici
    }
  });

  const cluster = await prisma.cluster.create({
    data: { name: "Production_Cluster_01", cluster_location_id: loc.location_id }
  });

  // 4. Génération Massive des Instances et de l'Historique
  console.log(`🚀 Injection massive : ${NB_SERVERS} serveurs et ~1.4M points...`);
  const now = new Date();

  for (let i = 0; i < NB_SERVERS; i++) {
    const server = await prisma.server.create({
      data: {
        hostname: `srv-${i.toString().padStart(3, '0')}`,
        cluster_id: cluster.cluster_id,
        config_id: clusterConfig.cluster_config_id,
        status: "ON"
      }
    });

    // Ventilateurs physiques
    for (let f = 0; f < FANS_PER_SERVER; f++) {
      await prisma.fan.create({
        data: {
          server_id: server.server_id,
          fan_catalog_id: fanCat.fan_catalog_id,
          fan_config_id: fanConfig.fan_id,
          status: "ON",
          speed_percent: 45
        }
      });
    }

    // Capteurs et Télémétrie
    for (let j = 0; j < SENSORS_PER_SERVER; j++) {
      const sensor = await prisma.sensor.create({
        data: {
          server_id: server.server_id,
          sensor_type: j === 0 ? "CPU_TEMP" : `CORE_${j}_TEMP`,
          unit: "°C"
        }
      });

      const historyBatch = [];
      for (let p = 0; p < POINTS_PER_SENSOR; p++) {
        historyBatch.push({
          sensor_id: sensor.sensor_id,
          value: 35 + Math.random() * 45,
          time: new Date(now.getTime() - p * MINUTES_STEP * 60000)
        });
      }

      // Insertion par batch pour la performance
      await prisma.sensorData.createMany({ data: historyBatch });
    }
    
    if ((i + 1) % 10 === 0) {
      console.log(`✅ ${i + 1}/${NB_SERVERS} serveurs injectés...`);
    }
  }

  console.log(`\n✨ SEEDING TERMINÉ : ~${(NB_SERVERS * SENSORS_PER_SERVER * POINTS_PER_SENSOR).toLocaleString()} points créés.`);
}

main()
  .catch(console.error)
  .finally(async () => {
    await prisma.$disconnect();
    await pool.end();
});