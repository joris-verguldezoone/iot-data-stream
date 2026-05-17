import { prisma } from "../prisma/prisma";
import { UpdateFanBody } from "./hardware.dto";

/**
 * Service Hardware : Centralise toute la logique métier liée 
 * aux composants physiques (Serveurs, Ventilateurs, Capteurs).
 */
export default class HardwareService {
  
  /**
   * Met à jour un ventilateur spécifique (Vitesse, Mode, Statut)
   * Utilisé par le FanController.
   */
    async updateFan(id: number, data: UpdateFanBody) {
        try {
        return await prisma.fan.update({
            where: { fan_id: id },
            data: data,
        });
        } catch (error: any) {
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
  async getServerHardware(serverId: number) {
    return await prisma.server.findUnique({
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
  async updateServerStatus(serverId: number, status: 'ON' | 'OFF' | 'MAINTENANCE') {
    return await prisma.server.update({
      where: { server_id: serverId },
      data: { status }
    });
  }
}