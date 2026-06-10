Voici la version définitive du fichier **`README.md`** rédigée sous la forme d'un **Getting Started** technique complet.

Il intègre tes consignes exactes : l'utilisation du générateur graphique pour **Marseille**, l'obligation pour les étudiants de **développer leur propre consommateur MQTT**, l'évaluation via la crise de Marseille, et les critères de notation pour leur **soutenance**.

---

# Getting Started : Projet "Juste des Ventilateurs" – Supervision IA & Flux IoT Temps Réel

## 1. Présentation de la Mission

> « *When things are getting hot and the sensors are going crazy, in a system controlling only fans, our AI gets turned on to cool things down and decrease pressure.* »

Dans la plupart des datacenters modernes, la question n’est plus seulement de “faire tourner les serveurs”, mais de maintenir les machines dans une zone de fonctionnement sûre tout en contenant la facture énergétique. Au quotidien, des équipes d’ingénieurs data et d’experts IA doivent jongler entre alertes de température, tickets d’incident et objectifs de réduction de consommation électrique, avec des infrastructures déjà en production et peu de marge pour expérimenter.

Votre équipe d'ingénieurs (2 à 4 personnes) est chargée de la fiabilité thermique d’un datacenter situé à **Marseille**. L’infrastructure est équipée de capteurs de température et de ventilateurs contrôlables à distance. Le pilotage actuel reste fondé sur des règles statiques, provoquant des épisodes de surchauffe et des arrêts thermiques de sécurité (`shutdown`) lors des pics de charge.

Pour expérimenter sans risque, vous allez concevoir un microservice autonome en Python baptisé **`juste-ventilateurs`** connecté à un jumeau numérique. Votre but : **recréer un pipeline complet d'ingestion IoT, insérer des modèles de Machine Learning dans une boucle de décision temps réel, et valider votre efficacité.**

---

## 2. Étape 1 : Lancement du Jumeau Numérique

Démarrez l'infrastructure complète du simulateur de datacenter (moteur physique, broker de messages, base de données et stack d'observabilité) à l'aide de Docker Compose :

```bash
docker compose up -d --build

```

### Points d'accès de votre environnement :
* **API du Moteur Physique** : `http://localhost:3333` (Documentation Swagger : `/docs`)
* **Broker MQTT (Mosquitto)** : `localhost:1883`
* **Observabilité Graphique (Grafana)** : `http://localhost:3000`

---

## 3. Étape 2 : Configuration Graphique de la Topologie

Avant d'initier la télémétrie, vous devez matérialiser les équipements industriels en utilisant le **Générateur de Topologie** disponible sur l'interface de l'application :

```text
 🏗️ Générateur de Topologie
   📍 Ville       :  Marseille
   🖥️ Profil      :  MEDIUM GPU 
   📦 Clusters    :  [ 1 ]
   
                     [ ➕ Ajouter un cluster ]  
                     
                     [ 🚀 Lancer le Build ]

```

* ** Ville** : `Marseille` (Impose le climat local et les coûts électriques locaux).
* ** Profil** : `MEDIUM GPU` (Instancie des clusters de serveurs de calcul intensif IA équipés de ventilateurs physiques régulables).
* Cliquez sur ** Lancer le Build** : Cette action purge les anciennes tables et configure une infrastructure propre.

---

## 4. Étape 3 : Spécifications de votre Consommateur (`ingest/`)

Votre premier livrable consiste à **développer de zéro un script consommateur MQTT (Subscriber)** capable de lire la télémétrie en temps réel et de l'historiser pour l'apprentissage de vos modèles.

### Structure des données IoT émises

Votre script doit se connecter au broker `localhost:1883` et s'abonner au topic : **`v1/gateway/telemetry/#`**.
Chaque payload reçu est au format JSON et structuré de cette manière :

```json
{
  "timestamp": "2026-05-19T13:27:39.000Z",
  "hostname": "marseille-marseille-zone-01-worker-01",
  "environment": { "external_city": "Marseille", "external_temp": "24.0", "ambient_dc_temp": "22.0" },
  "current_fan_speed": 20.00,
  "load_percent": "40.00",
  "sensors": [
    { "id": 1, "type": "LOAD", "value": "40.00", "unit": "%" },
    { "id": 2, "type": "CPU_TEMP", "value": "54.26", "unit": "°C" },
    { "id": 3, "type": "TOTAL_POWER", "value": "245.00", "unit": "W" },
    { "id": 4, "type": "FAN_SPEED_1", "value": "20.00", "unit": "%" }
  ]
}

```

### 💾 Objectif de l'ingestion :

Extrayez ces métriques en continu, calculez des features temporelles (dérivées $\Delta T$ à 15s/30s, moyennes glissantes) et sauvegardez-les dans des fichiers structurés (`Apache Parquet` ou `CSV`) ou dans votre propre base de données afin de constituer un jeu de données reproductible.

---

## 5. Étape 4 : Développement du Contrôleur Intelligent

Votre application `juste-ventilateurs` doit fermer la boucle de décision en temps réel en implémentant deux fonctionnalités majeures :

### 1. Régulation Dynamique de la Vitesse (Régime Nominal)

