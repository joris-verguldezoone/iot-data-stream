"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.CreateClusterConfigSchema = exports.ClusterConfigurationSchema = void 0;
const typebox_1 = require("@sinclair/typebox");
const utils_dto_1 = require("../common/utils.dto");
const load_profile_dto_1 = require("../cluster/load-profile.dto");
const hardware_dto_1 = require("../hardware/hardware.dto");
/**
 * Schéma Principal : ClusterConfiguration
 * Utilise Type.Ref pour les relations afin d'éviter l'erreur "schema already exists"
 */
exports.ClusterConfigurationSchema = typebox_1.Type.Object({
    cluster_config_id: typebox_1.Type.Integer(),
    name: typebox_1.Type.String(),
    master: typebox_1.Type.Integer(),
    worker: typebox_1.Type.Integer(),
    consomation_per_master: (0, utils_dto_1.Nullable)(typebox_1.Type.Number()),
    consomation_per_worker: (0, utils_dto_1.Nullable)(typebox_1.Type.Number()),
    pue: (0, utils_dto_1.Nullable)(typebox_1.Type.Number()),
    fan_count: typebox_1.Type.Integer(),
    cpu_cooler_catalog_id: typebox_1.Type.Integer(),
    fan_catalog_id: typebox_1.Type.Integer(),
    load_profile_id: typebox_1.Type.Optional(typebox_1.Type.Integer()),
    // ✅ On utilise Type.Ref(Schema) pour faire un lien logique sans copier l'objet
    load_profile: typebox_1.Type.Optional(typebox_1.Type.Ref(load_profile_dto_1.LoadProfileSchema)),
    fan_model: typebox_1.Type.Optional(typebox_1.Type.Ref(hardware_dto_1.FanCatalogSchema)),
    cooler_model: typebox_1.Type.Optional(typebox_1.Type.Ref(hardware_dto_1.CpuCoolerCatalogSchema)),
}, { $id: 'ClusterConfiguration' });
/**
 * DTO pour la création (POST)
 * On retire l'ID auto-incrémenté et les objets de relation complexes
 */
exports.CreateClusterConfigSchema = typebox_1.Type.Omit(exports.ClusterConfigurationSchema, [
    'cluster_config_id',
    'load_profile',
    'fan_model',
    'cooler_model'
]);
