"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const lodash_1 = __importDefault(require("lodash"));
const fan_configuration_1 = require("../interfaces/fan_configuration");
const seed_cluster_configuration_1 = require("../data_seed/seed_cluster_configuration");
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
    async seedFanConfiguration() {
        if (!fan_configuration_1.FAN_SEED?.length)
            return;
        for (const fan of fan_configuration_1.FAN_SEED) {
            const consomation = Array.isArray(fan.consomation)
                ? lodash_1.default.random(fan.consomation[0], fan.consomation[1], true)
                : fan.consomation ?? 0;
            // ✅ Utilisation directe sans check '?'
            await this.prisma.fanConfiguration.upsert({
                where: { name: fan.name },
                update: { consomation },
                create: { name: fan.name, consomation },
            });
            console.log(`🎛️ Fan config seedée: ${fan.name}`);
        }
    }
    async seedClusterConfiguration() {
        const groups = [seed_cluster_configuration_1.BIG_CLUSTERS, seed_cluster_configuration_1.MEDIUM_CLUSTERS, seed_cluster_configuration_1.SMALL_CLUSTERS];
        for (const group of groups) {
            if (!group)
                continue;
            for (const config of Object.values(group)) {
                await this.prisma.clusterConfiguration.upsert({
                    where: { name: config.name },
                    update: {
                        master: config.masters,
                        worker: config.workers,
                        consomation_per_master: this.randomInRange(config.consomation_per_master),
                        consomation_per_worker: this.randomInRange(config.consomation_per_worker),
                        hardware_per_master: config.hardware_per_master,
                        hardware_per_worker: config.hardware_per_worker,
                        env_factor: config.env_factor,
                        pue: config.PUE,
                    },
                    create: {
                        name: config.name,
                        master: config.masters,
                        worker: config.workers,
                        consomation_per_master: this.randomInRange(config.consomation_per_master),
                        consomation_per_worker: this.randomInRange(config.consomation_per_worker),
                        hardware_per_master: config.hardware_per_master,
                        hardware_per_worker: config.hardware_per_worker,
                        env_factor: config.env_factor,
                        pue: config.PUE,
                    },
                });
                console.log(`⚙️ Cluster config seedée: ${config.name}`);
            }
        }
    }
    async seedClusters() {
        const total = 50;
        const locations = [
            ...Array(Math.floor(total * 0.8)).fill('Marseille'),
            ...Array(Math.ceil(total * 0.2)).fill('Paris'),
        ];
        for (let i = 0; i < locations.length; i++) {
            const name = `CL-${locations[i].slice(0, 3).toUpperCase()}-${String(i + 1).padStart(2, '0')}`;
            await this.prisma.cluster.upsert({
                where: { name },
                update: {},
                create: { name, location: locations[i] },
            });
            console.log(`🏢 Cluster seedé: ${name}`);
        }
    }
    async seedServersAndSensors() {
        const clusters = await this.prisma.cluster.findMany();
        for (const cluster of clusters) {
            const exists = await this.prisma.server.count({
                where: { cluster_id: cluster.cluster_id },
            });
            if (exists > 0)
                continue;
            for (let i = 1; i <= 5; i++) {
                const hostname = `${cluster.name}-srv${String(i).padStart(2, '0')}`;
                const server = await this.prisma.server.create({
                    data: {
                        hostname,
                        cluster_id: cluster.cluster_id,
                    },
                });
                const temp = await this.prisma.sensor.create({
                    data: {
                        server_id: server.server_id,
                        sensor_type: 'temperature',
                        unit: '°C',
                        last_value: 20,
                    },
                });
                const power = await this.prisma.sensor.create({
                    data: {
                        server_id: server.server_id,
                        sensor_type: 'power',
                        unit: 'W',
                        last_value: 100,
                    },
                });
                await this.prisma.sensorData.createMany({
                    data: [
                        { sensor_id: temp.sensor_id, value: 20 },
                        { sensor_id: power.sensor_id, value: 100 },
                    ],
                });
                console.log(`🖥️ Server seedé: ${hostname}`);
            }
        }
    }
}
exports.default = SeedService;
