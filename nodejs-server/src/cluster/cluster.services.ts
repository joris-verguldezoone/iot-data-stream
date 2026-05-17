import { prisma } from '../prisma/prisma';
import { Cluster } from '@prisma/client';
import { CreateClusterDTO, UpdateClusterDTO } from './cluster.dto';

export default class ClusterService {
  private prisma = prisma;

// Exemple de ce que ton service devrait faire :
async getClusters() {
  const clusters = await this.prisma.cluster.findMany({
    include: { clusterLocation: true }
  });

  return clusters.map(c => ({
    ...c, 
    // On crée le champ 'city' à partir de 'location'
    city: c.clusterLocation?.location || null 
  }));
}

  async getClusterById(cluster_id: number): Promise<Cluster | null> {
    return await this.prisma.cluster.findUnique({
      where: { cluster_id },
      include: { clusterLocation: true }
    });
  }

  async createCluster(data: CreateClusterDTO): Promise<Cluster> {
    return await this.prisma.cluster.create({
      data: {
        name: data.name,
        cluster_location_id: data.cluster_location_id
      }
    });
  }

  async updateCluster(cluster_id: number, data: UpdateClusterDTO): Promise<Cluster> {
    return await this.prisma.cluster.update({
      where: { cluster_id },
      data
    });
  }

  async deleteCluster(cluster_id: number): Promise<Cluster> {
    return await this.prisma.cluster.delete({
      where: { cluster_id }
    });
  }
}