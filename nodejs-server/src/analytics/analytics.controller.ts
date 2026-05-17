import { FastifyInstance } from 'fastify';
import { Type } from '@sinclair/typebox';
import AnalyticsService from './analytics.service';


export default async function analyticsController(fastify: FastifyInstance) {
    const service = new AnalyticsService();

    fastify.get('/analytics/cluster/:clusterId/summary', {
        schema: {
            tags: ['Analytics'],
            params: {
                type: 'object',
                properties: { clusterId: { type: 'number' } }
            }
        }
    }, async (request, reply) => {
        const { clusterId } = request.params as { clusterId: number };
        try {
            return await service.getClusterSummary(clusterId);
        } catch (error) {
            reply.status(404).send({ error: "Cluster introuvable" });
        }
    });

    fastify.get('/analytics/history/:sensorId', async (request, reply) => {
        const { sensorId } = request.params as any;
        // On appelle le service qui interroge la vue matérialisée
        const history = await service.getHistoricalTrends(Number(sensorId));
        return reply.send(history);
    });

}