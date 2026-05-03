// src/app.ts
import Fastify from 'fastify';
import cors from '@fastify/cors';
import swagger from '@fastify/swagger';
import swaggerUi from '@fastify/swagger-ui';
import 'dotenv/config';

import { prisma } from './prisma/prisma';
import SeedService from './seed/SeedService';
import SensorService from './sensors/sensor.service';
import ClusterService from './cluster/cluster.services';

// Import des schémas JSON pour la validation
import { ClusterLocationSchema } from './prisma/schemas/cluster_location.schema';
import { ClusterConfigurationSchema } from './prisma/schemas/cluster_configuration.schema';
import { FanConfigurationSchema } from './prisma/schemas/fan_configuration.schema';
import { ClusterSchema } from './prisma/schemas/cluster.schema';
import { ServerSchema } from './prisma/schemas/server.schema';
import { SensorSchema } from './prisma/schemas/sensor.schema';
import { FanSchema } from './prisma/schemas/fan.schema';
import { SensorDataSchema } from './prisma/schemas/sensor_data.schema';

// Import des contrôleurs
import sensorController from './sensors/sensors.controller';
import clusterController from './cluster/cluster.controller';

const fastify = Fastify({ logger: true });
const seedServices = new SeedService(prisma);

const start = async () => {
  try {
    // 1. Swagger
    await fastify.register(swagger, {
      openapi: {
        info: {
          title: 'DataCenter IoT Simulation API',
          description: 'API de gestion et simulation de clusters pour M2 IA / M1 Cyber',
          version: '1.0.0',
        },
        tags: [
          { name: 'Seeder', description: 'Construction de l\'infrastructure' },
          { name: 'Cluster', description: 'Gestion des serveurs et clusters' },
          { name: 'SensorData', description: 'Logs de télémétrie' },
        ],
      },
    });

    await fastify.register(swaggerUi, { routePrefix: '/docs' });

    // 2. CORS
    await fastify.register(cors, {
      origin: ['http://localhost:4200', 'http://127.0.0.1:4200'],
      credentials: true,
    });

    // 3. Ajout des schémas à Fastify
    fastify.addSchema({ $id: 'ClusterLocation', ...ClusterLocationSchema });
    fastify.addSchema({ $id: 'ClusterConfiguration', ...ClusterConfigurationSchema });
    fastify.addSchema({ $id: 'FanConfiguration', ...FanConfigurationSchema });
    fastify.addSchema({ $id: 'Cluster', ...ClusterSchema });
    fastify.addSchema({ $id: 'Server', ...ServerSchema });
    fastify.addSchema({ $id: 'Sensor', ...SensorSchema });
    fastify.addSchema({ $id: 'Fan', ...FanSchema });
    fastify.addSchema({ $id: 'SensorData', ...SensorDataSchema });

    // 4. Routes Spéciales (Builder)
    fastify.post('/build-exercise', {
      schema: {
        description: 'Génère l\'infrastructure physique complète à partir des localisations',
        tags: ['Seeder'],
        body: {
          type: 'array',
          items: {
            type: 'object',
            required: ['name', 'city', 'envFactor', 'clusterCount'],
            properties: {
              name: { type: 'string' },
              city: { type: 'string' },
              envFactor: { type: 'number' },
              clusterCount: { type: 'number' }
            }
          }
        },
        response: {
          200: {
            type: 'object',
            properties: {
              status: { type: 'string' },
              message: { type: 'string' }
            },
          }
        },
      },
      handler: async (request: any) => {
        await seedServices.buildExercise(request.body);
        return { 
          status: 'success', 
          message: `Infrastructure construite pour ${request.body.length} localisations.` 
        };
      },
    });

    // 5. Enregistrement des contrôleurs modulaires
    await fastify.register(sensorController);
    await fastify.register(clusterController);

    // 6. Lancement
    await fastify.listen({ port: 3333, host: '0.0.0.0' });
    console.log('🚀 Serveur prêt sur http://localhost:3333');
    console.log('📚 Documentation Swagger sur http://localhost:3333/docs');

  } catch (err) {
    fastify.log.error(err);
    process.exit(1);
  }
};

start();