| Profile         | Matériel (ex)              | Rôles (per 20)        | IT per server (W) | Fan W (per server) | Rack / cluster IT (kW) | Infra overhead (kW) | Env factor      | Ex PUE example    | Master HW              | Master IT (W) | Worker IT (W) |
| --------------- | -------------------------- | --------------------- | ----------------- | ------------------ | ---------------------- | ------------------- | --------------- | ----------------- | ---------------------- | ------------- | ------------- |
| G-A (HPC)       | 2×Xeon, 1×A100, 512GB      | 4 masters, 16 workers | 1200–1800         | 20–40              | 24–36 kW               | 10–14 kW            | 1.05 (optimisé) | (30+12)/30 ≈ 1.40 | 2×Xeon + 1×A100, 512GB | 1700          | 1450          |
| G-B (Hybrid)    | 2×EPYC, 1×V100, 384GB      | 3 masters, 17 workers | 800–1200          | 15–30              | 16–24 kW               | 8–12 kW             | 1.10            | (20+10)/20 = 1.50 | 2×EPYC + 1×V100, 384GB | 1100          | 900           |
| G-C (Low-power) | 2×CPU dense, no GPU, 256GB | 2 masters, 18 workers | 400–600           | 10–20              | 8–12 kW                | 6–9 kW              | 1.15            | (10+7)/10 = 1.70  | 2×CPU dense, 256GB     | 550           | 450           |


| Profile         | Matériel               | Rôles (per 10)       | IT per server (W) | Fan W | IT cluster (kW) | Infra overhead (kW) | Env factor | Ex PUE           | Master HW              | Master IT (W) | Worker IT (W) |
| --------------- | ---------------------- | -------------------- | ----------------- | ----- | --------------- | ------------------- | ---------- | ---------------- | ---------------------- | ------------- | ------------- |
| M-A (GPU)       | 2×EPYC + 1×RTX, 256GB  | 2 masters, 8 workers | 600–900           | 15–25 | 6–9 kW          | 3.5–5.5 kW          | 1.1        | (8+4.5)/8 ≈ 1.56 | 2×EPYC + 1×RTX, 256GB  | 850           | 700           |
| M-B (CPU-heavy) | 2×Xeon, 128GB          | 2 masters, 8 workers | 300–500           | 8–15  | 3–5 kW          | 2.5–4 kW            | 1.2        | (4+3)/4 = 1.75   | 2×Xeon, 128GB          | 450           | 350           |
| M-C (Edge type) | i9 + small accel, 64GB | 1 master, 9 workers  | 150–300           | 5–10  | 1.5–3 kW        | 1.5–2.5 kW          | 1.25       | (2+2)/2 = 2.00   | i9 + small accel, 64GB | 250           | 180           |


| Profile           | Matériel              | Rôles (per 5)       | IT per server (W) | Fan W | IT cluster (kW) | Infra overhead (kW) | Env factor | Ex PUE               | Master HW             | Master IT (W) | Worker IT (W) |
| ----------------- | --------------------- | ------------------- | ----------------- | ----- | --------------- | ------------------- | ---------- | -------------------- | --------------------- | ------------- | ------------- |
| S-A (Mini GPU)    | i9 + 1×RTX, 128GB     | 1 master, 4 workers | 300–500           | 8–15  | 1.5–2.5 kW      | 1.2–1.8 kW          | 1.2        | (2+1.5)/2 = 1.75     | i9 + 1×RTX, 128GB     | 450           | 350           |
| S-B (Small CPU)   | i7 / Xeon small, 64GB | 1 master, 4 workers | 100–200           | 5–8   | 0.5–1 kW        | 0.8–1.2 kW          | 1.3        | (0.8+1)/0.8 = 2.25   | i7 / Xeon small, 64GB | 180           | 120           |
| S-C (Edge closet) | NUC / low-power, 32GB | 1 master, 4 workers | 30–80             | 2–5   | 0.15–0.4 kW     | 0.4–0.8 kW          | 1.35       | (0.3+0.6)/0.3 = 3.00 | NUC / low-power, 32GB | 70            | 45            |


1. IT Cluster (kW)

Puissance totale consommée par tous les serveurs (Masters + Workers) y compris les ventilateurs :

IT Cluster (kW)
=
∑
(
Master IT
+
Fan Master
+
Worker IT
+
Fan Worker
)
1000
IT Cluster (kW)=
1000
∑(Master IT+Fan Master+Worker IT+Fan Worker)
	​

2. Infra Overhead (kW)

Consommation des systèmes d’infrastructure (cooling, UPS, PDU, etc.), influencée par le facteur environnemental :

Infra Overhead (kW)
=
IT Cluster
×
Base Factor
×
Env Factor
Infra Overhead (kW)=IT Cluster×Base Factor×Env Factor

Base Factor : proportion de l’IT Cluster (ex : 0.3) ou valeur fixe par profile.

Env Factor : multiplicateur selon conditions environnementales (ex : 1.05 → +5% overhead).

3. PUE (Power Usage Effectiveness)

Mesure de l’efficacité énergétique du cluster :

PUE
=
IT Cluster + Infra Overhead
IT Cluster
PUE=
IT Cluster
IT Cluster + Infra Overhead
	​


Exemple :

IT Cluster = 32.5 kW

Infra Overhead = 12.1 kW

PUE
=
32.5
+
12.1
32.5
≈
1.37
PUE=
32.5
32.5+12.1
	​

≈1.37
4. IT / Fan par serveur

Pour chaque serveur :

IT total serveur
=
IT server
+
Fan W
IT total serveur=IT server+Fan W

IT server : consommation électrique du serveur (Master ou Worker).

Fan W : consommation ventilateurs du serveur.

Ensuite, on somme tous les serveurs pour obtenir IT Cluster.

5. Simulation intra-cluster

Chaque serveur peut tirer sa consommation dans la plage définie par le profile (IT per server (W) et Fan W).

L’overhead et la PUE peuvent varier légèrement selon les tirages pour simuler la variabilité réelle.

# Exemple de calcul du coût énergétique d’un ventilateur de 40 W

## Conversion de la puissance en kW

40 W ÷ 1000 = **0,04 kW**

## Consommation par jour

0,04 × 24 = **0,96 kWh / jour**

## Coût journalier

0,96 × 0,20 € = **0,192 € / jour**

## Coût mensuel

0,192 × 30 = **5,76 € / mois**

---

# Remarque

Le champ `IT per server (W)` ne sert plus et doit être supprimé.  
Cette valeur sera calculée a posteriori à partir des données réelles des serveurs.