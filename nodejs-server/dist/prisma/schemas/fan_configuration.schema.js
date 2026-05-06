"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.FanConfigurationSchema = void 0;
exports.FanConfigurationSchema = {
    type: 'object',
    properties: {
        fan_id: { type: 'integer' },
        name: { type: 'string' },
        consomation: { type: 'number', nullable: true },
    },
    required: ['name'],
};
