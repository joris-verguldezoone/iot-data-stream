import json
import requests
import paho.mqtt.client as mqtt

# 🌐 CONFIGURATION
MQTT_BROKER = "localhost"
MQTT_PORT = 1883
TOPIC_TELEMETRIE = "v1/gateway/telemetry/#"

# 🌟 ADAPTATION À TA ROUTE HARDWARE EXISTANTE
API_BASE_URL = "http://localhost:3333" 

# 🎛️ PARAMÈTRES DE CONTRÔLE
TEMP_CIBLE = 50.0    
FAN_BASE_SPEED = 20  
TEMP_CRITIQUE = 78.0 

Kp = 3.5             
Kf = 0.5             


def control_loi_physique(current_temp, current_load):
    """ Algorithme de régulation Proportionnel + Anticipation de charge """
    erreur = current_temp - TEMP_CIBLE
    action_p = Kp * erreur
    action_feed_forward = Kf * current_load
    
    vitesse = FAN_BASE_SPEED + action_p + action_feed_forward
    return max(0, min(100, int(vitesse)))


def on_connect(client, userdata, flags, rc):
    if rc == 0:
        print("✅ AGENT IA : Connecté au Broker MQTT. Utilisation de la route PATCH /fans/{id}")
        client.subscribe(TOPIC_TELEMETRIE)
    else:
        print(f"❌ Échec de connexion MQTT, code : {rc}")


def on_message(client, userdata, msg):
    try:
        payload = json.loads(msg.payload.decode("utf-8"))
        hostname = payload.get("hostname")
        sensors = payload.get("sensors", [])

        # Extraction des capteurs physiques
        temp_sensor = next((s for s in sensors if s.get("type") == "CPU_TEMP"), None)
        load_sensor = next((s for s in sensors if s.get("type") == "LOAD"), None)
        fan_sensor = next((s for s in sensors if s.get("type").startswith("FAN_SPEED")), None)

        if temp_sensor and load_sensor:
            cpu_temp = float(temp_sensor.get("value"))
            cpu_load = float(load_sensor.get("value"))
            
            # Note : On extrait l'ID présent dans le capteur de télémétrie
            sensor_id = fan_sensor.get("id") if fan_sensor else None
            
            # 🔥 CAS DE CRISE 1 : Déclenchement de la maintenance (Marseille)
            if cpu_temp >= TEMP_CRITIQUE and sensor_id:
                print(f"🚨 [CRISE - {hostname}] Surchauffe ({cpu_temp}°C) ! Demande de maintenance...")
                try:
                    res = requests.post(f"{API_BASE_URL}/sim/maintenance/repair", json={"fanId": int(sensor_id)}, timeout=2)
                    if res.status_code == 200:
                        print(f"🔧 [MAINTENANCE] Équipe envoyée pour le ventilateur {sensor_id}.")
                    else:
                        print(f"⚠️ Échec appel maintenance : {res.status_code}")
                except requests.exceptions.RequestException:
                    print("❌ API Maintenance introuvable.")
                return

            # 🟢 REGIME NOMINAL 2 : Modification réelle de la vitesse avec TA route PATCH
            vitesse_calculee = control_loi_physique(cpu_temp, cpu_load)
            status_icon = "🟢" if cpu_temp < 55 else "🟠"
            print(f"{status_icon} [{hostname}] T:{cpu_temp}°C -> Application vitesse : {vitesse_calculee}%")

            if sensor_id:
                try:
                    # 🌟 APPEL DE TA ROUTE : PATCH /fans/{id}
                    # Adapte le body {"speed_percent": ...} selon le nom exact attendu par ton DTO Prisma !
                    url_patch = f"{API_BASE_URL}/fans/{sensor_id}"
                    res = requests.patch(
                        url_patch, 
                        json={"speed_percent": vitesse_calculee}, 
                        timeout=2
                    )
                    if res.status_code != 200:
                        print(f"⚠️ Erreur PATCH {res.status_code} sur le ventilateur ID {sensor_id}")
                except requests.exceptions.RequestException:
                    print(f"❌ API Hardware injoignable pour le ventilateur {sensor_id}")

    except Exception as e:
        print(f"⚠️ Erreur agent : {e}")


if __name__ == "__main__":
    print("🤖 Lancement de l'Agent de Régulation avec intégration PATCH...")
    client = mqtt.Client()
    client.on_connect = on_connect
    client.on_message = on_message

    try:
        client.connect(MQTT_BROKER, MQTT_PORT, 60)
        client.loop_forever()
    except KeyboardInterrupt:
        print("\n👋 Arrêt de l'agent.")