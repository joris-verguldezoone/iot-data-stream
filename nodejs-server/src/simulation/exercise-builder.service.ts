// src/simulation/exercise-builder.service.ts
import { PrismaClient } from "@prisma/client";

// Payload d'entrée structuré avec TOUS les champs nécessaires
export interface SandboxBuildInput {
    topology: Array<{
        clusterName: string;   // 🚨 AJOUTÉ : Corrige l'erreur TS2339
        city: string;          // Menu déroulant 1 : La localisation géographique
        configProfile: string; // Menu déroulant 2 : Le profil matériel
        clusterCount: number;  // Menu déroulant 3 : Nombre de sous-clusters à déployer dans cette ville
        nodesOverride?: number; // Menu déroulant 4 : Optionnel - Forcer un nombre total de serveurs
    }>;
}

// 🌍 Catalogue des hubs majeurs de datacenters mondiaux
export const INDUSTRIAL_CITIES: Record<string, { envFactor: number; energyCost: number; defaultWeather: number }> = {
    "Paris": { envFactor: 1.05, energyCost: 0.16, defaultWeather: 16.0 },     // Hub historique majeur (FLAP)
    "Marseille": { envFactor: 1.20, energyCost: 0.18, defaultWeather: 24.0 }, // Hub télécom sous-marin hyper connecté, climat chaud
    "Frankfurt": { envFactor: 1.10, energyCost: 0.21, defaultWeather: 15.0 }, // Le plus gros nœud d'échange cloud européen, électricité chère
    "Oslo": { envFactor: 0.95, energyCost: 0.10, defaultWeather: 7.0 },      // Champion du Free-Cooling vert, énergie peu coûteuse
    "Dublin": { envFactor: 1.02, energyCost: 0.15, defaultWeather: 12.0 }     // Hub hyperscale (Google, AWS), climat océanique tempéré
};

// 🖥️ Fusion de tes catalogues de profils de clusters (BIG, MEDIUM, SMALL)
export const INTEGRATED_PROFILES: Record<string, {
    masters: number;
    workers: number;
    baseConsumptionMaster: number;
    baseConsumptionWorker: number;
    hardwareMaster: string;
    hardwareWorker: string;
    fanCount: number;
    fanModelName: string;
    cpuCoolerModelName: string;
}> = {
    // Profils de calcul massif (BIG)
    "BIG_CLUSTER_HIGH_POWER": { masters: 4, workers: 16, baseConsumptionMaster: 1700, baseConsumptionWorker: 1450, hardwareMaster: "2×Xeon + 1×A100, 512GB", hardwareWorker: "2×Xeon, 1×A100, 512GB", fanCount: 8, fanModelName: "FAN_HIGH_PERF", cpuCoolerModelName: "LIQUID_COOLING" },
    "BIG_CLUSTER_HYBRID": { masters: 3, workers: 17, baseConsumptionMaster: 1100, baseConsumptionWorker: 900, hardwareMaster: "2×EPYC, 1×V100, 384GB", hardwareWorker: "2×EPYC, 1×V100, 384GB", fanCount: 6, fanModelName: "FAN_HIGH_PERF", cpuCoolerModelName: "AIR_HIGH_PERF" },
    "BIG_CLUSTER_LOW_POWER": { masters: 2, workers: 18, baseConsumptionMaster: 800, baseConsumptionWorker: 475, hardwareMaster: "2×CPU dense, no GPU, 256GB", hardwareWorker: "2×CPU dense, no GPU, 256GB", fanCount: 4, fanModelName: "FAN_STANDARD", cpuCoolerModelName: "AIR_STANDARD" },
    
    // Profils intermédiaires (MEDIUM)
    "MEDIUM_GPU": { masters: 2, workers: 8, baseConsumptionMaster: 850, baseConsumptionWorker: 700, hardwareMaster: "2×EPYC + 1×RTX, 256GB", hardwareWorker: "2×EPYC + 1×RTX, 256GB", fanCount: 4, fanModelName: "FAN_HIGH_PERF", cpuCoolerModelName: "AIR_HIGH_PERF" },
    "MEDIUM_HEAVY_CPU": { masters: 2, workers: 8, baseConsumptionMaster: 425, baseConsumptionWorker: 325, hardwareMaster: "2×Xeon, 128GB", hardwareWorker: "2×Xeon, 128GB", fanCount: 3, fanModelName: "FAN_STANDARD", cpuCoolerModelName: "AIR_STANDARD" },
    "MEDIUM_EDGE_TYPE": { masters: 1, workers: 9, baseConsumptionMaster: 225, baseConsumptionWorker: 165, hardwareMaster: "i9 + small accel, 64GB", hardwareWorker: "i9 + small accel, 64GB", fanCount: 2, fanModelName: "FAN_STANDARD", cpuCoolerModelName: "AIR_STANDARD" },
    
    // Profils locaux et embarqués (SMALL)
    "SMALL_MINI_GPU": { masters: 1, workers: 4, baseConsumptionMaster: 425, baseConsumptionWorker: 325, hardwareMaster: "i9 + 1×RTX, 128GB", hardwareWorker: "i9 + 1×RTX, 128GB", fanCount: 2, fanModelName: "FAN_STANDARD", cpuCoolerModelName: "AIR_STANDARD" },
    "SMALL_CPU": { masters: 1, workers: 4, baseConsumptionMaster: 165, baseConsumptionWorker: 110, hardwareMaster: "i7 / Xeon small, 64GB", hardwareWorker: "i7 / Xeon small, 64GB", fanCount: 2, fanModelName: "FAN_ECO", cpuCoolerModelName: "AIR_STANDARD" },
    "SMALL_EDGE_CLOSET": { masters: 1, workers: 4, baseConsumptionMaster: 60, baseConsumptionWorker: 37, hardwareMaster: "NUC / low-power, 32GB", hardwareWorker: "NUC / low-power, 32GB", fanCount: 1, fanModelName: "FAN_ECO", cpuCoolerModelName: "AIR_STANDARD" }
};

