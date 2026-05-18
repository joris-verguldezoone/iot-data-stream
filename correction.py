import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sqlalchemy import create_engine

# 🌐 Connexion à la base de données TimescaleDB de Docker
DATABASE_URL = "postgresql://tsuser:tspassword@localhost:5432/tsdb"
engine = create_engine(DATABASE_URL)

print("🔌 Connexion à TimescaleDB réussie.\n")

# =====================================================================
# 📊 CORRECTION - QUESTION 1 : Cartographie de l'infrastructure
# =====================================================================
query_infra = """
SELECT c.name as cluster_name, COUNT(s.server_id) as total_servers
FROM cluster c
JOIN server s ON s.cluster_id = c.cluster_id
GROUP BY c.name;
"""
df_infra = pd.read_sql(query_infra, engine)
print("🏢 --- DISTRIBUTION DES SERVEURS PAR CLUSTER ---")
print(df_infra.to_string(index=False))
print("\n" + "="*50 + "\n")


# =====================================================================
# 📈 CORRECTION - QUESTION 2 : Le Sanity Check & Extraction Température
# =====================================================================
# On extrait l'historique d'un serveur spécifique pour voir le bug
target_host = "oslo-oslo-03-zone-01-worker-01"
query_temp = f"""
SELECT sd.time, sd.value::float as cpu_temp
FROM sensor_data sd
JOIN sensor s ON sd.sensor_id = s.sensor_id
JOIN server srv ON s.server_id = srv.server_id
WHERE srv.hostname = '{target_host}' AND s.sensor_type = 'CPU_TEMP'
ORDER BY sd.time ASC;
"""
df_temp = pd.read_sql(query_temp, engine)

# Plot Brut (Mise en évidence visuelle de la faille à 700°C-2000°C)
plt.figure(figsize=(12, 5))
plt.plot(df_temp['time'], df_temp['cpu_temp'], color='red', label='Température CPU Brute')
plt.title(f"Sanity Check - Historique Température Brute ({target_host})")
plt.xlabel("Horodatage (Time)")
plt.ylabel("Température (°C)")
plt.grid(True)
plt.legend()
# Note pour le prof : Le graphique va montrer un pic immense au début, écrasant le reste de la courbe.
plt.savefig("sanity_check_brut.png")
print(f"📉 Graphique brut sauvegardé sous 'sanity_check_brut.png'. Les pics écrasent l'échelle.")


# =====================================================================
# 🧼 CORRECTION - QUESTION 3 : Isolation et Filtrage des Outliers
# =====================================================================
# Un CPU de datacenter ne peut physiquement pas fonctionner à 700°C ou 2000°C sans fondre.
# Seuil physique maximal toléré = 100°C
SEUIL_MAX_PHYSIQUE = 100.0

outliers = df_temp[df_temp['cpu_temp'] > SEUIL_MAX_PHYSIQUE]
clean_data = df_temp[df_temp['cpu_temp'] <= SEUIL_MAX_PHYSIQUE]

moyenne_brute = df_temp['cpu_temp'].mean()
moyenne_propre = clean_data['cpu_temp'].mean()

print("\n🧼 --- RAPPORT D'AUDIT QUALITÉ DES DONNÉES ---")
print(f"• Nombre total d'enregistrements analysés : {len(df_temp)}")
print(f"• Anomalies détectées (Outliers)          : {len(outliers)} lignes corrompues")
print(f"• Température moyenne BRUTE (avec bug)    : {moyenne_brute:.2f}°C")
print(f"• Température moyenne RÉELLE (nettoyée)   : {moyenne_propre:.2f}°C")
print("\n" + "="*50 + "\n")


# =====================================================================
# 🎨 CORRECTION - QUESTION 4 : Visualisation Nettoyée & Export
# =====================================================================
# Tracé de la courbe propre après élimination du bruit de démarrage
plt.figure(figsize=(12, 5))
plt.plot(clean_data['time'], clean_data['cpu_temp'], color='green', label='Température Filtrée (Saine)')
plt.title(f"Historique Thermique Nettoyé ({target_host})")
plt.xlabel("Horodatage (Time)")
plt.ylabel("Température (°C)")
plt.grid(True)
plt.legend()
plt.savefig("dataset_nettoye.png")

# Export CSV pour l'étape suivante (Chantier 2)
clean_data.to_csv("telemetry_cpu_clean.csv", index=False)
print("💾 Dataset propre exporté avec succès sous 'telemetry_cpu_clean.csv' !")
print("🎨 Graphique nettoyé sauvegardé sous 'dataset_nettoye.png'.")