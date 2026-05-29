// src/scenario/scenario.controller.ts
import { FastifyInstance } from "fastify";
import { eventList } from "../data_seed/scenarios";

export default async function scenarioController(fastify: FastifyInstance) {
    const scenarioService = fastify.scenarioService;

    // /**
    //  * POST /sim/scenario/load
    //  */
    // fastify.post<{ Body: { scenarioId: string } }>('/sim/scenario/load', {
    // schema: {
    //     tags: ['Scénarios'],
    //     description: 'Arme un scénario d\'anomalie opérationnelle déterministe',
    //     body: {
    //         type: 'object',
    //         required: ['scenarioId'], // Bloque la requête si absent
    //         properties: {
    //             scenarioId: { 
    //                 type: 'string',
    //                 enum: eventList, // Génère automatiquement le menu déroulant clean dans Swagger UI
    //                 description: 'L\'identifiant du scénario à charger (ex: op_fan_failure, sc_marseille_massive_chaos)'
    //             }
    //         }
    //     },
    //     response: {
    //         200: {
    //             type: 'object',
    //             properties: {
    //                 status: { type: 'string' },
    //                 message: { type: 'string' }
    //             }
    //         }
    //     }
    // }
    // }, async (req, reply) => {
    //     const { scenarioId } = req.body; // Désormais garanti d'exister !
    //     try {
    //         await scenarioService.loadScenario(scenarioId);
    //         return { status: "success", message: `Scénario [${scenarioId}] chargé.` };
    //     } catch (error: any) {
    //         return reply.status(404).send({ error: error.message });
    //     }
    // });

    /**
     * POST /sim/scenario/clear
     */

}