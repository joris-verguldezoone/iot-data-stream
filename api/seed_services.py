"""
seed_timescale.py

Script corrigé et idempotent pour créer les tables et seed des données
(tests basiques) dans PostgreSQL/TimescaleDB via psycopg2.

Usage:
  - Place ce fichier dans ton projet
  - Assure-toi que FAN_SEED, BIG_CLUSTERS, MEDIUM_CLUSTERS, SMALL_CLUSTERS
    sont définis dans les modules importés (ou remplace par tes listes)
  - Lance : python3 seed_timescale.py

Notes :
  - Le script utilise des commits explicites et ferme correctement
    connexions/curseurs.
  - Les fonctions sont idempotentes : elles peuvent être relancées.
"""

import psycopg2
from datetime import datetime
from rich import print
from rich.pretty import Pretty
import random

# Imports fournis par l'utilisateur (doivent exister)
from fan_configuration import FAN_SEED
from cluster_configuration import BIG_CLUSTERS, MEDIUM_CLUSTERS, SMALL_CLUSTERS

# Configuration DB
DB_HOST = "timescaledb"
DB_PORT = 5432
DB_NAME = "tsdb"
DB_USER = "tsuser"
DB_PASS = "tspassword"


def get_connection():
    return psycopg2.connect(
        host=DB_HOST,
        port=DB_PORT,
        dbname=DB_NAME,
        user=DB_USER,
        password=DB_PASS
    )


def seed_db():
    """Crée toutes les tables nécessaires (idempotent)."""
    conn = get_connection()
    cur = conn.cursor()

    # Table des emplacements (villes / datacenters)
    cur.execute("""
    CREATE TABLE IF NOT EXISTS cluster_location (
        location_id SERIAL PRIMARY KEY,
        name TEXT NOT NULL,
        location TEXT,
        created_at TIMESTAMPTZ DEFAULT NOW()
    );
    """)

    # Configuration des ventilateurs
    cur.execute("""
    CREATE TABLE IF NOT EXISTS fan_configuration (
        fan_id SERIAL PRIMARY KEY,
        name TEXT,
        consomation NUMERIC
    );
    """)

    # Configuration de cluster (type de cluster)
    cur.execute("""
    CREATE TABLE IF NOT EXISTS cluster_configuration (
        cluster_config_id SERIAL PRIMARY KEY,
        name TEXT NOT NULL,
        master INTEGER NOT NULL,
        worker INTEGER NOT NULL,
        consomation_per_master NUMERIC,
        consomation_per_worker NUMERIC,
        hardware_per_master TEXT,
        hardware_per_worker TEXT,
        env_factor NUMERIC,
        pue NUMERIC,
        location_id INTEGER REFERENCES cluster_location(location_id) ON DELETE SET NULL,
        fan_id INTEGER REFERENCES fan_configuration(fan_id) ON DELETE SET NULL
    );
    """)

    # Table des clusters (instances réelles)
    cur.execute("""
    CREATE TABLE IF NOT EXISTS cluster (
        cluster_id SERIAL PRIMARY KEY,
        name TEXT NOT NULL,
        location TEXT,
        created_at TIMESTAMPTZ DEFAULT NOW()
    );
    """)

    # Serveurs appartenant à un cluster
    cur.execute("""
    CREATE TABLE IF NOT EXISTS server (
        server_id SERIAL PRIMARY KEY,
        cluster_id INT NOT NULL REFERENCES cluster(cluster_id) ON DELETE CASCADE,
        hostname TEXT NOT NULL,
        status TEXT DEFAULT 'ON',
        created_at TIMESTAMPTZ DEFAULT NOW()
    );
    """)

    # Capteurs attachés à un serveur
    cur.execute("""
    CREATE TABLE IF NOT EXISTS sensor (
        sensor_id SERIAL PRIMARY KEY,
        server_id INT NOT NULL REFERENCES server(server_id) ON DELETE CASCADE,
        sensor_type TEXT NOT NULL,
        unit TEXT NOT NULL,
        last_value DOUBLE PRECISION,
        created_at TIMESTAMPTZ DEFAULT NOW()
    );
    """)

    # Ventilateurs sur chaque serveur
    cur.execute("""
    CREATE TABLE IF NOT EXISTS fan (
        fan_id SERIAL PRIMARY KEY,
        server_id INT NOT NULL REFERENCES server(server_id) ON DELETE CASCADE,
        control_mode TEXT DEFAULT 'AUTO',
        status TEXT DEFAULT 'OFF',
        speed_percent INT DEFAULT 0,
        created_at TIMESTAMPTZ DEFAULT NOW()
    );
    """)

    # Timeseries (ex : données de capteur)
    cur.execute("""
    CREATE TABLE IF NOT EXISTS sensor_data (
        time TIMESTAMPTZ NOT NULL DEFAULT NOW(),
        sensor_id INT NOT NULL REFERENCES sensor(sensor_id) ON DELETE CASCADE,
        value DOUBLE PRECISION
    );
    """)

    conn.commit()
    cur.close()
    conn.close()
    print("✅ Toutes les tables initialisées")


