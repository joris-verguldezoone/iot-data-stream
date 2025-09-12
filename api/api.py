from typing import Union
import psycopg2

from fastapi import FastAPI
from sensors_services import getSensors, serialize_row
from fastapi.responses import JSONResponse, StreamingResponse
import csv
import io


app = FastAPI()


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.get("/sensors")
def read_item():
    rows, columns = getSensors()
    data = [serialize_row(row, columns) for row in rows]
    return JSONResponse(content=data)


@app.get("/download/sensors")
def download_rows():
    rows, columns = getSensors(False)

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