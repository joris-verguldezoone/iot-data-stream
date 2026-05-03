import { format as csvFormat } from '@fast-csv/format';
import { Readable } from 'stream';
import { prisma } from '../prisma/prisma';
import { Cluster } from '../prisma/generated/prisma/client';

export default class ClusterService {
  private prisma = prisma;

  async getClusters(latestOnly = true): Promise<Cluster[]> {
    try {
      return await this.prisma.cluster.findMany({
        orderBy: { created_at: 'desc' },
        take: latestOnly ? 100 : undefined,
        include: { clusterLocation: true } // Utile pour voir où ils sont
      });
    } catch (e) {
      throw new Error("Erreur lors de la récupération des clusters");
    }
  }

  async getClusterById(cluster_id: number): Promise<Cluster | null | Error> {
    try {
      return await this.prisma.cluster.findUnique({
        where: { cluster_id },
      });
    } catch (e: any) {
      return e;
    }
  }

  async createCluster(data: { name: string; cluster_location_id: number }): Promise<Cluster | Error> {
    try {
      return await this.prisma.cluster.create({ data });
    } catch (e: any) {
      return e;
    }
  }

  async updateCluster(
    cluster_id: number,
    data: Partial<{ name: string; cluster_location_id: number }>
  ): Promise<Cluster | Error> {
    try {
      return await this.prisma.cluster.update({ where: { cluster_id }, data });
    } catch (e: any) {
      return e;
    }
  }

  async deleteCluster(cluster_id: number): Promise<Cluster | Error> {
    try {
      return await this.prisma.cluster.delete({ where: { cluster_id } });
    } catch (e: any) {
      return e;
    }
  }
}