"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const fastify_1 = __importDefault(require("fastify"));
const cors_1 = __importDefault(require("@fastify/cors"));
const swagger_1 = __importDefault(require("@fastify/swagger"));
const swagger_ui_1 = __importDefault(require("@fastify/swagger-ui"));
const socket_io_1 = require("socket.io");
const path_1 = __importDefault(require("path"));
const fs_1 = __importDefault(require("fs"));
const static_1 = __importDefault(require("@fastify/static"));
require("dotenv/config");
const prisma_1 = require("./prisma/prisma");
// 1. Import des Schémas (DTOs)
const cluster_location_dto_1 = require("./cluster-location/cluster-location.dto");
const cluster_dto_1 = require("./cluster/cluster.dto");
const cluster_configuration_dto_1 = require("./cluster-configuration/cluster-configuration.dto");
const load_profile_dto_1 = require("./cluster/load-profile.dto");
const server_dto_1 = require("./server/server.dto");
const sensor_dto_1 = require("./sensors/sensor.dto");
const hardware_dto_1 = require("./hardware/hardware.dto");
// 2. Import des Services (Singletons d'état)
const scenario_service_1 = require("./scenario/scenario.service");
// 3. Import des Contrôleurs
const sensors_controller_1 = __importDefault(require("./sensors/sensors.controller"));
const cluster_controller_1 = __importDefault(require("./cluster/cluster.controller"));
const seed_controller_1 = __importDefault(require("./seed/seed.controller"));
const simulation_controller_1 = __importDefault(require("./simulation/simulation.controller"));
const fan_controller_1 = __importDefault(require("./hardware/fan.controller"));
const analytics_controller_1 = __importDefault(require("./analytics/analytics.controller"));
const agent_controller_1 = __importDefault(require("./agent/agent.controller"));
const scenario_controller_1 = __importDefault(require("./scenario/scenario.controller"));
const fastify = (0, fastify_1.default)({
    logger: true,
    ajv: {
        customOptions: {
            removeAdditional: "all",
            coerceTypes: true,
            useDefaults: true,
            keywords: ['example']
        }
    }
});
// 🌟 REGISTRE EN MÉMOIRE VIVE (Partagé entre les routes REST)
const coolingRegistry = {};
const start = async () => {
    try {
        // 🌟 REPARE : Détermination ultra-robuste du dossier public (Dev & Prod/Rebuild)
        let publicPath = path_1.default.join(process.cwd(), 'public');
        // Système de repli si le projet est exécuté depuis un sous-dossier spécifique
        if (!fs_1.default.existsSync(path_1.default.join(publicPath, 'dashboard.html'))) {
            publicPath = path_1.default.join(__dirname, '../public');
        }
        if (!fs_1.default.existsSync(path_1.default.join(publicPath, 'dashboard.html'))) {
            publicPath = path_1.default.join(__dirname, '../../public');
        }
        fastify.log.info(`📁 [STATIC] Dossier public localisé avec succès à : ${publicPath}`);
        // Configuration pour servir les fichiers statiques (Dashboard Front)
        await fastify.register(static_1.default, {
            root: publicPath,
            prefix: '/public/',
        });
        // 🌟 REPARE : On passe explicitement le chemin absolu validé pour bypasser les conflits du dossier dist/
        fastify.get('/dashboard', (request, reply) => {
            return reply.sendFile('dashboard.html', publicPath);
        });
        fastify.get('/create', (request, reply) => {
            return reply.sendFile('build-exercise.html', publicPath);
        });
        // 4. Configuration de Swagger (OpenAPI)
        await fastify.register(swagger_1.default, {
            openapi: {
                info: {
                    title: 'DataCenter IoT Simulation API',
                    description: 'Système de monitoring et simulation énergétique avec alertes temps-réel (Socket.IO)',
                    version: '1.4.0',
                },
                tags: [
                    { name: 'Seeder', description: 'Génération de l\'infrastructure' },
                    { name: 'Simulation', description: 'Moteur de ticks et stress-test' },
                    { name: 'Scénarios', description: 'Injections d\'anomalies opérationnelles' },
                    { name: 'Analytics', description: 'Calculs PUE et rentabilité' },
                    { name: 'Sensors', description: 'Gestion des capteurs et historique' },
                ],
            },
        });
        await fastify.register(swagger_ui_1.default, {
            routePrefix: '/docs',
            uiConfig: { docExpansion: 'list', deepLinking: false }
        });
        // 5. Initialisation et Décoration de Socket.IO
        const io = new socket_io_1.Server(fastify.server, {
            cors: {
                origin: "*",
                methods: ["GET", "POST"]
            }
        });
        fastify.decorate('io', io);
        // 6. Initialisation et Décoration du Gestionnaire de Scénarios
        const scenarioService = new scenario_service_1.ScenarioService(prisma_1.prisma, fastify.io);
        fastify.decorate('scenarioService', scenarioService);
        // 7. Gestion du CORS pour les requêtes REST
        await fastify.register(cors_1.default, {
            origin: ['http://localhost:4200', 'http://127.0.0.1:4200', 'http://localhost:3000'],
            credentials: true,
        });
        // 8. Enregistrement des Schémas Globaux
        const schemas = [
            load_profile_dto_1.LoadProfileSchema,
            hardware_dto_1.FanCatalogSchema,
            hardware_dto_1.CpuCoolerCatalogSchema,
            cluster_location_dto_1.ClusterLocationSchema,
            cluster_configuration_dto_1.ClusterConfigurationSchema,
            cluster_dto_1.ClusterSchema,
            server_dto_1.ServerSchema,
            sensor_dto_1.SensorSchema,
            sensor_dto_1.SensorDataSchema,
            sensor_dto_1.SensorHistoryResponseSchema,
            hardware_dto_1.FanSchema
        ];
        schemas.forEach(schema => {
            const schemaId = schema.$id;
            if (schemaId && !fastify.getSchema(schemaId)) {
                fastify.addSchema(schema);
            }
        });
        // 9. Enregistrement des Modules (Contrôleurs)
        await fastify.register(seed_controller_1.default);
        await fastify.register(sensors_controller_1.default);
        await fastify.register(cluster_controller_1.default);
        await fastify.register(simulation_controller_1.default);
        await fastify.register(fan_controller_1.default);
        await fastify.register(analytics_controller_1.default);
        await fastify.register(agent_controller_1.default);
        await fastify.register(scenario_controller_1.default);
        // 🌟 9b. BOUCLE DE RÉTROACTION (Contrôle IA & Communication Inter-Conteneur)
        fastify.post('/api/servers/:hostname/control', async (request, reply) => {
            const { hostname } = request.params;
            const { fan_speed } = request.body;
            if (fan_speed === undefined || fan_speed < 0 || fan_speed > 100) {
                return reply.status(400).send({ error: "fan_speed doit être une valeur entre 0 et 100" });
            }
            coolingRegistry[hostname] = fan_speed;
            fastify.log.info(`🎮 [CONTROL] Serveur: ${hostname} -> Vitesse ventilateur mise à jour à ${fan_speed}%`);
            return { success: true, hostname, fan_speed };
        });
        fastify.get('/internal/control', async (request, reply) => {
            return coolingRegistry;
        });
        // 10. Lancement du serveur
        const port = Number(process.env.PORT) || 3333;
        await fastify.listen({ port, host: '0.0.0.0' });
        fastify.io.on("connection", (socket) => {
            fastify.log.info(`🤝 Client connecté au flux temps-réel (ID: ${socket.id})`);
            socket.on("disconnect", () => {
                fastify.log.info(`👋 Client déconnecté (ID: ${socket.id})`);
            });
        });
        console.log(`
    🚀 SERVEUR DÉMARRÉ - MODE STABLE (MANUAL SOCKET.IO)
    📡 API REST     : http://localhost:${port}
    📚 SWAGGER      : http://localhost:${port}/docs
    🖥️  DASHBOARD    : http://localhost:${port}/dashboard
    🏗️  BUILD PANEL  : http://localhost:${port}/create
    🔌 WEBSOCKETS   : Port ${port} (Prêt pour alertes)
    `);
    }
    catch (err) {
        fastify.log.error(err);
        process.exit(1);
    }
};
start();
