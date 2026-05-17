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
        for (const fan of fans) {
            await this.prisma.fanConfiguration.upsert({
                where: { name: `CONFIG_${fan.model_name}` },
                update: { consomation: fan.consomation },
                create: { name: `CONFIG_${fan.model_name}`, consomation: fan.consomation }
            });
        }
    }
    async buildExercise(data) {
        console.log("🧹 Destruction et reset complet des séquences SQL...");
        const volatileTables = ["sensor_data", "sensor", "fan", "server"];
        // TRUNCATE réinitialise immédiatement les ID à 1 pour le prochain lot
        for (const table of volatileTables) {
            await this.prisma.$executeRawUnsafe(`TRUNCATE TABLE "${table}" RESTART IDENTITY CASCADE;`);
        }
        console.log("🚀 Démarrage du build complet déterministe...");
        // 1. Initialiser le hardware de base (Catalogues) [cite: 566]
        await this.seedHardwareCatalogs();
        // 2. Générer les 24 profils de charge (0h -> 23h)
        const profiles = [];
        for (let h = 0; h < 24; h++) {
            const profile = await this.prisma.loadProfile.upsert({
                where: { name_hour: { name: `Profil_H${h}`, hour: h } },
                update: {},
                create: {
                    name: `Profil_H${h}`,
                    hour: h,
                    expected_load_percent: h >= 9 && h <= 18 ? 85.0 : 20.0,
                    target_temp_celsius: 45.0,
                    standard_fan_speed: "MEDIUM"
                }
            });
            profiles.push(profile);
        }
        for (const cityData of data) {
            // 3. Création ou Mise à jour de la localisation
            const location = await this.prisma.clusterLocation.upsert({
                where: { name: cityData.name },
                update: {
                    location: cityData.city,
                    cluster_count: cityData.clusterCount || 1,
                    energy_cost_kwh: cityData.energyCostKwh || 0.15,
                    env_factor: cityData.envFactor || 1.0,
                },
                create: {
                    name: cityData.name,
                    location: cityData.city,
                    cluster_count: cityData.clusterCount || 1,
                    energy_cost_kwh: cityData.energyCostKwh || 0.15,
                    env_factor: cityData.envFactor || 1.0,
                }
            });
            // 4. Création ou Mise à jour du Cluster
            const cluster = await this.prisma.cluster.upsert({
                where: { name: cityData.name },
                update: { cluster_location_id: location.location_id },
                create: {
                    name: cityData.name,
                    cluster_location_id: location.location_id,
                }
            });
            // 5. Préparation de la Configuration (Blueprint)
            const currentHour = new Date().getHours();
            const targetProfile = profiles.find(p => p.hour === currentHour) || profiles[0];
            // Récupération des ressources hardware par défaut
            const defaultFan = await this.prisma.fanCatalog.findFirst();
            const defaultCooler = await this.prisma.cpuCoolerCatalog.findFirst();
            const defaultFanConfig = await this.prisma.fanConfiguration.findFirst();
            const configName = `Config_Auto_${cityData.name}`;
            const config = await this.prisma.clusterConfiguration.upsert({
                where: { name: configName },
                update: {
                    location_id: location.location_id,
                    load_profile_id: targetProfile.id,
                    cpu_cooler_catalog_id: defaultCooler?.cpu_cooler_catalog_id || 1,
                    fan_catalog_id: defaultFan?.fan_catalog_id || 1,
                    fan_config_id: defaultFanConfig?.id || 1
                },
                create: {
                    name: configName,
                    location_id: location.location_id,
                    load_profile_id: targetProfile.id,
                    master: 1,
                    worker: (cityData.clusterCount || 2) - 1,
                    cpu_cooler_catalog_id: defaultCooler?.cpu_cooler_catalog_id || 1,
                    fan_catalog_id: defaultFan?.fan_catalog_id || 1,
                    fan_config_id: defaultFanConfig?.id || 1,
                    pue: 1.2,
                    fan_count: 2,
                    consomation_per_master: 150,
                    consomation_per_worker: 200
                }
            });
            // 6. Création des Serveurs
            for (let i = 1; i <= (cityData.clusterCount || 2); i++) {
                const server = await this.prisma.server.create({
                    data: {
                        cluster_id: cluster.cluster_id,
                        config_id: config.cluster_config_id,
                        hostname: `${cityData.name.toLowerCase()}-srv-${String(i).padStart(2, '0')}`,
                        status: "ON",
                        base_consumption_offset: 50,
                    }
                });
                // 7. Création des Capteurs (Obligatoire pour la simulation)
                await this.prisma.sensor.createMany({
                    data: [
                        { server_id: server.server_id, sensor_type: 'CPU_TEMP', unit: '°C', last_value: 30.0 },
                        { server_id: server.server_id, sensor_type: 'LOAD', unit: '%', last_value: 0.0 },
                        { server_id: server.server_id, sensor_type: 'TOTAL_POWER', unit: 'W', last_value: 0.0 }
                    ]
                });
                // 8. Création des Ventilateurs (Avec TOUS les IDs requis)
                await this.prisma.fan.createMany({
                    data: [
                        {
                            server_id: server.server_id,
                            status: 'ON',
                            control_mode: 'AUTO',
                            speed_percent: 50,
                            fan_catalog_id: config.fan_catalog_id,
                            fan_config_id: config.fan_config_id
                        },
                        {
                            server_id: server.server_id,
                            status: 'ON',
                            control_mode: 'AUTO',
                            speed_percent: 50,
                            fan_catalog_id: config.fan_catalog_id,
                            fan_config_id: config.fan_config_id
                        }
                    ]
                });
            }
        }
        return { message: "Build terminé avec succès. Infrastructure prête pour la simulation." };
    }
    async linkConfigsToLocation(locationId) {
        const groups = [seed_cluster_configuration_1.BIG_CLUSTERS, seed_cluster_configuration_1.MEDIUM_CLUSTERS, seed_cluster_configuration_1.SMALL_CLUSTERS];
        const fanCatalogs = await this.prisma.fanCatalog.findMany();
        const coolerCatalogs = await this.prisma.cpuCoolerCatalog.findMany();
        const fanConfigs = await this.prisma.fanConfiguration.findMany();
        for (const group of groups) {
            for (const config of Object.values(group)) {
                const uniqueConfigName = `${config.name}-LOC-${locationId}`;
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
                        pue: config.PUE,
                        location_id: locationId,
                        // ✅ CORRECTION : fan_config_id est le nom dans Prisma, fanConfig.id est la PK
                        fan_config_id: fanConfig.id,
                        fan_count: config.fan_count || 1,
                        cpu_cooler_catalog_id: coolerCatalog.cpu_cooler_catalog_id,
                        fan_catalog_id: fanCatalog.fan_catalog_id
                    },
                    create: {
                        name: uniqueConfigName,
                        master: config.masters,
                        worker: config.workers,
                        consomation_per_master: this.randomInRange(config.consomation_per_master),
                        consomation_per_worker: this.randomInRange(config.consomation_per_worker),
                        pue: config.PUE,
                        location_id: locationId,
                        // ✅ CORRECTION : Idem ici
                        fan_config_id: fanConfig.id,
                        fan_count: config.fan_count || 1,
                        cpu_cooler_catalog_id: coolerCatalog.cpu_cooler_catalog_id,
                        fan_catalog_id: fanCatalog.fan_catalog_id
                    },
                });
            }
        }
    }
    async generateClustersForLocation(locationId, city, clusterCount) {
        const configs = await this.prisma.clusterConfiguration.findMany({
            where: { location_id: locationId }
        });
        for (let i = 0; i < clusterCount; i++) {
            // Sécurité : on définit un préfixe par défaut si city est invalide
            const prefix = (city && city.length >= 3)
                ? city.slice(0, 3).toUpperCase()
                : 'LOC';
            const clusterName = `CL-${prefix}-${String(i + 1).padStart(2, '0')}`;
            const cluster = await this.prisma.cluster.upsert({
                where: { name: clusterName },
                update: { cluster_location_id: locationId },
                create: {
                    name: clusterName,
                    cluster_location_id: locationId,
                },
            });
            await this.seedServersForCluster(cluster.cluster_id, configs);
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
                    // On utilise la clé étrangère stockée dans la config du cluster
                    fan_config_id: config.fan_config_id,
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
