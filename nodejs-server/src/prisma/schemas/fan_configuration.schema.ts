export const FanConfigurationSchema = {
  type: 'object',
  properties: {
    fan_id: { type: 'integer' },
    name: { type: 'string' },
    consomation: { type: 'number', nullable: true },
  },
  required: ['name'],
} as const;