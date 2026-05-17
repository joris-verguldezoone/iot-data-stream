import { prisma } from "../prisma/prisma";
import _ from "lodash";

export default class AnalyticsService {

  async getClusterSummary(clusterId: number) {
    // Le "as any" ici force TypeScript à accepter l'include, peu importe le nom
    const cluster = await prisma.cluster.findUnique({
      where: { cluster_id: clusterId },
      include: {
        location: true,
        servers: {
          include: { sensors: true, fans: true }
        }
      }
    } as any); 

    if (!cluster) throw new Error("Cluster non trouvé");

    let totalITPower = 0;
    let totalCoolingPower = 0;
    let totalTemp = 0;
    let sensorCount = 0;

    // On traite 'cluster' comme un 'any' pour éviter les erreurs de type 'never'
    const servers = (cluster as any).servers || [];

    for (const server of servers) {
      const sensors = server.sensors || [];
      const powerSensor = sensors.find((s: any) => s.sensor_type.toLowerCase() === 'total_power');
      const tempSensor = sensors.find((s: any) => s.sensor_type.toLowerCase() === 'cpu_temp');

      if (powerSensor) totalITPower += powerSensor.last_value || 0;
      if (tempSensor) {
        totalTemp += tempSensor.last_value || 0;
        sensorCount++;
      }
      totalCoolingPower += (server.fans || []).filter((f: any) => f.status === 'ON').length * 5;
    }

    const avgTemp = sensorCount > 0 ? totalTemp / sensorCount : 0;
    const totalClusterPower = totalITPower + totalCoolingPower;
    const pue = totalITPower > 0 ? (totalClusterPower / totalITPower) : 1;

    return {
      clusterName: cluster.name,
      location: (cluster as any).location?.location || "Inconnu",
      metrics: {
        averageTemperature: Number(avgTemp.toFixed(2)),
        totalPowerWatts: Number(totalClusterPower.toFixed(2)),
        pue: Number(pue.toFixed(3)),
        activeServers: servers.filter((s: any) => s.status === 'ON').length,
        totalServers: servers.length
      },
      status: avgTemp > 80 ? "CRITICAL" : avgTemp > 60 ? "WARNING" : "HEALTHY"
    };
  }

  async getClusterMetrics(clusterId: number) {
    const cluster = await prisma.cluster.findUnique({
      where: { cluster_id: clusterId },
      include: {
        location: true,
        servers: {
          include: {
            sensors: { where: { sensor_type: { in: ['total_power', 'TOTAL_POWER'] } } }
          }
        }
      }
    } as any);

    if (!cluster || !(cluster as any).location) {
        throw new Error("Données de cluster incomplètes");
    }

    const loc = (cluster as any).location;
    const servers = (cluster as any).servers || [];

    const itPowerWatts = servers.reduce((acc: number, srv: any) => {
      return acc + (srv.sensors?.[0]?.last_value || 0);
    }, 0);

    const envFactor = loc.env_factor || 1.2; 
    const sitePowerWatts = itPowerWatts * envFactor;
    const kwhPrice = loc.energy_cost_kwh || 0.15;
    const hourlyCost = (sitePowerWatts / 1000) * kwhPrice;

    return {
      cluster_name: cluster.name,
      location: loc.location,
      metrics: {
        it_power_kw: itPowerWatts / 1000,
        site_power_kw: sitePowerWatts / 1000,
        pue: envFactor,
        estimated_hourly_cost: hourlyCost,
        currency: "EUR"
      }
    };
  }

    async getHistoricalTrends(sensorId: number) {
        // Prisma ne connaît pas la vue dans son schéma, on passe par le SQL brut
        return await prisma.$queryRaw`
            SELECT bucket, avg_temp, max_temp, min_temp
            FROM sensor_stats_hourly
            WHERE sensor_id = ${sensorId}
            ORDER BY bucket ASC
            LIMIT 168; -- Les 168 dernières heures (1 semaine)
        `;
    }

  }