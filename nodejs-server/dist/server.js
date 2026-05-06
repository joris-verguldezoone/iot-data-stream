"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
// src/app.ts
const fastify_1 = __importDefault(require("fastify"));
const cors_1 = __importDefault(require("@fastify/cors"));
const swagger_1 = __importDefault(require("@fastify/swagger"));
const swagger_ui_1 = __importDefault(require("@fastify/swagger-ui"));
require("dotenv/config");
const prisma_1 = require("./prisma/prisma");
const SeedService_1 = __importDefault(require("./seed/SeedService"));
// Import des schémas JSON pour la validation
const cluster_location_schema_1 = require("./prisma/schemas/cluster_location.schema");
const cluster_configuration_schema_1 = require("./prisma/schemas/cluster_configuration.schema");
const fan_configuration_schema_1 = require("./prisma/schemas/fan_configuration.schema");
const cluster_schema_1 = require("./prisma/schemas/cluster.schema");
const server_schema_1 = require("./prisma/schemas/server.schema");
const sensor_schema_1 = require("./prisma/schemas/sensor.schema");
const fan_schema_1 = require("./prisma/schemas/fan.schema");
const sensor_data_schema_1 = require("./prisma/schemas/sensor_data.schema");
// Import des contrôleurs
const sensors_controller_1 = __importDefault(require("./sensors/sensors.controller"));
const cluster_controller_1 = __importDefault(require("./cluster/cluster.controller"));
const fastify = (0, fastify_1.default)({ logger: true });
const seedServices = new SeedService_1.default(prisma_1.prisma);
const start = async () => {
    try {
        // 1. Swagger
        await fastify.register(swagger_1.default, {
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
        await fastify.register(swagger_ui_1.default, { routePrefix: '/docs' });
        // 2. CORS
        await fastify.register(cors_1.default, {
            origin: ['http://localhost:4200', 'http://127.0.0.1:4200'],
            credentials: true,
        });
        // 3. Ajout des schémas à Fastify
        fastify.addSchema({ $id: 'ClusterLocation', ...cluster_location_schema_1.ClusterLocationSchema });
        fastify.addSchema({ $id: 'ClusterConfiguration', ...cluster_configuration_schema_1.ClusterConfigurationSchema });
        fastify.addSchema({ $id: 'FanConfiguration', ...fan_configuration_schema_1.FanConfigurationSchema });
        fastify.addSchema({ $id: 'Cluster', ...cluster_schema_1.ClusterSchema });
        fastify.addSchema({ $id: 'Server', ...server_schema_1.ServerSchema });
        fastify.addSchema({ $id: 'Sensor', ...sensor_schema_1.SensorSchema });
        fastify.addSchema({ $id: 'Fan', ...fan_schema_1.FanSchema });
        fastify.addSchema({ $id: 'SensorData', ...sensor_data_schema_1.SensorDataSchema });
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
            handler: async (request) => {
                await seedServices.buildExercise(request.body);
                return {
                    status: 'success',
                    message: `Infrastructure construite pour ${request.body.length} localisations.`
                };
            },
        });
        // 5. Enregistrement des contrôleurs modulaires
        await fastify.register(sensors_controller_1.default);
        await fastify.register(cluster_controller_1.default);
        // 6. Lancement
        await fastify.listen({ port: 3333, host: '0.0.0.0' });
        console.log('🚀 Serveur prêt sur http://localhost:3333');
        console.log('📚 Documentation Swagger sur http://localhost:3333/docs');
    }
    catch (err) {
        fastify.log.error(err);
        process.exit(1);
    }
};
start();
