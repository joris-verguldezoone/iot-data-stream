"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
// src/prisma/seed-telemetry.ts
require("dotenv/config"); // 🚨 REQUIS pour charger le fichier .env en mode autonome !
const prisma_1 = require("./prisma");
const lodash_1 = __importDefault(require("lodash"));
async function main() {
    console.log("⏳ [SEED] Début de la génération de masse de l'historique (7 jours)...");
    // 1. Nettoyage initial uniquement de la table de télémétrie
    console.log("🧹 Purge des anciennes données historiques...");
    await prisma_1.prisma.$executeRawUnsafe('TRUNCATE TABLE "sensor_data" RESTART IDENTITY;');
    const now = new Date();
    const startTime = new Date(now.getTime() - 7 * 24 * 60 * 60 * 1000); // -7 jours
    const intervalMs = 30000; // Un point toutes les 30 secondes
    let currentFakeTime = new Date(startTime);
    let totalPointsGenerated = 0;
    let sqlValuesBuffer = [];
    const BATCH_SIZE = 10000;
    console.log("🏗️  Calcul des trajectoires physiques et écriture asynchrone...");
    while (currentFakeTime < now) {
        const hour = currentFakeTime.getHours();
        // --- 1. SIMULATION DU CONTEXTE OPÉRATIONNEL ---
        const isDaytime = hour >= 9 && hour <= 18;
        const baseLoad = isDaytime ? 85.0 : 20.0;
        const srv1Load = lodash_1.default.clamp(baseLoad + lodash_1.default.random(-5, 5, true), 0, 100);
        const srv2Load = lodash_1.default.clamp(baseLoad + lodash_1.default.random(-4, 6, true), 0, 100);
        const dailyThermalWave = Math.sin(((hour - 8) / 24) * 2 * Math.PI) * 4.0;
        const ambientTempOffset = 22.0 + dailyThermalWave;
        // --- 2. CALCUL DES TEMPÉRATURES CPU ---
        const srv1Temp = lodash_1.default.clamp(ambientTempOffset + (srv1Load * 0.45) + lodash_1.default.random(-0.5, 0.5, true), 32, 85);
        const srv2Temp = lodash_1.default.clamp(ambientTempOffset + (srv2Load * 0.43) + lodash_1.default.random(-0.4, 0.4, true), 32, 85);
        // --- 3. CALCUL DE LA PUISSANCE ÉLECTRIQUE CONSUMÉE ---
        const srv1Power = 100.0 + (srv1Load * 2.2) + ((srv1Temp - 40) * 0.5);
        const srv2Power = 100.0 + (srv2Load * 2.3) + ((srv2Temp - 40) * 0.4);
        // --- 4. MAP DES DONNÉES SUR LES VRAIS IDS DE CAPTEURS ---
        const metrics = [
            { id: 1, val: srv1Temp }, { id: 2, val: srv1Load }, { id: 3, val: srv1Power },
            { id: 4, val: srv2Temp }, { id: 5, val: srv2Load }, { id: 6, val: srv2Power }
        ];
        const timestampIso = currentFakeTime.toISOString();
        for (const metric of metrics) {
            sqlValuesBuffer.push(`(${metric.val.toFixed(2)}, '${timestampIso}', ${metric.id})`);
            totalPointsGenerated++;
        }
        if (sqlValuesBuffer.length >= BATCH_SIZE) {
            await flushChunk(sqlValuesBuffer);
            sqlValuesBuffer = [];
        }
        currentFakeTime = new Date(currentFakeTime.getTime() + intervalMs);
    }
    if (sqlValuesBuffer.length > 0) {
        await flushChunk(sqlValuesBuffer);
    }
    console.log(`\n✅ [SEED COMPLÉTÉ] Télémétrie historique initialisée avec succès !`);
    console.log("📈 Total de lignes de mesures injectées :", totalPointsGenerated);
}
async function flushChunk(chunks) {
    const query = `INSERT INTO "sensor_data" (value, time, sensor_id) VALUES ${chunks.join(',')};`;
    try {
        await prisma_1.prisma.$executeRawUnsafe(query);
    }
    catch (err) {
        console.error("❌ Erreur critique lors de l'écriture du bloc SQL :", err);
        throw err;
    }
}
main()
    .catch((e) => {
    console.error(e);
    process.exit(1);
})
    .finally(async () => {
    await prisma_1.prisma.$disconnect();
});
