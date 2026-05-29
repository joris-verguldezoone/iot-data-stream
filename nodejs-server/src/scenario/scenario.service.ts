// src/scenario/scenario.service.ts
import { PrismaClient } from "@prisma/client";
import { eventsDetails, Scenario } from '../data_seed/scenarios';

export class ScenarioService {
    private activeScenario: Scenario | null = null;
    private currentTick: number = 0;
    private activeThermalDrifts: Map<number, number> = new Map();
    private currentLoadMultiplier: number = 1.0;
    private pendingRepairs: Map<number, { serverId: number; remainingTicks: number }> = new Map();

    constructor(private prisma: PrismaClient, private io: any) {}

    private getRandomOffset(min: number = -10, max: number = 10): number {
        return Math.floor(Math.random() * (max - min + 1)) + min;
    }

    getCurrentScenario(): Scenario | null {
        return this.activeScenario;
    }

    getLoadMultiplier(): number {
        return this.currentLoadMultiplier;
    }

    getAllThermalDrifts(): Record<number, number> {
        return Object.fromEntries(this.activeThermalDrifts);
    }

    async loadScenario(scenarioId: string): Promise<void> {
        const found = eventsDetails.find(s => s.id === scenarioId);
        if (!found) throw new Error(`Scenario [${scenarioId}] introuvable.`);

        const randomizedEvents = found.events.map(event => {
            const offset = this.getRandomOffset(-10, 10);
            const initialTick = event.tick;
            const dynamicTick = Math.max(1, initialTick + offset);
            
            console.log(`[ENTROPIE] Evenement [${event.type}] (Prevu initialement au Tick ${initialTick}) replanifie dynamiquement au Tick ${dynamicTick} (Offset: ${offset > 0 ? '+' : ''}${offset})`);
            
            return {
                ...event,
                tick: dynamicTick
            };
        });

        this.activeScenario = {
            ...found,
            events: randomizedEvents
        };

        this.currentTick = 0;
        this.activeThermalDrifts.clear();
        this.pendingRepairs.clear(); 
        this.currentLoadMultiplier = 1.0;
        
        console.log(`[READY] Scenario arme avec entropie variable : ${this.activeScenario.name}`);
        this.io.emit("scenario_started", { name: found.name, description: found.description });
    }

    async processTick(): Promise<void> {
        this.currentTick++;
        console.log(`[TICK] Scenario Service - Pas : ${this.currentTick}`);

        // Gestion du delai de maintenance (4 ticks de transit)
        for (const [fanId, repair] of this.pendingRepairs.entries()) {
            repair.remainingTicks--;
            
            if (repair.remainingTicks > 0) {
                console.log(`[MAINTENANCE] Ventilateur ${fanId} en cours de remplacement...`);
                this.io.emit("maintenance_progress", { fanId, remainingTicks: repair.remainingTicks });
            } else {
                try {
                    await this.prisma.fan.update({
                        where: { fan_id: fanId },
                        data: { status: 'ON', control_mode: 'AUTO', speed_percent: 20 }
                    });
                    this.clearDriftForServer(repair.serverId);
                    console.log(`[MAINTENANCE SUCCESS] Remplacement du Ventilateur ${fanId} termine.`);
                    this.io.emit("maintenance_complete", { fanId, serverId: repair.serverId });
                } catch (e) {
                    console.warn(`[MAINTENANCE WARN] Impossible de reparer le fan ${fanId} (ID obsolete pour cette topologie).`);
                } finally {
                    this.pendingRepairs.delete(fanId);
                }
            }
        }

        if (!this.activeScenario) return;

        const eventsToRun = this.activeScenario.events.filter(e => e.tick === this.currentTick);

        for (const event of eventsToRun) {
            console.log(`[WARN] Evenement scenario enclenche : [${event.type}] au Tick ${this.currentTick}`);
            this.io.emit("scenario_event_triggered", event);

            try {
                switch (event.type) {
                    case 'CRASH_FAN':
                        if (event.targetId) {
                            await this.prisma.fan.update({
                                where: { fan_id: event.targetId },
                                data: { speed_percent: 0, control_mode: 'MANUAL', status: 'CRASH_FAN' }
                            });
                            console.log(`[CRASH] Le ventilateur ${event.targetId} a ete sabote.`);
                        }
                        break;

                    case 'LOAD_SPIKE_ALL':
                        if (event.value !== undefined) {
                            this.currentLoadMultiplier = event.value;
                            await this.prisma.sensor.updateMany({
                                where: { sensor_type: 'LOAD' },
                                data: { last_value: event.value * 50 }
                            });
                        }
                        break;

                    case 'THERMAL_DRIFT_SERVER':
                        if (event.targetId && event.value !== undefined) {
                            const serverExists = await this.prisma.server.findUnique({ where: { server_id: event.targetId } });
                            if (serverExists) {
                                this.activeThermalDrifts.set(event.targetId, event.value);
                                console.log(`[HEAT] Derive thermique (+${event.value} degres C) appliquee au serveur ${event.targetId}`);
                            } else {
                                console.warn(`[SKIP] Serveur cible ${event.targetId} absent de la topologie active. Evenement ignore.`);
                            }
                        }
                        break;
                }
            } catch (prismaError) {
                console.warn(`[SKIP] Echec de l'evenement ${event.type} pour la cible ${event.targetId}. La simulation continue.`);
            }
        }
    }

    queueRepair(fanId: number, serverId: number, delayTicks: number): void {
        this.pendingRepairs.set(fanId, { serverId, remainingTicks: delayTicks });
    }

    isFanUnderRepair(fanId: number): boolean {
        return this.pendingRepairs.has(fanId);
    }

    getDriftForServer(serverId: number): number {
        return this.activeThermalDrifts.get(serverId) ?? 0.0;
    }

    clearDriftForServer(serverId: number): void {
        this.activeThermalDrifts.delete(serverId);
        console.log(`[CLEAN] Penalite environnementale / drift annulee pour le serveur ${serverId}`);
    }

    clearScenario(): void {
        this.activeScenario = null;
        this.currentTick = 0;
        this.activeThermalDrifts.clear();
        this.pendingRepairs.clear();
        this.currentLoadMultiplier = 1.0;
        console.log("[RESET] Scenario nettoye et derives reinitialisees.");
    }

    /**
     * Calcule le coefficient d'efficacite energetique dynamique du cluster
     */
    calculateDynamicPUE(
        baseEnvFactor: number,     
        currentWeather: number,    
        averageCpuLoad: number     
    ): number {
        
        const PUE_infra = 1.12;

        // Modélisation de l'impact de la météo extérieure (Free-Cooling efficace sous 15°C)
        const deltaTemperature = Math.max(0, currentWeather - 15.0);
        const PUE_meteo = (deltaTemperature * 0.008) * baseEnvFactor;

        // Modélisation de l'impact de la charge applicative (Loi quadratique de dissipation thermique)
        const PUE_charge = Math.pow(averageCpuLoad / 100, 2) * 0.15;

        const finalPue = PUE_infra + PUE_meteo + PUE_charge;

        return Number(finalPue.toFixed(3));
    }
}