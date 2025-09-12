from paho.mqtt.client import Client
import random
import time

import json
import psycopg2


# pour la bonne pratique il faudrait utiliser un .env
# et le répercuter dans le docker-compose.yaml
DB_HOST = "timescaledb"   # Nom du service Docker
DB_PORT = 5432
DB_NAME = "tsdb"
DB_USER = "tsuser"
DB_PASS = "tspassword"

conn = psycopg2.connect(
    host=DB_HOST,
    port=DB_PORT,
    dbname=DB_NAME,
    user=DB_USER,
    password=DB_PASS
)
cur = conn.cursor()

# INITIALISATION TIMESCALE TABLE on pourrait aussi le faire avec un entrypoint dans docker 
cur.execute("""
CREATE TABLE IF NOT EXISTS sensor_data (
    time TIMESTAMPTZ NOT NULL,
    device_id TEXT NOT NULL,
    temperature DOUBLE PRECISION
);
""")
conn.commit()

cur.execute("""
SELECT create_hypertable('sensor_data', 'time', if_not_exists => TRUE);
""")
conn.commit()

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
        # MQTT publishait un dict string, on convertit en dict
        data = eval(msg.payload.decode())  # pour démo, sinon json.loads si JSON valide
        device_id = data.get("device")
        temperature = float(data.get("temperature"))

        # Insert dans TimescaleDB
        cur.execute(
            "INSERT INTO sensor_data (time, device_id, temperature) VALUES (NOW(), %s, %s)",
            (device_id, temperature)
        )
        conn.commit()
        print(f"Inséré dans DB: {device_id} | temp={temperature}")

    except Exception as e:
        print(f"Erreur traitement message: {e}")

mqtt_client = Client(client_id="consumer-1")
mqtt_client.on_connect = on_connect
mqtt_client.on_message = on_message

mqtt_client.connect(BROKER, PORT)
mqtt_client.loop_forever()
