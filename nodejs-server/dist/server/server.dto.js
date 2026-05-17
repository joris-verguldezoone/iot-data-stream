"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.UpdateServerSchema = exports.CreateServerSchema = exports.ServerSchema = void 0;
const typebox_1 = require("@sinclair/typebox");
// On définit le schéma du Serveur
exports.ServerSchema = typebox_1.Type.Object({
    server_id: typebox_1.Type.Integer(),
    cluster_id: typebox_1.Type.Integer(),
    config_id: typebox_1.Type.Union([typebox_1.Type.Integer(), typebox_1.Type.Null()]),
    hostname: typebox_1.Type.String({ example: 'srv-01' }),
    status: typebox_1.Type.String({ default: 'ON' }),
    is_master: typebox_1.Type.Boolean({ default: false }),
    base_consumption_offset: typebox_1.Type.Number({ default: 0 }),
    // Au lieu d'importer l'objet ClusterSchema complet (risque de boucle),
    // on utilise une référence à l'ID du schéma enregistré dans Fastify.
    cluster: typebox_1.Type.Optional(typebox_1.Type.Ref(typebox_1.Type.Object({}, { $id: 'Cluster' }))),
    configuration: typebox_1.Type.Optional(typebox_1.Type.Ref(typebox_1.Type.Object({}, { $id: 'ClusterConfiguration' })))
}, { $id: 'Server' });
// Pour la création, on omet les champs générés par la BDD et les relations complexes
exports.CreateServerSchema = typebox_1.Type.Object({
    cluster_id: typebox_1.Type.Integer(),
    config_id: typebox_1.Type.Optional(typebox_1.Type.Integer()),
    hostname: typebox_1.Type.String(),
    status: typebox_1.Type.Optional(typebox_1.Type.String()),
    is_master: typebox_1.Type.Optional(typebox_1.Type.Boolean()),
    base_consumption_offset: typebox_1.Type.Optional(typebox_1.Type.Number()),
});
// Pour la mise à jour (PATCH)
exports.UpdateServerSchema = typebox_1.Type.Partial(exports.CreateServerSchema);
