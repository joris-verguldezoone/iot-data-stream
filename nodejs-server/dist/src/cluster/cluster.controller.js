"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.default = clusterController;
const cluster_services_1 = __importDefault(require("./cluster.services"));
async function clusterController(fastify) {
    const clusterService = new cluster_services_1.default();
    // ══════════════════════════════════════════════
    // CLUSTERS
    // ══════════════════════════════════════════════
    fastify.get('/clusters', {
        schema: {
            description: 'Récupère la liste de tous les clusters',
            tags: ['Cluster'],
            response: {
                200: { type: 'array', items: { $ref: 'Cluster#' } },
            },
        },
        handler: async () => {
            return clusterService.getClusters(false);
        },
    });
    fastify.get('/clusters/:id', {
        schema: {
            description: 'Récupère un cluster par son ID',
            tags: ['Cluster'],
            params: {
                type: 'object',
                properties: { id: { type: 'integer' } },
                required: ['id'],
            },
            response: {
                200: { $ref: 'Cluster#' },
            },
        },
        handler: async (req) => {
            return clusterService.getClusterById(Number(req.params.id));
        },
    });
    // spa mieux des dto ??
    fastify.post('/clusters', {
        schema: {
            description: 'Crée un nouveau cluster',
            tags: ['Cluster'],
            body: {
                type: 'object',
                required: ['name', 'cluster_location_id'],
                properties: {
                    name: { type: 'string' },
                    cluster_location_id: { type: 'integer' },
                },
            },
            response: {
                201: { $ref: 'Cluster#' },
            },
        },
        handler: async (req, reply) => {
            const cluster = await clusterService.createCluster(req.body);
            return reply.code(201).send(cluster);
        },
    });
    fastify.patch('/clusters/:id', {
        schema: {
            description: 'Met à jour un cluster',
            tags: ['Cluster'],
            params: {
                type: 'object',
                properties: { id: { type: 'integer' } },
                required: ['id'],
            },
            body: {
                type: 'object',
                properties: {
                    name: { type: 'string' },
                    cluster_location_id: { type: 'integer' },
                },
            },
            response: {
                200: { $ref: 'Cluster#' },
            },
        },
        handler: async (req) => {
            return clusterService.updateCluster(Number(req.params.id), req.body);
        },
    });
    fastify.delete('/clusters/:id', {
        schema: {
            description: 'Supprime un cluster',
            tags: ['Cluster'],
            params: {
                type: 'object',
                properties: { id: { type: 'integer' } },
                required: ['id'],
            },
            response: {
                200: { $ref: 'Cluster#' },
            },
        },
        handler: async (req) => {
            return clusterService.deleteCluster(Number(req.params.id));
        },
    });
}