export interface IdealPueReport {
    city: string;
    weatherTempCelsius: number;
    theoreticalIdealPue: number;
    description: string;
}

export class ExerciseBuilderService {
    constructor(private prisma: PrismaClient) {}

    async buildSandbox(input: SandboxBuildInput): Promise<IdealPueReport[]> {
        console.log("🧹 [BUILDER] Purge destructive et réinitialisation de la Sandbox...");
        
        const tables = ["sensor_data", "sensor", "fan", "server", "cluster", "cluster_configuration", "fan_configuration", "fan_catalog", "cpucooler_catalog", "load_profile", "cluster_location"];
        for (const table of tables) {
            await this.prisma.$executeRawUnsafe(`TRUNCATE TABLE "${table}" RESTART IDENTITY CASCADE;`);
        }

        // 1. Amorçage du catalogue matériel de référence
        const coolerLiquid = await this.prisma.cpuCoolerCatalog.create({ data: { model_name: "LIQUID_COOLING", type: "WATER", thermal_capacity: 500 } });
        const coolerAirHigh = await this.prisma.cpuCoolerCatalog.create({ data: { model_name: "AIR_HIGH_PERF", type: "AIR", thermal_capacity: 250 } });
        const coolerAirStd = await this.prisma.cpuCoolerCatalog.create({ data: { model_name: "AIR_STANDARD", type: "AIR", thermal_capacity: 150 } });

        const fanCatalogHigh = await this.prisma.fanCatalog.create({ data: { model_name: "FAN_HIGH_PERF", consomation: 1.5 } });
        const fanCatalogStd = await this.prisma.fanCatalog.create({ data: { model_name: "FAN_STANDARD", consomation: 0.8 } });
        const fanCatalogEco = await this.prisma.fanCatalog.create({ data: { model_name: "FAN_ECO", consomation: 0.4 } });

        const defaultFanConfig = await this.prisma.fanConfiguration.create({ data: { name: "Default_Auto_Regulation", consomation: 0.8 } });
        const defaultLoadProfile = await this.prisma.loadProfile.create({
            data: { name: "Config_Auto_Paris-01", hour: 12, expected_load_percent: 20, target_temp_celsius: 60.0, standard_fan_speed: "MEDIUM" }
        });

        const mappingCoolers: Record<string, number> = { "LIQUID_COOLING": coolerLiquid.cpu_cooler_catalog_id, "AIR_HIGH_PERF": coolerAirHigh.cpu_cooler_catalog_id, "AIR_STANDARD": coolerAirStd.cpu_cooler_catalog_id };
        const mappingFans: Record<string, number> = { "FAN_HIGH_PERF": fanCatalogHigh.fan_catalog_id, "FAN_STANDARD": fanCatalogStd.fan_catalog_id, "FAN_ECO": fanCatalogEco.fan_catalog_id };

        const pueReports: IdealPueReport[] = [];

        // 2. Déploiement de la topologie sur-mesure choisie par l'utilisateur
        for (const block of input.topology) {
            const cityConfig = INDUSTRIAL_CITIES[block.city];
            const blueprint = INTEGRATED_PROFILES[block.configProfile];

            if (!cityConfig) throw new Error(`La ville [${block.city}] n'appartient pas au catalogue de supervision.`);
            if (!blueprint) throw new Error(`Le profil matériel [${block.configProfile}] n'existe pas.`);

            // A. Initialisation ou mise à jour de la plaque géographique
            const location = await this.prisma.clusterLocation.upsert({
                where: { name: block.city },
                update: { cluster_count: { increment: block.clusterCount } },
                create: {
                    name: block.city,
                    location: `${block.city} Tech Hub`,
                    env_factor: cityConfig.envFactor,
                    energy_cost_kwh: cityConfig.energyCost,
                    cluster_count: block.clusterCount
                }
            });

            // B. Instanciation des sous-clusters demandés dans cette zone
            for (let c = 1; c <= block.clusterCount; c++) {
                const currentClusterName = `${block.clusterName}-Zone-${c.toString().padStart(2, '0')}`;

                const clusterConfig = await this.prisma.clusterConfiguration.create({
                    data: {
                        name: `Config_${currentClusterName}`,
                        master: blueprint.masters,
                        worker: blueprint.workers,
                        hardware_per_master: blueprint.hardwareMaster,
                        hardware_per_worker: blueprint.hardwareWorker,
                        consomation_per_master: blueprint.baseConsumptionMaster,
                        consomation_per_worker: blueprint.baseConsumptionWorker,
                        load_profile_id: defaultLoadProfile.id,
                        location_id: location.location_id,
                        fan_count: blueprint.fanCount,
                        cpu_cooler_catalog_id: mappingCoolers[blueprint.cpuCoolerModelName] || coolerAirStd.cpu_cooler_catalog_id,
                        fan_catalog_id: mappingFans[blueprint.fanModelName] || fanCatalogStd.fan_catalog_id,
                        fan_config_id: defaultFanConfig.id
                    }
                });

                const cluster = await this.prisma.cluster.create({
                    data: { name: currentClusterName, cluster_location_id: location.location_id }
                });

                // Détermination du nombre de nœuds à injecter (avec support de surcharge dynamique)
                let finalMastersCount = blueprint.masters;
                let finalWorkersCount = blueprint.workers;

                if (block.nodesOverride && block.nodesOverride > 0) {
                    finalMastersCount = Math.max(1, Math.round(block.nodesOverride * 0.2));
                    finalWorkersCount = Math.max(1, block.nodesOverride - finalMastersCount);
                }

                const totalNodes = finalMastersCount + finalWorkersCount;

                for (let i = 1; i <= totalNodes; i++) {
                    const isMaster = i <= finalMastersCount;
                    const role = isMaster ? "master" : "worker";
                    const idIndex = isMaster ? i : i - finalMastersCount;

                    const server = await this.prisma.server.create({
                        data: {
                            cluster_id: cluster.cluster_id,
                            config_id: clusterConfig.cluster_config_id,
                            hostname: `${block.city.toLowerCase()}-${currentClusterName.toLowerCase()}-${role}-${idIndex.toString().padStart(2, '0')}`,
                            status: "ON",
                            is_master: isMaster,
                            base_consumption_offset: isMaster ? blueprint.baseConsumptionMaster : blueprint.baseConsumptionWorker
                        }
                    });

                    // Déploiement des ventilateurs physiques sur le serveur
                    for (let f = 1; f <= blueprint.fanCount; f++) {
                        await this.prisma.fan.create({
                            data: {
                                server_id: server.server_id,
                                fan_catalog_id: mappingFans[blueprint.fanModelName] || fanCatalogStd.fan_catalog_id,
                                fan_config_id: defaultFanConfig.id,
                                control_mode: "AUTO",
                                status: "ON",
                                speed_percent: 20
                            }
                        });
                    }

                    // Attachement du kit complet des 5 capteurs de télémétrie
                    const kitSensors = [
                        { type: "LOAD", unit: "%", value: 15.0 },
                        { type: "CPU_TEMP", unit: "°C", value: 32.0 },
                        { type: "TOTAL_POWER", unit: "W", value: 0.0 },
                        { type: "FAN_SPEED_1", unit: "%", value: 20.0 },
                        { type: "FAN_SPEED_2", unit: "%", value: 20.0 }
                    ];

                    for (const s of kitSensors) {
                        await this.prisma.sensor.create({
                            data: { server_id: server.server_id, sensor_type: s.type, unit: s.unit, last_value: s.value }
                        });
                    }
                }
            }

            // 🚨 CALCUL DU PUE IDÉAL DE CETTE ZONE
            const baseInfrastructureFactor = 0.25;
            const weatherPenalty = cityConfig.defaultWeather > 15.0 ? (cityConfig.defaultWeather - 15.0) * 0.008 : 0.0;
            const serverHeatingPenalty = 32.0 > 40.0 ? (32.0 - 40.0) * 0.005 : 0.0; 

            const theoreticalIdealPue = Number((1.0 + baseInfrastructureFactor + weatherPenalty + serverHeatingPenalty).toFixed(3));

            pueReports.push({
                city: block.city,
                weatherTempCelsius: cityConfig.defaultWeather,
                theoreticalIdealPue,
                description: `Cible de performance énergétique parfaite pour le cluster ${block.clusterName} localisé à ${block.city} sous son climat nominal.`
            });
        }

        console.log("✅ [BUILDER] Sandbox configurée et déployée avec succès.");
        return pueReports;
    }

