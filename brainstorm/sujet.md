C'est une excellente question de fond. Dans la réalité, un administrateur système ou une IA ne tourne pas un bouton magique directement sur le processeur pour lui dire "travaille moins".

En revanche, on modifie la charge d'un serveur de manière indirecte mais ultra-précise via l'architecture réseau et logicielle. Dans le monde de la production (Cloud, Edge Computing, Datacenters), cela se produit tous les jours dans quatre grands cas concrets :

1. Le Routage de Trafic (Load Balancing) — Le cas le plus courant
Dans n'importe quelle architecture web (comme Netflix, Uber ou une banque), les serveurs sont cachés derrière un Répartiteur de charge (Load Balancer) comme Nginx, HAProxy ou AWS ALB.

Si une IA détecte que le serveur-01 surchauffe à cause de son ventilateur mort, elle va envoyer un ordre au Load Balancer : "Arrête d'envoyer des requêtes HTTP sur le serveur-01, bascule 100% des nouveaux utilisateurs sur le serveur-02".

Le serveur-01 n'ayant plus de requêtes à traiter, sa charge CPU va s'effondrer de 90% à 5% en quelques secondes, lui laissant le temps de refroidir sans couper le service pour les utilisateurs.

2. L'Orchestration de Conteneurs (Kubernetes / Docker Swarm)
Dans les infrastructures modernes, les applications tournent dans des conteneurs (Pods). Kubernetes surveille en continu la santé des machines physiques (les nœuds).

Si le démon de surveillance détecte une anomalie matérielle (une dérive thermique ou un ventilateur défaillant), il déclenche une procédure automatique appelée Cordon & Drain :

Le serveur est marqué comme "malade" (Cordon).

Kubernetes tue proprement les conteneurs qui tournent dessus et les recrée instantanément sur les autres serveurs sains du datacenter (Drain).

Résultat : La charge du serveur défectueux tombe à zéro, et les techniciens peuvent intervenir pour changer le ventilateur.

3. Les Calculs de Masse et l'IA (Batch Processing / Heavy Workloads)
Dans les datacenters qui font du rendu 3D, du calcul scientifique ou de l'entraînement de grands modèles d'IA, les serveurs exécutent des tâches lourdes qui durent des heures (via des systèmes comme Slurm, Kubernetes Jobs ou Hadoop/Spark).

Si un serveur commence à surchauffer au milieu d'un calcul d'IA :

L'ordonnanceur de tâches peut décider de mettre le calcul en "Pause" (mettre en veille les scripts de calcul) ou de générer un checkpoint pour déplacer le calcul sur une autre machine.

En coupant le script de calcul lourd, la charge du processeur (ou de la carte graphique) chute immédiatement.

4. Le Bridage Énergétique Automatique (Dynamic Voltage and Frequency Scaling - DVFS)
Au niveau du système d'exploitation (le noyau Linux), il existe des mécanismes de protection thermique.

Si l'OS voit que le CPU approche d'une zone dangereuse, il va réduire de force la fréquence d'horloge du processeur (on appelle ça le CPU Throttling ou le Thermal Throttling). Si ton CPU tournait à 3.8 GHz, Linux va le brider à 1.4 GHz. Le serveur mettra plus de temps à répondre aux clients, mais sa consommation et sa charge physique vont baisser drastiquement pour éviter que la puce ne brûle.

🎓 Ce que ça change pour ton TP :
Dans ton projet, l'action SET_SERVER_LOAD est une abstraction parfaite. Au lieu d'obliger tes M2 à configurer un cluster Kubernetes complet, à coder un proxy Nginx et à gérer de vrais conteneurs (ce qui prendrait des mois de cours), ton API simule exactement le résultat final de ces technologies.

Pour eux, envoyer value: 10 simule le fait que l'IA a réussi à délester le serveur en déplaçant son trafic ailleurs.

Est-ce que tu veux qu'on prépare le terrain pour le premier script Python que tu vas donner à tes étudiants pour qu'ils commencent à scripter ces réactions ?


