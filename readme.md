locust -f locust_producer.py
locust -f locust_consumer.py

# Faire évoluer le sujet:
Si température trop elevée, allumer un ventillateur 
Panne prévu 
Status d'utilisation (en cours ou non)
intéraction api pour gérer l'IOT a distance
systeme a etat, peut etre faire du monitoring avec des alertes 

base de donnée = entrainement & apprentissage des stratégies a adopter
inférence = flux chaud pour mettre en pratique 
Bilan
Pannes
Facture d'electricité ? 
Optimisation gagné / productivité 
vitesse du ventillateur 

MCP

websocket ? 

<<<<<<< HEAD
https://dbdiagram.io/d/68c978f51ff9c616bdf484d6
=======

20 cluster 
# sensor_type:
3 capteurs 
Température CPU
Consommation électrique
Débit d’air (airflow)

# Ventillateur
2 fan 
vitesse: 
faible moyen fort
Chaque vitesse a une consommation différente
Scénarios de clustering (variantes)

Pour chaque scénario ci-dessous, hypothèse de base : chaque serveur = 3 capteurs (temp CPU, conso W, airflow) + 2 fans.

Petit cluster (5 serveurs)

Avantages : meilleure isolation, charge thermique plus facile à dissiper, redondance simple.

Inconvénients : moins de données pour détecter patterns, une panne serveur = impact proportionnellement plus fort.

Test à simuler : panne d’un fan sur 1 serveur → hausse locale de la température; l’IA devrait détecter la déviation rapide et proposer action (monter speed ou basculer en manuel).

Cluster moyen (10 serveurs)

Avantages : agrégation utile pour corrélation, possibilité d’équilibrer charge.

Inconvénients : points chauds localisés peuvent rester invisibles si on ne regarde que la moyenne.

Test : hausse modérée de charge CPU sur 2 serveurs → conso ↑ + temp ↑; si airflow baisse sur 1 serveur (capteur airflow défaillant), l’IA doit distinguer «capteur mort» vs «vrai problème».

Cluster large (15 serveurs)

Avantages : plus de données → meilleurs modèles ML, meilleure robustesse statistique.

Inconvénients : propagation thermique possible (hot-aisle effects) ; consommation cumulée élevée.

Test : simuler défaillance partielle de la clim de la salle → températures globales montent progressivement sur plusieurs serveurs ; l’IA devrait détecter corrélation spatiale (plusieurs serveurs du même rack / cluster montent ensemble).

Très large (20 serveurs) — scénario par défaut

Avantages : forte volumétrie pour entrainer modèles, possibilité d’optimisation énergétique à l’échelle du cluster.

Inconvénients : plus d’interactions non-linéaires (ventilos, flux d’air, PDU) → politiques de contrôle plus complexes.

Test : montée de charge transitoire (pic), + 1 ventilateur tombe progressivement (dégradation) → l’IA doit prédire la panne totale du fan et planifier remplacement / redistribution de charge.

Causes de pannes simulées (à injecter)

Défaillance matérielle soudaine : fan OFF, capteur qui renvoie NULL, disque qui saute.

Dégradation progressive : fan qui perd 1-2% d’efficacité toutes les heures (courbe linéaire ou exponentielle).

Erreur de capteur : drift systématique (offset) ou stuck value.

Surcharge logicielle : processus CPU intensif simulé → temp + conso ↑.

Problème d’infrastructure : PDU (alim) qui limite la puissance, climatisation qui baisse en performance.

Interférence réseau : perte de télémetrie intermittente (paquets manquants), entraînant trous dans séries temporelles.

Effets de regroupement : hot-aisle / cold-aisle — si le flux d’air est mal réparti, serveurs voisins impactés.

Métriques & KPIs à observer

Température (°C) : moyenne, max par serveur, dérivée (delta/min).

Consommation (W) : par serveur / cluster, pics, énergie cumulative (kWh).

Airflow (m³/s ou valeur relative) : chute absolue ou relative.

