"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.GetClusterParamsSchema = exports.ClusterSchema = void 0;
const zod_1 = require("zod");
// Le schéma de l'objet Cluster (ce que tu avais dans ton $ref)
exports.ClusterSchema = zod_1.z.object({
    cluster_id: zod_1.z.number(),
    name: zod_1.z.string(),
    created_at: zod_1.z.date(),
    cluster_location_id: zod_1.z.number(),
});
// Le schéma pour valider l'ID dans l'URL
exports.GetClusterParamsSchema = zod_1.z.object({
    // .coerce permet de transformer un string "12" en number 12
    id: zod_1.z.coerce.number().describe('L\'ID unique du cluster'),
});
