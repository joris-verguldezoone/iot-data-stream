import { FastifyInstance } from 'fastify';
import SensorService from './sensor.service';
import { 
  SensorDataFiltersSchema, 
  SensorDataFilters, 
  CreateSensorDataSchema, 
  CreateSensorData, 
  SensorHistoryParams,
  SensorHistoryQuery,
  SensorHistoryParamsSchema,
  SensorHistoryQuerySchema
} from './sensor.dto';

const sensorService = new SensorService();

export default async function sensorController(fastify: FastifyInstance) {

  // GET /sensor-data
  fastify.get<{ Querystring: SensorDataFilters }>('/sensor-data', {
    schema: {
      description: 'Récupère les logs de données capteurs avec filtres optionnels',
      tags: ['SensorData'],
      querystring: SensorDataFiltersSchema,
      response: {
        200: { type: 'array', items: { $ref: 'SensorData#' } },
      },
    },
    handler: async (req) => {
      // 1. On récupère les données brutes typées String par le DTO
      const { from, to, sensor_id, limit } = req.query;

      // 2. On "hydrate" l'objet pour le service (Conversion String -> Date / Number)
      return sensorService.getSensorDataList({
        sensor_id, // Déjà un number grâce à TypeBox
        limit,     // Déjà un number grâce à TypeBox
        from: from ? new Date(from) : undefined, // Conversion explicite
        to:   to   ? new Date(to)   : undefined, // Conversion explicite
      });
    },
  });

  // GET /download/sensors
  fastify.get('/download/sensors', {
    schema: {
      description: 'Télécharge les logs au format CSV pour analyse (M2 IA)',
      tags: ['SensorData'],
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

  // GET /sensors
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

  // POST /sensor-data
// POST /sensor-data
  fastify.post<{ Body: CreateSensorData }>('/sensor-data', {
    schema: {
      description: 'Ajoute manuellement une mesure (utile pour tests)',
      tags: ['SensorData'],
      body: CreateSensorDataSchema,
      response: {
        201: { $ref: 'SensorData#' },
      },
    },
    handler: async (req, reply) => {
      // 1. On prépare les données pour le service
      // On propage tout le body, mais on écrase 'time' avec une vraie Date
      const dataForService = {
        ...req.body,
        time: req.body.time ? new Date(req.body.time) : undefined
      };

      // 2. On appelle le service avec le bon type
      const data = await sensorService.createSensorData(dataForService);
      
      return reply.code(201).send(data);
    },
  });

  fastify.get<{ Params: SensorHistoryParams; Querystring: SensorHistoryQuery }>(
    '/sensors/:id/history', 
    {
      schema: {
        description: 'Récupère l\'historique d\'un capteur spécifique',
        tags: ['Sensors'],
        params: SensorHistoryParamsSchema,
        querystring: SensorHistoryQuerySchema,
        response: {
          200: { $ref: 'SensorHistory#' }
        }
      }
    },
    async (req) => {
      const { id } = req.params;
      const { minutes, limit } = req.query;
      
      return await sensorService.getSensorHistory(id, minutes!, limit!);
    }
  );
}