Fans : status (ON/OFF), speed_percent, temps de réponse.

Disponibilité capteurs (missing %).

Anomalies détectées (count/jour), FA/FR rates (faux positifs/négatifs).

Latence de détection et temps moyen pour remédiation (simulé).

Expériences concrètes à lancer (protocoles)

Pour chaque taille de cluster, exécute ces tests et collecte résultats :

Test “fan fail” (soudain)

Injecter fan.status = OFF sur un fan d’un serveur à t0.

Observables : temp_local ↑ (p.ex. +6–12°C), fans restants augmentent speed, consommation inchangée.

Vérifie si l’IA propose : augmenter speed du fan adjacent, migrer jobs, alerter maintenance.

Test “sensor drift” (progressif)

Appliquer offset +0.5°C par heure sur un capteur.

Observables : divergence entre capteurs du même serveur → signe d’erreur capteur.

L’IA doit apprendre à corréler capteurs (ex. température CPU vs chassis) pour détecter drift.

Test “clim dégradée” (cluster-wide)

Baisser airflow ambiant ou la capacité de la clim (simulateur) → temps: montée lente sur plusieurs serveurs.

Observables : pattern spatial (serveurs en bas du rack plus chauds).

L’IA doit classifier «issue cluster vs server».

Test “charge burst”

Simuler pic de CPU sur N serveurs (1, 5, 10 selon taille).

Observables : conso ↑, temp ↑ ; si N grand → température cluster augmente plus, puis fans saturent.

Étudier seuils où actions préventives deviennent nécessaires.

Test “partial network loss”

Simuler perte de télémétrie 10–30s sur certains capteurs.

Observables : trous temporels ; l’IA/ingestion doit interpoler ou marquer données manquantes.

Hypothèses / apprentissages que l’IA peut tirer

Corrélations multi-capteur : temp ↑ + conso ↑ → vraie charge ; temp ↑ seule → airflow/ventilateur défectueux ou capteur.

Détection précoce : dégradation progressive des fans peut être identifiée par augmentation progressive de speed_percent et temps de réponse.

Classification spatiale : pannes cluster-wide vs server-level grâce à motifs spatiaux (plusieurs serveurs identiques).

Optimisation énergétique : apprendre politiques pour limiter consommation globale (par ex. baisser speed sur serveurs déjà froids et augmenter juste où nécessaire).

Comment injecter les scénarios (pratique)

Seeder : script Python qui crée clusters/servers/sensors/fans (tu l’as déjà en tête).

Fault injector : module qui, selon calendrier, modifie en DB les lignes fan.status, sensor.last_value ou injecte valeurs corrompues dans sensor_data.

Orchestrateur : scheduler (cron ou APScheduler) qui lance les tests (on/off, drift, bursts).

Observability : dashboard (Grafana) + alerting (Prometheus alertmanager ou simple webhook) pour voir effets en temps réel.

Logging : stocker événements de fault injection pour labels ML (anomaly = true).

Exemples de paramètres numériques (à copier-coller)

Dégradation de fan : speed_percent -= 2 tous les 30 min jusqu’à speed_percent <= 40 puis status = OFF.

Drift capteur : value += 0.2 °C / heure.

Charge burst : duration=120s, CPU load = 90% sur N serveurs.

Pertes télémétrie : drop messages MQTT pendant 10–30s sur 20% des capteurs.

# Mesure cout electrique 
Mesures de consommation (Watt) → déjà prévues avec tes capteurs POWER.

Durée de fonctionnement → chaque mesure sensor_data est timestampée.

Prix du kWh → paramètre configurable (ex. 0,20 €/kWh en France, variable selon contrat).

## Exemple 
Exemple concret

1 serveur consomme en moyenne 200 W.

Cluster = 20 serveurs → 200 W × 20 = 4000 W = 4 kW.

Si cluster tourne 24h →

4
 
kW
×
24
 
h
=
96
 
kWh
4kW×24h=96kWh

Prix de l’électricité = 0,20 €/kWh →

