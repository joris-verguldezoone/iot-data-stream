// app.js
import Fastify from 'fastify';
// @ts-ignore
import cors from '@fastify/cors';
import  SensorService  from './sensors/sensor_service';
import SeedService from './seed/SeedService';
import { pipeline, Readable } from 'stream';
// @ts-ignore
import { format } from '@fast-csv/format';
// import csvStringify from 'csv-stringify/lib/sync';
import {prisma} from './prisma/prisma'
import 'dotenv/config'
import swagger from '@fastify/swagger';
import swaggerUi from '@fastify/swagger-ui';

const fastify = Fastify({ logger: true });
const seedServices = new SeedService(prisma);
// CORS
fastify.register(cors, {
  origin: [
    "http://localhost:4200",
    "http://127.0.0.1:4200"
  ],
  credentials: true
});



const sensorService = new SensorService();

// Root
fastify.get('/', async (request: any, reply: any) => {
  seedServices.seedClusterConfiguration();
  return { Hello: "World" };
});

fastify.get('/sensors', async () => {
  const { rows, columns } = await sensorService.getSensors();
  return sensorService.serializeRows(rows, columns);
});

fastify.get('/download/sensors', async (request: any, reply: any) => {
  const { rows, columns } = await sensorService.getSensors(false);
  const csvStream = sensorService.toCSVStream(rows, columns);

  reply
    .header('Content-Type', 'text/csv')
    .header('Content-Disposition', 'attachment; filename="sensors.csv"')
    .send(csvStream);
});

// Seed DB plus besoin avec l'orm
// fastify.get('/seed/db', async (request: any, reply: any) => {
//   await seedDb();
//   return { status: 'Database seeded' };
// });

// Seed cluster location
fastify.get('/seed/cluster/location', async (request: any, reply: any) => {
  await seedServices.seedClusters();
  return { status: 'Cluster seeded' };
});

// Seed computers in clusters
// fastify.get('/seed/cluster/computer', async (request: any, reply: any) => {
//   await seedServices.seedComputersInClusters();
//   return { status: 'Computers seeded in cluster' };
// });

// Seed cluster configuration
fastify.get('/seed/cluster/configuration', async (request: any, reply: any) => {
  await seedServices.seedClusterConfiguration();
  return { status: 'Cluster configuration seeded' };
});

// Seed fan configuration
fastify.get('/seed/configuration/fan', async (request: any, reply: any) => {
  await seedServices.seedFanConfiguration();
  return { status: 'Fan configuration seeded' };
});

// Start server
const start = async () => {
  try {
    await fastify.register(swagger, {
      openapi: {
        info: {
          title: 'Cluster API',
          description: 'API de gestion des clusters',
          version: '1.0.0',
        },
      }});

      await fastify.register(swaggerUi, {
        routePrefix: '/docs',
      });

    await fastify.listen({ 
      port: 3333, 
      host: '0.0.0.0'  
    });    
    console.log('Server running at http://localhost:3333');
  } catch (err) {
    fastify.log.error(err);
    process.exit(1);
  }
};

start();
