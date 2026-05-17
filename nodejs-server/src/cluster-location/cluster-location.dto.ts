import { Type, Static } from '@sinclair/typebox';

export const ClusterLocationSchema = Type.Object({
  location_id: Type.Optional(Type.Integer()),
  name: Type.String({ example: "Paris-01" }),
  city: Type.String({ example: "Paris" }), 
  env_factor: Type.Number({ default: 1.0 }),
  cluster_count: Type.Integer(),
  energyCostKwh: Type.Number({ default: 0.15 }),
  created_at: Type.Optional(Type.String({ format: 'date-time' }))
}, { $id: 'ClusterLocation' });

export type ClusterLocationDTO = Static<typeof ClusterLocationSchema>;