import { z } from 'zod';

export const ClusterSchema = z.object({
  cluster_id: z.number(),
  name: z.string(),
  created_at: z.date(),
  cluster_location_id: z.number(),
});

export const GetClusterParamsSchema = z.object({
  id: z.coerce.number().describe('L\'ID unique du cluster'),
});