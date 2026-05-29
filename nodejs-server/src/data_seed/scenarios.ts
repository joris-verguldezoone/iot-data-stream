export interface ScenarioEvent {
    tick: number;
    type: 'CRASH_FAN' | 'LOAD_SPIKE_ALL' | 'THERMAL_DRIFT_SERVER';
    targetId?: number;
    value?: number;
}

export interface Scenario {
    id: string;
    name: string;
    description: string;
    events: ScenarioEvent[];
}

export const eventsDetails: Scenario[] = [
  {
    "id": "sc_marseille_gpu_melt",
    "name": "🔥 [MARSEILLE] Canicule Phocéenne & Surcharge GPU (Milieu de semaine)",
    "description": "Le datacenter démarre le lundi. Tout est normal pendant 2 jours. Le Mercredi à 04h00 (Tick 52), une surcharge applicative frappe les serveurs (Multiplié par 2). À 08h00 (Tick 56), la canicule crée une dérive thermique (+15°C) sur le srv-3. À midi (Tick 60), le ventilateur 9 lâche en plein pic de chaleur.",
    "events": [
      { "tick": 52, "type": "LOAD_SPIKE_ALL", "value": 2.0 },
      { "tick": 56, "type": "THERMAL_DRIFT_SERVER", "targetId": 3, "value": 15.0 },
      { "tick": 60, "type": "CRASH_FAN", "targetId": 9 }
    ]
  },
  {
    "id": "op_fan_failure",
    "name": "Défaut Matériel : Panne Ventilateur",
    "description": "Arrêt mécanique d'un des ventilateurs de refroidissement sur le serveur srv-001.",
    "events": [
      { "tick": 15, "type": "CRASH_FAN", "targetId": 1 }
    ]
  },
  {
    "id": "op_traffic_surge",
    "name": "Surcharge Opérationnelle : Hausse de Trafic",
    "description": "Soudaine vagues de requêtes hors production provoquant un pic de charge global.",
    "events": [
      { "tick": 10, "type": "LOAD_SPIKE_ALL", "value": 2.0 }
    ]
  },
  {
    "id": "op_thermal_drift",
    "name": "Dégradation Physique : Dérive Thermique",
    "description": "Perte progressive de l'efficacité de dissipation thermique sur le nœud de calcul 2.",
    "events": [
      { "tick": 5, "type": "THERMAL_DRIFT_SERVER", "targetId": 2, "value": 1.5 }
    ]
  },
  {
    "id": "sc_cluster_high",
    "name": "🔥 [HIGH-POWER] Stress-Test IA & Supercalculateur",
    "description": "Simulation d'un entraînement massif de LLM sur le cluster High-Power. La charge informatique sature instantanément à 95%, mettant à l'épreuve l'inertie des gros CPU.",
    "events": [
      { "tick": 5, "type": "LOAD_SPIKE_ALL", "value": 2.2 }
    ]
  },
  {
    "id": "sc_cluster_medium",
    "name": "⚡ [MEDIUM-CLUSTER] Incident Électrique Alterné",
    "description": "Une anomalie sur l'onduleur du Cluster Medium provoque des micro-coupures de charge suivies d'une surchauffe vicieuse (dérive thermique +2.0) sur les nœuds intermédiaires.",                                                                                                                                                                                                                                                                                                                                                                                               
    "events": [
      { "tick": 8, "type": "THERMAL_DRIFT_SERVER", "targetId": 3, "value": 2.0 }
    ]
  },
  {
    "id": "sc_cluster_small",
    "name": "📡 [SMALL-EDGE] Coup de Chaleur sur Micro-Closet",
    "description": "Scénario critique pour les petits routeurs / serveurs Edge en armoire de rue (Small). Le système de ventilation principal lâche au tick 12. Sans réaction rapide de l'élève pour brider la charge, le crash thermique est garanti.",
    "events": [
      { "tick": 12, "type": "CRASH_FAN", "targetId": 5 }
    ]
  }, 
  {
    "id": "sc_euro_cross_topology",
    "name": "🌍 [TOPOLOGIE] Le Grand Chelem Européen (Multi-Villes)",
    "description": "Scénario ultime configuré pour la topologie d'examen : Le Big Cluster de Paris subit un pic de charge (x2), le Medium de Marseille fait face à une dérive thermique (+2.5) liée à la chaleur du Sud, tandis que le Small d'Oslo subit une panne de ventilateur.",
    "events": [
      { "tick": 4, "type": "LOAD_SPIKE_ALL", "value": 2.0 },
      { "tick": 8, "type": "THERMAL_DRIFT_SERVER", "targetId": 3, "value": 2.5 },
      { "tick": 12, "type": "CRASH_FAN", "targetId": 5 }
    ]
  },
  
  // ==========================================
  // 💥 NEW ARMAGEDDON SCENARIOS FOR AI EXPERTS
  // ==========================================
  {
    "id": "sc_marseille_massive_chaos",
    "name": "🌪️ [PROD-CRISIS] Marseille Chaos - Rafale de pannes sur 1 semaine",
    "description": "Scénario ultra-dense étalé sur 168 ticks. Idéal pour l'apprentissage supervisé de modèles prédictifs. Inondation de pannes sur plusieurs machines en simultané, oscillations agressives de charge informatique et dérives thermiques multiples.",
    "events": [
      { "tick": 20, "type": "LOAD_SPIKE_ALL", "value": 1.8 },
      { "tick": 25, "type": "THERMAL_DRIFT_SERVER", "targetId": 1, "value": 8.0 },
      { "tick": 30, "type": "CRASH_FAN", "targetId": 2 },
      { "tick": 45, "type": "CRASH_FAN", "targetId": 4 },
      { "tick": 60, "type": "LOAD_SPIKE_ALL", "value": 2.2 },
      { "tick": 65, "type": "THERMAL_DRIFT_SERVER", "targetId": 3, "value": 18.0 },
      { "tick": 70, "type": "CRASH_FAN", "targetId": 9 },
      { "tick": 72, "type": "CRASH_FAN", "targetId": 10 },
      { "tick": 90, "type": "THERMAL_DRIFT_SERVER", "targetId": 2, "value": 12.0 },
      { "tick": 105, "type": "CRASH_FAN", "targetId": 6 },
      { "tick": 120, "type": "LOAD_SPIKE_ALL", "value": 1.5 },
      { "tick": 135, "type": "CRASH_FAN", "targetId": 3 },
      { "tick": 140, "type": "THERMAL_DRIFT_SERVER", "targetId": 4, "value": 10.0 },
      { "tick": 150, "type": "CRASH_FAN", "targetId": 7 }
    ]
  },
  {
    "id": "sc_cluster_10_infestation",
    "name": "🦠 [SCALE-10] Infestation Matérielle Multi-Zone",
    "description": "Scénario taillé pour une topologie de 10 clusters. Simule un défaut de fabrication d'une série de ventilateurs qui se mettent à flancher en cascade sur toute l'infrastructure. L'IA doit paralléliser ses appels de maintenance.",
    "events": [
      { "tick": 15, "type": "LOAD_SPIKE_ALL", "value": 2.0 },
      { "tick": 22, "type": "CRASH_FAN", "targetId": 10 },
      { "tick": 24, "type": "CRASH_FAN", "targetId": 12 },
      { "tick": 26, "type": "CRASH_FAN", "targetId": 15 },
      { "tick": 35, "type": "THERMAL_DRIFT_SERVER", "targetId": 3, "value": 14.0 },
      { "tick": 40, "type": "CRASH_FAN", "targetId": 18 },
      { "tick": 42, "type": "CRASH_FAN", "targetId": 20 },
      { "tick": 44, "type": "CRASH_FAN", "targetId": 25 },
      { "tick": 60, "type": "LOAD_SPIKE_ALL", "value": 2.4 },
      { "tick": 65, "type": "THERMAL_DRIFT_SERVER", "targetId": 6, "value": 16.0 },
      { "tick": 70, "type": "CRASH_FAN", "targetId": 11 },
      { "tick": 75, "type": "CRASH_FAN", "targetId": 22 }
    ]
  },
  {
    "id": "sc_apocalypse_50",
    "name": "🌋 [APOCALYPSE-50] Blackout Thermique Massif (50 Clusters)",
    "description": "Le boss final du TP. 50 clusters en activité. Surcharge cataclysmique (x2.5), incendie électrique provoquant des dérives environnementales extrêmes sur les nœuds pivots et pannes en rafale. Seuls les meilleurs modèles MLOps survivront.",
    "events": [
      { "tick": 10, "type": "LOAD_SPIKE_ALL", "value": 2.5 },
      { "tick": 15, "type": "THERMAL_DRIFT_SERVER", "targetId": 5, "value": 20.0 },
      { "tick": 15, "type": "THERMAL_DRIFT_SERVER", "targetId": 15, "value": 20.0 },
      { "tick": 15, "type": "THERMAL_DRIFT_SERVER", "targetId": 25, "value": 20.0 },
      { "tick": 20, "type": "CRASH_FAN", "targetId": 10 },
      { "tick": 21, "type": "CRASH_FAN", "targetId": 20 },
      { "tick": 22, "type": "CRASH_FAN", "targetId": 30 },
      { "tick": 23, "type": "CRASH_FAN", "targetId": 40 },
      { "tick": 24, "type": "CRASH_FAN", "targetId": 50 },
      { "tick": 40, "type": "THERMAL_DRIFT_SERVER", "targetId": 2, "value": 15.0 },
      { "tick": 45, "type": "CRASH_FAN", "targetId": 15 },
      { "tick": 46, "type": "CRASH_FAN", "targetId": 35 },
      { "tick": 47, "type": "CRASH_FAN", "targetId": 55 },
      { "tick": 60, "type": "LOAD_SPIKE_ALL", "value": 2.0 }
    ]
  }
];

export const eventList = [
  "sc_marseille_gpu_melt",
  "op_fan_failure",
  "op_traffic_surge",
  "op_thermal_drift",
  "sc_cluster_high",
  "sc_cluster_medium",
  "sc_cluster_small",
  "sc_euro_cross_topology",
  "sc_marseille_massive_chaos",
  "sc_cluster_10_infestation",
  "sc_apocalypse_50"
]