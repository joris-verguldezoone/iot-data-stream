"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ScenarioService = void 0;
const fs_extra_1 = __importDefault(require("fs-extra"));
const path_1 = __importDefault(require("path"));
class ScenarioService {
    prisma;
    io;
    activeScenario = null;
    currentTick = 0;
    activeThermalDrifts = new Map();
    // 🌟 SUIVI DYNAMIQUE DES MUTATIONS DE CHARGE GLOBALE
    currentLoadMultiplier = 1.0;
    // Suivi des réparations en cours { fanId -> { serverId, ticksRestants } }
    pendingRepairs = new Map();
    constructor(prisma, io) {
        this.prisma = prisma;
        this.io = io;
    }
    /**
     * 🌟 US 1 : Retourne le scénario actuellement chargé (Métadonnées)
     */
    getCurrentScenario() {
        return this.activeScenario;
    }
    /**
     * 🌟 US 3 : Retourne le multiplicateur de charge actif lié aux événements
     */
    getLoadMultiplier() {
        return this.currentLoadMultiplier;
    }
    /**
     * 🌟 US 3 : Expose toutes les dérives thermiques actives sous forme d'objet JSON { [serverId]: valeur }
     */
    getAllThermalDrifts() {
        return Object.fromEntries(this.activeThermalDrifts);
    }
    async loadScenario(scenarioId) {
        const filePath = path_1.default.join(__dirname, "../data_seed/scenarios.json");
        const scenarios = await fs_extra_1.default.readJson(filePath);
        const found = scenarios.find(s => s.id === scenarioId);
        if (!found)
            throw new Error(`Scénario [${scenarioId}] introuvable.`);
        this.activeScenario = found;
        this.currentTick = 0;
        this.activeThermalDrifts.clear();
        this.pendingRepairs.clear();
        this.currentLoadMultiplier = 1.0; // Réinitialisation de la charge
        console.log(`📖 Scénario armé : ${this.activeScenario.name}`);
        this.io.emit("scenario_started", { name: found.name, description: found.description });
    }
    async processTick() {
        this.currentTick++;
        console.log(`⏱️ [SCÉNARIO] Tick : ${this.currentTick}`);
        // GESTION DU DÉLAI DE MAINTENANCE
        for (const [fanId, repair] of this.pendingRepairs.entries()) {
            repair.remainingTicks--;
            if (repair.remainingTicks > 0) {
                console.log(`🔧 [MAINTENANCE] Ventilateur ${fanId} en cours de remplacement (Arrivée du technicien dans ${repair.remainingTicks} ticks...)`);
                this.io.emit("maintenance_progress", { fanId, remainingTicks: repair.remainingTicks });
            }
            else {
                await this.prisma.fan.update({
                    where: { fan_id: fanId },
                    data: { status: 'ON', control_mode: 'AUTO', speed_percent: 20 }
                });
                this.clearDriftForServer(repair.serverId);
                this.pendingRepairs.delete(fanId);
                console.log(`✅ [MAINTENANCE SUCCÈS] Remplacement du Ventilateur ${fanId} terminé.`);
                this.io.emit("maintenance_complete", { fanId, serverId: repair.serverId });
            }
        }
        if (!this.activeScenario)
            return;
        const eventsToRun = this.activeScenario.events.filter(e => e.tick === this.currentTick);
        for (const event of eventsToRun) {
            console.log(`⚠️ ÉVÈNEMENT SCÉNARIO ENCLENCHÉ : [${event.type}] (Cible: ${event.targetId ?? 'ALL'})`);
            this.io.emit("scenario_event_triggered", event);
            switch (event.type) {
                case 'CRASH_FAN':
                    if (event.targetId) {
                        await this.prisma.fan.update({
                            where: { fan_id: event.targetId },
                            data: { speed_percent: 0, control_mode: 'MANUAL', status: 'ON' }
                        });
                    }
                    break;
                case 'LOAD_SPIKE_ALL':
                    if (event.value !== undefined) {
                        // 🌟 Enregistre le multiplicateur (ex: 1.5 pour +50% de trafic)
                        this.currentLoadMultiplier = event.value;
                        await this.prisma.sensor.updateMany({
                            where: { sensor_type: 'LOAD' },
                            data: { last_value: event.value * 50 } // Conservation de la valeur indicative en BDD
                        });
                    }
                    break;
                case 'THERMAL_DRIFT_SERVER':
                    if (event.targetId && event.value !== undefined) {
                        this.activeThermalDrifts.set(event.targetId, event.value);
                    }
                    break;
            }
        }
    }
    queueRepair(fanId, serverId, delayTicks) {
        this.pendingRepairs.set(fanId, { serverId, remainingTicks: delayTicks });
    }
    isFanUnderRepair(fanId) {
        return this.pendingRepairs.has(fanId);
    }
    getDriftForServer(serverId) {
        return this.activeThermalDrifts.get(serverId) ?? 0.0;
    }
    clearDriftForServer(serverId) {
        this.activeThermalDrifts.delete(serverId);
        console.log(`🧹 [SCÉNARIO] Pénalité environnementale/drift annulée pour le serveur ${serverId}`);
    }
    clearScenario() {
        this.activeScenario = null;
        this.currentTick = 0;
        this.activeThermalDrifts.clear();
        this.pendingRepairs.clear();
        this.currentLoadMultiplier = 1.0; // 🌟 Reset du multiplicateur au nettoyage
        console.log("♻️ Scénario nettoyé et dérives réinitialisées.");
    }
}
exports.ScenarioService = ScenarioService;
