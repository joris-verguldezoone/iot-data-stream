import psycopg2
from datetime import datetime

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

def getSensors(bool = True):
    try:
        with conn.cursor() as cur: 
            if bool:
                cur.execute("SELECT * FROM sensor_data ORDER BY time DESC LIMIT 100")
            else:   
                cur.execute("SELECT * FROM sensor_data ORDER BY time DESC")

            rows = cur.fetchall()
            columns = [desc[0] for desc in cur.description]
            return rows, columns
    except Exception as e:
        print("Erreur SQL :", e) # logs
        return [], []  # retourne toujours quelque chose au lieu de return une erreur 


def serialize_row(row, columns):
    result = {}
    for col, val in zip(columns, row):
        if isinstance(val, datetime):
            result[col] = val.isoformat()  # transforme en string ISO 8601
        else:
            result[col] = val
    return result
