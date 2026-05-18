import { FastifyInstance } from "fastify";
import SimulationService from "./simulation.service";
import { ExerciseBuilderService } from "./exercise-builder.service";
import { prisma } from "../prisma/prisma";
import { UpdateLoadProfileDTO, UpdateLoadProfileSchema } from "../cluster/load-profile.dto";

export default async function simulationController(fastify: FastifyInstance) {
    let timer: NodeJS.Timeout | undefined = undefined;
    let currentCadenceMs = 5000; // Variable globale partagée (5s par défaut)
    
    // 🌟 SUIVI TEMPOREL POUR L'AUTO-STOP
    let virtualMinutesElapsed = 0;
    const ONE_WEEK_MINUTES = 7 * 24 * 60; // 10 080 minutes (7 jours)

    /**
     * GET /internal/cadence
     * Endpoint privé pour synchroniser le conteneur mqtt-producer
     */
/**
     * GET /internal/cadence
     * Synchro totale pour le mqtt-producer (Cadence, État et Modificateurs de Scénarios)
     */
    fastify.get('/internal/cadence', { schema: { hide: true } }, async () => {
        // On récupère le coefficient de charge et de chaleur du scénario s'il y en a un
        const activeScenario = fastify.scenarioService.getCurrentScenario();
        
        return { 
            cadenceMs: currentCadenceMs,
            isRunning: timer !== undefined,
            // Si un scénario de surcharge est actif, on passe son multiplicateur, sinon 1.0
            loadMultiplier: activeScenario?.effects?.loadFactor ?? 1.0,
            // Si une dérive thermique est en cours, on transmet sa valeur, sinon 0.0
            thermalDrift: activeScenario?.effects?.thermalDrift ?? 0.0
        };
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
     * Démarre la simulation automatique (S'arrête TOUTE SEULE après 1 semaine virtuelle)
     */
    fastify.post<{ Querystring: { persist?: boolean; cadence?: number; tickDuration?: string; startDate?: string } }>('/sim/start', {
        schema: { 
            tags: ['Simulation'], 
            description: 'Démarre la boucle de simulation automatique (Idempotente : purge les scénarios et pannes en cours)',
            querystring: {
                type: 'object',
                properties: {
                    persist: { type: 'boolean', default: false, description: 'Si true, enregistre les métriques dans TimescaleDB' },
                    cadence: { type: 'number', enum: [3, 4, 5, 6, 7, 8, 9, 10], default: 5, description: 'Fréquence de rafraîchissement en secondes' },
                    tickDuration: { type: 'string', enum: ['5', '10', '15', '20', '25', '30', '1h'], default: '1h', description: 'Durée virtuelle d\'un tick' },
                    startDate: { type: 'string', description: 'Date de début personnalisée' }
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
        } catch (scenarioError) {
            // 🌟 CORRIGÉ : Utilisation du format d'objet de log structuré pour Pino/Fastify
            fastify.log.error({ err: scenarioError }, "⚠️ Impossible de clear le scenarioService au démarrage");
        }
        
        // US 2 : TRAITEMENT DE LA DATE DYNAMIQUE
        if (startDateParam) {
            const parsedDate = new Date(startDateParam);
            if (!isNaN(parsedDate.getTime())) {
                SimulationService.setClock(parsedDate);
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
                const service = new SimulationService(prisma, fastify.io, fastify.scenarioService);
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
            } catch (err) {
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
    fastify.post('/sim/hard-reset', {
        schema: { tags: ['Simulation'] }
    }, async () => {
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
    fastify.post('/sim/seed-history', {
        schema: { tags: ['Simulation'] }
    }, async () => {
        const builder = new ExerciseBuilderService(prisma);
        const totalRows = await builder.seedHealthyWeekHistory();
        return { status: 'success', message: `Historique généré (${totalRows} lignes).` };
    });
}