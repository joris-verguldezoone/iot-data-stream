"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.SensorHistoryResponseSchema = exports.SensorHistoryQuerySchema = exports.SensorHistoryParamsSchema = exports.CreateSensorDataSchema = exports.SensorDataFiltersSchema = exports.SensorSchema = exports.SensorDataSchema = void 0;
const typebox_1 = require("@sinclair/typebox");
// --- Schéma de l'objet SensorData (Sortie) ---
exports.SensorDataSchema = typebox_1.Type.Object({
    id: typebox_1.Type.Integer(),
    time: typebox_1.Type.String({ format: 'date-time' }),
    sensor_id: typebox_1.Type.Integer(),
    value: typebox_1.Type.Number(),
}, { $id: 'SensorData' });
// --- Schéma de l'objet Sensor (Sortie) ---
exports.SensorSchema = typebox_1.Type.Object({
    sensor_id: typebox_1.Type.Integer(),
    server_id: typebox_1.Type.Integer(),
    sensor_type: typebox_1.Type.String(),
    unit: typebox_1.Type.String(),
    last_value: typebox_1.Type.Union([typebox_1.Type.Number(), typebox_1.Type.Null()]),
    created_at: typebox_1.Type.String({ format: 'date-time' }),
}, { $id: 'Sensor' });
// --- DTO pour les filtres (GET /sensor-data) ---
exports.SensorDataFiltersSchema = typebox_1.Type.Object({
    sensor_id: typebox_1.Type.Optional(typebox_1.Type.Integer({ example: 2070 })),
    from: typebox_1.Type.Optional(typebox_1.Type.String({ format: 'date-time', example: '2026-04-26T00:00:00Z' })),
    to: typebox_1.Type.Optional(typebox_1.Type.String({ format: 'date-time', example: '2026-04-26T23:59:59Z' })),
    limit: typebox_1.Type.Optional(typebox_1.Type.Integer({ default: 100 })),
});
// --- DTO pour la création (POST /sensor-data) ---
exports.CreateSensorDataSchema = typebox_1.Type.Object({
    sensor_id: typebox_1.Type.Integer(),
    value: typebox_1.Type.Number(),
    time: typebox_1.Type.Optional(typebox_1.Type.String({ format: 'date-time' })),
});
// Extraction des types TS pour les utiliser dans le controller
exports.SensorHistoryParamsSchema = typebox_1.Type.Object({
    id: typebox_1.Type.Integer({ description: "ID du capteur" })
});
exports.SensorHistoryQuerySchema = typebox_1.Type.Object({
    minutes: typebox_1.Type.Optional(typebox_1.Type.Integer({ default: 60, description: "Historique sur X minutes" })),
    limit: typebox_1.Type.Optional(typebox_1.Type.Integer({ default: 100 }))
});
exports.SensorHistoryResponseSchema = typebox_1.Type.Array(typebox_1.Type.Object({
    id: typebox_1.Type.Integer(),
    time: typebox_1.Type.String({ format: 'date-time' }),
    value: typebox_1.Type.Number()
}), { $id: 'SensorHistory' });
