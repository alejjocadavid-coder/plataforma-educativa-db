import mysql.connector
import pandas as pd
from faker import Faker
import random

# 1. Establecer la conexión exitosa que ya tienes
conexion = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Alejjo2026",
    database="plataforma_educativa"
)
cursor = conexion.cursor()

# 2. Aquí va tu lógica de Faker para crear los datos (Ejemplo básico)
fake = Faker()
print("Generando e insertando datos...")

for _ in range(1500):  # Para tus 1,500 alumnos
    nombre = fake.name()
    email = fake.unique.email()  # <--- ¡Le agregamos el .unique aquí!
    # Genera una fecha aleatoria de este año para el registro
    fecha_registro = fake.date_this_year()
    
    # # 1. Definimos la consulta SQL real con marcadores %s
    query = "INSERT INTO ESTUDIANTES (nombre, email, fecha_registro) VALUES (%s, %s, %s)"
    valores = (nombre, email, fecha_registro)
    
    # # 2. Ejecutamos la inserción real en la base de datos (¡sin el #!)
    cursor.execute(query, valores)

    # ... aquí termina tu línea 30 con el cursor.execute(query, valores)

# 3. Guardar cambios de forma definitiva y cerrar conexión (¡Alineado a la izquierda!)
conexion.commit()
cursor.close()
conexion.close()
print("¡Carga masiva completada con éxito!")