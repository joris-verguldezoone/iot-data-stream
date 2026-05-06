"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ClusterSchema = void 0;
exports.ClusterSchema = {
    type: 'object',
    properties: {
        cluster_id: { type: 'integer' },
        name: { type: 'string' },
        cluster_location_id: { type: 'integer' },
        created_at: { type: 'string', format: 'date-time' },
    },
    required: ['name'],
};