Pour des étudiants de Master 2 qui ne sont pas des matheux dans l'âme, il faut absolument fuir les sigles grecs et les intégrales. Le secret, c'est de leur présenter le PUE comme une facture avec des suppléments.Voici la formule vulgarisée, "clés en main", que tu peux copier-coller directement dans ton sujet de TP ou projeter au tableau.🧾 L'analogie simple : "L'addition du DataCenter"Explique-leur que pour 1 Watt d'électricité utile consommé par un serveur, le datacenter va devoir payer des extras pour faire tourner l'infrastructure.La formule magique à leur donner est la suivante :PUE = 1,25 + Malus Météo + Malus Surchauffe🔍 Le détail des lignes de la facture (Sans maths)1,25 (La Base) : C'est le tarif minimum incompressible de la salle informatique. Même si tous les serveurs dorment et qu'il fait super froid dehors, on consomme 0,25 Watt de plus pour chaque Watt serveur (pertes des onduleurs, l'éclairage, la sécurité).Le Malus Météo (La taxe canicule) :S'il fait 15°C ou moins dehors : C'est gratuit ! On ouvre les fenêtres (Free Cooling), le malus est égal à 0.Si la météo dépasse 15°C : Les clims s'allument. Chaque degré de trop dehors ajoute 0,008 à l'addition.Le Malus Surchauffe (La taxe effort) :Si les serveurs bossent peu et restent sous les 40°C : Le malus est égal à 0.Si les serveurs charbonnent et dépassent 40°C : Les puces chauffent la pièce. Chaque degré CPU en trop ajoute 0,005 à l'addition.💡 Un exemple concret à leur donner :"Imaginons qu'il fasse 25°C à Marseille (soit 10°C de trop) et que vos serveurs bossent tellement qu'ils montent à 60°C (soit 20°C de trop).Base : 1,25Malus Météo : 10°C en trop $\times$ 0,008 = +0,08Malus Surchauffe : 20°C en trop $\times$ 0,005 = +0,10Addition finale : 1,25 + 0,08 + 0,10 = 1,43 de PUE.Cela veut dire que pour 100W consommés par le serveur, le datacenter en facture 143W au total."🎯 Le défi pour leur code PythonAvec cette présentation, l'objectif du TP devient limpide pour eux : "Votre script doit brider la charge des serveurs juste assez pour ne pas déclencher le Malus Surchauffe, sans pour autant faire ramer les applications." Ils comprennent instantanément l'impact de leurs lignes de code sur la facture énergétique.Pour leur simplifier la vie lors des premières minutes du TP, veux-tu qu'on écrive la petite fonction Python d'aide (le "calculateur de PUE théorique") qu'ils pourront intégrer directement dans leur script pour estimer ce PUE idéal ?






📝 Énoncé de l'exercice pour les étudiants
Question 1 : Cartographie de l'infrastructure
Écrivez un script Python qui se connecte à la base de données tsdb et affiche le nombre total de serveurs par cluster (Paris, Marseille, Oslo) ainsi que la liste des types de capteurs uniques enregistrés dans la table sensor.

Question 2 : Le "Sanity Check" (Visualisation brute)
Chargez l'historique des données du capteur CPU_TEMP pour le serveur oslo-oslo-03-zone-01-worker-01. À l'aide de la bibliothèque matplotlib ou seaborn, tracez la courbe brute de la température en fonction du temps.

Indice : Un événement anormal s'est produit au démarrage de la simulation. Que remarquez-vous sur l'échelle de l'axe des ordonnées (Y) ?

Question 3 : Isolation des Outliers
À l'aide de la méthode des barrières physiques (Seuils) ou de l'écart interquartile (IQR), déterminez le nombre de lignes corrompues par le bug de démarrage. Calculez la température moyenne brute (avec bug) VS la température moyenne réelle après exclusion des valeurs aberrantes.

Question 4 : Export du Dataset Propre
Créez un DataFrame Pandas contenant uniquement les données valides (sans valeurs aberrantes) et exportez-le au format .csv pour préparer le pipeline d'entraînement de votre futur modèle prédictif.


