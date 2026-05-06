"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ServerSchema = void 0;
exports.ServerSchema = {
    type: 'object',
    properties: {
        server_id: { type: 'integer' },
        cluster_id: { type: 'integer' },
        config_id: { type: 'integer', nullable: true }, // Ajouté 
        hostname: { type: 'string' }, // 
        status: { type: 'string', default: 'ON' },
        base_consumption_offset: { type: 'number' }, // Ajouté 
        created_at: { type: 'string', format: 'date-time' },
    },
    required: ['cluster_id', 'hostname'],
};
