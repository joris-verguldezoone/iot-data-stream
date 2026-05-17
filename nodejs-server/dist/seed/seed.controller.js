"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.default = seederController;
const seed_service_1 = __importDefault(require("./seed.service"));
const prisma_1 = require("../prisma/prisma");
async function seederController(fastify) {
    const seedServices = new seed_service_1.default(prisma_1.prisma);
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
