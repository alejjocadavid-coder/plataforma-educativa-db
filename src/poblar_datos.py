# Script para forzar la carga de 24,000 registros en PROGRESO
# Proyecto: EduAnalytics
# Autor: Alejandro Cadavid Velásquez

import mysql.connector
from mysql.connector import Error
import random

db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': 'Alejjo2026',
    'database': 'plataforma_educativa'
}

try:
    connection = mysql.connector.connect(**db_config)
    cursor = connection.cursor()

    # 1. Obtener todas las inscripciones actuales (asegúrate de que existen)
    cursor.execute("SELECT id_inscripcion FROM INSCRIPCIONES")
    inscripciones = [row[0] for row in cursor.fetchall()]
    
    # 2. Obtener todos los módulos
    cursor.execute("SELECT id_modulo FROM MODULOS")
    modulos = [row[0] for row in cursor.fetchall()]

    # 3. Forzar 24,000 registros
    print("Generando 24,000 registros exactos de progreso...")
    progreso_data = []
    
    # Repartimos los 24,000 registros entre las inscripciones disponibles
    for i in range(1, 24001):
        id_insc = random.choice(inscripciones)
        id_mod = random.choice(modulos)
        porcentaje = float(random.randint(0, 100))
        estado = 'Completado' if porcentaje == 100 else 'En curso'
        
        progreso_data.append((i, id_insc, id_mod, porcentaje, estado, '2026-07-16'))

    # 4. Insertar en bloques
    cursor.execute("TRUNCATE TABLE PROGRESO") # Limpiamos los 18,104 anteriores
    
    query = """INSERT INTO PROGRESO (id_progreso, id_inscripcion, id_modulo, porcentaje_progreso, estado, fecha_actualizacion) 
               VALUES (%s, %s, %s, %s, %s, %s)"""
    
    cursor.executemany(query, progreso_data)
    connection.commit()
    print("¡Éxito! Se han insertado exactamente 24,000 registros de progreso.")

except Error as e:
    print(f"Error: {e}")
finally:
    if connection.is_connected():
        cursor.close()
        connection.close()