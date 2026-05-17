"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ClusterLocationSchema = void 0;
const typebox_1 = require("@sinclair/typebox");
exports.ClusterLocationSchema = typebox_1.Type.Object({
    location_id: typebox_1.Type.Optional(typebox_1.Type.Integer()),
    name: typebox_1.Type.String({ example: "Paris-01" }),
    city: typebox_1.Type.String({ example: "Paris" }),
    env_factor: typebox_1.Type.Number({ default: 1.0 }),
    cluster_count: typebox_1.Type.Integer(),
    energyCostKwh: typebox_1.Type.Number({ default: 0.15 }),
    created_at: typebox_1.Type.Optional(typebox_1.Type.String({ format: 'date-time' }))
}, { $id: 'ClusterLocation' });
