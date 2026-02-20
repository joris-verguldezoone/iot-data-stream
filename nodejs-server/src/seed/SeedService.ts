import _ from 'lodash'
import { FAN_SEED } from '../interfaces/fan_configuration'
import {
  BIG_CLUSTERS,
  MEDIUM_CLUSTERS,
  SMALL_CLUSTERS,
} from '../data_seed/seed_cluster_configuration'
import { ClusterConfig } from '../types/cluster_configuration_type'
import { prisma } from '../prisma/prisma';


export default class SeedService {
 private prisma: typeof prisma

  constructor(prismaInstance: typeof prisma) {
  this.prisma = prismaInstance
  }

  private randomInRange(range?: [number, number]): number | null {
    if (!range) return null
    const [min, max] = range
    return _.random(min, max, true)
  }

  async seedFanConfiguration() {
    if (!FAN_SEED?.length) return

    for (const fan of FAN_SEED) {
      const consomation = Array.isArray(fan.consomation)
        ? _.random(fan.consomation[0], fan.consomation[1], true)
        : fan.consomation ?? 0

      // ✅ Utilisation directe sans check '?'
      await this.prisma.fanConfiguration.upsert({
        where: { name: fan.name },
        update: { consomation },
        create: { name: fan.name, consomation },
      })

      console.log(`🎛️ Fan config seedée: ${fan.name}`)
    }
  }

  async seedClusterConfiguration() {
    const groups = [BIG_CLUSTERS, MEDIUM_CLUSTERS, SMALL_CLUSTERS]

    for (const group of groups) {
      if (!group) continue

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
        })

        console.log(`⚙️ Cluster config seedée: ${config.name}`)
      }
    }
  }

  async seedClusters() {
    const total = 50
    const locations = [
      ...Array(Math.floor(total * 0.8)).fill('Marseille'),
      ...Array(Math.ceil(total * 0.2)).fill('Paris'),
    ]

    for (let i = 0; i < locations.length; i++) {
      const name = `CL-${locations[i].slice(0, 3).toUpperCase()}-${String(i + 1).padStart(2, '0')}`

      await this.prisma.cluster.upsert({
        where: { name },
        update: {},
        create: { name, location: locations[i] },
      })

      console.log(`🏢 Cluster seedé: ${name}`)
    }
  }

  async seedServersAndSensors() {
    const clusters = await this.prisma.cluster.findMany()

    for (const cluster of clusters) {
      const exists = await this.prisma.server.count({
        where: { cluster_id: cluster.cluster_id },
      })

      if (exists > 0) continue

      for (let i = 1; i <= 5; i++) {
        const hostname = `${cluster.name}-srv${String(i).padStart(2, '0')}`

        const server = await this.prisma.server.create({
          data: {
            hostname,
            cluster_id: cluster.cluster_id,
          },
        })

        const temp = await this.prisma.sensor.create({
          data: {
            server_id: server.server_id,
            sensor_type: 'temperature',
            unit: '°C',
            last_value: 20,
          },
        })

        const power = await this.prisma.sensor.create({
          data: {
            server_id: server.server_id,
            sensor_type: 'power',
            unit: 'W',
            last_value: 100,
          },
        })

        await this.prisma.sensorData.createMany({
          data: [
            { sensor_id: temp.sensor_id, value: 20 },
            { sensor_id: power.sensor_id, value: 100 },
          ],
        })

        console.log(`🖥️ Server seedé: ${hostname}`)
      }
    }
  }
}