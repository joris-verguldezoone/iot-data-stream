"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.UpdateClusterSchema = exports.CreateClusterSchema = exports.ClusterParamsSchema = exports.ClusterSchema = void 0;
const typebox_1 = require("@sinclair/typebox");
/**
 * 1. Schéma de l'objet Cluster (Réponse API)
 * Ce schéma définit comment un Cluster est envoyé au client.
 */
exports.ClusterSchema = typebox_1.Type.Object({
    cluster_id: typebox_1.Type.Integer(),
    name: typebox_1.Type.String(),
    cluster_location_id: typebox_1.Type.Integer(),
    created_at: typebox_1.Type.Any(),
    // ✅ Doit correspondre à ce que le service envoie
    city: typebox_1.Type.Optional(typebox_1.Type.Union([typebox_1.Type.String(), typebox_1.Type.Null()])),
}, { $id: 'Cluster' });
/**
 * 2. Schémas pour les entrées (Params & Body)
 */
// Paramètres d'URL (ex: /clusters/:id)
exports.ClusterParamsSchema = typebox_1.Type.Object({
    id: typebox_1.Type.Integer({ description: "ID unique du cluster" })
});
// Corps de création (POST)
exports.CreateClusterSchema = typebox_1.Type.Object({
    name: typebox_1.Type.String({ minLength: 3 }),
    cluster_location_id: typebox_1.Type.Integer()
});
// Corps de mise à jour (PATCH)
exports.UpdateClusterSchema = typebox_1.Type.Partial(exports.CreateClusterSchema);
