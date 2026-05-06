"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const seed_cluster_configuration_1 = require("../data_seed/seed_cluster_configuration");
const lodash_1 = __importDefault(require("lodash"));
class SeedService {
    prisma;
    constructor(prismaInstance) {
        this.prisma = prismaInstance;
    }
    randomInRange(range) {
        if (!range)
            return null;
        const [min, max] = range;
        return lodash_1.default.random(min, max, true);
    }
    /**
     * ✅ PHASE 1 : Initialisation des Catalogues Hardware
     * Obligatoire pour satisfaire les contraintes NOT NULL de ClusterConfiguration
     */
    async seedHardwareCatalogs() {
        console.log("📦 Initialisation des catalogues hardware...");
        const fans = [
            { model_name: 'FAN_HIGH_PERF', consomation: 1.5 },
            { model_name: 'FAN_STANDARD', consomation: 0.8 },
            { model_name: 'FAN_ECO', consomation: 0.4 }
        ];
        const coolers = [
            { model_name: 'LIQUID_COOLING', type: 'LIQUID', thermal_capacity: 400 },
            { model_name: 'AIR_HIGH_PERF', type: 'AIR', thermal_capacity: 250 },
            { model_name: 'AIR_STANDARD', type: 'AIR', thermal_capacity: 150 }
        ];
        for (const fan of fans) {
            await this.prisma.fanCatalog.upsert({
                where: { model_name: fan.model_name },
                update: { consomation: fan.consomation },
                create: fan
            });
        }
        for (const cooler of coolers) {
            await this.prisma.cpuCoolerCatalog.upsert({
                where: { model_name: cooler.model_name },
                update: { type: cooler.type, thermal_capacity: cooler.thermal_capacity },
                create: cooler
            });
        }
        // Création des profils de config ventilateurs (utilisés dans ClusterConfiguration)
        for (const fan of fans) {
            await this.prisma.fanConfiguration.upsert({
                where: { name: `CONFIG_${fan.model_name}` },
                update: { consomation: fan.consomation },
                create: { name: `CONFIG_${fan.model_name}`, consomation: fan.consomation }
            });
        }
    }
    async buildExercise(locations) {
        console.log("🚀 Lancement de la construction de l'exercice...");
        // Initialiser les catalogues AVANT toute création de configuration
        await this.seedHardwareCatalogs();
        for (const custom_location of locations) {
            const location = await this.prisma.clusterLocation.upsert({
                where: { name: custom_location.name },
                update: {
                    env_factor: custom_location.envFactor,
                    location: custom_location.city,
                    cluster_count: custom_location.clusterCount
                },
                create: {
                    name: custom_location.name,
                    location: custom_location.city,
                    env_factor: custom_location.envFactor,
                    cluster_count: custom_location.clusterCount
                },
            });
            console.log(`📍 Location traitée : ${location.name}`);
            await this.linkConfigsToLocation(location.location_id);
            await this.generateClustersForLocation(location, custom_location.clusterCount);
        }
    }
    async linkConfigsToLocation(locationId) {
        const groups = [seed_cluster_configuration_1.BIG_CLUSTERS, seed_cluster_configuration_1.MEDIUM_CLUSTERS, seed_cluster_configuration_1.SMALL_CLUSTERS];
        const fanCatalogs = await this.prisma.fanCatalog.findMany();
        const coolerCatalogs = await this.prisma.cpuCoolerCatalog.findMany();
        const fanConfigs = await this.prisma.fanConfiguration.findMany();
        for (const group of groups) {
            for (const config of Object.values(group)) {
                const uniqueConfigName = `${config.name}-LOC-${locationId}`;
                // Récupération des IDs réels depuis les catalogues hardware
                const fanCatalog = fanCatalogs.find(f => f.model_name === config.fan_model_name) || fanCatalogs[0];
                const coolerCatalog = coolerCatalogs.find(c => c.model_name === config.cpu_cooler_model_name) || coolerCatalogs[0];
                const fanConfig = fanConfigs.find(fc => fc.name === `CONFIG_${config.fan_model_name}`) || fanConfigs[0];
                await this.prisma.clusterConfiguration.upsert({
                    where: { name: uniqueConfigName },
                    update: {
                        master: config.masters,
                        worker: config.workers,
                        consomation_per_master: this.randomInRange(config.consomation_per_master),
                        consomation_per_worker: this.randomInRange(config.consomation_per_worker),
                        hardware_per_master: config.hardware_per_master,
                        hardware_per_worker: config.hardware_per_worker,
                        pue: config.PUE,
                        location_id: locationId,
                        fan_id: fanConfig.fan_id,
                        fan_count: config.fan_count || 1,
                        cpu_cooler_catalog_id: coolerCatalog.cpu_cooler_catalog_id, // FIX: Ne sera plus NULL
                        fan_catalog_id: fanCatalog.fan_catalog_id // FIX: Ne sera plus NULL
                    },
                    create: {
                        name: uniqueConfigName,
                        master: config.masters,
                        worker: config.workers,
                        consomation_per_master: this.randomInRange(config.consomation_per_master),
                        consomation_per_worker: this.randomInRange(config.consomation_per_worker),
                        hardware_per_master: config.hardware_per_master,
                        hardware_per_worker: config.hardware_per_worker,
                        pue: config.PUE,
                        location_id: locationId,
                        fan_id: fanConfig.fan_id,
                        fan_count: config.fan_count || 1,
                        cpu_cooler_catalog_id: coolerCatalog.cpu_cooler_catalog_id,
                        fan_catalog_id: fanCatalog.fan_catalog_id
                    },
                });
            }
        }
    }
    async generateClustersForLocation(location, clusterCount) {
        const configs = await this.prisma.clusterConfiguration.findMany({
            where: { location_id: location.location_id }
        });
        for (let i = 0; i < clusterCount; i++) {
            const config = lodash_1.default.sample(configs);
            const clusterName = `CL-${location.location?.slice(0, 3).toUpperCase() || 'XXX'}-${String(i + 1).padStart(2, '0')}`;
            const cluster = await this.prisma.cluster.upsert({
                where: { name: clusterName },
                update: { cluster_location_id: location.location_id },
                create: {
                    name: clusterName,
                    cluster_location_id: location.location_id,
                },
            });
            await this.seedServersForCluster(cluster.cluster_id, config);
        }
    }
    async seedServersForCluster(clusterId, config) {
        const totalServers = config.master + config.worker;
        for (let i = 1; i <= totalServers; i++) {
            const isMaster = i <= config.master;
            const server = await this.prisma.server.create({
                data: {
                    hostname: `SRV-${isMaster ? 'MST' : 'WRK'}-${String(i).padStart(3, '0')}-CID${clusterId}`,
                    cluster_id: clusterId,
                    config_id: config.cluster_config_id,
                    base_consumption_offset: lodash_1.default.random(-5, 5, true),
                    status: "ON"
                }
            });
            await this.attachHardware(server.server_id, config);
        }
    }
    async attachHardware(serverId, config) {
        const fanCount = config.fan_count || 1;
        for (let i = 1; i <= fanCount; i++) {
            await this.prisma.fan.create({
                data: {
                    server_id: serverId,
                    fan_catalog_id: config.fan_catalog_id,
                    fan_config_id: config.fan_id,
                    control_mode: "AUTO",
                    status: "ON",
                    speed_percent: 25
                }
            });
            await this.prisma.sensor.create({
                data: {
                    server_id: serverId,
                    sensor_type: `fan_${i}_speed`,
                    unit: 'RPM',
                    last_value: 1200
                }
            });
        }
        await this.prisma.sensor.createMany({
            data: [
                { server_id: serverId, sensor_type: 'cpu_temp', unit: '°C', last_value: 35 },
                { server_id: serverId, sensor_type: 'total_power', unit: 'W', last_value: 100 },
                { server_id: serverId, sensor_type: 'load', unit: '%', last_value: 5 }
            ]
        });
    }
}
exports.default = SeedService;
