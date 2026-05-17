-- Créer une vue qui calcule les stats par heure automatiquement
CREATE MATERIALIZED VIEW sensor_stats_hourly
WITH (timescaledb.continuous) AS
SELECT 
    sensor_id,
    time_bucket('1 hour', time) AS bucket,
    AVG(value) as avg_temp,
    MAX(value) as max_temp,
    MIN(value) as min_temp
FROM sensor_data
GROUP BY sensor_id, bucket;

-- Rafraîchir la vue toutes les heures
SELECT add_continuous_aggregate_policy('sensor_stats_hourly',
    start_offset => INTERVAL '2 hours',
    end_offset => INTERVAL '1 hour',
    schedule_interval => INTERVAL '1 hour');