// src/simulation/simulation.controller.ts
import { FastifyInstance } from "fastify";
import SimulationService from "./simulation.service";
import { ExerciseBuilderService, INDUSTRIAL_CITIES, INTEGRATED_PROFILES } from "./exercise-builder.service";
import { prisma } from "../prisma/prisma";
import { UpdateLoadProfileDTO, UpdateLoadProfileSchema } from "../cluster/load-profile.dto";
import { eventsDetails } from '../data_seed/scenarios';
import { Type } from "@sinclair/typebox";

const cityList = Object.keys(INDUSTRIAL_CITIES);
const profileList = Object.keys(INTEGRATED_PROFILES);
const eventList = eventsDetails.map(s => s.id);

export default async function simulationController(fastify: FastifyInstance) {
    let timer: NodeJS.Timeout | undefined = undefined;
    let currentCadenceMs = 5000; 
    
    let virtualMinutesElapsed = 0;
    const ONE_WEEK_MINUTES = 7 * 24 * 60; 

    function stopExistingSimulation() {
        if (timer) {
            clearInterval(timer);
            timer = undefined;
        }
    }

    /**
     * GET /internal/cadence
     * Endpoint prive de synchronisation complete pour le mqtt-producer
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
     * POST /sim/scenarios/run
     * Route unifiee : Tout passe par la querystring pour forcer Swagger UI a afficher les listes deroulantes
     */
    fastify.post('/sim/scenarios/run', {
        schema: {
            tags: ['Simulation'],
            summary: '[RUN] Charger et Demarrer un Scenario d\'Anomalies',
            description: 'Arme le scenario selectionne via le menu deroulant et demarre la boucle automatique.',
            querystring: {
                type: 'object',
                required: ['scenarioId'],
                properties: {
                    scenarioId: {
                        type: 'string',
                        enum: eventList, 
                        description: 'Identifiant du scenario d\'anomalies a charger'
                    },
                    cadence: { 
                        type: 'number', 
                        enum: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 
                        default: 5, 
                        description: 'Vitesse de la boucle (secondes par tick)' 
                    },
                    tickDuration: { 
                        type: 'string', 
                        enum: ['5', '10', '15', '20', '25', '30', '1h'], 
                        default: '1h', 
                        description: 'Pas de temps virtuel par tick' 
                    },
                    startDate: { 
                        type: 'string', 
                        description: 'Optionnel - Date de depart (Format ISO)' 
                    }
                }
            }
        }
    }, async (req, reply) => {
        const { scenarioId, cadence, tickDuration, startDate } = req.query as any;
        const cadenceSeconds = cadence ?? 5;
        const duration = tickDuration ?? '1h';

        stopExistingSimulation();
        virtualMinutesElapsed = 0;

        let start = new Date("2026-05-18T00:00:00.000Z");
        if (startDate) {
            const parsedDate = new Date(startDate);
            if (!isNaN(parsedDate.getTime())) {
                start = parsedDate;
            }
        }
        SimulationService.setClock(start);

        try {
            await fastify.scenarioService.loadScenario(scenarioId);
            console.log(`[OK] Scenario [${scenarioId}] injecte avec succes.`);
        } catch (err: any) {
            return reply.status(404).send({ 
                status: 'error', 
                message: `Impossible de charger le scenario : ${err.message}` 
            });
        }

        currentCadenceMs = cadenceSeconds * 1000;
        let minutesPerTick = 60;
        if (duration !== '1h') {
            minutesPerTick = parseInt(duration, 10) || 60;
        }

        timer = setInterval(async () => {
            try {
                const service = new SimulationService(prisma, fastify.io, fastify.scenarioService);
                await service.simulateTick({ tickDuration: duration });
                
                virtualMinutesElapsed += minutesPerTick;
                
                if (virtualMinutesElapsed >= ONE_WEEK_MINUTES) {
                    clearInterval(timer);
                    timer = undefined;
                    fastify.io.emit('simulation_auto_stopped', {
                        reason: '1_week_completed',
                        message: `[DONE] Fin automatique du benchmark pour le scenario ${scenarioId} : 1 semaine ecoulee.`
                    });
                }
            } catch (err) {
                fastify.log.error(err);
            }
        }, currentCadenceMs);

        return {
            status: 'success',
            message: `Scenario [${scenarioId}] arme et simulation lancee.`,
            setup: {
                scenarioActive: scenarioId,
                cadenceMs: currentCadenceMs,
                tickDuration: duration,
                startedAt: start.toISOString()
            }
        };
    });

    /**
     * POST /sim/scenarios/marseille
     */
    fastify.post<{ Querystring: { cadence?: number; tickDuration?: string; startDate?: string } }>('/sim/scenarios/marseille', {
        schema: { 
            tags: ['Simulation'], 
            description: 'Arme le scenario de Marseille et demarre la boucle automatique',
            querystring: {
                type: 'object',
                properties: {
                    cadence: { type: 'number', enum: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], default: 5 },
                    tickDuration: { type: 'string', enum: ['5', '10', '15', '20', '25', '30', '1h'], default: '1h' },
                    startDate: { type: 'string' }
                }
            }
        }
    }, async (req, reply) => {
        const cadenceSeconds = req.query.cadence ?? 5;
        const tickDuration = req.query.tickDuration ?? '1h';

        stopExistingSimulation();

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
                message: "Le scenario [sc_marseille_gpu_melt] est introuvable." 
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
                await service.simulateTick({ tickDuration });
                
                virtualMinutesElapsed += minutesPerTick;
                
                if (virtualMinutesElapsed >= ONE_WEEK_MINUTES) {
                    clearInterval(timer);
                    timer = undefined; 
                    fastify.io.emit('simulation_auto_stopped', { 
                        reason: '1_week_completed',
                        message: "[DONE] Fin du benchmark Marseille : 1 semaine complete s'est ecoulee."
                    });
                }
            } catch (err) {
                fastify.log.error(err);
            }
        }, currentCadenceMs);

        return { 
            status: "success", 
            message: "[OK] Scenario Marseille enclenche", 
            setup: {
                cadence: `${cadenceSeconds}s par tick`,
                virtualTimePerTick: tickDuration,
                startedAt: startDate.toISOString()
            }
        };
    });

    /**
     * POST /sim/scenario/load
     */
    fastify.post<{ Body: { scenarioId: string } }>('/sim/scenario/load', {
        schema: {
            tags: ['Simulation'],
            description: 'Arme un scenario d\'anomalie operationnelle du catalogue',
            body: {
                type: 'object',
                required: ['scenarioId'],
                properties: {
                    scenarioId: { 
                        type: 'string',
                        enum: eventList, 
                        description: 'L\'identifiant du scenario a charger'
                    }
                }
            },
            response: {
                200: {
                    type: 'object',
                    properties: {
                        status: { type: 'string' },
                        message: { type: 'string' }
                    }
                }
            }
        }
    }, async (req, reply) => {
        const { scenarioId } = req.body;
        try {
            await fastify.scenarioService.loadScenario(scenarioId);
            return { status: 'success', message: `Le scenario [${scenarioId}] est charge.` };
        } catch (err: any) {
            return reply.status(404).send({ status: 'error', message: err.message });
        }
    });

    /**
     * POST /sim/tick
     */
    fastify.post<{ Querystring: { tickDuration?: string } }>('/sim/tick', {
        schema: { 
            tags: ['Simulation'], 
            querystring: {
                type: 'object',
                properties: {
                    tickDuration: { type: 'string', enum: ['5', '10', '15', '20', '25', '30', '1h'], default: '1h' }
                }
            }
        }
    }, async (req) => {
        const tickDuration = req.query.tickDuration ?? '1h';
        const service = new SimulationService(prisma, fastify.io, fastify.scenarioService);
        await service.simulateTick({ tickDuration });
        return { status: 'success', message: `Pas de temps manuel execute (${tickDuration}).` };
    });

    /**
     * POST /sim/start
     */
    fastify.post<{ Querystring: { cadence?: number; tickDuration?: string; startDate?: string } }>('/sim/start', {
        schema: { 
            tags: ['Simulation'], 
            querystring: {
                type: 'object',
                properties: {
                    cadence: { type: 'number', enum: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], default: 5 },
                    tickDuration: { type: 'string', enum: ['5', '10', '15', '20', '25', '30', '1h'], default: '1h' },
                    startDate: { type: 'string' }
                }
            }
        }
    }, async (req) => {
        stopExistingSimulation();
        virtualMinutesElapsed = 0;
        const cadenceSeconds = req.query.cadence ?? 5;
        const tickDuration = req.query.tickDuration ?? '1h';
        
        try {
            fastify.scenarioService.clearScenario();
        } catch (e) {
            fastify.log.error(e);
        }
        
        let startDate = new Date("2026-05-18T00:00:00.000Z");
        if (req.query.startDate) {
            const parsedDate = new Date(req.query.startDate);
            if (!isNaN(parsedDate.getTime())) {
                startDate = parsedDate;
            }
        }
        SimulationService.setClock(startDate);
        currentCadenceMs = cadenceSeconds * 1000;

        let minutesPerTick = 60;
        if (tickDuration !== '1h') {
            minutesPerTick = parseInt(tickDuration, 10) || 60;
        }

        timer = setInterval(async () => {
            try {
                const service = new SimulationService(prisma, fastify.io, fastify.scenarioService);
                await service.simulateTick({ tickDuration });
                virtualMinutesElapsed += minutesPerTick;
                
                if (virtualMinutesElapsed >= ONE_WEEK_MINUTES) {
                    clearInterval(timer);
                    timer = undefined; 
                }
            } catch (err) {
                fastify.log.error(err);
            }
        }, currentCadenceMs);

        return { status: "Simulation demarree", cadence: `${cadenceSeconds}s` };
    });

    /**
     * POST /sim/stop
     */
    fastify.post('/sim/stop', { schema: { tags: ['Simulation'] } }, async () => {
        if (timer) {
            clearInterval(timer);
            timer = undefined; 
            return { status: "Simulation arretee manuellement.", minutesSimulated: virtualMinutesElapsed };
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
    fastify.post<{ 
        Body: { 
            topology: Array<{ 
                clusterName: string; 
                city: string; 
                configProfile: string; 
                clusterCount: number; 
                nodesOverride?: number 
            }> 
        } 
    }>('/build-exercise', {
        schema: { 
            tags: ['Simulation'],
            summary: '[BUILD] Generer une Topologie Customisee (Sandbox)',
            description: 'Purge le datacenter et recree une topologie sur-mesure.',
            body: {
                type: 'object',
                required: ['topology'],
                properties: {
                    topology: {
                        type: 'array',
                        description: 'Liste des clusters geographiques a instancier',
                        items: {
                            type: 'object',
                            required: ['clusterName', 'city', 'configProfile', 'clusterCount'],
                            properties: {
                                clusterName: { type: 'string', example: 'Marseille-Core-IA', description: 'Nom unique du cluster' },
                                city: { type: 'string', enum: cityList, description: 'Hub physique de deploiement' },
                                configProfile: { type: 'string', enum: profileList, description: 'Profil materiel des serveurs' },
                                clusterCount: { type: 'integer', minimum: 1, default: 1, description: 'Nombre de clusters logiques a deployer' },
                                nodesOverride: { type: 'integer', minimum: 0, description: 'Forcer manuellement un nombre global de serveurs' }
                            }
                        }
                    }
                }
            }
        }
    }, async (req) => {
        stopExistingSimulation();
        const builder = new ExerciseBuilderService(prisma);
        const idealPueReports = await builder.buildSandbox(req.body);
        return { status: 'success', idealTargets: idealPueReports };
    });

    /**
     * POST /sim/maintenance/repair
     */
    fastify.post<{ Body: { fanId: number } }>('/sim/maintenance/repair', {
        schema: {
            tags: ['Simulation'],
            summary: '[MAINTENANCE] Envoyer l\'equipe technique',
            description: 'Declenche une intervention sur un ventilateur en panne avec un delai de 4 ticks.',
            body: Type.Object({
                fanId: Type.Integer({ 
                    description: 'L\'identifiant unique du ventilateur a remplacer',
                    example: 1 
                })
            }),
            response: {
                200: Type.Object({
                    success: Type.Boolean(),
                    message: Type.String()
                })
            }
        }
    }, async (req) => {
        const { fanId } = req.body;
        const service = new SimulationService(prisma, fastify.io, fastify.scenarioService);
        const result = await service.repairFan(Number(fanId));
        return result;
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
        return { status: "DataCenter refroidi et horloge synchronisee." };
    });

    /**
     * POST /sim/hard-reset
     */
    fastify.post('/sim/hard-reset', { schema: { tags: ['Simulation'] } }, async () => {
        stopExistingSimulation();
        fastify.scenarioService.clearScenario();
        SimulationService.resetClock();
        virtualMinutesElapsed = 0;
        const tables = ["sensor_data", "sensor", "fan", "server", "cluster", "cluster_configuration", "fan_configuration", "fan_catalog", "cpucooler_catalog", "load_profile", "cluster_location"];
        for (const table of tables) {
            await prisma.$executeRawUnsafe(`TRUNCATE TABLE "${table}" RESTART IDENTITY CASCADE;`);
        }
        return { status: "Base de données purgee." };
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
        return { message: `Profil horaire ${id} mis a jour.` };
    });

    /**
     * POST /sim/seed-history
     */
    fastify.post('/sim/seed-history', { schema: { tags: ['Simulation'] } }, async () => {
        const builder = new ExerciseBuilderService(prisma);
        const totalRows = await builder.seedHealthyWeekHistory();
        return { status: 'success', message: `Historique genere (${totalRows} lignes).` };
    });

    /**
     * POST /sim/scenario/clear
     */
    fastify.post('/sim/scenario/clear', {
        schema: {
            tags: ['Simulation'],
            description: 'Purge le scenario en cours et reinitialise les derives thermiques'
        }
    }, async () => {
        fastify.scenarioService.clearScenario();
        return { status: "success", message: "Evenements de pannes reinitialises." };
    });
}