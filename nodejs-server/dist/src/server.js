"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
// app.js
const fastify_1 = __importDefault(require("fastify"));
// @ts-ignore
const cors_1 = __importDefault(require("@fastify/cors"));
const sensor_service_1 = __importDefault(require("./sensors/sensor_service"));
const SeedService_1 = __importDefault(require("./seed/SeedService"));
// import csvStringify from 'csv-stringify/lib/sync';
const prisma_1 = require("./prisma/prisma");
require("dotenv/config");
const swagger_1 = __importDefault(require("@fastify/swagger"));
const swagger_ui_1 = __importDefault(require("@fastify/swagger-ui"));
const fastify = (0, fastify_1.default)({ logger: true });
const seedServices = new SeedService_1.default(prisma_1.prisma);
// CORS
fastify.register(cors_1.default, {
    origin: [
        "http://localhost:4200",
        "http://127.0.0.1:4200"
    ],
    credentials: true
});
const sensorService = new sensor_service_1.default();
// Root
fastify.get('/', async (request, reply) => {
    seedServices.seedClusterConfiguration();
    return { Hello: "World" };
});
fastify.get('/sensors', async () => {
    const { rows, columns } = await sensorService.getSensors();
    return sensorService.serializeRows(rows, columns);
});
fastify.get('/download/sensors', async (request, reply) => {
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
fastify.get('/seed/cluster/location', async (request, reply) => {
    await seedServices.seedClusters();
    return { status: 'Cluster seeded' };
});
// Seed computers in clusters
// fastify.get('/seed/cluster/computer', async (request: any, reply: any) => {
//   await seedServices.seedComputersInClusters();
//   return { status: 'Computers seeded in cluster' };
// });
// Seed cluster configuration
fastify.get('/seed/cluster/configuration', async (request, reply) => {
    await seedServices.seedClusterConfiguration();
    return { status: 'Cluster configuration seeded' };
});
// Seed fan configuration
fastify.get('/seed/configuration/fan', async (request, reply) => {
    await seedServices.seedFanConfiguration();
    return { status: 'Fan configuration seeded' };
});
// Start server
const start = async () => {
    try {
        await fastify.register(swagger_1.default, {
            openapi: {
                info: {
                    title: 'Cluster API',
                    description: 'API de gestion des clusters',
                    version: '1.0.0',
                },
            }
        });
        await fastify.register(swagger_ui_1.default, {
            routePrefix: '/docs',
        });
        await fastify.listen({
            port: 3333,
            host: '0.0.0.0'
        });
        console.log('Server running at http://localhost:3333');
    }
    catch (err) {
        fastify.log.error(err);
        process.exit(1);
    }
};
start();
