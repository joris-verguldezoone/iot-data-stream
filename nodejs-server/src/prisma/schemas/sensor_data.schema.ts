export const SensorDataSchema = {
  type: 'object',
  properties: {
    id: { type: 'integer' },
    time: { type: 'string', format: 'date-time' },
    sensor_id: { type: 'integer' },
    value: { type: 'number' },
  },
  required: ['sensor_id', 'value'],
} as const;