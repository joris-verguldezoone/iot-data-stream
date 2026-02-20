export interface ClusterConfig {
  name: string;
  masters: number;
  workers: number;
  consomation_per_master: [number, number];  // plage
  consomation_per_worker: [number, number];  // plage
  hardware_per_master: string;
  hardware_per_worker: string;
  env_factor: number;
  PUE: number;
}
