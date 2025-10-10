import psycopg2
from datetime import datetime
import os

# DB_HOST = os.environ.get("DB_HOST", "timescaledb")
DB_HOST = os.environ.get("DB_HOST", "localhost")
DB_PORT = int(os.environ.get("DB_PORT", 5432))
DB_NAME = os.environ.get("DB_NAME", "tsdb")
DB_USER = os.environ.get("DB_USER", "tsuser")
DB_PASS = os.environ.get("DB_PASS", "tspassword")

conn = psycopg2.connect(
    host=DB_HOST,
    port=DB_PORT,
    dbname=DB_NAME,
    user=DB_USER,
    password=DB_PASS
)

def get_sensors(latest_only=True):
    try:
        with conn.cursor() as cur:
            if latest_only:
                cur.execute("SELECT * FROM sensor_data ORDER BY time DESC LIMIT 100")
            else:   
                cur.execute("SELECT * FROM sensor_data ORDER BY time DESC")

            rows = cur.fetchall()
            columns = [desc[0] for desc in cur.description]
            return rows, columns
    except Exception as e:
        print("Erreur SQL :", e)
        return [], []

def serialize_row(row, columns):
    result = {}
    for col, val in zip(columns, row):
        if isinstance(val, datetime):
            result[col] = val.isoformat()
        else:
            result[col] = val
    return result