def seed_fan_configuration():
    """Insère les configurations de ventilateur depuis FAN_SEED.
    FAN_SEED doit être une liste de dicts: [{"name":..., "consomation": (min, max)}, ...]
    """
    if not FAN_SEED:
        print("ℹ️ FAN_SEED vide — pas de seed pour fan_configuration")
        return

    conn = get_connection()
    cur = conn.cursor()

    for fan in FAN_SEED:
        # consomation attendu comme tuple (min, max)
        if isinstance(fan.get('consomation'), (list, tuple)) and len(fan['consomation']) >= 2:
            consomation = random.uniform(fan['consomation'][0], fan['consomation'][1])
        else:
            consomation = fan.get('consomation') or 0

        # Utiliser UPSERT pour éviter doublons si relancé
        cur.execute(
            """
            INSERT INTO fan_configuration (name, consomation)
            VALUES (%s, %s)
            ON CONFLICT (name) DO UPDATE SET consomation = EXCLUDED.consomation
            RETURNING fan_id;
            """,
            (fan.get('name'), consomation)
        )
        fid = cur.fetchone()[0]
        print(f"🎛️ Fan seedé: {fan.get('name')} -> fan_id={fid}")

    conn.commit()
    cur.close()
    conn.close()


def seed_cluster():
    """Crée des clusters (instances) selon ratio Marseille/Paris par défaut.
    Idempotent : empêche doublons en vérifiant le nom.
    """
    conn = get_connection()
    cur = conn.cursor()

    total_clusters = 50
    marseille_ratio = 0.8
    paris_ratio = 0.2

    marseille_count = int(total_clusters * marseille_ratio)
    paris_count = total_clusters - marseille_count

    locations = ["Marseille"] * marseille_count + ["Paris"] * paris_count

    for i, city in enumerate(locations, start=1):
        cluster_name = f"CL-{city[:3].upper()}-{i:02d}"
        # Insérer seulement si n'existe pas
        cur.execute(
            """
            INSERT INTO cluster (name, location)
            VALUES (%s, %s)
            ON CONFLICT (name) DO NOTHING
            RETURNING cluster_id;
            """,
            (cluster_name, city)
        )
        row = cur.fetchone()
        if row:
            cluster_id = row[0]
            print(f"Cluster créé : {cluster_name} ({city}) -> ID {cluster_id}")
        else:
            # Récupérer existant
            cur.execute("SELECT cluster_id FROM cluster WHERE name = %s", (cluster_name,))
            cluster_id = cur.fetchone()[0]
            print(f"Cluster déjà existant : {cluster_name} -> ID {cluster_id}")

    conn.commit()
    cur.close()
    conn.close()


