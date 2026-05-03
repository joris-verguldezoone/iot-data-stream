export const SensorSchema = {
  type: 'object',
  properties: {
    sensor_id: { type: 'integer' },
    server_id: { type: 'integer' },
    sensor_type: { type: 'string' },
    unit: { type: 'string' },
    last_value: { type: 'number', nullable: true },
    created_at: { type: 'string', format: 'date-time' },
  },
  required: ['server_id', 'sensor_type', 'unit'],
} as const;