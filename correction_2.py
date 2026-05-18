import json
import requests
import paho.mqtt.client as mqtt

# 🌐 CONFIGURATION
MQTT_BROKER = "localhost"
MQTT_PORT = 1883
TOPIC_TELEMETRIE = "v1/gateway/telemetry/#"
API_CONTROL_URL = "http://localhost:3333/api/servers"

# 🎛️ PARAMÈTRES DE CONTRÔLE
TEMP_CIBLE = 30.0
FAN_BASE_SPEED = 30  # Vitesse minimale de sécurité (mode éco)

# Gains du régulateur (Ajustés pour contrer l'inertie)
Kp = 3.5             # Puissance de réaction face à l'écart de température
Kf = 0.5             # Facteur d'anticipation basé sur la charge (Feed-Forward)


def control_loi_physique(hostname, current_temp, current_load):
    """
    🧠 Algorithme de régulation Proportionnel + Anticipation de charge.
    """
    # 1. Calcul de l'écart par rapport à la cible
    erreur = current_temp - TEMP_CIBLE
    
    # 2. Composante Proportionnelle (Réaction à la chaleur présente)
    action_p = Kp * erreur
    
    # 3. Composante Anticipative (Réaction préventive à la charge CPU de travail)
    action_feed_forward = Kf * current_load
    
    # 4. Calcul de la vitesse finale
    vitesse = FAN_BASE_SPEED + action_p + action_feed_forward
    
    # Sécurité : On borne impérativement la vitesse entre 0% et 100%
    vitesse_clamped = max(0, min(100, int(vitesse)))
    
    return vitesse_clamped


def on_connect(client, userdata, flags, rc):
    if rc == 0:
        print("✅ AGENT IA : Connecté au Broker MQTT. Analyse des clusters en cours...")
        client.subscribe(TOPIC_TELEMETRIE)
    else:
        print(f"❌ Échec de connexion MQTT, code : {rc}")


def on_message(client, userdata, msg):
    try:
        payload = json.loads(msg.payload.decode("utf-8"))
        hostname = payload.get("hostname")
        sensors = payload.get("sensors", [])

        # Extraction simultanée de la température et de la charge
        temp_sensor = next((s for s in sensors if s.get("type") == "CPU_TEMP"), None)
        load_sensor = next((s for s in sensors if s.get("type") == "LOAD"), None)

        if temp_sensor and load_sensor:
            cpu_temp = float(temp_sensor.get("value"))
            cpu_load = float(load_sensor.get("value"))
            
            # Évaluation de la commande optimale
            vitesse_calculee = control_loi_physique(hostname, cpu_temp, cpu_load)
            
            # Détermination de la sévérité du log selon le niveau de crise
            status_icon = "🟢" if cpu_temp < 62 else ("🟠" if cpu_temp < 70 else "🚨")
            print(f"{status_icon} [{hostname}] T:{cpu_temp}°C | Load:{cpu_load:.1f}% -> Ordre Ventilo : {vitesse_calculee}%")

            # Envoi de la commande via l'API Fastify
            url = f"{API_CONTROL_URL}/{hostname}/control"
            try:
                res = requests.post(url, json={"fan_speed": vitesse_calculee}, timeout=2)
                if res.status_code != 200:
                    print(f"⚠️ Erreur HTTP {res.status_code} sur {hostname}")
            except requests.exceptions.RequestException:
                print(f"❌ API Fastify injoignable pour le serveur {hostname}")

    except Exception as e:
        print(f"⚠️ Erreur parsing message : {e}")


if __name__ == "__main__":
    print("🤖 Lancement de l'Agent de Régulation Thermique Avancé...")
    client = mqtt.Client()
    client.on_connect = on_connect
    client.on_message = on_message

    try:
        client.connect(MQTT_BROKER, MQTT_PORT, 60)
        client.loop_forever()
    except KeyboardInterrupt:
        print("\n👋 Arrêt de l'agent de régulation.")