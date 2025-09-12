from locust import User, task, between
from paho.mqtt.client import Client
import random
import time
# Probleme de réseau, si je ne dockerise pas mon python je risque d'avoir un probleme de connexion a la premiere connexion. 
# En mettant python directement dans mon docker je n'ai pas de probleme de concurrence de résolution de nom de domaine DNS 
# Ainsi je peux utiliser le nom de service mosquitto et non pas localhost. En local sans dockerisation mosquitto met trop 
# de temps a être reconnu et le conteneur crash

BROKER = "mosquitto"  # Nom du service Docker Mosquitto
PORT = 1883
TOPIC = "devices/temperature"

class IoTDevice(User):
    wait_time = between(1, 5)

    def on_start(self):
        self.client_id = f"device-{random.randint(1, 1000000)}"
        # Client MQTT moderne sans callback_api_version
        self.mqtt = Client(client_id=self.client_id)
        try:
            self.mqtt.connect(BROKER, PORT)
            self.mqtt.loop_start()
            print(f"{self.client_id} connecté au broker {BROKER}:{PORT}")
        except Exception as e:
            print(f"Erreur connexion MQTT pour {self.client_id} : {e}")

    def on_stop(self):
        try:
            self.mqtt.loop_stop()
            self.mqtt.disconnect()
            print(f"{self.client_id} déconnecté")
        except Exception as e:
            print(f"Erreur déconnexion MQTT pour {self.client_id} : {e}")

    @task
    def send_temperature(self):
        temp = round(random.uniform(20.0, 30.0), 2)
        payload = {
            "device": self.client_id,
            "temperature": temp,
            "ts": time.time()
        }
        try:
            self.mqtt.publish(TOPIC, str(payload))
            print(f"{self.client_id} -> {payload}")
        except Exception as e:
            print(f"Erreur publication MQTT pour {self.client_id} : {e}")
