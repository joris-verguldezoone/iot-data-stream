"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.default = sensorController;
const sensor_service_1 = __importDefault(require("./sensor.service"));
const sensorService = new sensor_service_1.default();
async function sensorController(fastify) {
    // ══════════════════════════════════════════════
    // LOGS DE DONNÉES (SENSOR DATA)
    // ══════════════════════════════════════════════
    fastify.get('/sensor-data', {
        schema: {
            description: 'Récupère les logs de données capteurs avec filtres optionnels',
            tags: ['SensorData'],
            querystring: {
                type: 'object',
                properties: {
                    sensor_id: { type: 'integer' },
                    from: { type: 'string', format: 'date-time' },
                    to: { type: 'string', format: 'date-time' },
                    limit: { type: 'integer', default: 100 },
                },
            },
            response: {
                200: { type: 'array', items: { $ref: 'SensorData#' } },
            },
        },
        handler: async (req) => {
            const { sensor_id, from, to, limit } = req.query;
            return sensorService.getSensorDataList({
                sensor_id: sensor_id ? Number(sensor_id) : undefined,
                from: from ? new Date(from) : undefined,
                to: to ? new Date(to) : undefined,
                limit: limit ? Number(limit) : 100
            });
        },
    });
    // ══════════════════════════════════════════════
    // EXPORT CSV
    // ══════════════════════════════════════════════
    fastify.get('/download/sensors', {
        schema: {
            description: 'Télécharge les logs au format CSV pour analyse (M2 IA)',
            tags: ['SensorData'],
            response: {
                200: { type: 'string', description: 'Fichier CSV' },
            },
        },
        handler: async (_req, reply) => {
            const { rows, columns } = await sensorService.getSensorDataLogs(false);
            const csvStream = sensorService.toCSVStream(rows, columns);
            return reply
                .header('Content-Type', 'text/csv')
                .header('Content-Disposition', 'attachment; filename="sensor_logs.csv"')
                .send(csvStream);
        },
    });
    // ══════════════════════════════════════════════
    // INSTANCES DE CAPTEURS (SENSORS)
    // ══════════════════════════════════════════════
    fastify.get('/sensors', {
        schema: {
            description: 'Liste tous les capteurs physiques installés sur les serveurs',
            tags: ['Sensors'],
            response: {
                200: { type: 'array', items: { $ref: 'Sensor#' } },
            },
        },
        handler: async () => {
            return sensorService.getPhysicalSensors();
        },
    });
    fastify.post('/sensor-data', {
        schema: {
            description: 'Ajoute manuellement une mesure (utile pour tests)',
            tags: ['SensorData'],
            body: {
                type: 'object',
                required: ['sensor_id', 'value'],
                properties: {
                    sensor_id: { type: 'integer' },
                    value: { type: 'number' },
                    time: { type: 'string', format: 'date-time' },
                },
            },
            response: {
                201: { $ref: 'SensorData#' },
            },
        },
        handler: async (req, reply) => {
            const data = await sensorService.createSensorData(req.body);
            return reply.code(201).send(data);
        },
    });
}
