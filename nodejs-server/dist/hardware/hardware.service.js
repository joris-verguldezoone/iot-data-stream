"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const prisma_1 = require("../prisma/prisma");
/**
 * Service Hardware : Centralise toute la logique métier liée
 * aux composants physiques (Serveurs, Ventilateurs, Capteurs).
 */
class HardwareService {
    /**
     * Met à jour un ventilateur spécifique (Vitesse, Mode, Statut)
     * Utilisé par le FanController.
     */
    async updateFan(id, data) {
        try {
            return await prisma_1.prisma.fan.update({
                where: { fan_id: id },
                data: data,
            });
        }
        catch (error) {
            // P2025 est le code spécifique "Record not found"
            if (error.code === 'P2025') {
                return null; // On renvoie null pour dire "pas trouvé"
            }
            throw error; // On laisse les autres erreurs remonter
        }
    }
    /**
     * Récupère tous les détails d'un serveur incluant ses composants
     */
    async getServerHardware(serverId) {
        return await prisma_1.prisma.server.findUnique({
            where: { server_id: serverId },
            include: {
                fans: true,
                sensors: true,
                configuration: {
                    include: {
                        fan_model: true,
                        cooler_model: true
                    }
                }
            }
        });
    }
    /**
     * Alerte : Change le statut d'un serveur si une anomalie est détectée
     */
    async updateServerStatus(serverId, status) {
        return await prisma_1.prisma.server.update({
            where: { server_id: serverId },
            data: { status }
        });
    }
}
exports.default = HardwareService;
