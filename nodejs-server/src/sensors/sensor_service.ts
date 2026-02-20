// src/sensors/SensorService.ts
import { format as csvFormat } from '@fast-csv/format';
import { Readable } from 'stream';
import { prisma } from '../prisma/prisma';

export default class SensorService {
   private prisma = prisma; // on réutilise l'instance


  /**
   * Récupère les données des capteurs
   * @param latestOnly - si true, limite aux 100 dernières valeurs
   */
  async getSensors(latestOnly = true): Promise<{ rows: any[]; columns: string[] }> {
    try {
      const rows = await this.prisma.sensorData.findMany({
        orderBy: { time: 'desc' },
        take: latestOnly ? 100 : undefined,
      });

      const columns = rows.length > 0 ? Object.keys(rows[0]) : [];
      return { rows, columns };
    } catch (e) {
      console.error("Erreur SQL :", e);
      return { rows: [], columns: [] };
    }
  }

  /**
   * Sérialise une ligne pour JSON (ex: conversion Date -> ISO)
   */
  serializeRow(row: Record<string, any>, columns: string[]): Record<string, any> {
    const result: Record<string, any> = {};
    for (const col of columns) {
      const val = row[col];
      result[col] = val instanceof Date ? val.toISOString() : val;
    }
    return result;
  }

  /**
   * Sérialise un tableau de lignes
   */
  serializeRows(rows: any[], columns: string[]): any[] {
    return rows.map(row => this.serializeRow(row, columns));
  }

  /**
   * Transforme les données en CSV et renvoie un flux Readable
   */
  toCSVStream(rows: any[], columns: string[]): Readable {
    const csvStream = csvFormat({ headers: columns });
    const readable = Readable.from(this.serializeRows(rows, columns));
    return readable.pipe(csvStream);
  }
}
