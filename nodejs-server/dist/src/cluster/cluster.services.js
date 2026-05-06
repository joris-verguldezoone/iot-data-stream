"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const prisma_1 = require("../prisma/prisma");
class ClusterService {
    prisma = prisma_1.prisma;
    async getClusters(latestOnly = true) {
        try {
            return await this.prisma.cluster.findMany({
                orderBy: { created_at: 'desc' },
                take: latestOnly ? 100 : undefined,
                include: { clusterLocation: true } // Utile pour voir où ils sont
            });
        }
        catch (e) {
            throw new Error("Erreur lors de la récupération des clusters");
        }
    }
    async getClusterById(cluster_id) {
        try {
            return await this.prisma.cluster.findUnique({
                where: { cluster_id },
            });
        }
        catch (e) {
            return e;
        }
    }
    async createCluster(data) {
        try {
            return await this.prisma.cluster.create({ data });
        }
        catch (e) {
            return e;
        }
    }
    async updateCluster(cluster_id, data) {
        try {
            return await this.prisma.cluster.update({ where: { cluster_id }, data });
        }
        catch (e) {
            return e;
        }
    }
    async deleteCluster(cluster_id) {
        try {
            return await this.prisma.cluster.delete({ where: { cluster_id } });
        }
        catch (e) {
            return e;
        }
    }
}
exports.default = ClusterService;
