"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class SimulationService {
    prisma;
    io;
    scenarioService;
    static simulatedDate = new Date();
    dataBuffer = [];
    constructor(prisma, io, scenarioService) {
        this.prisma = prisma;
        this.io = io;
        this.scenarioService = scenarioService;
    }
    static resetClock() {
        SimulationService.simulatedDate = new Date();
    }
    static getClock() {
        return new Date(SimulationService.simulatedDate);
    }
    static setClock(date) {
        SimulationService.simulatedDate = new Date(date);
        console.log(`📅 [HORLOGE] La simulation a été calée sur : ${SimulationService.simulatedDate.toISOString()}`);
    }
    async flushBuffer() {
        if (this.dataBuffer.length === 0)
            return;
        const values = this.dataBuffer.map(d => {
            const dateValue = d.time instanceof Date ? d.time : SimulationService.simulatedDate;
            return `(${d.value}, '${dateValue.toISOString()}', ${d.sensor_id})`;
        }).join(',');
        await this.prisma.$executeRawUnsafe(`INSERT INTO "sensor_data" (value, time, sensor_id) VALUES ${values}`);
        this.dataBuffer = [];
    }
    async simulateTick(options = {}) {
        const persist = options.persist === true;
        const tickDuration = options.tickDuration ?? '1h';
        let minutesToAdd = 60;
        if (tickDuration !== '1h') {
            minutesToAdd = parseInt(tickDuration, 10) || 60;
        }
        SimulationService.simulatedDate.setMinutes(SimulationService.simulatedDate.getMinutes() + minutesToAdd);
        await this.scenarioService.processTick();
        const activeClusters = await this.prisma.cluster.findMany({
            include: {
                clusterLocation: true,
                servers: { include: { sensors: true, fans: true } }
            }
        });
        const currentHour = SimulationService.simulatedDate.getHours();
        const loadMultiplier = this.scenarioService.getLoadMultiplier();
        for (const cluster of activeClusters) {
            const profileRow = await this.prisma.loadProfile.findFirst({
                where: {
                    hour: currentHour,
                    cluster_configurations: {
                        some: {
                            cluster_config_id: cluster.cluster_id
                        }
                    }
                }
            });
            let profileLoadFactor = (profileRow?.expected_load_percent ?? 20) / 100;
            if (profileLoadFactor === 0.20) {
                profileLoadFactor = 0.45 + 0.30 * Math.sin(((currentHour - 8) * Math.PI) / 12);
            }
            for (const server of cluster.servers) {
                const isMaster = server.hostname.toLowerCase().includes("master");
                let finalLoad = isMaster ? 0.12 : profileLoadFactor * loadMultiplier;
                if (finalLoad > 1.0)
                    finalLoad = 1.0;
                if (finalLoad < 0.0)
                    finalLoad = 0.0;
                let totalSpeed = 0;
                let activeFansCount = 0;
                for (const f of server.fans) {
                    if (f.status === "ON") {
                        totalSpeed += f.speed_percent;
                        activeFansCount++;
                    }
                }
                const fanSpeed = activeFansCount > 0 ? totalSpeed / server.fans.length : 0;
                const drift = this.scenarioService.getDriftForServer(server.server_id);
                // 🌟 MODÈLE PHYSIQUE RÉALISTE DU CPU (Loi d'échange de calories)
                const tAmb = 22.0;
                let computedTemp = tAmb + (finalLoad * 55) + drift;
                if (fanSpeed > 0) {
                    const coolingPower = (fanSpeed / 100) * 25 * (finalLoad + 0.3);
                    computedTemp -= coolingPower;
                }
                if (computedTemp < tAmb)
                    computedTemp = tAmb;
                if (computedTemp > 105.0)
                    computedTemp = 105.0;
                const baseConsumption = 120;
                const maxConsumption = 450;
                const currentPower = baseConsumption + (finalLoad * (maxConsumption - baseConsumption)) + (fanSpeed * 0.6);
                for (const sensor of server.sensors) {
                    let nextValue = 0;
                    if (sensor.sensor_type === "CPU_TEMP")
                        nextValue = computedTemp;
                    else if (sensor.sensor_type === "LOAD")
                        nextValue = finalLoad * 100;
                    else if (sensor.sensor_type === "TOTAL_POWER")
                        nextValue = currentPower;
                    else if (sensor.sensor_type.startsWith("FAN_SPEED"))
                        nextValue = fanSpeed;
                    await this.prisma.sensor.update({
                        where: { sensor_id: sensor.sensor_id },
                        data: { last_value: Number(nextValue.toFixed(2)) }
                    });
                    if (persist) {
                        this.dataBuffer.push({
                            value: Number(nextValue.toFixed(2)),
                            // 🌟 CLONAGE STRICTE : Fige l'état exact pour ne pas avoir de doublons temporels
                            time: new Date(SimulationService.simulatedDate),
                            sensor_id: sensor.sensor_id
                        });
                    }
                }
            }
        }
        if (persist && this.dataBuffer.length > 0) {
            await this.flushBuffer();
        }
        this.io.emit('tick_completed', {
            timestamp: SimulationService.simulatedDate.toISOString(),
            loadMultiplier,
            hour: currentHour
        });
    }
    async repairFan(fanId) {
        const fan = await this.prisma.fan.findUnique({ where: { fan_id: fanId } });
        if (!fan)
            return { success: false, message: "Ventilateur introuvable" };
        const MAINTENANCE_DELAY_TICKS = 4;
        this.scenarioService.queueRepair(fanId, fan.server_id, MAINTENANCE_DELAY_TICKS);
        this.io.emit('maintenance_started', {
            fanId,
            serverId: fan.server_id,
            durationTicks: MAINTENANCE_DELAY_TICKS
        });
        return {
            success: true,
            message: `Ordre de maintenance reçu. Temps d'accès estimé : ${MAINTENANCE_DELAY_TICKS} ticks.`
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
