import { Type, Static } from '@sinclair/typebox';

export const LoadProfileSchema = Type.Object({
  id: Type.Integer(),
  name: Type.String(),
  hour: Type.Integer({ minimum: 0, maximum: 23 }),
  expected_load_percent: Type.Number(),
  target_temp_celsius: Type.Number(),
  standard_fan_speed: Type.String(),
}, { $id: 'LoadProfile' });

export const CreateLoadProfileSchema = Type.Omit(LoadProfileSchema, ['id']);

export type LoadProfile = Static<typeof LoadProfileSchema>;


export const UpdateLoadProfileSchema = Type.Object({
  expected_load_percent: Type.Number({ minimum: 0, maximum: 100 }),
});

export type UpdateLoadProfileDTO = Static<typeof UpdateLoadProfileSchema>;