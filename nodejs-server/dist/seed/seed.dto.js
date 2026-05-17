"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.BuildExerciseSchema = exports.BuildLocationSchema = void 0;
// src/seed/seeder.dto.ts
const typebox_1 = require("@sinclair/typebox");
exports.BuildLocationSchema = typebox_1.Type.Object({
    name: typebox_1.Type.String({ example: "Paris-01" }),
    city: typebox_1.Type.String({ example: "Paris" }), // Requis pour le slice() du service
    envFactor: typebox_1.Type.Number({ default: 1.0 }),
    clusterCount: typebox_1.Type.Number({ example: 2 }),
    energyCostKwh: typebox_1.Type.Number({ default: 0.15 })
});
exports.BuildExerciseSchema = typebox_1.Type.Array(exports.BuildLocationSchema);
