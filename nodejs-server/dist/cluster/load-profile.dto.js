"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.UpdateLoadProfileSchema = exports.CreateLoadProfileSchema = exports.LoadProfileSchema = void 0;
const typebox_1 = require("@sinclair/typebox");
exports.LoadProfileSchema = typebox_1.Type.Object({
    id: typebox_1.Type.Integer(),
    name: typebox_1.Type.String(),
    hour: typebox_1.Type.Integer({ minimum: 0, maximum: 23 }),
    expected_load_percent: typebox_1.Type.Number(),
    target_temp_celsius: typebox_1.Type.Number(),
    standard_fan_speed: typebox_1.Type.String(),
}, { $id: 'LoadProfile' });
exports.CreateLoadProfileSchema = typebox_1.Type.Omit(exports.LoadProfileSchema, ['id']);
exports.UpdateLoadProfileSchema = typebox_1.Type.Object({
    expected_load_percent: typebox_1.Type.Number({ minimum: 0, maximum: 100 }),
});
