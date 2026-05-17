import { FastifyInstance } from 'fastify';
import HardwareService from './hardware.service';
import { 
  UpdateFanParamsSchema, 
  UpdateFanParams, 
  UpdateFanBodySchema, 
  UpdateFanBody 
} from './hardware.dto';

export default async function fanController(fastify: FastifyInstance) {
  const hardwareService = new HardwareService();

  fastify.patch<{ Params: UpdateFanParams; Body: UpdateFanBody }>(
    '/fans/:id', 
    {
      schema: {
        description: 'Met à jour les paramètres d\'un ventilateur (Vitesse, Mode, Statut)',
        tags: ['Hardware'],
        params: UpdateFanParamsSchema,
        body: UpdateFanBodySchema,
        response: {
          200: { 
            description: 'Ventilateur mis à jour avec succès',
            $ref: 'Fan#' 
          },
          400: { description: 'Données de mise à jour invalides' },
          404: { 
            type: 'object',
            properties: {
              statusCode: { type: 'number' },
              error: { type: 'string' },
              message: { type: 'string' }
            }
          }
        }
      }
    },
    async (req, reply) => {
      const { id } = req.params;

      try {
        const updatedFan = await hardwareService.updateFan(id, req.body);
        
        // Si le service renvoie null (géré dans le service) ou si Prisma ne trouve rien
        if (!updatedFan) {
          return reply.status(404).send({
            statusCode: 404,
            error: "Not Found",
            message: `Le ventilateur avec l'ID ${id} n'existe pas en base.`
          });
        }

        return updatedFan;

      } catch (error: any) {
        // Gestion spécifique de l'erreur Prisma "Record not found" (P2025)
        if (error.code === 'P2025') {
          return reply.status(404).send({
            statusCode: 404,
            error: "Not Found",
            message: `Impossible de mettre à jour : le ventilateur ${id} est introuvable.`
          });
        }

        // Pour toutes les autres erreurs imprévues
        fastify.log.error(error);
        return reply.status(500).send({ 
          statusCode: 500, 
          error: "Internal Server Error", 
          message: "Une erreur critique est survenue lors de la mise à jour." 
        });
      }
    }
  );
}