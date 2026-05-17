import json
import requests
import paho.mqtt.client as mqtt

API_URL = "http://localhost:3333/api/servers"

def on_message(client, userdata, msg):
    data = json.loads(msg.payload.decode())
    hostname = data["hostname"]
    temp_sensor = next(s for s in data["sensors"] if s["type"] == "temperature")
    current_temp = float(temp_sensor["value"])
    
    # Algorithme de l'étudiant (Ex: Si ça dépasse 45°C, on accélère le ventilo)
    target_fan = 30
    if current_temp > 45.0:
        target_fan = 80
        
    # Envoi de la commande via ton API HTTP !
    requests.post(f"{API_URL}/{hostname}/control", json={"fan_speed": target_fan})

# Configuration de leur écouteur MQTT...