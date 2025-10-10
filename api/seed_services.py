import psycopg2
from datetime import datetime
from rich import print
from rich.pretty import Pretty
#revoir l'import
import random
from fan_configuration import FAN_SEED
from cluster_configuration import BIG_CLUSTERS, MEDIUM_CLUSTERS, SMALL_CLUSTERS

# DB_HOST = "timescaledb"   # Nom du service Docker
DB_HOST = "localhost"   # Nom du service local

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


class Seeder():
    computers_in_big_cluster = 20
    computers_in_medium_cluster = 10
    computers_in_small_cluster = 5
    cluster = 50

    # refacto les def dans la classes, tout clé en main

def seed_db():
    # cur = conn.cursor()
    cur.execute("""
    CREATE TABLE IF NOT EXISTS cluster_location (
        location_id SERIAL PRIMARY KEY,
        name TEXT NOT NULL,
        location TEXT,
        created_at TIMESTAMPTZ DEFAULT NOW()
    );
    """)

    cur.execute("""
    CREATE TABLE IF NOT EXISTS fan_configuration (
        fan_id SERIAL PRIMARY KEY,
        name TEXT,
        consomation NUMERIC
    );
    """)

    cur.execute("""
    CREATE TABLE IF NOT EXISTS cluster_configuration (
        cluster_id SERIAL PRIMARY KEY,
        name TEXT NOT NULL,
        master INTEGER NOT NULL,
        worker INTEGER NOT NULL,
        consomation_per_master NUMERIC,
        consomation_per_worker NUMERIC,
        hardware_per_master TEXT,
        hardware_per_worker TEXT,
        env_factor NUMERIC,
        PUE NUMERIC,
        location_id INT REFERENCES cluster_location(location_id) ON DELETE CASCADE,
        fan_id INT REFERENCES fan_configuration(fan_id) ON DELETE SET NULL
    );
    """)

    cur.execute("""
    CREATE TABLE IF NOT EXISTS server (
        server_id SERIAL PRIMARY KEY,
        cluster_id INT NOT NULL REFERENCES cluster_configuration(cluster_id) ON DELETE CASCADE,
        hostname TEXT NOT NULL,
        status TEXT DEFAULT 'ON',
        created_at TIMESTAMPTZ DEFAULT NOW()
    );
    """)

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

    cur.execute("""
    CREATE TABLE IF NOT EXISTS sensor_data (
        time TIMESTAMPTZ NOT NULL,
        sensor_id INT NOT NULL REFERENCES sensor(sensor_id) ON DELETE CASCADE,
        value DOUBLE PRECISION
    );
    """)
    
    cur.execute("""
                CREATE TABLE IF NOT EXISTS fan_configuration (id SERIAL PRIMARY KEY, consomation cluster_id INTEGER NOT NULL; """)
    

    conn.commit()
    cur.close()
    conn.close()
    print("✅ Toutes les tables initialisées avec TimescaleDB")

# cur.close()
# conn.close()
        

def seed_cluster():
    total_clusters = 50
    marseille_ratio = 0.8
    paris_ratio = 0.2

    marseille_count = int(total_clusters * marseille_ratio)
    paris_count = total_clusters - marseille_count

    locations = ["Marseille"] * marseille_count + ["Paris"] * paris_count
    # Créer 40 valeurs marseille, créer 10 valeurs paris 
    # Convention de nommage : CL-<ville>-<num>
    for i, city in enumerate(locations, start=1):
        cluster_name = f"CL-{city[:3].upper()}-{i:02d}"  # ex: CL-MAR-01
        cur.execute("""
            INSERT INTO cluster (name, location)
            VALUES (%s, %s)
            RETURNING cluster_id;
        """, (cluster_name, city))
        cluster_id = cur.fetchone()[0]
        print(f"Cluster créé : {cluster_name} ({city}) -> ID {cluster_id}")

    conn.commit()
    cur.close()
    conn.close()
    

