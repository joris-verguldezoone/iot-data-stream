"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.default = clusterController;
const cluster_services_1 = __importDefault(require("./cluster.services"));
const cluster_dto_1 = require("./cluster.dto");
async function clusterController(fastify) {
    const clusterService = new cluster_services_1.default();
    // GET ALL
    fastify.get('/clusters', {
        schema: {
            description: 'Récupère la liste de tous les clusters',
            tags: ['Cluster'],
            response: {
                200: {
                    type: 'array',
                    items: { $ref: 'Cluster#' }
                },
            },
        },
        handler: async () => {
            const data = await clusterService.getClusters();
            console.log("DONNÉES ENVOYÉES :", data[0]); // Regarde ce qui sort dans ton terminal
            return data;
        },
    });
    // GET BY ID
    fastify.get('/clusters/:id', {
        schema: {
            description: 'Récupère un cluster par son ID',
            tags: ['Cluster'],
            params: cluster_dto_1.ClusterParamsSchema,
            response: {
                200: { $ref: 'Cluster#' },
            },
        },
        handler: async (req) => {
            return await clusterService.getClusterById(req.params.id);
        },
    });
    // POST
    fastify.post('/clusters', {
        schema: {
            description: 'Crée un nouveau cluster',
            tags: ['Cluster'],
            body: cluster_dto_1.CreateClusterSchema,
            response: {
                201: { $ref: 'Cluster#' }, // Correction : un seul objet, pas un array
            },
        }, // Accolade fermante du schema ajoutée ici !
        handler: async (req, reply) => {
            const cluster = await clusterService.createCluster(req.body);
            return reply.code(201).send(cluster);
        },
    });
    // PATCH
    fastify.patch('/clusters/:id', {
        schema: {
            description: 'Met à jour un cluster',
            tags: ['Cluster'],
            params: cluster_dto_1.ClusterParamsSchema,
            body: cluster_dto_1.UpdateClusterSchema,
            response: {
                200: { $ref: 'Cluster#' },
            },
        },
        handler: async (req) => {
            return await clusterService.updateCluster(req.params.id, req.body);
        },
    });
    // DELETE
    fastify.delete('/clusters/:id', {
        schema: {
            description: 'Supprime un cluster',
            tags: ['Cluster'],
            params: cluster_dto_1.ClusterParamsSchema,
            response: {
                200: { $ref: 'Cluster#' },
            },
        },
        handler: async (req) => {
            return await clusterService.deleteCluster(req.params.id);
        },
    });
}
