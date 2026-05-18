"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.default = simulationController;
const simulation_service_1 = __importDefault(require("./simulation.service"));
const exercise_builder_service_1 = require("./exercise-builder.service");
const prisma_1 = require("../prisma/prisma");
const load_profile_dto_1 = require("../cluster/load-profile.dto");
async function simulationController(fastify) {
    let timer = undefined;
    let currentCadenceMs = 5000; // Variable globale partagée (5s par défaut)
    // 🌟 SUIVI TEMPOREL POUR L'AUTO-STOP
    let virtualMinutesElapsed = 0;
    const ONE_WEEK_MINUTES = 7 * 24 * 60; // 10 080 minutes (7 jours)
    /**
     * GET /internal/cadence
     * Endpoint privé de synchronisation complète pour le mqtt-producer (US 1 & 3)
     */
    fastify.get('/internal/cadence', { schema: { hide: true } }, async () => {
        return {
            cadenceMs: currentCadenceMs,
            isRunning: timer !== undefined,
            // 🌟 Appels conformes aux types de ton ScenarioService
            loadMultiplier: fastify.scenarioService.getLoadMultiplier(),
            thermalDrifts: fastify.scenarioService.getAllThermalDrifts()
        };
    });
    /**
     * POST /sim/tick
     * Exécute un pas de temps manuel avec durée de tick ajustable
     */
    fastify.post('/sim/tick', {
        schema: {
            tags: ['Simulation'],
            description: 'Exécute un pas de temps manuel de la physique du datacenter',
            querystring: {
                type: 'object',
                properties: {
                    persist: { type: 'boolean', default: false, description: 'Si true, enregistre la télémétrie' },
                    tickDuration: {
                        type: 'string',
                        enum: ['5', '10', '15', '20', '25', '30', '1h'],
                        default: '1h',
                        description: 'Durée virtuelle représentée par ce pas de temps'
                    }
                }
            }
        }
    }, async (req) => {
        const persist = req.query.persist === true;
        const tickDuration = req.query.tickDuration ?? '1h';
        const service = new simulation_service_1.default(prisma_1.prisma, fastify.io, fastify.scenarioService);
        await service.simulateTick({ persist, tickDuration });
        return { status: 'success', message: `Pas de temps manuel exécuté (${tickDuration}).` };
    });
    /**
     * POST /sim/start
     * Démarre la simulation automatique (S'arrête TOUTE SEULE après 1 semaine virtuelle)
     */
    fastify.post('/sim/start', {
        schema: {
            tags: ['Simulation'],
            description: 'Démarre la boucle de simulation automatique (Idempotente : purge les scénarios et pannes en cours)',
            querystring: {
                type: 'object',
                properties: {
                    persist: { type: 'boolean', default: false, description: 'Si true, enregistre les métriques dans TimescaleDB' },
                    cadence: { type: 'number', enum: [3, 4, 5, 6, 7, 8, 9, 10], default: 5, description: 'Fréquence de rafraîchissement en secondes' },
                    tickDuration: { type: 'string', enum: ['5', '10', '15', '20', '25', '30', '1h'], default: '1h', description: 'Durée virtuelle d\'un tick' },
                    startDate: { type: 'string', description: 'Date de début personnalisée (US 2)' }
                }
            }
        }
    }, async (req) => {
        const persist = req.query.persist === true;
        const cadenceSeconds = req.query.cadence ?? 5;
        const tickDuration = req.query.tickDuration ?? '1h';
        const startDateParam = req.query.startDate;
        // 🌟 SÉCURITÉ & IDEMPOTENCE : Si un métronome tourne déjà, on le coupe cleanly
        if (timer) {
            clearInterval(timer);
            timer = undefined;
        }
        // 🌟 US 1 : NETTOYAGE DES ANOMALIES EN COURS
        try {
            fastify.scenarioService.clearScenario();
            fastify.log.info("♻️ [START-SEAL] Nettoyage préemptif des pannes et scénarios résiduels réussi.");
        }
        catch (scenarioError) {
            fastify.log.error({ err: scenarioError }, "⚠️ Impossible de clear le scenarioService au démarrage");
        }
        // US 2 : TRAITEMENT DE LA DATE DYNAMIQUE
        if (startDateParam) {
            const parsedDate = new Date(startDateParam);
            if (!isNaN(parsedDate.getTime())) {
                simulation_service_1.default.setClock(parsedDate);
            }
        }
        // Réinitialisation du compteur de la session
        virtualMinutesElapsed = 0;
        currentCadenceMs = cadenceSeconds * 1000;
        let minutesPerTick = 60;
        if (tickDuration !== '1h') {
            minutesPerTick = parseInt(tickDuration, 10) || 60;
        }
        // Lancement de la boucle
        timer = setInterval(async () => {
            try {
                const service = new simulation_service_1.default(prisma_1.prisma, fastify.io, fastify.scenarioService);
                await service.simulateTick({ persist, tickDuration });
                virtualMinutesElapsed += minutesPerTick;
                if (virtualMinutesElapsed >= ONE_WEEK_MINUTES) {
                    clearInterval(timer);
                    timer = undefined;
                    fastify.io.emit('simulation_auto_stopped', {
                        reason: '1_week_completed',
                        message: "🏁 Fin du benchmark : 1 semaine complète s'est écoulée !"
                    });
                }
            }
            catch (err) {
                fastify.log.error(err);
            }
        }, currentCadenceMs);
        return {
            status: "Simulation démarrée",
            setup: "Clean & Serein (Pannes réinitialisées)",
            cadence: `${cadenceSeconds}s`,
            tickDuration: tickDuration
        };
    });
    /**
     * POST /sim/stop
     * Arrête la simulation manuellement
     */
    fastify.post('/sim/stop', {
        schema: { tags: ['Simulation'], description: 'Arrête le métronome manuellement' }
    }, async () => {
        if (timer) {
            clearInterval(timer);
            timer = undefined;
            return { status: "Simulation arrêtée manuellement.", minutesSimulated: virtualMinutesElapsed };
        }
        return { status: "Aucun cycle actif" };
    });
    /**
     * GET /sim/state
     * Récupère l'état instantané du parc pour l'agent Python
     */
    fastify.get('/sim/state', {
        schema: { tags: ['Simulation'], description: 'Observations pour l\'agent SRE' }
    }, async () => {
        const service = new simulation_service_1.default(prisma_1.prisma, fastify.io, fastify.scenarioService);
        return await service.getAgentState();
    });
    /**
     * POST /build-exercise
     */
    fastify.post('/build-exercise', {
        schema: {
            tags: ['Simulation'],
            body: {
                type: 'object',
                required: ['topology'],
                properties: {
                    topology: {
                        type: 'array',
                        items: {
                            type: 'object',
                            required: ['clusterName', 'city', 'configProfile', 'clusterCount'],
                            properties: {
                                clusterName: { type: 'string' },
                                city: { type: 'string', enum: ['Paris', 'Marseille', 'Frankfurt', 'Oslo', 'Dublin'] },
                                configProfile: { type: 'string' },
                                clusterCount: { type: 'number' },
                                nodesOverride: { type: 'number' }
                            }
                        }
                    }
                }
            }
        }
    }, async (req) => {
        if (timer) {
            clearInterval(timer);
            timer = undefined;
        }
        const builder = new exercise_builder_service_1.ExerciseBuilderService(prisma_1.prisma);
        const idealPueReports = await builder.buildSandbox(req.body);
        return { status: 'success', idealTargets: idealPueReports };
    });
    /**
     * POST /sim/maintenance/repair
     */
    fastify.post('/sim/maintenance/repair', {
        schema: {
            tags: ['Simulation'],
            body: { type: 'object', required: ['fanId'], properties: { fanId: { type: 'number' } } }
        }
    }, async (req, reply) => {
        const { fanId } = req.body;
        const service = new simulation_service_1.default(prisma_1.prisma, fastify.io, fastify.scenarioService);
        const result = await service.repairFan(fanId);
        if (!result.success)
            return reply.status(404).send({ status: 'error', message: result.message });
        return { status: 'success', message: result.message };
    });
    /**
     * POST /sim/reset
     */
    fastify.post('/sim/reset', {
        schema: { tags: ['Simulation'] }
    }, async () => {
        fastify.scenarioService.clearScenario();
        simulation_service_1.default.resetClock();
        virtualMinutesElapsed = 0;
        await prisma_1.prisma.server.updateMany({ data: { status: 'ON' } });
        await prisma_1.prisma.sensor.updateMany({ where: { sensor_type: 'LOAD' }, data: { last_value: 15 } });
        await prisma_1.prisma.sensor.updateMany({ where: { sensor_type: 'CPU_TEMP' }, data: { last_value: 32 } });
        return { status: "DataCenter refroidi et horloge synchronisée." };
    });
    /**
     * POST /sim/hard-reset
     */
    fastify.post('/sim/hard-reset', {
        schema: { tags: ['Simulation'] }
    }, async () => {
        if (timer) {
            clearInterval(timer);
            timer = undefined;
        }
        fastify.scenarioService.clearScenario();
        simulation_service_1.default.resetClock();
        virtualMinutesElapsed = 0;
        const tables = ["sensor_data", "sensor", "fan", "server", "cluster", "cluster_configuration", "fan_configuration", "fan_catalog", "cpucooler_catalog", "load_profile", "cluster_location"];
        for (const table of tables) {
            await prisma_1.prisma.$executeRawUnsafe(`TRUNCATE TABLE "${table}" RESTART IDENTITY CASCADE;`);
        }
        return { status: "Base de données purgée." };
    });
    /**
     * PATCH /simulation/load-profiles/:id
     */
    fastify.patch('/simulation/load-profiles/:id', {
        schema: { body: load_profile_dto_1.UpdateLoadProfileSchema }
    }, async (req) => {
        const { id } = req.params;
        const { expected_load_percent } = req.body;
        await prisma_1.prisma.loadProfile.update({ where: { id: Number(id) }, data: { expected_load_percent } });
        return { message: `Profil horaire ${id} mis à jour.` };
    });
    /**
     * POST /sim/seed-history
     */
    fastify.post('/sim/seed-history', {
        schema: { tags: ['Simulation'] }
    }, async () => {
        const builder = new exercise_builder_service_1.ExerciseBuilderService(prisma_1.prisma);
        const totalRows = await builder.seedHealthyWeekHistory();
        return { status: 'success', message: `Historique généré (${totalRows} lignes).` };
    });
}
