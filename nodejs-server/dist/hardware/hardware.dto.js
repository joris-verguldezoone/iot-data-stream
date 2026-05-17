"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.FanSchema = exports.UpdateFanBodySchema = exports.UpdateFanParamsSchema = exports.CpuCoolerCatalogSchema = exports.FanCatalogSchema = void 0;
const typebox_1 = require("@sinclair/typebox");
const utils_dto_1 = require("../common/utils.dto");
exports.FanCatalogSchema = typebox_1.Type.Object({
    fan_catalog_id: typebox_1.Type.Integer(),
    model_name: typebox_1.Type.String(),
    consomation: (0, utils_dto_1.Nullable)(typebox_1.Type.Number()),
}, { $id: 'FanCatalog' });
exports.CpuCoolerCatalogSchema = typebox_1.Type.Object({
    cpu_cooler_catalog_id: typebox_1.Type.Integer(),
    model_name: typebox_1.Type.String(),
    type: typebox_1.Type.String(), // "AIR" | "LIQUID"
    thermal_capacity: typebox_1.Type.Integer(),
}, { $id: 'CpuCoolerCatalog' });
exports.UpdateFanParamsSchema = typebox_1.Type.Object({
    id: typebox_1.Type.Integer({ description: "ID unique du ventilateur" })
});
exports.UpdateFanBodySchema = typebox_1.Type.Object({
    speed_percent: typebox_1.Type.Optional(typebox_1.Type.Integer({ minimum: 0, maximum: 100 })),
    control_mode: typebox_1.Type.Optional(typebox_1.Type.Union([
        typebox_1.Type.Literal('AUTO'),
        typebox_1.Type.Literal('MANU')
    ])),
    status: typebox_1.Type.Optional(typebox_1.Type.Union([
        typebox_1.Type.Literal('ON'),
        typebox_1.Type.Literal('OFF')
    ]))
});
exports.FanSchema = typebox_1.Type.Object({
    fan_id: typebox_1.Type.Integer(),
    server_id: typebox_1.Type.Integer(),
    fan_catalog_id: typebox_1.Type.Optional(typebox_1.Type.Integer()),
    fan_config_id: typebox_1.Type.Optional(typebox_1.Type.Integer()),
    control_mode: typebox_1.Type.String(),
    status: typebox_1.Type.String(),
    speed_percent: typebox_1.Type.Integer(),
    created_at: typebox_1.Type.Any(), // Ou Type.String({ format: 'date-time' })
}, { $id: 'Fan' }); // <--- L'ID CAPITAL EST ICI
