-- 1. Référentiels et Profils
SELECT * FROM "cluster_location" LIMIT 3;
SELECT * FROM "load_profile" LIMIT 3;
SELECT * FROM "cpucooler_catalog" LIMIT 3;
SELECT * FROM "fan_catalog" LIMIT 3;
SELECT * FROM "fan_configuration" LIMIT 3;

-- 2. Configuration du Cluster (La table critique pour les FK)
SELECT * FROM "cluster_configuration" LIMIT 3;

-- 3. Instances physiques
SELECT * FROM "cluster" LIMIT 3;
SELECT * FROM "server" LIMIT 3;
SELECT * FROM "fan" LIMIT 3;
