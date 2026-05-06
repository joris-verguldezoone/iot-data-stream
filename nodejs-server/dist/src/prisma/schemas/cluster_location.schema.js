"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ClusterLocationSchema = void 0;
exports.ClusterLocationSchema = {
    type: 'object',
    properties: {
        location_id: { type: 'integer' },
        name: { type: 'string' },
        location: { type: 'string', nullable: true },
        env_factor: { type: 'number', default: 1.0 }, // Ajouté 
        cluster_count: { type: 'integer' }, // Ajouté
        created_at: { type: 'string', format: 'date-time' },
    },
    required: ['name', 'cluster_count'],
};
