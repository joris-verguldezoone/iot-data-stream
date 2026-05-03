export const ClusterSchema = {
  type: 'object',
  properties: {
    cluster_id: { type: 'integer' },
    name: { type: 'string' },
    cluster_location_id: { type: 'integer' },
    created_at: { type: 'string', format: 'date-time' },
  },
  required: ['name'],
} as const;