from typing import Union
import psycopg2

from fastapi import FastAPI
from sensors_services import get_sensors, serialize_row
from seed_services import seed_cluster, seed_cluster_configuration, seed_computer_in_clusters, seed_cluster_config, seed_fan_configuration, seed_db
from fastapi.responses import JSONResponse, StreamingResponse
import csv
import io
from fastapi.middleware.cors import CORSMiddleware

# uvicorn api:app --reload pour lancer l'app en local

app = FastAPI()

origins = [
    "http://localhost:4200",   # Angular
    "http://127.0.0.1:4200"    
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,      # <-- attention ici
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def read_root():
    seed_cluster_config()
    return {"Hello": "World"}


@app.get("/sensors")
def read_item():
    rows, columns = get_sensors()
    data = [serialize_row(row, columns) for row in rows]
    return JSONResponse(content=data)


@app.get("/download/sensors")
def download_rows():
    rows, columns = get_sensors(False)

    output = io.StringIO()
    writer = csv.writer(output)
    writer.writerow(columns)  # header : temperature 
    writer.writerows(rows)
    output.seek(0)

    return StreamingResponse(
        output,
        media_type="text/csv",
        headers={"Content-Disposition": "attachment; filename=rows.csv"}
    )

@app.get('/seed/db')
def initialize_db():
    seed_db()

@app.get("/seed/cluster/location")
def initialize_cluster():
    seed_cluster();

@app.get("/seed/cluster/computer")
def initialize_cluster():
    seed_computer_in_clusters();

@app.get("/seed/cluster/configuration")
def initialize_cluster_configuration(): 
    seed_cluster_configuration();

@app.get("/seed/configuration/fan")
def initalize_fan_configuration():
    seed_fan_configuration();