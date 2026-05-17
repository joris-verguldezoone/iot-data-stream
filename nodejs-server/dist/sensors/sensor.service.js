"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// src/sensors/sensor.service.ts
const format_1 = require("@fast-csv/format");
const stream_1 = require("stream");
const prisma_1 = require("../prisma/prisma");
class SensorService {
    prisma = prisma_1.prisma;
    // ─────────────────────────────────────────────
    // LECTURE DES DONNÉES (LOGS)
    // ─────────────────────────────────────────────
    /**
     * Récupère les logs bruts pour l'affichage ou l'export
     * Renommé pour éviter la confusion avec la liste des capteurs physiques
     */
    async getSensorDataLogs(latestOnly = true) {
        try {
            const rows = await this.prisma.sensorData.findMany({
                orderBy: { time: 'desc' },
                take: latestOnly ? 100 : undefined,
            });
            const columns = rows.length > 0 ? Object.keys(rows[0]) : [];
            return { rows, columns };
        }
        catch (e) {
            console.error('Erreur lors de la récupération des logs :', e);
            return { rows: [], columns: [] };
        }
    }
    /**
     * Liste filtrée des données capteurs
     */
    async getSensorDataList(filters = {}) {
        const where = {};
        // 2. On ajoute les filtres seulement s'ils existent
        if (filters.sensor_id) {
            where.sensor_id = Number(filters.sensor_id);
        }
        if (filters.from || filters.to) {
            where.time = {};
            if (filters.from)
                where.time.gte = new Date(filters.from);
            if (filters.to)
                where.time.lte = new Date(filters.to);
        }
        return await this.prisma.sensorData.findMany({
            where: where,
            take: Number(filters.limit) || 100,
            orderBy: { time: 'desc' },
        });
    }
    // ─────────────────────────────────────────────
    // GESTION DES CAPTEURS (INSTANCES)
    // ─────────────────────────────────────────────
    /**
     * Récupère la liste des capteurs physiques (pour le frontend)
     */
    async getPhysicalSensors() {
        return await this.prisma.sensor.findMany({
            include: {
                server: true
            }
        });
    }
    // ─────────────────────────────────────────────
    // CRUD SENSOR DATA
    // ─────────────────────────────────────────────
    async createSensorData(data) {
        return await this.prisma.sensorData.create({
            data: {
                sensor_id: data.sensor_id,
                value: data.value,
                time: data.time || new Date(),
            },
        });
    }
    async deleteSensorDataByRange(sensor_id, from, to) {
        return await this.prisma.sensorData.deleteMany({
            where: {
                sensor_id,
                time: { gte: from, lte: to },
            },
        });
    }
    // ─────────────────────────────────────────────
    // UTILITAIRES D'EXPORTATION (Crucial pour M2 IA)
    // ─────────────────────────────────────────────
    /**
     * Prépare les lignes pour la sérialisation JSON
     */
    serializeRows(rows, columns) {
        return rows.map(row => {
            const result = {};
            for (const col of columns) {
                const val = row[col];
                result[col] = val instanceof Date ? val.toISOString() : val;
            }
            return result;
        });
    }
    /**
     * Génère un flux CSV pour le téléchargement
     */
    toCSVStream(rows, columns) {
        const csvStream = (0, format_1.format)({ headers: columns });
        const readable = new stream_1.Readable({
            read() {
                rows.forEach(row => csvStream.write(row));
                csvStream.end();
            },
        });
        // On transforme le flux de formatage en flux de lecture
        return stream_1.Readable.from(csvStream);
    }
    async getSensorHistory(sensorId, minutes, limit) {
        const startTime = new Date(Date.now() - minutes * 60000);
        return await prisma_1.prisma.sensorData.findMany({
            where: {
                sensor_id: sensorId,
                time: { gte: startTime }
            },
            orderBy: { time: 'desc' },
            take: limit,
            select: {
                id: true,
                time: true,
                value: true
            }
        });
    }
}
exports.default = SensorService;