def seed_cluster_configuration():
    """Seed des types/configurations de clusters à partir de variables importées.
    BIG_CLUSTERS, MEDIUM_CLUSTERS, SMALL_CLUSTERS doivent être itérables de dicts.
    """
    seed_groups = [
        (BIG_CLUSTERS, 'big'),
        (MEDIUM_CLUSTERS, 'medium'),
        (SMALL_CLUSTERS, 'small')
    ]

    conn = get_connection()
    cur = conn.cursor()

    for group, label in seed_groups:
        if not group:
            print(f"ℹ️ {label} clusters list empty")
            continue

        for item in group:
            # item attendu comme dict avec clés name, master, worker, consomation_per_master, ...
            name = item.get('name')
            master = item.get('master', 0)
            worker = item.get('worker', 0)
            cpm = item.get('consomation_per_master')
            cpw = item.get('consomation_per_worker')
            hpm = item.get('hardware_per_master')
            hpw = item.get('hardware_per_worker')
            env = item.get('env_factor')
            pue = item.get('PUE')

            # Insert simple, on conflict on name
            cur.execute(
                """
                INSERT INTO cluster_configuration
                (name, master, worker, consomation_per_master, consomation_per_worker,
                 hardware_per_master, hardware_per_worker, env_factor, pue)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
                ON CONFLICT (name) DO UPDATE
                SET master = EXCLUDED.master,
                    worker = EXCLUDED.worker,
                    consomation_per_master = EXCLUDED.consomation_per_master,
                    consomation_per_worker = EXCLUDED.consomation_per_worker,
                    hardware_per_master = EXCLUDED.hardware_per_master,
                    hardware_per_worker = EXCLUDED.hardware_per_worker,
                    env_factor = EXCLUDED.env_factor,
                    pue = EXCLUDED.pue
                RETURNING cluster_config_id;
                """,
                (name, master, worker, cpm, cpw, hpm, hpw, env, pue)
            )
            cid = cur.fetchone()[0]
            print(f"Config cluster seedée: {name} -> id {cid}")

    conn.commit()
    cur.close()
    conn.close()


def seed_computer_in_clusters():
    """Pour chaque cluster existant, créer quelques serveurs (computers) de test.
    Exemple basique et idempotent.
    """
    conn = get_connection()
    cur = conn.cursor()

    cur.execute("SELECT cluster_id, name FROM cluster ORDER BY cluster_id")
    rows = cur.fetchall()

    for cluster_id, cluster_name in rows:
        # vérifier s'il existe déjà des serveurs pour éviter duplication
        cur.execute("SELECT COUNT(*) FROM server WHERE cluster_id = %s", (cluster_id,))
        count = cur.fetchone()[0]
        if count > 0:
            print(f"Serveurs existent déjà pour {cluster_name} (cluster_id={cluster_id}) -> skip")
            continue

        # créer 5 serveurs exemples par cluster
        for i in range(1, 6):
            hostname = f"{cluster_name}-srv{i:02d}"
            cur.execute(
                """
                INSERT INTO server (cluster_id, hostname)
                VALUES (%s, %s)
                RETURNING server_id;
                """,
                (cluster_id, hostname)
            )
            sid = cur.fetchone()[0]
            print(f"  ➜ Server créé: {hostname} -> id {sid}")

            # créer 2 capteurs basiques par serveur
            cur.execute(
                """
                INSERT INTO sensor (server_id, sensor_type, unit, last_value)
                VALUES (%s, %s, %s, %s) RETURNING sensor_id;
                """,
                (sid, 'temperature', '°C', 20.0)
            )
            temp_id = cur.fetchone()[0]

            cur.execute(
                """
                INSERT INTO sensor (server_id, sensor_type, unit, last_value)
                VALUES (%s, %s, %s, %s) RETURNING sensor_id;
                """,
                (sid, 'power', 'W', 100.0)
            )
            power_id = cur.fetchone()[0]

            # Inserer quelques points sensor_data pour démonstration
            cur.execute(
                "INSERT INTO sensor_data (time, sensor_id, value) VALUES (NOW(), %s, %s)",
                (temp_id, 20.0)
            )
            cur.execute(
                "INSERT INTO sensor_data (time, sensor_id, value) VALUES (NOW(), %s, %s)",
                (power_id, 100.0)
            )

    conn.commit()
    cur.close()
    conn.close()


if __name__ == '__main__':
    # Ordre important : tables -> fan config -> cluster config -> clusters -> servers
    try:
        seed_db()
        seed_fan_configuration()
        seed_cluster_configuration()
        seed_cluster()
        seed_computer_in_clusters()
        print("\n✅ Seed terminé.")
    except Exception as e:
        print("❌ Erreur lors du seed:", e)
        raise
