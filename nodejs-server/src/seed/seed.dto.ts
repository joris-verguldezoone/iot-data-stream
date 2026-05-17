// src/seed/seeder.dto.ts
import { Type, Static } from '@sinclair/typebox';

export const BuildLocationSchema = Type.Object({
  name: Type.String({ example: "Paris-01" }),
  city: Type.String({ example: "Paris" }), // Requis pour le slice() du service
  envFactor: Type.Number({ default: 1.0 }),
  clusterCount: Type.Number({ example: 2 }),
  energyCostKwh: Type.Number({ default: 0.15 })
});

export const BuildExerciseSchema = Type.Array(BuildLocationSchema);
export type BuildExerciseDTO = Static<typeof BuildExerciseSchema>;