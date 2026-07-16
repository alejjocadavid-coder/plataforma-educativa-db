import mysql.connector
from mysql.connector import Error
from faker import Faker
import random
from datetime import datetime, timedelta

# 1. Configuración de la conexión a tu MySQL local
db_config = {
    'host': 'localhost',
    'user': 'root',            # Cambia por tu usuario de MySQL
    'password': 'Alejjo2026',   # Cambia por tu contraseña de MySQL
    'database': 'plataforma_educativa' # Nombre de tu base de datos
}

fake = Faker('es_CO') # Generador de datos de Colombia
Faker.seed(42)
random.seed(42)

try:
    # Conectar a la base de datos
    connection = mysql.connector.connect(**db_config)
    cursor = connection.cursor()
    print("Conexión exitosa a la base de datos 'plataforma_educativa'.")

    # =========================================================================
    # PASO 1: Generar e Insertar 1.500 Estudiantes
    # =========================================================================
    print("Generando 1.500 estudiantes...")
    estudiantes_data = []
    
    # Rango de fechas de registro (últimos 12 meses)
    fin_fecha = datetime.now()
    inicio_fecha = fin_fecha - timedelta(days=365)

    for i in range(1, 1501):
        nombre = fake.name()
        email = fake.unique.email()
        # Formato de solo fecha (DATE) para tu columna fecha_registro
        fecha_reg = fake.date_time_between(start_date=inicio_fecha, end_date=fin_fecha).date()
        
        estudiantes_data.append((i, nombre, email, fecha_reg))

    query_estudiantes = """
    INSERT INTO estudiantes (id_estudiante, nombre, email, fecha_registro) 
    VALUES (%s, %s, %s, %s)
    """
    cursor.executemany(query_estudiantes, estudiantes_data)
    connection.commit()
    print("¡Éxito! 1.500 estudiantes insertados.")

    # =========================================================================
    # PASO 2: Obtener Cursos y Módulos Existentes
    # =========================================================================
    # Consultamos los cursos creados por tu script '02_insercion_datos.sql'
    cursor.execute("SELECT id_curso FROM cursos")
    cursos = [row[0] for row in cursor.fetchall()]
    
    if not cursos:
        print("Error: No se encontraron cursos en la tabla 'cursos'. Ejecuta primero '02_insercion_datos.sql'.")
        exit()

    # Mapeamos los módulos pertenecientes a cada curso
    cursor.execute("SELECT id_modulo, id_curso FROM modulos")
    modulos_por_curso = {}
    for id_modulo, id_curso in cursor.fetchall():
        if id_curso not in modulos_por_curso:
            modulos_por_curso[id_curso] = []
        modulos_por_curso[id_curso].append(id_modulo)

    # =========================================================================
    # PASO 3: Generar Inscripciones e Historial de Progreso (24.000 Filas)
    # =========================================================================
    print("Generando inscripciones y registros de progreso...")
    inscripciones_data = []
    progreso_data = []
    
    id_inscripcion = 1
    id_progreso = 1
    
    estados_inscripcion = ['Activa', 'Inactiva', 'Completada']
    estados_progreso = ['No iniciado', 'En curso', 'Completado']

    for id_estudiante, _, _, fecha_reg in estudiantes_data:
        # Cada estudiante se inscribe a entre 1 y 2 cursos aleatorios
        num_cursos = random.randint(1, 2)
        cursos_estudiante = random.sample(cursos, min(num_cursos, len(cursos)))
        
        for id_curso in sorted(cursos_estudiante):
            # La inscripción es posterior al registro del estudiante
            fecha_inscripcion = fecha_reg + timedelta(days=random.randint(1, 15))
            estado_insc = random.choices(estados_inscripcion, weights=[75, 10, 15], k=1)[0]
            
            inscripciones_data.append((id_inscripcion, id_estudiante, id_curso, fecha_inscripcion, estado_insc))
            
            # Generar el registro de progreso para los módulos asociados al curso
            modulos_asociados = modulos_por_curso.get(id_curso, [])
            for id_modulo in modulos_asociados:
                if id_progreso > 24000:
                    break
                
                # Asignar porcentajes y estados coherentes
                if estado_insc == 'Completada':
                    porcentaje = 100.00
                    estado_prog = 'Completado'
                elif estado_insc == 'Inactiva':
                    porcentaje = float(random.randint(0, 20))
                    estado_prog = 'No iniciado' if porcentaje == 0 else 'En curso'
                else: # Activa
                    porcentaje = float(random.randint(0, 99))
                    estado_prog = 'No iniciado' if porcentaje == 0 else 'En curso'
                
                # Fecha de actualización del progreso
                fecha_actualizacion = datetime.combine(fecha_inscripcion, datetime.min.time()) + timedelta(days=random.randint(1, 30))
                
                progreso_data.append((id_progreso, id_inscripcion, id_modulo, porcentaje, estado_prog, fecha_actualizacion))
                id_progreso += 1
            
            id_inscripcion += 1
            if id_progreso > 24000:
                break
        if id_progreso > 24000:
            break

    # Insertar Inscripciones
    print(f"Insertando {len(inscripciones_data)} inscripciones...")
    query_inscripciones = """
    INSERT INTO inscripciones (id_inscripcion, id_estudiante, id_curso, fecha_inscripcion, estado) 
    VALUES (%s, %s, %s, %s, %s)
    """
    cursor.executemany(query_inscripciones, inscripciones_data)
    connection.commit()

    # Insertar Progreso en bloques para mejorar rendimiento
    print(f"Insertando {len(progreso_data)} registros en progreso...")
    query_progreso = """
    INSERT INTO progreso (id_progreso, id_inscripcion, id_modulo, porcentaje_progreso, estado, fecha_actualizacion) 
    VALUES (%s, %s, %s, %s, %s, %s)
    """
    
    tamanio_bloque = 5000
    for i in range(0, len(progreso_data), tamanio_bloque):
        bloque = progreso_data[i:i + tamanio_bloque]
        cursor.executemany(query_progreso, bloque)
        connection.commit()
        print(f"Bloque {i // tamanio_bloque + 1} insertado...")

    print("\n¡Listo! Datos de prueba y progreso generados correctamente.")

except Error as e:
    print(f"Error: {e}")
    if connection.is_connected():
        connection.rollback()

finally:
    if connection.is_connected():
        cursor.close()
        connection.close()
        print("Conexión cerrada de forma segura.")
