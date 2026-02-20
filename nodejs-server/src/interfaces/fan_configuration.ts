// types.ts


// fan_configuration.ts
import type { FanConfiguration } from "../types/fan-type";

export const FAN_SEED: FanConfiguration[] = [
  { consomation: [20, 40], name: "big_high_power" },
  { consomation: [15, 30], name: "big_hybrid" },
  { consomation: [10, 20], name: "big_low_power" },

  { consomation: [15, 25], name: "medium_GPU" },
  { consomation: [8, 15], name: "medium_CPU_HEAVY" },
  { consomation: [5, 10], name: "medium_EDGE_TYPE" },

  { consomation: [8, 15], name: "small_MINI_GPU" },
  { consomation: [5, 8], name: "small_CPU" },
  { consomation: [2, 5], name: "small_EDGE_CLOSET" },
];
