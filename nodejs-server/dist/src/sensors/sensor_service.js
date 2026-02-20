"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// src/sensors/SensorService.ts
const format_1 = require("@fast-csv/format");
const stream_1 = require("stream");
const prisma_1 = require("../prisma/prisma");
class SensorService {
    prisma = prisma_1.prisma; // on réutilise l'instance
    /**
     * Récupère les données des capteurs
     * @param latestOnly - si true, limite aux 100 dernières valeurs
     */
    async getSensors(latestOnly = true) {
        try {
            const rows = await this.prisma.sensorData.findMany({
                orderBy: { time: 'desc' },
                take: latestOnly ? 100 : undefined,
            });
            const columns = rows.length > 0 ? Object.keys(rows[0]) : [];
            return { rows, columns };
        }
        catch (e) {
            console.error("Erreur SQL :", e);
            return { rows: [], columns: [] };
        }
    }
    /**
     * Sérialise une ligne pour JSON (ex: conversion Date -> ISO)
     */
    serializeRow(row, columns) {
        const result = {};
        for (const col of columns) {
            const val = row[col];
            result[col] = val instanceof Date ? val.toISOString() : val;
        }
        return result;
    }
    /**
     * Sérialise un tableau de lignes
     */
    serializeRows(rows, columns) {
        return rows.map(row => this.serializeRow(row, columns));
    }
    /**
     * Transforme les données en CSV et renvoie un flux Readable
     */
    toCSVStream(rows, columns) {
        const csvStream = (0, format_1.format)({ headers: columns });
        const readable = stream_1.Readable.from(this.serializeRows(rows, columns));
        return readable.pipe(csvStream);
    }
}
exports.default = SensorService;
