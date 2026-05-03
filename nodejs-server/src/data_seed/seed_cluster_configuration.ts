// cluster_configuration.ts
import type { ClusterConfig } from '../types/cluster_configuration_type';

// Dans ton fichier de constantes ou en haut de ton service
const INITIAL_HARDWARE = {
    fans: [
        { name: 'FAN_HIGH_PERF', consomation: 1.5 },
        { name: 'FAN_STANDARD', consomation: 0.8 },
        { name: 'FAN_ECO', consomation: 0.4 }
    ],
    coolers: [
        { name: 'LIQUID_COOLING', power_draw: 50 }, // Pompe + Radiateur
        { name: 'AIR_HIGH_PERF', power_draw: 15 },
        { name: 'AIR_STANDARD', power_draw: 5 }
    ]
};
export const BIG_CLUSTERS: Record<string, ClusterConfig> = {
  BIG_CLUSTER_HIGH_POWER: {
    name: "BIG_CLUSTER_HIGH_POWER",
    masters: 4,
    workers: 16,
    consomation_per_master: [1600, 1800],
    consomation_per_worker: [1350, 1550],
    hardware_per_master: "2×Xeon + 1×A100, 512GB",
    hardware_per_worker: "2×Xeon, 1×A100, 512GB",
    env_factor: 1.05,
    PUE: 1.40,
    fan_count: 8,                         // Châssis 4U / Redondance
    fan_model_name: "FAN_HIGH_PERF",
    cpu_cooler_model_name: "LIQUID_COOLING"
  },
  BIG_CLUSTER_HYBRID: {
    name: "BIG_CLUSTER_HYBRID",
    masters: 3,
    workers: 17,
    consomation_per_master: [1000, 1200],
    consomation_per_worker: [800, 1000],
    hardware_per_master: "2×EPYC, 1×V100, 384GB",
    hardware_per_worker: "2×EPYC, 1×V100, 384GB",
    env_factor: 1.05,
    PUE: 1.40,
    fan_count: 6,
    fan_model_name: "FAN_HIGH_PERF",
    cpu_cooler_model_name: "AIR_HIGH_PERF"
  },
  BIG_CLUSTER_LOW_POWER: {
    name: "BIG_CLUSTER_LOW_POWER",
    masters: 2,
    workers: 18,
    consomation_per_master: [700, 900],
    consomation_per_worker: [450, 500],
    hardware_per_master: "2×CPU dense, no GPU, 256GB",
    hardware_per_worker: "2×CPU dense, no GPU, 256GB",
    env_factor: 1.15,
    PUE: 1.70,
    fan_count: 4,
    fan_model_name: "FAN_STANDARD",
    cpu_cooler_model_name: "AIR_STANDARD"
  },
};

export const MEDIUM_CLUSTERS: Record<string, ClusterConfig> = {
  MEDIUM_GPU: {
    name: "MEDIUM_GPU",
    masters: 2,
    workers: 8,
    consomation_per_master: [750, 950],
    consomation_per_worker: [650, 750],
    hardware_per_master: "2×EPYC + 1×RTX, 256GB",
    hardware_per_worker: "2×EPYC + 1×RTX, 256GB",
    env_factor: 1.1,
    PUE: 1.56,
    fan_count: 4,
    fan_model_name: "FAN_HIGH_PERF",
    cpu_cooler_model_name: "AIR_HIGH_PERF"
  },
  MEDIUM_HEAVY_CPU: {
    name: "MEDIUM_HEAVY_CPU",
    masters: 2,
    workers: 8,
    consomation_per_master: [350, 500],
    consomation_per_worker: [300, 350],
    hardware_per_master: "2×Xeon, 128GB",
    hardware_per_worker: "2×Xeon, 128GB",
    env_factor: 1.2,
    PUE: 1.75,
    fan_count: 3,
    fan_model_name: "FAN_STANDARD",
    cpu_cooler_model_name: "AIR_STANDARD"
  },
  MEDIUM_EDGE_TYPE: {
    name: "MEDIUM_EDGE_TYPE",
    masters: 1,
    workers: 9,
    consomation_per_master: [200, 250],
    consomation_per_worker: [150, 180],
    hardware_per_master: "i9 + small accel, 64GB",
    hardware_per_worker: "i9 + small accel, 64GB",
    env_factor: 1.25,
    PUE: 2.0,
    fan_count: 2,
    fan_model_name: "FAN_STANDARD",
    cpu_cooler_model_name: "AIR_STANDARD"
  },
};

export const SMALL_CLUSTERS: Record<string, ClusterConfig> = {
  SMALL_MINI_GPU: {
    name: "SMALL_MINI_GPU",
    masters: 1,
    workers: 4,
    consomation_per_master: [400, 450],
    consomation_per_worker: [300, 350],
    hardware_per_master: "i9 + 1×RTX, 128GB",
    hardware_per_worker: "i9 + 1×RTX, 128GB",
    env_factor: 1.2,
    PUE: 1.75,
    fan_count: 2,
    fan_model_name: "FAN_STANDARD",
    cpu_cooler_model_name: "AIR_STANDARD"
  },
  SMALL_CPU: {
    name: "SMALL_CPU",
    masters: 1,
    workers: 4,
    consomation_per_master: [150, 180],
    consomation_per_worker: [100, 120],
    hardware_per_master: "i7 / Xeon small, 64GB",
    hardware_per_worker: "i7 / Xeon small, 64GB",
    env_factor: 1.3,
    PUE: 2.25,
    fan_count: 2,
    fan_model_name: "FAN_ECO",
    cpu_cooler_model_name: "AIR_STANDARD"
  },
  SMALL_EDGE_CLOSET: {
    name: "SMALL_EDGE_CLOSET",
    masters: 1,
    workers: 4,
    consomation_per_master: [50, 70],
    consomation_per_worker: [30, 45],
    hardware_per_master: "NUC / low-power, 32GB",
    hardware_per_worker: "NUC / low-power, 32GB",
    env_factor: 1.35,
    PUE: 2.25,
    fan_count: 1,
    fan_model_name: "FAN_ECO",
    cpu_cooler_model_name: "AIR_STANDARD"
  },
};