def seed_cluster_config():
    big_cluster_counter = 20 # automatiser le seeding en fonction du ratio et du nbr de cluster et de selft en class
    medium_cluster_counter = 20
    small_cluster_counter = 10

    i = 0

    items = list(BIG_CLUSTERS) 
    result = []


    print(result,"yooo")
    print(len(result),"yooo")

    # while i < 50:
    #     for j in range(big_cluster_counter):

    
    
    # cur.execute("""
    #         INSERT INTO cluster (name, location)
    #         VALUES (%s, %s)
    #         RETURNING cluster_id;
    #     """, (cluster_name, city))
    #     cluster_id = cur.fetchone()[0]
    #     print(f"Cluster créé : {cluster_name} ({city}) -> ID {cluster_id}")

    # conn.commit()
    # cur.close()
    # conn.close()

def seed_computer_in_clusters():
    cur.execute("""
    SELECT * FROM cluster
    """)
    rows = cur.fetchall()
    columns = [desc[0] for desc in cur.description]

    all_clusters = [dict(zip(columns, row)) for row in rows]

    # all_clusters = cur.fetchall()
    all_clusters_count = len(all_clusters)

    big_clusters_ratio = 0.4
    medium_clusters_ratio = 0.4
    small_clusters_ratio = 0.2
    # Répartition de la création de cluster par catégories (big medium small)


    big_clusters_count = int(all_clusters_count * big_clusters_ratio)
    medium_clusters_count = int(all_clusters_count * medium_clusters_ratio)
    small_clusters_count = int(all_clusters_count * small_clusters_ratio)

    big_clusters = []           
    medium_clusters = []
    small_clusters = []
    print("------------all clusters------------")
    print(all_clusters)
    print("------------all clusters------------")
    # il faudrait enlever tous les autres attributs de all_cluster et garder uniquement 
    # le cluster_id


    for i in all_clusters:
        if i["cluster_id"] < big_clusters_count:
            big_clusters.append({"cluster_id":i["cluster_id"]})

            # appeler une fonction qui permet de randomiser les 
            # plages de configuration de chaque seed
        elif i["cluster_id"] < (big_clusters_count + medium_clusters_count):
            medium_clusters.append({"cluster_id":i["cluster_id"]})
        elif i["cluster_id"] >= (big_clusters_count + medium_clusters_count):
            small_clusters.append({"cluster_id":i["cluster_id"]})
    
    

    print("------------big------------")
    print(Pretty(big_clusters, indent_size=4))
    print("------------big------------")
    print("------------medium------------")

    print(Pretty(medium_clusters, indent_size=4))
    print("------------medium------------")
    print("------------small------------")

    print(Pretty(small_clusters, indent_size=4))
    print("------------small------------")

def seed_cluster_configuration():
    cur.execute("""
    CREATE TABLE IF NOT EXISTS cluster_configuration (
        cluster_id SERIAL PRIMARY KEY,
        name TEXT NOT NULL,
        master INTEGER NOT NULL,
        worker INTEGER NOT NULL,
        consomation_per_master NUMERIC,
        consomation_per_worker NUMERIC,
        hardware_per_master TEXT,
        hardware_per_worker TEXT,
        env_factor NUMERIC,
        PUE NUMERIC,
        location_id INTEGER
        fan_id INTEGER
    );
""")


    seed = [BIG_CLUSTERS, MEDIUM_CLUSTERS, SMALL_CLUSTERS]
    for i in range(seed):
        for j in range (i):
            cur.execute("""
                    INSERT INTO cluster_configuration (name, master, worker, consomation_per_master,
                        consomation_per_worker, hardware_per_master, hardware_per_worker, env_factor
                        PUE, fan_id)
                    VALUES (%s, %s)
                    RETURNING cluster_id;
                """, (i["name"], i["master"], i["worker"], i["consomation_per_master"],
                      i["consomation_per_worker"], i["hardware_per_master"], i["hardware_per_worker"], i["env_factor"],
                        i["PUE"], i["location_id"],i["fan_id"])) 
            # il faut remplacer location_id fan_id par les id réel d'un précédent seed
            # il faut d'abord insérer les localisation_cluster
            # il faut d'abord seed les fan
  
def seed_fan_configuration():

    for fan in FAN_SEED:
        consomation = random.randrange(fan['consomation'][0], fan['consomation'][1])
        cur.execute("""
            INSERT INTO fan_configuration (consomation, name)
            VALUES (%s, %s, %s)
            RETURNING id;
        """, (consomation, fan["name"]))