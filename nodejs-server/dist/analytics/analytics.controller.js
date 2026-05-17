"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.default = analyticsController;
const analytics_service_1 = __importDefault(require("./analytics.service"));
async function analyticsController(fastify) {
    const service = new analytics_service_1.default();
    fastify.get('/analytics/cluster/:clusterId/summary', {
        schema: {
            tags: ['Analytics'],
            params: {
                type: 'object',
                properties: { clusterId: { type: 'number' } }
            }
        }
    }, async (request, reply) => {
        const { clusterId } = request.params;
        try {
            return await service.getClusterSummary(clusterId);
        }
        catch (error) {
            reply.status(404).send({ error: "Cluster introuvable" });
        }
    });
    fastify.get('/analytics/history/:sensorId', async (request, reply) => {
        const { sensorId } = request.params;
        // On appelle le service qui interroge la vue matérialisée
        const history = await service.getHistoricalTrends(Number(sensorId));
        return reply.send(history);
    });
}