Entraînez un modèle (ou concevez une politique à score) évaluant le meilleur compromis **Sûreté Thermique / Sobriété Énergétique**. Votre script doit appliquer les nouvelles consignes de vitesse sur le matériel en appelant l'API officielle :

```http
PATCH http://localhost:3333/fans/{id_du_ventilateur}
Body: { "speed_percent": <vitesse_calculee> }

```

### 2. Détection d'Anomalie et Maintenance (Régime de Crise)

Si un ventilateur subit une avarie physique, modifier sa vitesse (`speed_percent`) n'aura aucun effet. Votre agent doit détecter cette situation (Exemple : Température $>78^\circ\text{C}$ alors que la ventilation demandée est déjà au maximum). Il doit alors envoyer une équipe de techniciens virtuels via la route :

```http
POST http://localhost:3333/sim/maintenance/repair
Body: { "fanId": <id_du_ventilateur_en_panne> }

```

---

## 6. Scénario d'Évaluation : La Crise de Marseille

L'évaluation de votre code se fera en direct en déclenchant la route de stress officielle :

```http
POST http://localhost:3333/sim/scenarios/marseille?cadence=1&persist=true

```

### Chronologie des événements :

* **Tick 52** : **Pic Informatique** – La charge CPU de calcul est **multipliée par 2** instantanément.
* **Tick 56** : **Canicule** – Une dérive thermique lourde de **$+15^\circ\text{C}$** frappe le serveur `worker-01`.
* **Tick 60** : **Avarie Ventilateur** – Le refroidissement mécanique de la machine lâche et tombe à 0% d'efficacité (`CRASH_FAN`).

---

## 7. Structure de Dépôt Recommandée

juste-ventilateurs/
├── ingest/                 # Votre consommateur MQTT et pipeline d'historisation
├── features/               # Pipeline de feature engineering (calcul des dérivées)
├── models/
│   ├── failure_prediction/ # Modèle de prédiction des incidents futurs (ML)
│   └── fan_control/        # Votre contrôleur de régulation de vitesse
├── data/                   # Datasets d'entraînement versionnés
├── docker-compose.yml      # Containerisation de votre microservice
└── requirements.txt        # Dépendances Python (requests, paho-mqtt, scikit-learn...)


Types d'Événements Renseignés
CRASH_FAN : Arrêt mécanique immédiat d'un composant de refroidissement (la vitesse tombe à 0%).

LOAD_SPIKE_ALL : Multiplicateur de charge globale appliqué instantanément sur l'ensemble de l'infrastructure informatique.

THERMAL_DRIFT_SERVER : Pénalité environnementale ajoutant une hausse constante de température sur un nœud spécifique (perte d'efficacité de dissipation).

Catalogue des Scénarios
Le système expose 11 scénarios préconfigurés, classés par niveau de complexité :

Anomalies Unitaires (Validation)
op_fan_failure (Défaut Matériel : Panne Ventilateur) : Panne du ventilateur cible 1 au tick 15.

op_traffic_surge (Surcharge Opérationnelle : Hausse de Trafic) : Doublement de la charge globale au tick 10.

op_thermal_drift (Dégradation Physique : Dérive Thermique) : Hausse thermique de +1.5°C sur le serveur 2 au tick 5.

Configurations par Type de Cluster
sc_cluster_small (SMALL-EDGE : Coup de Chaleur sur Micro-Closet) : Panne de ventilation sur infrastructure Edge au tick 12. Sans action de bridage, le crash thermique est immédiat.

sc_cluster_medium (MEDIUM-CLUSTER : Incident Électrique Alterné) : Dérive thermique de +2.0°C sur le nœud 3 au tick 8.

sc_cluster_high (HIGH-POWER : Stress-Test IA & Supercalculateur) : Surcharge massive de calcul à 220% de la normale dès le tick 5.

Scénarios Avancés et Multi-Villes
sc_marseille_gpu_melt (MARSEILLE : Canicule Phocéenne & Surcharge GPU) : Simulation sur une semaine. Surcharge au tick 52, dérive caniculaire (+15°C) au tick 56, panne matérielle critique au tick 60.

sc_euro_cross_topology (TOPOLOGIE : Le Grand Chelem Européen) : Événements hétérogènes synchronisés sur plusieurs zones géographiques (Surcharge globale, dérive thermique à Marseille et panne de ventilation à Oslo).

Profils de Crise Majeure (Algorithmes IA et MLOps)
sc_marseille_massive_chaos (PROD-CRISIS : Marseille Chaos) : 14 pannes et dérives majeures distribuées sur 168 ticks pour tester la maintenance prédictive sous flux de données instable.

sc_cluster_10_infestation (SCALE-10 : Infestation Matérielle Multi-Zone) : Défaillance en cascade des systèmes de ventilation sur 10 clusters distincts, forçant l'ordonnanceur à paralléliser les actions correctives.

sc_apocalypse_50 (APOCALYPSE-50 : Blackout Thermique Massif) : Épreuve de robustesse ultime impliquant 50 clusters simultanés. Injections simultanées de hausses environnementales extrêmes (+20°C) et pannes en rafale.

Liste des Identifiants Disponibles
Pour charger un scénario depuis les contrôleurs ou l'API, utilisez l'un des jetons de la liste d'enregistrement standard :

```
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
];

```