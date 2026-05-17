-- 1. Activer l'extension dans la base
CREATE EXTENSION IF NOT EXISTS timescaledb CASCADE;
-- 2. Transformer la table existante en Hypertable
-- On indique la colonne de temps ('time') et on définit la taille des partitions (ex: 1 jour)
SELECT create_hypertable('sensor_data', 'time', chunk_time_interval => INTERVAL '1 day');

-- 3. (Optionnel) Activer la compression pour économiser 90% d'espace
-- Très utile pour "les millions de données" de vos étudiants
ALTER TABLE sensor_data SET (
  timescaledb.compress,
  timescaledb.compress_segmentby = 'sensor_id'
);

-- Appliquer la compression sur les données vieilles de plus de 7 jours
SELECT add_compression_policy('sensor_data', INTERVAL '7 days');