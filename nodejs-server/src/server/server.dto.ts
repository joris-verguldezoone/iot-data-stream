import { Type, Static } from '@sinclair/typebox';

// On définit le schéma du Serveur
export const ServerSchema = Type.Object({
  server_id: Type.Integer(),
  cluster_id: Type.Integer(),
  config_id: Type.Union([Type.Integer(), Type.Null()]),
  hostname: Type.String({ example: 'srv-01' }),
  status: Type.String({ default: 'ON' }),
  is_master: Type.Boolean({ default: false }), 
  base_consumption_offset: Type.Number({ default: 0 }),
  
  // Au lieu d'importer l'objet ClusterSchema complet (risque de boucle),
  // on utilise une référence à l'ID du schéma enregistré dans Fastify.
  cluster: Type.Optional(Type.Ref(Type.Object({}, { $id: 'Cluster' }))),
  configuration: Type.Optional(Type.Ref(Type.Object({}, { $id: 'ClusterConfiguration' })))
}, { $id: 'Server' });

// Pour la création, on omet les champs générés par la BDD et les relations complexes
export const CreateServerSchema = Type.Object({
  cluster_id: Type.Integer(),
  config_id: Type.Optional(Type.Integer()),
  hostname: Type.String(),
  status: Type.Optional(Type.String()),
  is_master: Type.Optional(Type.Boolean()),
  base_consumption_offset: Type.Optional(Type.Number()),
});

// Pour la mise à jour (PATCH)
export const UpdateServerSchema = Type.Partial(CreateServerSchema);

export type ServerDTO = Static<typeof ServerSchema>;
export type CreateServerDTO = Static<typeof CreateServerSchema>;