96 × 0.20 = 19.20 € /𝑗𝑜𝑢𝑟

96×0.20=19.20€/jour

Donc un cluster de 20 serveurs consomme environ ~20 € par jour.

Charge dynamique : la consommation varie avec l’utilisation CPU → il faut intégrer les données capteurs temporelles.

Ventilateurs : chaque fan consomme aussi (typiquement 2–10 W chacun).

Overhead (climatisation, PDU, UPS) → introduire un PUE (Power Usage Effectiveness).

Exemple : si PUE = 1,5 → chaque 1 kWh IT entraîne 0,5 kWh infra.

Coût réel = Cout IT× 𝑃𝑈𝐸 cout IT×PUE.

# Le batching 

Ce qu’on peut calculer dans chaque batch

Pour chaque capteur et chaque fenêtre (par ex. 5 min), tu peux calculer :

avg = moyenne (ex : conso moyenne 5 min)

min = valeur minimale

max = valeur maximale

first = première valeur de la fenêtre

last = dernière valeur de la fenêtre

count = nombre de points

Candlestick = oui, tu peux !

Les candlesticks viennent du monde financier (OHLC : Open, High, Low, Close), mais ça marche aussi pour l’IoT :

Open → première mesure de la fenêtre

High → max de la fenêtre

Low → min de la fenêtre

Close → dernière mesure de la fenêtre

Donc si tu fais du batch en séries temporelles, tu peux produire directement des chandeliers (candlestick charts) pour :

température CPU d’un serveur,

consommation électrique d’un cluster,

airflow d’un ventilateur.

Et tu peux tracer ça avec n’importe quel outil (Grafana, matplotlib, plotly…).


Capteurs & serveurs

Temp sensors par serveur : 2–4 (CPU, inlet, chassis).

Power sensor : 1 par serveur (ou 1 PDU per rack + estimation per server).

Airflow sensor : 0–1 par serveur + 1 par rack.

Fan : 2 par serveur OK, mais simuler aussi fans rack/room.

Valeurs typiques (ordres de grandeur)

Serveur idle ≈ 50–120 W (selon type), peak ≈ 150–500 W (serveur lourd / GPU beaucoup plus).

Fan per server ≈ 2–20 W chacun (dépendant du modèle).

PUE datacenter réaliste : 1.1–1.8 (1.2 bon).

Fréquence d’échantillonnage conseillée

Température CPU / airflow : 5–15 s pour détection rapide des pics.

Puissance (W) : 15–60 s (les PDU peuvent être plus lents).

États fans / status : on/off en temps réel, log quand changement.

Historique à garder haute fréquence → downsample pour stockage long terme (5s → 1m → 1h).

Modélisation des pannes

Défaillance soudaine : injecter status = OFF à t0 (probabilité p par période).

Dégradation : fan efficiency -= x% every Y hours (simulate wear).

Sensor drift : add bias drawn from normal distro (mu=0, sigma small) cumulative.

Network loss : drop rate 0–5% intermittently.

Statistiques & distributions

MTBF / temps de panne : modéliser avec Weibull ou exponentielle pour la probabilité d’échec.

Charge bursts : utiliser Poisson process pour arrivées de jobs/pics.


Garder ton modèle actuel comme baseline (20/10/5 serveurs par cluster).

Augmenter capteurs par serveur : remplacer 1 temp par 3 sondes (cpu/inlet/chassis).

Ajouter profil de conso : idle/baseline/peak par serveur, générés stochastiquement.

Ajouter fans rack / PUE dans le calcul de coût.

Définir règles de panne (soudaines, drift, dégradation) avec paramètres simples (probabilité, amplitude, durée).

Choix d’échantillonnage : temp 10s, power 30s, stockage long terme downsample 1m.

Si tu veux, je peux générer directement :

un script seed qui crée les capteurs supplémentaires, profils de conso et PUE ; ou

un module de simulation / fault injector qui applique les distributions (Weibull, drift, bursts) et produit des séries temporelles réalistes.
>>>>>>> frontend
