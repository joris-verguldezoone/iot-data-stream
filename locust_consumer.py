from paho.mqtt.client import Client
import random
import time

import json
import psycopg2
import ast


DB_HOST = "timescaledb"   # Nom du service Docker
DB_PORT = 5432
DB_NAME = "tsdb"
DB_USER = "tsuser"
DB_PASS = "tspassword"

# pour la bonne pratique il faudrait utiliser un .env
# et le répercuter dans le docker-compose.yaml
conn = psycopg2.connect(
    host=DB_HOST,
    port=DB_PORT,
    dbname=DB_NAME,
    user=DB_USER,
    password=DB_PASS
)
cur = conn.cursor()

# --- TABLES ---

# cur.execute("""
# CREATE TABLE IF NOT EXISTS cluster_location (
#     cluster_id SERIAL PRIMARY KEY,
#     name TEXT NOT NULL,
#     location TEXT,
#     created_at TIMESTAMPTZ DEFAULT NOW()
# );
# """)

# cur.execute("""
# CREATE TABLE IF NOT EXISTS server (
#     server_id SERIAL PRIMARY KEY,
#     cluster_id INT NOT NULL REFERENCES cluster(cluster_id) ON DELETE CASCADE,
#     hostname TEXT NOT NULL,
#     status TEXT DEFAULT 'ON',
#     created_at TIMESTAMPTZ DEFAULT NOW()
# );
# """)

# cur.execute("""
# CREATE TABLE IF NOT EXISTS sensor (
#     sensor_id SERIAL PRIMARY KEY,
#     server_id INT NOT NULL REFERENCES server(server_id) ON DELETE CASCADE,
#     cluster_id INT NOT NULL REFERENCES cluster(cluster_id) ON DELETE CASCADE,
#     sensor_type TEXT NOT NULL,
#     unit TEXT NOT NULL,
#     last_value DOUBLE PRECISION,
#     created_at TIMESTAMPTZ DEFAULT NOW()
# );
# """)

# cur.execute("""
# CREATE TABLE IF NOT EXISTS fan (
#     fan_id SERIAL PRIMARY KEY,
#     server_id INT NOT NULL REFERENCES server(server_id) ON DELETE CASCADE,
#     cluster_id INT NOT NULL REFERENCES cluster(cluster_id) ON DELETE CASCADE,
#     control_mode TEXT DEFAULT 'AUTO',
#     status TEXT DEFAULT 'OFF',
#     speed_percent INT DEFAULT 0,
#     created_at TIMESTAMPTZ DEFAULT NOW()
# );
# """)

# cur.execute("""
# CREATE TABLE IF NOT EXISTS sensor_data (
#     time TIMESTAMPTZ NOT NULL,
#     sensor_id INT NOT NULL REFERENCES sensor(sensor_id) ON DELETE CASCADE,
#     value DOUBLE PRECISION,
#     PRIMARY KEY (time, sensor_id)
# );
# """)

# conn.commit()

# # --- HYPERTABLE ---
# cur.execute("""
# SELECT create_hypertable('sensor_data', 'time', if_not_exists => TRUE);
# """)
# conn.commit()

# print("✅ Toutes les tables initialisées avec TimescaleDB")

# cur.close()
conn.close()

print("TimescaleDB initialisée ✅")

# --- CONFIG MQTT ---
BROKER = "mosquitto"
PORT = 1883
TOPIC = "devices/temperature"



def on_connect(client, userdata, flags, rc):
    print("Connecté au broker MQTT avec code", rc)
    client.subscribe(TOPIC)

def on_message(client, userdata, msg):
    try:
        # Pour les dict Python envoyés comme string
        data = ast.literal_eval(msg.payload.decode())
        device_id = data.get("device")
        temperature = float(data.get("temperature"))

        with psycopg2.connect(
            host=DB_HOST,
            port=DB_PORT,
            dbname=DB_NAME,
            user=DB_USER,
            password=DB_PASS
        ) as conn:
            with conn.cursor() as cur:
                cur.execute(
                    "INSERT INTO sensor_data (time, sensor_id, value) VALUES (NOW(), %s, %s)",
                    (device_id, temperature)
                )

        print(f"Inséré dans DB: {device_id} | temp={temperature}")

    except Exception as e:
        print(f"Erreur traitement message: {e}")

mqtt_client = Client(client_id="consumer-1")
mqtt_client.on_connect = on_connect
mqtt_client.on_message = on_message

mqtt_client.connect(BROKER, PORT)
mqtt_client.loop_forever()


