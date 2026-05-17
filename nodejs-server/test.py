import json
import requests  # 🌟 Indispensable pour parler à notre API Fastify
import paho.mqtt.client as mqtt

# 🌐 CONFIGURATION
MQTT_BROKER = "localhost"  # Depuis leur machine, Mosquitto est exposé sur localhost
MQTT_PORT = 1883
TOPIC_TELEMETRIE = "v1/gateway/telemetry/#"  # 🌟 Modifié pour écouter TOUS les serveurs
API_CONTROL_BASE_URL = "http://localhost:3333/api/servers"  # 🌟 Notre route de contrôle Fastify

# 🎛️ SEUILS DE SÉCURITÉ
TEMP_CIBLE = 60.0
TEMP_CRITIQUE = 75.0


def calculer_vitesse_ventilo(hostname, cpu_temp):
    """
    🧠 ZONE DE TRAVAIL DES ÉTUDIANTS
    C'est ici qu'ils doivent coder leur logique intelligente (Algorithme).
    """
    if cpu_temp >= TEMP_CRITIQUE:
        vitesse = 100  # Alerte maximale
    elif cpu_temp > TEMP_CIBLE:
        vitesse = 70   # On accélère pour refroidir
    else:
        vitesse = 25   # Mode éco, le CPU est frais
        
    # TODO pour les étudiants : Remplacer ces paliers par un correcteur PID
    # ou une formule proportionnelle : vitesse = Kp * (cpu_temp - TEMP_CIBLE)
    
    return vitesse


def on_connect(client, userdata, flags, rc):
    """Déclenché lorsque l'agent réussit à se connecter au broker Mosquitto."""
    if rc == 0:
        print("✅ Agent connecté avec succès au Broker MQTT du DataCenter !")
        client.subscribe(TOPIC_TELEMETRIE)
        print(f"📥 Écoute du flux global : {TOPIC_TELEMETRIE}")
    else:
        print(f"❌ Échec de la connexion, code retour : {rc}")

def on_message(client, userdata, msg):
    """Déclenché à chaque fois que le producer émet le statut d'un serveur."""
    try:
        # 1. Décodage du payload JSON
        payload = json.loads(msg.payload.decode("utf-8"))
        hostname = payload.get("hostname")
        sensors = payload.get("sensors", [])

        # 2. ✅ CORRECTION : On cherche "CPU_TEMP" (en majuscules)
        temp_sensor = next((s for s in sensors if s.get("type") == "CPU_TEMP"), None)

        if temp_sensor:
            cpu_temp = float(temp_sensor.get("value"))
            
            # Ce print va ENFIN s'afficher !
            print(f"📡 [{hostname}] Température CPU détectée : {cpu_temp}°C")

            # 3. Calcul de la réponse de ventilation
            nouvelle_vitesse = calculer_vitesse_ventilo(hostname, cpu_temp)

            # 4. Boucle de rétroaction via l'API Fastify
            url_controle = f"{API_CONTROL_BASE_URL}/{hostname}/control"
            payload_http = {"fan_speed": nouvelle_vitesse}

            try:
                response = requests.post(url_controle, json=payload_http)
                if response.status_code == 200:
                    print(f"⚙️  [{hostname}] Commande HTTP transmise -> Ventilo = {nouvelle_vitesse}%")
                else:
                    print(f"⚠️ [{hostname}] Erreur API Fastify (Code {response.status_code})")
            except Exception as e:
                print(f"❌ Impossible de joindre l'API Fastify : {e}")
                
        else:
            # Optionnel : pour debug si un message n'a pas de capteur CPU_TEMP
            print(f"👻 Message reçu de {hostname} mais pas de capteur CPU_TEMP trouvé.")

    except Exception as e:
        print(f"⚠️ Erreur lors du traitement du message : {e}")

# 🚀 DEMARRAGE DE L'AGENT
if __name__ == "__main__":
    print("🤖 Initialisation de l'Agent de Régulation Thermique...")
    
    # Note : Utilisation de CallbackAPIVersion pour éviter les warnings selon la version de paho-mqtt
    client = mqtt.Client()
    client.on_connect = on_connect
    client.on_message = on_message

    try:
        client.connect(MQTT_BROKER, MQTT_PORT, 60)
        # Lance la boucle infinie d'écoute des messages MQTT
        client.loop_forever()
    except KeyboardInterrupt:
        print("\n👋 Arrêt de l'agent. Déconnexion.")