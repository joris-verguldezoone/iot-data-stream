"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.default = fanController;
const hardware_service_1 = __importDefault(require("./hardware.service"));
const hardware_dto_1 = require("./hardware.dto");
async function fanController(fastify) {
    const hardwareService = new hardware_service_1.default();
    fastify.patch('/fans/:id', {
        schema: {
            description: 'Met à jour les paramètres d\'un ventilateur (Vitesse, Mode, Statut)',
            tags: ['Hardware'],
            params: hardware_dto_1.UpdateFanParamsSchema,
            body: hardware_dto_1.UpdateFanBodySchema,
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
    }, async (req, reply) => {
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
        }
        catch (error) {
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
    });
}
