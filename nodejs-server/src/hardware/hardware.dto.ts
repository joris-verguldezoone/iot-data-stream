import { Type, Static } from '@sinclair/typebox';
import { Nullable } from '../common/utils.dto';

export const FanCatalogSchema = Type.Object({
  fan_catalog_id: Type.Integer(),
  model_name: Type.String(),
  consomation: Nullable(Type.Number()),
}, { $id: 'FanCatalog' });

export const CpuCoolerCatalogSchema = Type.Object({
  cpu_cooler_catalog_id: Type.Integer(),
  model_name: Type.String(),
  type: Type.String(), // "AIR" | "LIQUID"
  thermal_capacity: Type.Integer(),
}, { $id: 'CpuCoolerCatalog' });

export type FanCatalog = Static<typeof FanCatalogSchema>;
export type CpuCoolerCatalog = Static<typeof CpuCoolerCatalogSchema>;

export const UpdateFanParamsSchema = Type.Object({
  id: Type.Integer({ description: "ID unique du ventilateur" })
});

export const UpdateFanBodySchema = Type.Object({
  speed_percent: Type.Optional(Type.Integer({ minimum: 0, maximum: 100 })),
  control_mode: Type.Optional(Type.Union([
    Type.Literal('AUTO'), 
    Type.Literal('MANU')
  ])),
  status: Type.Optional(Type.Union([
    Type.Literal('ON'), 
    Type.Literal('OFF')
  ]))
});

export type UpdateFanParams = Static<typeof UpdateFanParamsSchema>;
export type UpdateFanBody = Static<typeof UpdateFanBodySchema>;

export const FanSchema = Type.Object({
  fan_id: Type.Integer(),
  server_id: Type.Integer(),
  fan_catalog_id: Type.Optional(Type.Integer()),
  fan_config_id: Type.Optional(Type.Integer()),
  control_mode: Type.String(),
  status: Type.String(),
  speed_percent: Type.Integer(),
  created_at: Type.Any(), // Ou Type.String({ format: 'date-time' })
}, { $id: 'Fan' }); // <--- L'ID CAPITAL EST ICI

export type Fan = Static<typeof FanSchema>;