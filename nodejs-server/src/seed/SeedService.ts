import { prisma } from "../prisma/prisma";
import Cluster_Location from "../cluster-location/cluster_location.interface";
import { BIG_CLUSTERS, MEDIUM_CLUSTERS, SMALL_CLUSTERS } from "../data_seed/seed_cluster_configuration";
import _ from "lodash";
import { ClusterConfig } from "../types/cluster_configuration_type";

export default class SeedService {
    private prisma: typeof prisma;

    constructor(prismaInstance: typeof prisma) {
        this.prisma = prismaInstance;
    }

    private randomInRange(range: [number, number]): number | null {
        if (!range) return null;
        const [min, max] = range;
        return _.random(min, max, true);
    }

    /**
     * ✅ PHASE 1 : Initialisation des Catalogues Hardware
     * Obligatoire pour satisfaire les contraintes NOT NULL de ClusterConfiguration
     */
    private async seedHardwareCatalogs() {
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

    async buildExercise(locations: Cluster_Location[]) {
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

    private async linkConfigsToLocation(locationId: number) {
        const groups = [BIG_CLUSTERS, MEDIUM_CLUSTERS, SMALL_CLUSTERS];
        
        const fanCatalogs = await this.prisma.fanCatalog.findMany();
        const coolerCatalogs = await this.prisma.cpuCoolerCatalog.findMany();
        const fanConfigs = await this.prisma.fanConfiguration.findMany();

        for (const group of groups) {
            for (const config of Object.values(group) as ClusterConfig[]) {
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
                        fan_catalog_id: fanCatalog.fan_catalog_id           // FIX: Ne sera plus NULL
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

    private async generateClustersForLocation(location: any, clusterCount: number) {
        const configs = await this.prisma.clusterConfiguration.findMany({
            where: { location_id: location.location_id }
        });

        for (let i = 0; i < clusterCount; i++) {
            const config = _.sample(configs)!; 
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

    private async seedServersForCluster(clusterId: number, config: any) {
        const totalServers = config.master + config.worker;

        for (let i = 1; i <= totalServers; i++) {
            const isMaster = i <= config.master;
            const server = await this.prisma.server.create({
                data: {
                    hostname: `SRV-${isMaster ? 'MST' : 'WRK'}-${String(i).padStart(3, '0')}-CID${clusterId}`,
                    cluster_id: clusterId,
                    config_id: config.cluster_config_id,
                    base_consumption_offset: _.random(-5, 5, true),
                    status: "ON"
                }
            });

            await this.attachHardware(server.server_id, config);
        }
    }

    private async attachHardware(serverId: number, config: any) {
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