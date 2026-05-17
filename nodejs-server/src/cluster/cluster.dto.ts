import { Type, Static } from '@sinclair/typebox';

/**
 * 1. Schéma de l'objet Cluster (Réponse API)
 * Ce schéma définit comment un Cluster est envoyé au client.
 */
export const ClusterSchema = Type.Object({
  cluster_id: Type.Integer(),
  name: Type.String(),
  cluster_location_id: Type.Integer(),
  created_at: Type.Any(),
  
  // ✅ Doit correspondre à ce que le service envoie
  city: Type.Optional(Type.Union([Type.String(), Type.Null()])), 
}, { $id: 'Cluster' });
/**
 * 2. Schémas pour les entrées (Params & Body)
 */

// Paramètres d'URL (ex: /clusters/:id)
export const ClusterParamsSchema = Type.Object({
  id: Type.Integer({ description: "ID unique du cluster" })
});

// Corps de création (POST)
export const CreateClusterSchema = Type.Object({
  name: Type.String({ minLength: 3 }),
  cluster_location_id: Type.Integer()
});

// Corps de mise à jour (PATCH)
export const UpdateClusterSchema = Type.Partial(CreateClusterSchema);

/**
 * 3. Types TypeScript (Inférence)
 */
export type ClusterDTO = Static<typeof ClusterSchema>;
export type ClusterParams = Static<typeof ClusterParamsSchema>;
export type CreateClusterDTO = Static<typeof CreateClusterSchema>;
export type UpdateClusterDTO = Static<typeof UpdateClusterSchema>;