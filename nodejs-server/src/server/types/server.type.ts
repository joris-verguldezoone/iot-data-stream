// src/types/server.type.ts
import { Prisma } from "../../prisma/generated/prisma/client";

export type ServerWithHardware = Prisma.ServerGetPayload<{
  include: { 
    configuration: {
        include: { 
          fan_config: true, // Corrigé : le nom de la relation est fan_config
          fan_model: true   // Optionnel : si tu veux aussi les infos du catalogue
        } 
    }, 
    fans: true, 
    sensors: true 
  }
}>;