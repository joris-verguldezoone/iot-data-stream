"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Nullable = void 0;
const typebox_1 = require("@sinclair/typebox");
const Nullable = (schema) => typebox_1.Type.Union([schema, typebox_1.Type.Null()]);
exports.Nullable = Nullable;
