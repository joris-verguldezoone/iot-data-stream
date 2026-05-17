"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const prisma_1 = require("../prisma/prisma");
class ClusterService {
    prisma = prisma_1.prisma;
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
    async getClusterById(cluster_id) {
        return await this.prisma.cluster.findUnique({
            where: { cluster_id },
            include: { clusterLocation: true }
        });
    }
    async createCluster(data) {
        return await this.prisma.cluster.create({
            data: {
                name: data.name,
                cluster_location_id: data.cluster_location_id
            }
        });
    }
    async updateCluster(cluster_id, data) {
        return await this.prisma.cluster.update({
            where: { cluster_id },
            data
        });
    }
    async deleteCluster(cluster_id) {
        return await this.prisma.cluster.delete({
            where: { cluster_id }
        });
    }
}
exports.default = ClusterService;
