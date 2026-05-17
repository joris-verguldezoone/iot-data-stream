import { FastifyInstance } from 'fastify';
import SeedService from './seed.service';
import { prisma } from '../prisma/prisma';
import { BuildExerciseSchema, BuildExerciseDTO } from './seed.dto';

export default async function seederController(fastify: FastifyInstance) {
  const seedServices = new SeedService(prisma);

  // fastify.post<{ Body: BuildExerciseDTO }>('/build-exercise', {
  //   schema: {
  //     description: 'Génère l\'infrastructure physique complète',
  //     tags: ['Seeder'],
  //     body: BuildExerciseSchema,
  //     response: {
  //       200: {
  //         type: 'object',
  //         properties: {
  //           status: { type: 'string' },
  //           message: { type: 'string' }
  //         }
  //       }
  //     },
  //   },
  //   handler: async (request, reply) => {
  //     // TypeScript est maintenant heureux car BuildExerciseDTO 
  //     // est assignable à Cluster_Location[]
  //     await seedServices.buildExercise(request.body);
      
  //     return { 
  //       status: 'success', 
  //       message: `Infrastructure construite pour ${request.body.length} localisations.` 
  //     };
  //   },
  // });
}