    /**
     * Génère 7 jours d'historique sain (Télémétrie nominale) pour remplir Grafana instantanément
     */
    async seedHealthyWeekHistory(): Promise<number> {
        console.log("⏳ [TIME-TRAVEL] Début de la génération des 7 jours d'historique sain...");
        
        // 1. Récupération de l'infrastructure actuelle (tes 40 serveurs répartis dans les 4 clusters)
        const servers = await this.prisma.server.findMany({
            include: { sensors: true, cluster: { include: { clusterLocation: true } } }
        });

        if (servers.length === 0) {
            throw new Error("Impossible de générer l'historique : aucun serveur n'existe en base. Lance d'abord /build-exercise.");
        }

        const bulkData: any[] = [];
        const now = new Date();
        const totalHours = 7 * 24; // 168 points historiques par capteur

        // 2. Boucle temporelle : on remonte 168 heures dans le passé et on avance heure par heure
        for (let hourOffset = totalHours; hourOffset >= 0; hourOffset--) {
            const simulatedTime = new Date(now.getTime() - hourOffset * 60 * 60 * 1000);
            
            const hourOfDay = simulatedTime.getHours();
            const dayOfWeek = simulatedTime.getDay(); // 0 = Dimanche, 6 = Samedi
            const isWeekend = dayOfWeek === 0 || dayOfWeek === 6;

            // A. Détermination du profil de charge humaine (Rythme de bureau)
            let baseLoad = 20.0;
            if (!isWeekend) {
                if (hourOfDay >= 8 && hourOfDay <= 18) {
                    // Vague de charge la journée entre 8h et 18h
                    baseLoad = 55.0 + Math.sin((hourOfDay - 8) * (Math.PI / 10)) * 20.0;
                } else if (hourOfDay > 18 && hourOfDay <= 23) {
                    // Décroissance lente en soirée
                    baseLoad = 40.0 - (hourOfDay - 18) * 4.0;
                }
            } else {
                // Charge minimale calme le week-end
                baseLoad = 15.0 + Math.sin(hourOfDay * (Math.PI / 12)) * 5.0;
            }

            // B. Génération de la physique pour chaque serveur pour cette heure précise
            for (const server of servers) {
                const cityName = server.cluster.clusterLocation.name;
                const envFactor = server.cluster.clusterLocation.env_factor;

                // Météo de base par ville
                let baseCityTemp = 15.0;
                if (cityName === "Marseille") baseCityTemp = 23.0;
                if (cityName === "Oslo") baseCityTemp = 7.0;
                if (cityName === "Paris") baseCityTemp = 16.0;

                // Oscillation thermique jour/nuit (Maximum à 14h, Minimum à 4h du matin)
                const weatherOscillation = Math.sin((hourOfDay - 8) * (Math.PI / 12)) * 5.0;
                const currentExternalWeather = baseCityTemp + weatherOscillation;

                // Petite variation aléatoire par serveur pour ne pas avoir des courbes superposées parfaites
                const serverNoise = Math.sin(server.server_id * 10) * 2.0;
                const actualLoad = Math.max(5, Math.min(100, baseLoad + serverNoise + (Math.random() * 4 - 2)));

                // Température CPU saine (Auto-régulée par ventilation stable)
                const cpuTemp = Math.max(30, Math.min(85, 35.0 + (actualLoad * 0.35) + (currentExternalWeather * 0.2) + (Math.random() * 2 - 1)));

                // Consommation électrique proportionnelle à la charge
                const powerWatts = server.is_master
                    ? server.base_consumption_offset + (actualLoad * 3.5)
                    : server.base_consumption_offset + (actualLoad * 2.8);

                // Vitesse simulée des ventilateurs
                const fanSpeed = Math.max(20, Math.min(100, 20.0 + (cpuTemp - 40.0) * 2.5));

                // C. Distribution des valeurs aux 5 capteurs du serveur
                for (const sensor of server.sensors) {
                    let sensorValue = 0;
                    const type = sensor.sensor_type.toUpperCase();

                    if (type === "LOAD") sensorValue = actualLoad;
                    else if (type === "CPU_TEMP") sensorValue = cpuTemp;
                    else if (type === "TOTAL_POWER") sensorValue = powerWatts;
                    else if (type === "FAN_SPEED_1" || type === "FAN_SPEED_2") sensorValue = fanSpeed;

                    bulkData.push({
                        value: Number(sensorValue.toFixed(2)),
                        time: simulatedTime,
                        sensor_id: sensor.sensor_id
                    });
                }
            }
        }

        // 3. Écriture de masse ultra-rapide dans PostgreSQL (Bulk Insert par paquets de 5000 lignes)
        console.log(`💾 [TIME-TRAVEL] Injection de ${bulkData.length} lignes de télémétrie en BDD...`);
        const chunkSize = 5000;
        for (let i = 0; i < bulkData.length; i += chunkSize) {
            const chunk = bulkData.slice(i, i + chunkSize);
            const values = chunk.map(d => `(${d.value}, '${d.time.toISOString()}', ${d.sensor_id})`).join(',');
            await this.prisma.$executeRawUnsafe(
                `INSERT INTO "sensor_data" (value, time, sensor_id) VALUES ${values}`
            );
        }

        console.log("🏁 [TIME-TRAVEL] Historique des 7 jours généré avec succès !");
        return bulkData.length;
    }
}