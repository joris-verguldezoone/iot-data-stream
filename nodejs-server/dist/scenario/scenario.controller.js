"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.default = scenarioController;
async function scenarioController(fastify) {
    const scenarioService = fastify.scenarioService;
    /**
     * POST /sim/scenario/load
     */
    fastify.post('/sim/scenario/load', {
        schema: {
            tags: ['Scénarios'],
            description: 'Arme un scénario d\'anomalie opérationnelle déterministe',
            // 🚨 CE BLOC EST REQUIS POUR SWAGGER ET LES ARGUMENTS
            body: {
                type: 'object',
                required: ['scenarioId'], // Bloque la requête si absent
                properties: {
                    scenarioId: {
                        type: 'string',
                        example: 'op_fan_failure', // Remplit automatiquement le champ dans Swagger
                        description: 'L\'identifiant du scénario (ex: op_fan_failure, op_traffic_surge)'
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
        const { scenarioId } = req.body; // Désormais garanti d'exister !
        try {
            await scenarioService.loadScenario(scenarioId);
            return { status: "success", message: `Scénario [${scenarioId}] chargé.` };
        }
        catch (error) {
            return reply.status(404).send({ error: error.message });
        }
    });
    /**
     * POST /sim/scenario/clear
     */
    fastify.post('/sim/scenario/clear', {
        schema: {
            tags: ['Scénarios'],
            description: 'Purge le scénario en cours et réinitialise les dérives thermiques'
        }
    }, async () => {
        scenarioService.clearScenario();
        return { status: "success", message: "Événements de pannes réinitialisés." };
    });
}
