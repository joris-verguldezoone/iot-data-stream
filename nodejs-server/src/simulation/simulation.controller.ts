import { FastifyInstance } from "fastify";
import SimulationService from "./simulation.service";
import { ExerciseBuilderService } from "./exercise-builder.service";
import { prisma } from "../prisma/prisma";
import { UpdateLoadProfileDTO, UpdateLoadProfileSchema } from "../cluster/load-profile.dto";

export default async function simulationController(fastify: FastifyInstance) {
    let timer: NodeJS.Timeout | null = null;
    let currentCadenceMs = 5000; // Variable globale partagée (5s par défaut)

    /**
     * GET /internal/cadence
     * Endpoint privé pour synchroniser le conteneur mqtt-producer
     */
    fastify.get('/internal/cadence', { schema: { hide: true } }, async () => {
        return { cadenceMs: currentCadenceMs };
    });

    /**
     * POST /sim/tick
     * Exécute un pas de temps manuel avec durée de tick ajustable
     */
    fastify.post<{ Querystring: { persist?: boolean; tickDuration?: string } }>('/sim/tick', {
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
        
        const service = new SimulationService(prisma, fastify.io, fastify.scenarioService);
        await service.simulateTick({ persist, tickDuration });
        return { status: 'success', message: `Pas de temps manuel exécuté (${tickDuration}).` };
    });

    /**
     * POST /sim/start
     * Démarre la simulation automatique (Métronome et échelle de temps ajustables)
     */
    fastify.post<{ Querystring: { persist?: boolean; cadence?: number; tickDuration?: string } }>('/sim/start', {
        schema: { 
            tags: ['Simulation'], 
            description: 'Démarre la boucle de simulation automatique avec cadence et durée de tick ajustables',
            querystring: {
                type: 'object',
                properties: {
                    persist: { 
                        type: 'boolean', 
                        default: false, 
                        description: 'Si true, enregistre les métriques dans TimescaleDB' 
                    },
                    cadence: { 
                        type: 'number', 
                        enum: [3, 4, 5, 6, 7, 8, 9, 10], 
                        default: 5, 
                        description: 'Fréquence de rafraîchissement de la simulation en secondes (Écran)' 
                    },
                    tickDuration: {
                        type: 'string',
                        enum: ['5', '10', '15', '20', '25', '30', '1h'],
                        default: '1h',
                        description: 'Durée virtuelle représentée par chaque tick de simulation (Chronologie)'
                    }
                }
            }
        }
    }, async (req) => {
        const persist = req.query.persist === true;
        const cadenceSeconds = req.query.cadence ?? 5;
        const tickDuration = req.query.tickDuration ?? '1h';
        
        SimulationService.resetClock();
        // HOT-RELOAD : Si un cycle tourne déjà, on l'arrête pour appliquer la nouvelle vitesse
        if (timer) {
            clearInterval(timer);
        }
        
        currentCadenceMs = cadenceSeconds * 1000;

        timer = setInterval(async () => {
            try {
                const service = new SimulationService(prisma, fastify.io, fastify.scenarioService);
                await service.simulateTick({ persist, tickDuration });
            } catch (err) {
                fastify.log.error(err);
            }
        }, currentCadenceMs);

        return { 
            status: "Simulation démarrée", 
            cadence: `${cadenceSeconds} secondes`,
            tickDuration: tickDuration,
            persist: persist 
        };
    });

    /**
     * POST /sim/stop
     * Arrête la simulation automatique
     */
    fastify.post('/sim/stop', {
        schema: { tags: ['Simulation'], description: 'Arrête le métronome' }
    }, async () => {
        if (timer) {
            clearInterval(timer);
            timer = null;
            return { status: "Simulation arrêtée" };
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
        const service = new SimulationService(prisma, fastify.io, fastify.scenarioService);
        return await service.getAgentState();
    });

    /**
     * POST /build-exercise
     */
    fastify.post<{ Body: { topology: Array<{ clusterName: string; city: string; configProfile: string; clusterCount: number; nodesOverride?: number }> } }>('/build-exercise', {
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
            timer = null;
        }
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
            body: { type: 'object', required: ['fanId'], properties: { fanId: { type: 'number' } } }
        }
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
    fastify.post('/sim/reset', {
        schema: { tags: ['Simulation'] }
    }, async () => {
        fastify.scenarioService.clearScenario();
        SimulationService.resetClock(); // Remet l'horloge virtuelle à zéro (Temps Réel actuel)
        await prisma.server.updateMany({ data: { status: 'ON' } });
        await prisma.sensor.updateMany({ where: { sensor_type: 'LOAD' }, data: { last_value: 15 } });
        await prisma.sensor.updateMany({ where: { sensor_type: 'CPU_TEMP' }, data: { last_value: 32 } });
        return { status: "DataCenter refroidi et horloge synchronisée." };
    });

    /**
     * POST /sim/hard-reset
     */
    fastify.post('/sim/hard-reset', {
        schema: { tags: ['Simulation'] }
    }, async () => {
        if (timer) { clearInterval(timer); timer = null; }
        fastify.scenarioService.clearScenario();
        SimulationService.resetClock();
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
    fastify.post('/sim/seed-history', {
        schema: { tags: ['Simulation'] }
    }, async () => {
        const builder = new ExerciseBuilderService(prisma);
        const totalRows = await builder.seedHealthyWeekHistory();
        return { status: 'success', message: `Historique généré (${totalRows} lignes).` };
    });
}