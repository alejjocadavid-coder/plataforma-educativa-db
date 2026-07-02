import mysql.connector
from faker import Faker
import random

# Conexión con tu base de datos local
conexion = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Alejjo2026",
    database="plataforma_educativa"
)
cursor = conexion.cursor()
fake = Faker()

print("🚀 Iniciando simulación de entorno de alta concurrencia...")

# [FASE 1] Ingesta masiva de 1,500 estudiantes únicos
print("📥 Insertando 1,500 estudiantes...")
id_estudiantes = []
for _ in range(1500):
    nombre = fake.name()
    email = fake.unique.email()
    fecha_registro = fake.date_this_year()
    
    query_est = "INSERT INTO ESTUDIANTES (nombre, email, fecha_registro) VALUES (%s, %s, %s)"
    cursor.execute(query_est, (nombre, email, fecha_registro))
    id_estudiantes.append(cursor.lastrowid)

# Buscamos los cursos existentes para asociarlos
cursor.execute("SELECT id_curso FROM CURSOS")
cursos_existentes = [fila[0] for fila in cursor.fetchall()]

# [FASE 2] Inscripciones masivas 
print("🧡 Matriculando estudiantes en la oferta académica...")
id_inscripciones = []
for id_est in id_estudiantes:
    for id_cur in cursos_existentes:
        query_ins = "INSERT INTO INSCRIPCIONES (id_estudiante, id_curso, fecha_inscripcion, estado) VALUES (%s, %s, %s, 'Activa')"
        cursor.execute(query_ins, (id_est, id_cur, fake.date_this_year()))
        id_inscripciones.append(cursor.lastrowid)

# [FASE 3] Generación masiva de registros de PROGRESO
print("🔘 Generando las 12,000 filas de PROGRESO...")
for id_ins in id_inscripciones:
    for modulo_n in range(4):
        porcentaje = round(random.uniform(0.00, 100.00), 2)
        
        if porcentaje == 0.00:
            estado = 'No iniciado'
        elif porcentaje == 100.00:
            estado = 'Completado'
        else:
            estado = 'En curso'
            
        query_prog = "INSERT INTO PROGRESO (id_inscripcion, porcentaje_progreso, estado) VALUES (%s, %s, %s)"
        cursor.execute(query_prog, (id_ins, porcentaje, estado))

conexion.commit()
print("🏁 ¡Simulación completada con éxito!")
print(f"📊 Resumen final: {len(id_estudiantes)} Estudiantes | {len(id_inscripciones)} Inscripciones | {len(id_inscripciones) * 4} Filas de progreso.")

cursor.close()
conexion.close()