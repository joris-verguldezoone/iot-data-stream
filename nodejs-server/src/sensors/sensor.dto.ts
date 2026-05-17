import { Type, Static } from '@sinclair/typebox';

// --- Schéma de l'objet SensorData (Sortie) ---
export const SensorDataSchema = Type.Object({
  id: Type.Integer(),
  time: Type.String({ format: 'date-time' }),
  sensor_id: Type.Integer(),
  value: Type.Number(),
}, { $id: 'SensorData' });

// --- Schéma de l'objet Sensor (Sortie) ---
export const SensorSchema = Type.Object({
  sensor_id: Type.Integer(),
  server_id: Type.Integer(),
  sensor_type: Type.String(),
  unit: Type.String(),
  last_value: Type.Union([Type.Number(), Type.Null()]),
  created_at: Type.String({ format: 'date-time' }),
}, { $id: 'Sensor' });

// --- DTO pour les filtres (GET /sensor-data) ---
export const SensorDataFiltersSchema = Type.Object({
  sensor_id: Type.Optional(Type.Integer({ example: 2070 })),
  from: Type.Optional(Type.String({ format: 'date-time', example: '2026-04-26T00:00:00Z' })),
  to: Type.Optional(Type.String({ format: 'date-time', example: '2026-04-26T23:59:59Z' })),
  limit: Type.Optional(Type.Integer({ default: 100 })),
});

// --- DTO pour la création (POST /sensor-data) ---
export const CreateSensorDataSchema = Type.Object({
  sensor_id: Type.Integer(),
  value: Type.Number(),
  time: Type.Optional(Type.String({ format: 'date-time' })),
});

// Extraction des types TS pour les utiliser dans le controller

export const SensorHistoryParamsSchema = Type.Object({
  id: Type.Integer({ description: "ID du capteur" })
});

export const SensorHistoryQuerySchema = Type.Object({
  minutes: Type.Optional(Type.Integer({ default: 60, description: "Historique sur X minutes" })),
  limit: Type.Optional(Type.Integer({ default: 100 }))
});

export const SensorHistoryResponseSchema = Type.Array(
  Type.Object({
    id: Type.Integer(),
    time: Type.String({ format: 'date-time' }),
    value: Type.Number()
  }),
  { $id: 'SensorHistory' }
);

export type SensorHistoryParams = Static<typeof SensorHistoryParamsSchema>;
export type SensorHistoryQuery = Static<typeof SensorHistoryQuerySchema>;
export type SensorDataFilters = Static<typeof SensorDataFiltersSchema>;
export type CreateSensorData = Static<typeof CreateSensorDataSchema>;


