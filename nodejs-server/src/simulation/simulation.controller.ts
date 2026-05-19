// src/simulation/simulation.controller.ts
import { FastifyInstance } from "fastify";
import SimulationService from "./simulation.service";
import { ExerciseBuilderService } from "./exercise-builder.service";
import { prisma } from "../prisma/prisma";
import { UpdateLoadProfileDTO, UpdateLoadProfileSchema } from "../cluster/load-profile.dto";

export default async function simulationController(fastify: FastifyInstance) {
    let timer: NodeJS.Timeout | undefined = undefined;
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
            currentSimulatedDate: SimulationService.getClock().toISOString()
        };
    });

    /**
     * POST /sim/scenarios/marseille
     * Lance le scénario Marseille avec cadence, durée de ticks et date de départ ajustables
     */
    fastify.post<{ Querystring: { persist?: boolean; cadence?: number; tickDuration?: string; startDate?: string } }>('/sim/scenarios/marseille', {
        schema: { 
            tags: ['Simulation'], 
            description: 'Arme le scénario de Marseille à horaire fixe (Lundi par défaut) et démarre la boucle à vitesse configurable',
            querystring: {
                type: 'object',
                properties: {
                    persist: { type: 'boolean', default: true },
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
        SimulationService.setClock(startDate);

        try {
            await fastify.scenarioService.loadScenario('sc_marseille_gpu_melt');
        } catch (err) {
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
                const service = new SimulationService(prisma, fastify.io, fastify.scenarioService);
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
            } catch (err) {
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
    fastify.post<{ Querystring: { persist?: boolean; tickDuration?: string } }>('/sim/tick', {
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
        
        const service = new SimulationService(prisma, fastify.io, fastify.scenarioService);
        await service.simulateTick({ persist, tickDuration });
        return { status: 'success', message: `Pas de temps manuel exécuté (${tickDuration}).` };
    });

    /**
     * POST /sim/start
     */
    fastify.post<{ Querystring: { persist?: boolean; cadence?: number; tickDuration?: string; startDate?: string } }>('/sim/start', {
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
        } catch (e) {
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
        SimulationService.setClock(startDate);
        
        virtualMinutesElapsed = 0;
        currentCadenceMs = cadenceSeconds * 1000;

        let minutesPerTick = 60;
        if (tickDuration !== '1h') {
            minutesPerTick = parseInt(tickDuration, 10) || 60;
        }

        timer = setInterval(async () => {
            try {
                const service = new SimulationService(prisma, fastify.io, fastify.scenarioService);
                await service.simulateTick({ persist, tickDuration });
                virtualMinutesElapsed += minutesPerTick;
                
                if (virtualMinutesElapsed >= ONE_WEEK_MINUTES) {
                    clearInterval(timer);
                    timer = undefined; 
                }
            } catch (err) {
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
        const service = new SimulationService(prisma, fastify.io, fastify.scenarioService);
        return await service.getAgentState();
    });

    /**
     * POST /build-exercise
     */
    fastify.post<{ Body: { topology: Array<{ clusterName: string; city: string; configProfile: string; clusterCount: number; nodesOverride?: number }> } }>('/build-exercise', {
        schema: { tags: ['Simulation'] }
    }, async (req) => {
        if (timer) {
            clearInterval(timer);
            timer = undefined;
        }
        const builder = new ExerciseBuilderService(prisma);
        const idealPueReports = await builder.buildSandbox(req.body);
        return { status: 'success', idealTargets: idealPueReports };
    });

    /**
     * POST /sim/maintenance/repair
     */
    fastify.post<{ Body: { fanId: number } }>('/sim/maintenance/repair', {
        schema: { tags: ['Simulation'] }
    }, async (req, reply) => {
        const { fanId } = req.body;
        const service = new SimulationService(prisma, fastify.io, fastify.scenarioService);
        const result = await service.repairFan(fanId);
        if (!result.success) return reply.status(404).send({ status: 'error', message: result.message });
        return { status: 'success', message: result.message };
    });

    /**
     * POST /sim/reset
     */
    fastify.post('/sim/reset', { schema: { tags: ['Simulation'] } }, async () => {
        fastify.scenarioService.clearScenario();
        SimulationService.resetClock(); 
        virtualMinutesElapsed = 0; 
        await prisma.server.updateMany({ data: { status: 'ON' } });
        await prisma.sensor.updateMany({ where: { sensor_type: 'LOAD' }, data: { last_value: 15 } });
        await prisma.sensor.updateMany({ where: { sensor_type: 'CPU_TEMP' }, data: { last_value: 32 } });
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
        SimulationService.resetClock();
        virtualMinutesElapsed = 0;
        const tables = ["sensor_data", "sensor", "fan", "server", "cluster", "cluster_configuration", "fan_configuration", "fan_catalog", "cpucooler_catalog", "load_profile", "cluster_location"];
        for (const table of tables) {
            await prisma.$executeRawUnsafe(`TRUNCATE TABLE "${table}" RESTART IDENTITY CASCADE;`);
        }
        return { status: "Base de données purgée." };
    });

    /**
     * PATCH /simulation/load-profiles/:id
     */
    fastify.patch<{ Params: { id: number }; Body: UpdateLoadProfileDTO }>('/simulation/load-profiles/:id', { 
        schema: { body: UpdateLoadProfileSchema } 
    }, async (req) => {
        const { id } = req.params;
        const { expected_load_percent } = req.body;
        await prisma.loadProfile.update({ where: { id: Number(id) }, data: { expected_load_percent } });
        return { message: `Profil horaire ${id} mis à jour.` };
    });

    /**
     * POST /sim/seed-history
     */
    fastify.post('/sim/seed-history', { schema: { tags: ['Simulation'] } }, async () => {
        const builder = new ExerciseBuilderService(prisma);
        const totalRows = await builder.seedHealthyWeekHistory();
        return { status: 'success', message: `Historique généré (${totalRows} lignes).` };
    });
}