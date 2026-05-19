Voici le fichier `README.md` complet, structuré, professionnel et parfaitement calibré pour l'exercice sur **Marseille**. Il intègre le contexte de l'infrastructure, le générateur de topologie de l'interface, la création du microservice d'ingestion MQTT ("juste-ventilateurs") et les attendus précis pour la soutenance des étudiants.

---

# 🏢 README : Sujet de TP / Projet Final – Jumeau Numérique & Régulation IA de l'Infrastructure de Marseille

## 📖 1. Introduction & Contexte du Projet

Dans la plupart des datacenters modernes, la question n’est plus seulement de “faire tourner les serveurs”, mais de maintenir les machines dans une zone de fonctionnement sûre tout en contenant la facture énergétique. Au quotidien, des équipes d’ingénieurs data et d’experts IA doivent jongler entre alertes de température, tickets d’incident et objectifs de réduction de consommation électrique, avec des infrastructures déjà en production et peu de marge pour expérimenter.

Dans ce projet, vous travaillez sur un environnement contrôlé qui reproduit un parc de machines et ses contraintes thermiques. Le simulateur open source **`jumeaux-chauds`** joue le rôle de jumeau numérique d’un datacenter : télémétrie temps réel via MQTT, API de pilotage des ventilateurs, mécanismes d’arrêt automatique pour protéger les machines, scénarios de charge et de stress variés. Vous n’avez pas à gérer la couche matérielle ou réseau, mais à exploiter ce jumeau comme le feraient des ingénieurs en production.

Quand les choses se réchauffent et que les capteurs s’agitent, dans un système qui contrôle juste des ventilateurs, notre IA est activée pour refroidir les choses et faire baisser la pression.

---

## 🗺️ 2. Mise en Situation Professionnelle

Vous faites partie d’une petite équipe de 2 à 4 ingénieurs (data, IA, ML/MLOps) en charge de la fiabilité thermique d’un datacenter de taille moyenne basé à **Marseille**. L’infrastructure est équipée de capteurs de température et de ventilateurs contrôlables à distance, exposant des flux de télémétrie et des APIs. Le pilotage actuel reste fondé sur des règles statiques (seuils fixes, modes ventilateur prédéfinis), provoquant des épisodes de surchauffe et quelques arrêts thermiques de sécurité (`shutdown`) lors des pics de charge.

Pour expérimenter sans risque, vous utilisez le jumeau numérique **`jumeaux-chauds`** pour piloter le cluster de **Marseille** et y injecter un scénario de stress caniculaire et de panne matérielle.

### Enjeux clés :

* **Sécurité thermique** : Ne jamais tolérer un shutdown par dépassement de critère de température ($105^\circ\text{C}$).
* **Efficacité énergétique** : Garder les machines assez froides avec le **minimum** d'énergie compatible avec la sûreté.

---

## 🏗️ 3. Étape 1 : Initialisation de la Topologie via le Générateur

Avant d'exécuter vos modèles, vous devez initialiser l'infrastructure de l'exercice. Utilisez le **Générateur de Topologie** présent sur l'interface graphique du simulateur (ou l'endpoint `POST /build-exercise`) configuré obligatoirement de la manière suivante :

```text
 🏗️ Générateur de Topologie
   📍 Ville       :  Marseille
   🖥️ Profil      :  MEDIUM GPU  (ou BIG HIGH POWER / SMALL EDGE CLOSET)
   📦 Clusters    :  [ 1 ]
   
                     [ ➕ Ajouter un cluster ]  
                     
                     [ 🚀 Lancer le Build ]

```
Vous pouvez vous rendre sur l'endpoint http://localhost:3333/create pour accéder a un forumlaire de building
* **📍 Ville** : `Marseille` (Impose le climat méditerranéen chaud et le coût énergétique local).
* **🖥️ Profil** : `MEDIUM GPU` (Déploie un cluster de serveurs de calcul avec cartes graphiques accélérées, équipé de ventilateurs physiques régulables).
* Cliquez sur **🚀 Lancer le Build** : Cela va purger l'historique et instancier votre topologie propre en base de données.

---

## 🧪 4. Le Scénario de Référence : La Crise de Marseille

Une fois votre topologie construite, l'évaluation de vos algorithmes se fera en déclenchant la route de crise dédiée :

```http
POST http://localhost:3333/sim/scenarios/marseille?cadence=1&persist=true

```

Le scénario applique une gradation de crise temporelle sur votre infrastructure :

1. **Tick 52 (Mercredi 04h00)** : Une surcharge applicative frappe Marseille (La charge de calcul nominale de base est **multipliée par 2**).
2. **Tick 56 (Mercredi 08h00)** : Une canicule s'abat sur la ville, provoquant une dérive thermique lourde de **$+15^\circ\text{C}$** sur l'environnement du serveur `worker-01`.
3. **Tick 60 (Mercredi 12h00)** : Le ventilateur principal du serveur en surchauffe subit une avarie mécanique totale et s'arrête (`CRASH_FAN` bloqué à 0%).

### Comportement par défaut (Sans votre IA) :

La température du CPU s'emballe verticalement et vient saturer sur la ligne rouge critique des **$105^\circ\text{C}$**.

---

## 🛠️ 5. Travaux à Réaliser (Votre Roadmap)

Vous devez concevoir et livrer un dépôt nommé **`juste-ventilateurs`**, exécutable côte à côte avec `jumeaux-chauds` sous la forme d'un microservice conteneurisé.

### Phase 1 : Prise en main, Ingestion et Ingestion Temps Réel (Votre Consommateur)

* Développer un **Subscriber MQTT autonome** (en Python) qui écoute le topic `v1/gateway/telemetry/#`.
* Parser et normaliser les payloads reçus.
* Alimenter une base de données de séries temporelles (TimescaleDB) ou exporter les données au format Parquet/CSV structuré afin de constituer vos datasets pour l'apprentissage (`train`/`validation`/`test`).

### Phase 2 : Feature Engineering

* Construire des features glissantes : Températures actuelles, dérivées temporelles ($\Delta T$ à 5s, 15s, 30s), rolling means de la charge informatique, marge avant le shutdown.
* Calculer des métriques énergétiques : Puissance instantanée consommée ($W$) et coût cumulé.

### Phase 3 : Modèle d'Anticipation de Pannes

* Entraîner un modèle de classification (ex: *Random Forest, XGBoost ou LightGBM*) pour prédire à un horizon de 60 secondes si une machine va basculer en mode dégradé ou en shutdown.
* **Baseline obligatoire** : Comparer votre modèle avec un système heuristique à seuil fixe simple.

### Phase 4 : Contrôleur et Politique de Régulation des Ventilateurs

* Concevoir l'algorithme d'actionneur. Vous devez passer les machines en mode manuel et ajuster dynamiquement la vitesse en appelant la route REST native du jumeau :
```http
PATCH http://localhost:3333/fans/{id_du_ventilateur}
Body: { "speed_percent": <vitesse_calculee> }

```


* **Gestion de la panne mécanique (Tick 60)** : Votre script doit détecter l'anomalie (Température $> 78^\circ\text{C}$ alors que la ventilation demandée est déjà au maximum). Il doit alors déclencher automatiquement l'envoi de l'équipe technique virtuelle via l'API :
```http
POST http://localhost:3333/sim/maintenance/repair
Body: { "fanId": <id_du_composant_en_panne> }
