"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.SensorDataSchema = void 0;
exports.SensorDataSchema = {
    type: 'object',
    properties: {
        id: { type: 'integer' },
        time: { type: 'string', format: 'date-time' },
        sensor_id: { type: 'integer' },
        value: { type: 'number' },
    },
    required: ['sensor_id', 'value'],
};
