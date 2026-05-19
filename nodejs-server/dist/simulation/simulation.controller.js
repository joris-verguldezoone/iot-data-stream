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
    // SUIVI TEMPOREL POUR L'AUTO-STOP
    let virtualMinutesElapsed = 0;
    const ONE_WEEK_MINUTES = 7 * 24 * 60; // 10 080 minutes (7 jours)
    function stopExistingSimulation() {
        if (timer) {
            clearInterval(timer);
            timer = undefined;
        }
    }
    /**
     * GET /internal/cadence
     * Endpoint privé de synchronisation complète pour le mqtt-producer
     */
    fastify.get('/internal/cadence', { schema: { hide: true } }, async () => {
        return {
            cadenceMs: currentCadenceMs,
            isRunning: timer !== undefined,
            loadMultiplier: fastify.scenarioService.getLoadMultiplier(),
            thermalDrifts: fastify.scenarioService.getAllThermalDrifts(),
            currentSimulatedDate: simulation_service_1.default.getClock().toISOString()
        };
    });
    /**
     * POST /sim/scenarios/marseille
     * Lance le scénario Marseille avec cadence, durée de ticks et date de départ ajustables
     */
    fastify.post('/sim/scenarios/marseille', {
        schema: {
            tags: ['Simulation'],
            description: 'Arme le scénario de Marseille à horaire fixe (Lundi par défaut) et démarre la boucle à vitesse configurable',
            querystring: {
                type: 'object',
                properties: {
                    persist: { type: 'boolean', default: false },
                    cadence: { type: 'number', enum: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], default: 5 },
                    tickDuration: { type: 'string', enum: ['5', '10', '15', '20', '25', '30', '1h'], default: '1h' },
                    startDate: { type: 'string' }
                }
            }
        }
    }, async (req, reply) => {
        const persist = req.query.persist !== false;
        const cadenceSeconds = req.query.cadence ?? 5;
        const tickDuration = req.query.tickDuration ?? '1h';
        if (timer) {
            clearInterval(timer);
            timer = undefined;
        }
        // Horaire fixe par défaut au Lundi à 00h00 pile
        let startDate = new Date("2026-05-18T00:00:00.000Z");
        if (req.query.startDate) {
            const parsedDate = new Date(req.query.startDate);
            if (!isNaN(parsedDate.getTime())) {
                startDate = parsedDate;
            }
        }
        simulation_service_1.default.setClock(startDate);
        try {
            await fastify.scenarioService.loadScenario('sc_marseille_gpu_melt');
        }
        catch (err) {
            return reply.status(404).send({
                status: 'error',
                message: "Le scénario [sc_marseille_gpu_melt] est introuvable. Vérifie ton fichier scenarios.json."
            });
        }
        virtualMinutesElapsed = 0;
        currentCadenceMs = cadenceSeconds * 1000;
        let minutesPerTick = 60;
        if (tickDuration !== '1h') {
            minutesPerTick = parseInt(tickDuration, 10) || 60;
        }
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
                        message: "🏁 Fin du benchmark Marseille : 1 semaine complète s'est écoulée !"
                    });
                }
            }
            catch (err) {
                fastify.log.error(err);
            }
        }, currentCadenceMs);
        return {
            status: "success",
            message: "🔥 Scénario Marseille enclenché !",
            setup: {
                cadence: `${cadenceSeconds}s par tick`,
                virtualTimePerTick: tickDuration,
                startedAt: startDate.toISOString()
            }
        };
    });
    /**
     * POST /sim/tick
     */
    fastify.post('/sim/tick', {
        schema: {
            tags: ['Simulation'],
            querystring: {
                type: 'object',
                properties: {
                    persist: { type: 'boolean', default: false },
                    tickDuration: { type: 'string', enum: ['5', '10', '15', '20', '25', '30', '1h'], default: '1h' }
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
     */
    fastify.post('/sim/start', {
        schema: {
            tags: ['Simulation'],
            querystring: {
                type: 'object',
                properties: {
                    persist: { type: 'boolean', default: false },
                    cadence: { type: 'number', enum: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], default: 5 },
                    tickDuration: { type: 'string', enum: ['5', '10', '15', '20', '25', '30', '1h'], default: '1h' },
                    startDate: { type: 'string' }
                }
            }
        }
    }, async (req) => {
        stopExistingSimulation();
        virtualMinutesElapsed = 0;
        const persist = req.query.persist === true;
        const cadenceSeconds = req.query.cadence ?? 5;
        const tickDuration = req.query.tickDuration ?? '1h';
        if (timer) {
            clearInterval(timer);
            timer = undefined;
        }
        try {
            fastify.scenarioService.clearScenario();
        }
        catch (e) {
            fastify.log.error(e);
        }
        // 🌟 CORRECTION : Forcer la date par défaut (Lundi à 00h00) si non fournie dans l'URL
        let startDate = new Date("2026-05-18T00:00:00.000Z");
        if (req.query.startDate) {
            const parsedDate = new Date(req.query.startDate);
            if (!isNaN(parsedDate.getTime())) {
                startDate = parsedDate;
            }
        }
        simulation_service_1.default.setClock(startDate);
        virtualMinutesElapsed = 0;
        currentCadenceMs = cadenceSeconds * 1000;
        let minutesPerTick = 60;
        if (tickDuration !== '1h') {
            minutesPerTick = parseInt(tickDuration, 10) || 60;
        }
        timer = setInterval(async () => {
            try {
                const service = new simulation_service_1.default(prisma_1.prisma, fastify.io, fastify.scenarioService);
                await service.simulateTick({ persist, tickDuration });
                virtualMinutesElapsed += minutesPerTick;
                if (virtualMinutesElapsed >= ONE_WEEK_MINUTES) {
                    clearInterval(timer);
                    timer = undefined;
                }
            }
            catch (err) {
                fastify.log.error(err);
            }
        }, currentCadenceMs);
        return { status: "Simulation démarrée", cadence: `${cadenceSeconds}s` };
    });
    /**
     * POST /sim/stop
     */
    fastify.post('/sim/stop', { schema: { tags: ['Simulation'] } }, async () => {
        if (timer) {
            clearInterval(timer);
            timer = undefined;
            return { status: "Simulation arrêtée manuellement.", minutesSimulated: virtualMinutesElapsed };
        }
        return { status: "Aucun cycle actif" };
    });
    /**
     * GET /sim/state
     */
    fastify.get('/sim/state', { schema: { tags: ['Simulation'] } }, async () => {
        const service = new simulation_service_1.default(prisma_1.prisma, fastify.io, fastify.scenarioService);
        return await service.getAgentState();
    });
    /**
     * POST /build-exercise
     */
    fastify.post('/build-exercise', {
        schema: { tags: ['Simulation'] }
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
        schema: { tags: ['Simulation'] }
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
    fastify.post('/sim/reset', { schema: { tags: ['Simulation'] } }, async () => {
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
    fastify.post('/sim/hard-reset', { schema: { tags: ['Simulation'] } }, async () => {
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
    fastify.post('/sim/seed-history', { schema: { tags: ['Simulation'] } }, async () => {
        const builder = new exercise_builder_service_1.ExerciseBuilderService(prisma_1.prisma);
        const totalRows = await builder.seedHealthyWeekHistory();
        return { status: 'success', message: `Historique généré (${totalRows} lignes).` };
    });
}
