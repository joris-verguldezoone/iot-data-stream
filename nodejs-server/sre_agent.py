# sre_agent.py
import time
import requests

# 🚨 Configuration propre des routes de l'API Fastify
BASE_URL = "http://localhost:3333"
URL_STATE = f"{BASE_URL}/sim/state"
URL_ACTION = f"{BASE_URL}/agent/action"
URL_REPAIR = f"{BASE_URL}/sim/maintenance/repair"

def control_loop():
    print("🤖 [SRE AGENT] Agent autonome de supervision connecté au DataCenter.")
    print("👀 Surveillance active (Analyse de la télémétrie toutes les 5 secondes)...\n")
    
    # Dictionnaire pour suivre l'état des chantiers de maintenance en cours par serveur
    # Évite d'envoyer un technicien en boucle si un est déjà en route
    active_repairs = {}

    while True:
        try:
            # 1. Collecte de la télémétrie instantanée (Observations)
            response = requests.get(URL_STATE)
            if response.status_code != 200:
                print(f"❌ Erreur : Impossible de joindre l'API de supervision (Code: {response.status_code})")
                time.sleep(5)
                continue
                
            data = response.json()
            servers = data.get("observations", [])

            # Nettoyage des chantiers terminés basés sur la baisse naturelle de température
            for srv_id in list(active_repairs.keys()):
                # Si le serveur est redescendu sous le seuil nominal, on considère la crise passée
                target_srv = next((s for s in servers if (s.get("serverId") or s.get("server_id")) == srv_id), None)
                if target_srv:
                    temp = target_srv.get("cpuTemp") or target_srv.get("cpu_temp")
                    if temp and temp < 62.0:
                        print(f"🟢 [SÉCURITÉ] Le Serveur {srv_id} est revenu à sa température nominale ({temp:.1f}°C). Clôture du ticket.")
                        del active_repairs[srv_id]

            # 2. Analyse de l'état de chaque machine
            for srv in servers:
                srv_id = srv.get("serverId") or srv.get("server_id") or srv.get("id")
                hostname = srv.get("hostname", f"srv-{srv_id}")
                temp = srv.get("cpuTemp") or srv.get("cpu_temp") or srv.get("temp")
                load = srv.get("cpuLoad") or srv.get("cpu_load") or srv.get("load")
                
                if temp is None or load is None:
                    continue

                # Affichage des métriques lues en direct
                print(f"📊 [MONITORING] {hostname.ljust(16)} -> Temp CPU: {temp:.1f}°C | Charge: {load:.0f}%")
                
                # 🔥 SEUIL DE CRISE : Si le processeur franchit les 75°C
                if temp > 75.0:
                    print(f"🚨 [ALERTE THERMIQUE] {hostname} surchauffe dangereusement ({temp:.1f}°C) !")
                    
                    # A. MITIGATION (Urgence logicielle) : On déleste la charge à 15% pour éviter le crash à 100°C
                    if load > 15:
                        print(f"📉 [ACTION] Envoi immédiat de l'ordre de délestage d'urgence à 15% de charge...")
                        action_payload = {
                            "actions": [{ "type": "SET_SERVER_LOAD", "id": srv_id, "value": 15 }]
                        }
                        res_action = requests.post(URL_ACTION, json=action_payload)
                        if res_action.status_code == 200:
                            print(f"✅ Charge bridée avec succès sur {hostname}.")
                        else:
                            print(f"❌ Échec du délestage d'urgence (Code: {res_action.status_code}).")

                    # B. REMÉDIATION (Maintenance matérielle asynchrone) : On appelle le technicien
                    if srv_id not in active_repairs:
                        # Règle heuristique simple : Si Serveur 1 -> Fan 1 | Si Serveur 2 -> Fan 3
                        target_fan_id = 1 if srv_id == 1 else 3
                        print(f"📦 [MAINTENANCE] Ouverture d'un ticket d'intervention pour le Ventilateur {target_fan_id}...")
                        
                        try:
                            res_repair = requests.post(URL_REPAIR, json={"fanId": target_fan_id})
                            if res_repair.status_code == 200:
                                msg = res_repair.json().get("message", "Ticket validé.")
                                print(f"⏳ [TECHNICIEN EN ROUTE] {msg}")
                                active_repairs[srv_id] = True
                            else:
                                print(f"❌ Échec d'ouverture du ticket de réparation (Code: {res_repair.status_code})")
                        except Exception as err:
                            print(f"❌ Erreur lors de l'appel au service de maintenance : {err}")

        except Exception as e:
            print(f"❌ Erreur critique dans la boucle de contrôle de l'agent : {e}")

        print("-" * 60)
        time.sleep(5) # Aligné sur le pas de temps de 5s du datacenter

if __name__ == "__main__":
    control_loop()