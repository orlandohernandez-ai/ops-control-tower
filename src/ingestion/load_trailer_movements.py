import csv
import psycopg2

conn = psycopg2.connect(
    host="localhost",
    database="ops_tower",
    user="tower_user",
    password="tower_password",
    port=5432
)

cursor = conn.cursor()

with open("data/raw/trailer_movements.csv", "r") as file:
    reader = csv.DictReader(file)

    for row in reader:
        cursor.execute(
            """
            INSERT INTO trailer_movements
            (trailer_id, origin, destination, delay_minutes)
            VALUES (%s, %s, %s, %s)
            """,
            (
                row["trailer_id"],
                row["origin"],
                row["destination"],
                row["delay_minutes"]
            )
        )

conn.commit()
cursor.close()
conn.close()

print("Trailer data successfully ingested.")
