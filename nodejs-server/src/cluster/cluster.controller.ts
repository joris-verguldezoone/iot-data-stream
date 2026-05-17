import { FastifyInstance } from 'fastify';
import ClusterService from './cluster.services';
import { 
  CreateClusterSchema, 
  CreateClusterDTO, 
  UpdateClusterSchema, 
  UpdateClusterDTO, 
  ClusterParamsSchema, 
  ClusterParams,
} from './cluster.dto';

export default async function clusterController(fastify: FastifyInstance) {
  const clusterService = new ClusterService();

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
  fastify.get<{ Params: ClusterParams }>('/clusters/:id', {
    schema: {
      description: 'Récupère un cluster par son ID',
      tags: ['Cluster'],
      params: ClusterParamsSchema,
      response: {
        200: { $ref: 'Cluster#' },
      },
    },
    handler: async (req) => {
      return await clusterService.getClusterById(req.params.id);
    },
  });

  // POST
  fastify.post<{ Body: CreateClusterDTO }>('/clusters', {
    schema: {
      description: 'Crée un nouveau cluster',
      tags: ['Cluster'],
      body: CreateClusterSchema,
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
  fastify.patch<{ Params: ClusterParams; Body: UpdateClusterDTO }>('/clusters/:id', {
    schema: {
      description: 'Met à jour un cluster',
      tags: ['Cluster'],
      params: ClusterParamsSchema,
      body: UpdateClusterSchema,
      response: {
        200: { $ref: 'Cluster#' },
      },
    },
    handler: async (req) => {
      return await clusterService.updateCluster(req.params.id, req.body);
    },
  });

  // DELETE
  fastify.delete<{ Params: ClusterParams }>('/clusters/:id', {
    schema: {
      description: 'Supprime un cluster',
      tags: ['Cluster'],
      params: ClusterParamsSchema,
      response: {
        200: { $ref: 'Cluster#' },
      },
    },
    handler: async (req) => {
      return await clusterService.deleteCluster(req.params.id);
    },
  });
}