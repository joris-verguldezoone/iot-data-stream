import Fastify from 'fastify';
import cors from '@fastify/cors';
import swagger from '@fastify/swagger';
import swaggerUi from '@fastify/swagger-ui';
import { Server } from 'socket.io';
import path from 'path';
import fs from 'fs';
import fastifyStatic from '@fastify/static';
import 'dotenv/config';
import { TypeBoxTypeProvider } from '@fastify/type-provider-typebox';
import { prisma } from './prisma/prisma';

// 1. Import des Schémas (DTOs)
import { ClusterLocationSchema } from './cluster-location/cluster-location.dto';
import { ClusterSchema } from './cluster/cluster.dto';
import { ClusterConfigurationSchema } from './cluster-configuration/cluster-configuration.dto';
import { LoadProfileSchema } from './cluster/load-profile.dto';
import { ServerSchema } from './server/server.dto';
import { SensorSchema, SensorDataSchema, SensorHistoryResponseSchema } from './sensors/sensor.dto';
import { FanCatalogSchema, CpuCoolerCatalogSchema, FanSchema } from './hardware/hardware.dto';

// 2. Import des Services (Singletons d'état)
import { ScenarioService } from './scenario/scenario.service';

// 3. Import des Contrôleurs
import sensorController from './sensors/sensors.controller';
import clusterController from './cluster/cluster.controller';
import seederController from './seed/seed.controller';
import simulationController from './simulation/simulation.controller';
import fanController from './hardware/fan.controller';
import analyticsController from './analytics/analytics.controller';
import agentController from './agent/agent.controller';
import scenarioController from './scenario/scenario.controller'; 

// Extension des types Fastify pour injecter nos Singletons
declare module 'fastify' {
  interface FastifyInstance {
    io: Server;
    scenarioService: ScenarioService;
  }
} 

const fastify = Fastify({ 
  logger: true,
  ajv: {
    customOptions: {
      removeAdditional: "all",
      coerceTypes: true,
      useDefaults: true,
      keywords: ['example'] 
    }
  }
}).withTypeProvider<TypeBoxTypeProvider>();


// 🌟 REGISTRE EN MÉMOIRE VIVE (Partagé entre les routes REST)
const coolingRegistry: Record<string, number> = {};

const start = async () => {
  try {
    // 🌟 REPARE : Détermination ultra-robuste du dossier public (Dev & Prod/Rebuild)
    let publicPath = path.join(process.cwd(), 'public');
    
    // Système de repli si le projet est exécuté depuis un sous-dossier spécifique
    if (!fs.existsSync(path.join(publicPath, 'dashboard.html'))) {
      publicPath = path.join(__dirname, '../public');
    }
    if (!fs.existsSync(path.join(publicPath, 'dashboard.html'))) {
      publicPath = path.join(__dirname, '../../public');
    }

    fastify.log.info(`📁 [STATIC] Dossier public localisé avec succès à : ${publicPath}`);

    // Configuration pour servir les fichiers statiques (Dashboard Front)
    await fastify.register(fastifyStatic, {
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
    await fastify.register(swagger, {
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

    await fastify.register(swaggerUi, { 
      routePrefix: '/docs',
      uiConfig: { docExpansion: 'list', deepLinking: false }
    });

    // 5. Initialisation et Décoration de Socket.IO
    const io = new Server(fastify.server, {
      cors: {
        origin: "*",
        methods: ["GET", "POST"]
      }
    });
    fastify.decorate('io', io);

    // 6. Initialisation et Décoration du Gestionnaire de Scénarios
    const scenarioService = new ScenarioService(prisma, fastify.io);
    fastify.decorate('scenarioService', scenarioService);

    // 7. Gestion du CORS pour les requêtes REST
    await fastify.register(cors, {
      origin: ['http://localhost:4200', 'http://127.0.0.1:4200', 'http://localhost:3000'],
      credentials: true,
    });

    // 8. Enregistrement des Schémas Globaux
    const schemas = [
      LoadProfileSchema,
      FanCatalogSchema,
      CpuCoolerCatalogSchema,
      ClusterLocationSchema,
      ClusterConfigurationSchema,
      ClusterSchema,
      ServerSchema,
      SensorSchema,
      SensorDataSchema,
      SensorHistoryResponseSchema,
      FanSchema
    ];

    schemas.forEach(schema => {
      const schemaId = schema.$id;
      if (schemaId && !fastify.getSchema(schemaId)) {
        fastify.addSchema(schema);
      }
    });

    // 9. Enregistrement des Modules (Contrôleurs)
    await fastify.register(seederController);
    await fastify.register(sensorController);
    await fastify.register(clusterController);
    await fastify.register(simulationController);
    await fastify.register(fanController);
    await fastify.register(analyticsController);
    await fastify.register(agentController);
    await fastify.register(scenarioController); 

    // 🌟 9b. BOUCLE DE RÉTROACTION (Contrôle IA & Communication Inter-Conteneur)
    fastify.post('/api/servers/:hostname/control', async (request, reply) => {
      const { hostname } = request.params as { hostname: string };
      const { fan_speed } = request.body as { fan_speed: number };

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

  } catch (err) {
    fastify.log.error(err);
    process.exit(1);
  }
};

start();