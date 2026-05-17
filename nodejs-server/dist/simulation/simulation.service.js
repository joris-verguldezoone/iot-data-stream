"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const lodash_1 = __importDefault(require("lodash"));
const service_1 = require("../openweatherapi/service"); // Connexion à ton API météo réelle
class SimulationService {
    prisma;
    io;
    scenarioService;
    // 🌟 Horloge virtuelle progressive partagée entre toutes les instances du service
    static simulatedDate = new Date();
    dataBuffer = [];
    constructor(prisma, io, scenarioService) {
        this.prisma = prisma;
        this.io = io;
        this.scenarioService = scenarioService;
    }
    /**
     * Réinitialise l'horloge virtuelle sur l'heure actuelle
     */
    static resetClock() {
        SimulationService.simulatedDate = new Date();
    }
    async flushBuffer() {
        if (this.dataBuffer.length === 0)
            return;
        const values = this.dataBuffer.map(d => {
            const dateValue = d.time instanceof Date ? d.time : SimulationService.simulatedDate;
            return `(${d.value}, '${dateValue.toISOString()}', ${d.sensor_id})`;
        }).join(',');
        try {
            await this.prisma.$executeRawUnsafe(`INSERT INTO "sensor_data" (value, time, sensor_id) VALUES ${values}`);
            this.dataBuffer = [];
        }
        catch (e) {
            console.error("❌ [DB] Échec du Bulk Insert Télémétrie :", e);
        }
    }
    pushToBuffer(sensorId, value) {
        this.dataBuffer.push({
            sensor_id: sensorId,
            value: Number(value.toFixed(2)),
            time: SimulationService.simulatedDate // 🌟 Utilisation de l'horloge progressive
        });
    }
    async simulateTick(options) {
        // 🌟 ÉTAPE CHRONOLOGIE : Avancement dynamique de l'horloge virtuelle avant le calcul physique
        let minutesToAdd = 60; // Valeur par défaut historique (1h)
        if (options?.tickDuration) {
            if (options.tickDuration === '1h') {
                minutesToAdd = 60;
            }
            else {
                minutesToAdd = parseInt(options.tickDuration, 10) || 60;
            }
        }
        SimulationService.simulatedDate.setMinutes(SimulationService.simulatedDate.getMinutes() + minutesToAdd);
        await this.scenarioService.processTick();
        const configs = await this.prisma.clusterConfiguration.findMany({
            include: {
                load_profile: true,
                location: true,
                servers: { include: { sensors: true, fans: true } }
            }
        });
        let grandTotalItPower = 0;
        let weightedPueSum = 0;
        let allServersCount = 0;
        let totalCpuTempSum = 0;
        for (const config of configs) {
            const targetLoad = config.load_profile?.expected_load_percent ?? 20;
            console.log(`--- BLOC CONFIGURATION : ${config.name} (Cible Profil : ${targetLoad}%) ---`);
            const cityName = config.location?.name || "Paris";
            let externalWeatherTemp = 15.0;
            try {
                externalWeatherTemp = await (0, service_1.getLiveWeather)(cityName);
            }
            catch (err) {
                // Taux limite ou coupure réseau : repli de sécurité silencieux
            }
            let configItPower = 0;
            let configCpuTempSum = 0;
            const configServersCount = config.servers.length;
            for (const server of config.servers) {
                await this.applyThermalRegulation(server);
                await this.generateServerData(server, targetLoad, options);
                const powerSensor = server.sensors.find(s => s.sensor_type.toUpperCase() === 'TOTAL_POWER');
                const tempSensor = server.sensors.find(s => s.sensor_type.toUpperCase() === 'CPU_TEMP');
                configItPower += powerSensor?.last_value ?? 0;
                configCpuTempSum += tempSensor?.last_value ?? 30;
            }
            const configAvgCpuTemp = configServersCount > 0 ? configCpuTempSum / configServersCount : 30;
            const baseFactor = 0.3;
            let envFactor = config.location?.env_factor ?? 1.0;
            if (externalWeatherTemp > 15.0) {
                envFactor += (externalWeatherTemp - 15.0) * 0.006;
            }
            if (configAvgCpuTemp > 60.0) {
                envFactor += (configAvgCpuTemp - 60.0) * 0.004;
            }
            const infraOverhead = configItPower * baseFactor * envFactor;
            const configPue = configItPower > 0 ? (configItPower + infraOverhead) / configItPower : 1.0;
            grandTotalItPower += configItPower;
            weightedPueSum += configPue * configItPower;
            allServersCount += configServersCount;
            totalCpuTempSum += configCpuTempSum;
            console.log(`📍 [MÉTÉO] ${cityName} : ${externalWeatherTemp.toFixed(1)}°C | PUE local du Cluster : ${configPue.toFixed(3)}`);
        }
        if (options?.persist === true) {
            await this.flushBuffer();
        }
        else {
            this.dataBuffer = []; // Anti-fuite mémoire
        }
        const globalAvgTemp = allServersCount > 0 ? totalCpuTempSum / allServersCount : 30;
        const globalPue = grandTotalItPower > 0 ? weightedPueSum / grandTotalItPower : 1.2;
        const totalPowerWithClim = grandTotalItPower * globalPue;
        console.log(`📡 [EMIT] Global datacenter -> Temp CPU: ${globalAvgTemp.toFixed(1)}°C | Puissance Totale: ${totalPowerWithClim.toFixed(0)}W | PUE Moyen: ${globalPue.toFixed(3)}`);
        // 🌟 Transmission de la date virtuelle aux dashboards websockets en direct
        this.io.emit('tick_update', {
            timestamp: SimulationService.simulatedDate,
            avgTemp: globalAvgTemp.toFixed(1),
            totalPower: totalPowerWithClim.toFixed(0),
            pue: globalPue.toFixed(3)
        });
    }
    async generateServerData(server, targetLoad, options) {
        let isServerOff = server.status === 'OFF';
        const loadSensor = server.sensors.find(s => s.sensor_type.toUpperCase() === 'LOAD');
        let currentSensorValue = loadSensor?.last_value || targetLoad;
        let actualTickLoad = 0;
        if (!isServerOff) {
            if (currentSensorValue >= 99) {
                actualTickLoad = 100;
            }
            else {
                actualTickLoad = Math.abs(currentSensorValue - targetLoad) > 5
                    ? (currentSensorValue > targetLoad ? currentSensorValue - 5 : currentSensorValue + 5)
                    : targetLoad + lodash_1.default.random(-2, 2);
            }
        }
        const activeFans = server.fans.filter(f => f.status === 'ON');
        const avgFanSpeed = activeFans.length > 0 ? lodash_1.default.meanBy(activeFans, 'speed_percent') : 0;
        const driftPenalty = this.scenarioService.getDriftForServer(server.server_id);
        const tempSensor = server.sensors.find(s => s.sensor_type.toUpperCase() === 'CPU_TEMP');
        let previousTemp = tempSensor?.last_value || 30;
        let finalTemp = 30;
        if (isServerOff) {
            finalTemp = previousTemp - ((previousTemp - 30) * 0.15);
        }
        else {
            const heatGain = (actualTickLoad * 0.55) + driftPenalty;
            const cooling = (avgFanSpeed * 0.25);
            finalTemp = previousTemp + ((heatGain - cooling) * 0.15) + lodash_1.default.random(-0.1, 0.1);
        }
        finalTemp = lodash_1.default.clamp(finalTemp, 30, 110);
        if (finalTemp >= 100 && !isServerOff) {
            console.log(`🚨 [SÉCURITÉ] ARRET D'URGENCE THERMIQUE : ${server.hostname}`);
            this.io.emit('emergency_shutdown', { hostname: server.hostname, temp: Math.round(finalTemp) });
            await this.prisma.server.update({
                where: { server_id: server.server_id },
                data: { status: 'OFF' }
            });
            isServerOff = true;
            actualTickLoad = 0;
            finalTemp = previousTemp - ((previousTemp - 30) * 0.15);
        }
        const finalPower = isServerOff
            ? 15
            : 100 + (actualTickLoad * 2.5) + (activeFans.length * (avgFanSpeed * 0.4));
        for (const sensor of server.sensors) {
            const sensorType = sensor.sensor_type.toUpperCase();
            let newValue = 0;
            if (sensorType === 'LOAD')
                newValue = actualTickLoad;
            else if (sensorType === 'CPU_TEMP')
                newValue = finalTemp;
            else if (sensorType === 'TOTAL_POWER')
                newValue = finalPower;
            else if (sensorType === 'FAN_SPEED_1')
                newValue = server.fans[0]?.speed_percent ?? 0;
            else if (sensorType === 'FAN_SPEED_2')
                newValue = server.fans[1]?.speed_percent ?? 0;
            await this.prisma.sensor.update({
                where: { sensor_id: sensor.sensor_id },
                data: { last_value: newValue }
            });
            if (options?.persist === true) {
                this.pushToBuffer(sensor.sensor_id, newValue);
            }
        }
        console.log(`[DEBUG] ${server.hostname.padEnd(12)} | Alim: ${isServerOff ? 'OFF' : 'ON '} | Charge: ${actualTickLoad.toFixed(0)}% | Temp: ${finalTemp.toFixed(1)}°C`);
    }
    async applyThermalRegulation(server) {
        const targetTemp = 60.0;
        const tempSensor = server.sensors.find(s => s.sensor_type.toUpperCase() === 'CPU_TEMP');
        if (!tempSensor || server.status === 'OFF')
            return;
        const currentTemp = tempSensor.last_value || 30;
        const autoFans = server.fans.filter(f => f.control_mode === 'AUTO' && f.status === 'ON');
        if (autoFans.length === 0)
            return;
        let speedAdjustment = (currentTemp - targetTemp) * 4.0;
        for (const fan of autoFans) {
            let newSpeed = lodash_1.default.clamp(fan.speed_percent + speedAdjustment, 20, 100);
            await this.prisma.fan.update({
                where: { fan_id: fan.fan_id },
                data: { speed_percent: Math.round(newSpeed) }
            });
            fan.speed_percent = Math.round(newSpeed);
        }
    }
    async repairFan(fanId) {
        const fan = await this.prisma.fan.findUnique({ where: { fan_id: fanId } });
        if (!fan) {
            return { success: false, message: `Le ventilateur avec l'ID ${fanId} n'existe pas.` };
        }
        if (this.scenarioService.isFanUnderRepair(fanId)) {
            return { success: false, message: `L'intervention est déjà en cours pour le ventilateur ${fanId}. Veuillez patienter.` };
        }
        const MAINTENANCE_DELAY_TICKS = 5;
        this.scenarioService.queueRepair(fanId, fan.server_id, MAINTENANCE_DELAY_TICKS);
        console.log(`🔧 [MAINTENANCE] Ticket ouvert. Technicien dépêché pour le ventilateur ${fanId} (Arrivée dans ${MAINTENANCE_DELAY_TICKS} ticks).`);
        this.io.emit('maintenance_started', {
            fanId,
            serverId: fan.server_id,
            durationTicks: MAINTENANCE_DELAY_TICKS
        });
        return {
            success: true,
            message: `Ordre de maintenance reçu. Le technicien est en route vers le rack du ventilateur ${fanId}. Temps d'accès estimé : ${MAINTENANCE_DELAY_TICKS} ticks.`
        };
    }
    async getAgentState() {
        const servers = await this.prisma.server.findMany({
            include: { sensors: true }
        });
        return {
            observations: servers.map(srv => {
                const tempSensor = srv.sensors.find(s => s.sensor_type.toUpperCase() === 'CPU_TEMP');
                const loadSensor = srv.sensors.find(s => s.sensor_type.toUpperCase() === 'LOAD');
                return {
                    serverId: srv.server_id,
                    hostname: srv.hostname,
                    cpuTemp: tempSensor?.last_value ?? 30,
                    cpuLoad: loadSensor?.last_value ?? 0
                };
            })
        };
    }
}
exports.default = SimulationService;
