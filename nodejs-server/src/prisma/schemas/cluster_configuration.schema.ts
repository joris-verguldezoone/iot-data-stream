export const ClusterConfigurationSchema = {
  type: 'object',
  properties: {
    cluster_config_id: { type: 'integer' },
    name: { type: 'string' },
    master: { type: 'integer' },
    worker: { type: 'number' },
    consomation_per_master: { type: 'number', nullable: true },
    consomation_per_worker: { type: 'number', nullable: true },
    hardware_per_master: { type: 'string', nullable: true },
    hardware_per_worker: { type: 'string', nullable: true },
    pue: { type: 'number', nullable: true },
    location_id: { type: 'integer', nullable: true },
    fan_id: { type: 'integer', nullable: true },
    fan_count: { type: 'integer', default: 1 }, // Ajouté pour le Builder
  },
  required: ['name', 'master', 'worker'],
} as const;