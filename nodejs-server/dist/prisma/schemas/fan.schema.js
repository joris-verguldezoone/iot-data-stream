"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.FanSchema = void 0;
exports.FanSchema = {
    type: 'object',
    properties: {
        fan_id: { type: 'integer' },
        server_id: { type: 'integer' },
        control_mode: { type: 'string', default: 'AUTO' },
        status: { type: 'string', default: 'OFF' },
        speed_percent: { type: 'integer', default: 0 },
        created_at: { type: 'string', format: 'date-time' },
    },
    required: ['server_id'],
};
