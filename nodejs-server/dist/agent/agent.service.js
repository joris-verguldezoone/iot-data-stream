"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AgentService = void 0;
const socket_io_1 = require("socket.io");
const lodash_1 = __importDefault(require("lodash"));
const service_1 = require("../openweatherapi/service"); // 🚨 Connexion à ton API météo réelle
class AgentService {
    prisma;
    io;
    constructor(prisma, io = new socket_io_1.Server()) {
        this.prisma = prisma;
        this.io = io;
    }
    /**
     * Récupère l'état complet de l'environnement pour le script Python (Flux chaud)
     */
    async getEnvironmentState() {
        const servers = await this.prisma.server.findMany({
            include: {
                sensors: true,
                fans: true,
                cluster: { include: { clusterLocation: true } }
            }
        });
        const observations = servers.map(s => this.mapServerToObservation(s));
        // 1. Calcul des agrégats IT et thermiques instantanés
        const totalPower = observations.reduce((acc, obs) => acc + obs.powerWatts, 0);
        const avgTemp = observations.reduce((acc, obs) => acc + obs.cpuTemp, 0) / (servers.length || 1);
        // 2. Détermination de la météo extérieure (basée sur la localisation du premier serveur)
        const cityName = servers[0]?.cluster?.clusterLocation?.name || "Paris";
        let externalWeatherTemp = 15.0; // Valeur de repli par défaut (Anti-crash si l'API est hors-ligne)
        try {
            externalWeatherTemp = await (0, service_1.getLiveWeather)(cityName);
        }
        catch (err) {
            // Silencieux pour éviter de bloquer la boucle des étudiants en cas de timeout OpenWeather
        }
        // 3. Application de la formule Option B (Météo extérieure + Surchauffe CPU)
        const baseInfrastructureFactor = 0.25;
        const weatherPenalty = externalWeatherTemp > 15.0 ? (externalWeatherTemp - 15.0) * 0.008 : 0.0;
        const serverHeatingPenalty = avgTemp > 40.0 ? (avgTemp - 40.0) * 0.005 : 0.0;
        const currentPue = Number(lodash_1.default.clamp(1.0 + baseInfrastructureFactor + weatherPenalty + serverHeatingPenalty, 1.15, 2.50).toFixed(3));
        const totalFacilityPower = totalPower * currentPue;
        return {
            timestamp: new Date(),
            observations,
            globalMetrics: {
                pue: currentPue,
                totalPower: Number(totalFacilityPower.toFixed(1)),
                averageTemp: Number(avgTemp.toFixed(1))
            },
            reward: this.computeReward(observations, currentPue),
            isTerminal: servers.some(s => s.status === 'OFF') // Partie perdue si un serveur subit un crash
        };
    }
    /**
     * Applique les ordres d'action envoyés par l'IA des étudiants
     */
    async applyActions(actions) {
        for (const action of actions) {
            switch (action.type) {
                case 'SET_FAN_SPEED':
                    await this.prisma.fan.update({
                        where: { fan_id: action.id },
                        data: {
                            speed_percent: Math.round(action.value),
                            control_mode: 'MANUAL'
                        }
                    });
                    break;
                case 'SET_SERVER_LOAD':
                    await this.prisma.sensor.updateMany({
                        where: { server_id: action.id, sensor_type: 'LOAD' },
                        data: { last_value: action.value }
                    });
                    break;
            }
            this.io.emit('agent_action_applied', {
                type: action.type,
                targetId: action.id,
                newValue: action.value
            });
        }
    }
    mapServerToObservation(server) {
        const getSensorValue = (type) => server.sensors.find((s) => s.sensor_type.toUpperCase() === type)?.last_value || 0;
        return {
            serverId: server.server_id,
            hostname: server.hostname,
            status: server.status,
            cpuTemp: getSensorValue('CPU_TEMP'),
            cpuLoad: getSensorValue('LOAD'),
            powerWatts: getSensorValue('TOTAL_POWER'),
            fanSpeeds: server.fans.map((f) => f.speed_percent)
        };
    }
    /**
     * Calcule le score de performance (Reward) de l'étudiant
     */
    computeReward(obs, pue) {
        // Bonus inversement proportionnel au PUE (Plus le PUE est proche de 1, plus le score monte)
        let reward = (2.0 - pue) * 10;
        for (const server of obs) {
            // Malus si un processeur surchauffe (Seuil d'alerte à 75°C)
            if (server.cpuTemp > 75) {
                reward -= (server.cpuTemp - 75) * 2.0;
            }
            // Énorme pénalité financière et opérationnelle si la machine s'éteint
            if (server.status === 'OFF') {
                reward -= 500.0;
            }
        }
        return Number(reward.toFixed(4));
    }
    /**
     * Conservé à 100% : Outil d'analyse statistique d'historique pour la détection de dérives
     */
    async getContextualObservation(sensorId) {
        const sensor = await this.prisma.sensor.findUnique({
            where: { sensor_id: sensorId }
        });
        const stats = await this.prisma.$queryRaw `
            SELECT avg_temp 
            FROM sensor_stats_hourly 
            WHERE sensor_id = ${sensorId} 
            ORDER BY bucket DESC 
            LIMIT 1
        `;
        const current = sensor?.last_value ?? 30.0;
        const baseline = stats[0]?.avg_temp ?? 30.0;
        return {
            sensorId,
            current,
            baseline,
            deviation: Number((current - baseline).toFixed(2))
        };
    }
}
exports.AgentService = AgentService;
