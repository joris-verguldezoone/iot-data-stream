export default interface Cluster_Location {
  name: string;
  city: string;
  envFactor: number;      // Impact climatique (ex: 1.2 pour Marseille, 0.9 pour Oslo)
  energyCostKwh: number;  // Coût financier (ex: 0.15€)
  clusterCount: number; // pour le builder
}