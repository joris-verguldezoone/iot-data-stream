// src/agent/agent.controller.ts
import { FastifyInstance } from "fastify";
import { AgentService } from "./agent.service";
import { prisma } from "../prisma/prisma";

export default async function agentController(fastify: FastifyInstance) {
    // ✅ Injection du Singleton io décoré sur l'instance de Fastify
    const agentService = new AgentService(prisma, fastify.io);

    // GET /agent/state -> Observation pour l'IA
    fastify.get('/state', async (request, reply) => {
        const state = await agentService.getEnvironmentState();
        return reply.code(200).send(state);
    });

    // Définition du schéma pour la route action

    const actionSchema = {
        tags: ['Agent IA'],
        description: 'Permet à l\'IA d\'envoyer des commandes de régulation (Brider la charge ou forcer les ventilateurs)',
        body: {
            type: 'object',
            required: ['actions'],
            properties: {
                actions: {
                    type: 'array',
                    items: {
                        type: 'object',
                        required: ['type', 'id', 'value'],
                        properties: {
                            type: { type: 'string', enum: ['SET_FAN_SPEED', 'SET_SERVER_LOAD'] },
                            id: { type: 'number' },
                            value: { type: 'number' }
                        }
                    }
                }
            }
        }
    };
    // POST /agent/action -> Commandes de l'IA
    fastify.post('/action', { schema: actionSchema }, async (request, reply) => {
        const { actions } = request.body as any;
        
        await agentService.applyActions(actions);
        return reply.code(201).send({ 
            status: "applied", 
            count: actions.length 
        });
    });
}