Question 1 : Architecture Réseau (Le Pont IT/OT)Créez un script Python capable de s'abonner au topic MQTT v1/gateway/telemetry/#. Pour chaque message reçu, extrayez le hostname du serveur et sa température CPU actuelle. Établissez la connexion HTTP avec l'API Fastify pour envoyer une commande de test fixant la vitesse à 50% sur le endpoint /api/servers/{hostname}/control.Question 2 : Le Piège des Paliers (Algorithme "Tout ou Rien")Implémentez une logique de contrôle simple par paliers (ex: si $T > 65^\circ\text{C} \rightarrow \text{Ventilo}=100\%$, si $T < 55^\circ\text{C} \rightarrow \text{Ventilo}=25\%$).Exécutez l'agent pendant 2 minutes réelles (ce qui correspond à plusieurs heures simulées) et observez le comportement sur votre tableau de bord Grafana.Analyse attendue : Pourquoi la courbe de température du cluster de Paris se met-elle à osciller violemment (effet yoyo en dents de scie) au lieu de se stabiliser ? Quel est l'impact de l'inertie thermique ?Question 3 : Implémentation d'un Contrôleur Proportionnel (P-Controller)Pour corriger l'effet yoyo, remplacez les paliers par une approche mathématique continue : un correcteur Proportionnel. La vitesse du ventilateur doit être proportionnelle à l'erreur constatée par rapport à la cible ($60^\circ\text{C}$) :$$\text{Erreur} = \text{Température Actuelle} - \text{Température Cible}$$$$\text{Vitesse} = \text{Vitesse de Base} + (K_p \times \text{Erreur})$$Trouvez expérimentalement la valeur du gain proportionnel ($K_p$) permettant de stabiliser Oslo et Marseille sans surconsommer.Question 4 : Le Défi de Paris (Anticipation)Le cluster de Paris, à cause de son inertie thermique de 92%, continue de chauffer même quand le ventilateur accélère. Si votre algorithme attend que le serveur dépasse $60^\circ\text{C}$ pour réagir, la température va monter à $72^\circ\text{C}$ avant de redescendre.Défi : Modifiez votre algorithme pour qu'il lise également le capteur de charge (LOAD) du serveur dans le payload MQTT afin d'accélérer les ventilateurs dès que la charge augmente, avant même que le CPU n'ait eu le temps de chauffer.




CHANTIER 3 : Analytics, PUE et Impact Financier du Refroidissement (Green IT)🎯 Objectifs du chantier :Comprendre et calculer l'indicateur industriel clé d'un DC : le PUE.Calculer la consommation électrique globale de l'infrastructure (Informatique + Climatisation).Traduire la consommation technique en coût financier direct ($\text{kWh} \times \text{Tarif Local}$).Mesurer le ROI (Retour sur Investissement) : combien d'argent l'IA codée au Chantier 2 fait-elle économiser par rapport à une ventilation bête et méchante ?🧮 Rappel de physique pour les étudiants :$\text{PUE} = \frac{\text{Énergie Totale du Bâtiment}}{\text{Énergie consommée par les Serveurs (IT)}}$$\text{Énergie Totale Bâtiment} = \text{Énergie IT} \times \text{PUE}$Un PUE de $1.25$ signifie que pour $100\text{ W}$ consommés par le CPU, $25\text{ W}$ supplémentaires sont gaspillés par le bâtiment (principalement dans la climatisation).📝 Énoncé de l'exercice pour les étudiantsQuestion 1 : Le Coût de l'ÉnergieEn analysant la table cluster_location, identifiez le coût du kWh pour chaque ville.Quelle est la ville la plus économique pour faire tourner un serveur ? Quelle est la plus chère ? Quel est l'impact de cette asymétrie sur la répartition géographique des calculs ?Question 2 : Requête SQL - Consommation Globale RéelleÉcrivez une requête SQL pour Grafana qui calcule la puissance totale consommée par chaque cluster en temps réel (en Kilowatts, $\text{kW}$), en incluant le PUE du bâtiment spécifié dans la table cluster_configuration.Formule : $\text{Puissance Totale (kW)} = \frac{\text{Somme des capteurs TOTAL\_POWER de tous les serveurs du cluster}}{1000} \times \text{PUE}$Question 3 : Requête SQL - La Facture Horaire (Dashboarding)À l'aide de la fonction time_bucket de TimescaleDB, créez une requête qui affiche l'évolution du coût financier horaire (en €/h) de chaque datacenter. Ce panel sera le cœur du tableau de bord destiné à la direction financière.Question 4 : L'épreuve du ROI (Analyse Comparative)Comparez la facture globale simulée lorsque les ventilateurs tournent à fond par défaut ($100\%$) VS lorsque votre Agent IA du Chantier 2 régule dynamiquement le système.Calculez l'économie financière réalisée sur 24 heures simulées pour le cluster de Paris.


const currentHour = simulatedDate.getHours();
// ...
if (location.includes("paris")) {
  // Pic de charge calé en journée (décalage de 6h, amplitude de 55%)
  load = 0.25 + 0.55 * Math.sin((((currentHour % 24) - 6) / 24) * 2 * Math.PI); 
} else if (location.includes("marseille")) {
  load = 0.45 + 0.15 * Math.sin(((currentHour % 24) / 24) * 2 * Math.PI);
} else {
  load = 0.25 + 0.05 * Math.sin(((currentHour % 24) / 24) * 2 * Math.PI);
}