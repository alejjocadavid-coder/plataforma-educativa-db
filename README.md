# 🎓 Proyecto 4 — EduAnalytics Platform
**Inteligencia de Negocios aplicada a la retención y progresión académica en entornos virtuales.**
### 🚀 BeTek / Makaia — Misión 15 (Análisis de Datos)
**Año:** 2026

---

## 👥 Integrantes del Equipo (Grupo 1)
* **Alejandro Cadavid Velásquez**
* **Ingri Johana Rolón Torres**
* **Luz Angelith Espinosa Mendoza**

---

## 📝 Contexto y Alcance del Sistema

### 1. Contexto
Se requiere diseñar una base de datos para una plataforma de educación en línea que ofrece cursos a estudiantes. El sistema debe permitir gestionar cursos, módulos, estudiantes y el progreso de aprendizaje.

### 🎯 2. Alcance
El modelo de datos incluye de forma estricta las siguientes dimensiones de información:
* **Estudiantes:** Información básica del estudiante y cursos en los que está inscrito.
* **Cursos:** Estructura principal del contenido educativo, compuesta por varios módulos.
* **Módulos:** Unidades que conforman un curso, con contenido específico.
* **Progreso:** Registro del avance del estudiante en cada curso o módulo.

### ⚠️ 3. Simplificaciones Técnicas Autorizadas
Para garantizar un enfoque 100% centrado en la analítica educativa, se han aplicado las siguientes exclusiones al diseño:
* No se modelan evaluaciones o exámenes.
* No se incluyen foros o interacciones sociales.
* No se gestionan certificados.

---

## 💼 Reglas de Negocio Universales
1. Un estudiante puede inscribirse en múltiples cursos de forma simultánea.
2. Un curso contiene y está estructurado obligatoriamente por múltiples módulos.
3. Un estudiante tiene un progreso asociado de forma única a cada curso o módulo.
4. El progreso se mide de forma exacta mediante porcentaje matemático o un estado lógico (completado / en curso / no iniciado).

---

## 🎨 Estrategia de Diseño: Categorización Semántica

Para optimizar la interpretación técnica y funcional del modelo, se ha implementado una codificación visual por colores en el diagrama institucional:

* 🔵 **Azul (Entidades Maestras):** `ESTUDIANTES` y `DOCENTES`. Constituyen los pilares de identidad del sistema.
* 🟢 **Verde (Catálogo y Estructura):** `CURSOS` y `MODULOS`. Definen la oferta académica y la jerarquía del contenido.
* 🟠 **Naranja (Transaccional):** `INSCRIPCIONES`. Representa el evento de negocio donde el usuario adquiere o se registra en el producto.
* 🔘 **Gris (Seguimiento / Log):** `PROGRESO`. Registro detallado y dinámico de la actividad del estudiante.

---

## 🏛️ Diccionario de Datos Técnico (Tercera Forma Normal - 3FN)

### 1. Tabla: `DOCENTES`
| Atributo | Tipo de Dato | Restricciones | Descripción |
| :--- | :--- | :--- | :--- |
| `id_docente` | INT | PRIMARY KEY, AUTO_INCREMENT | Identificador único del docente. |
| `nombre` | VARCHAR(100) | NOT NULL | Nombre completo del profesor. |
| `especialidad`| VARCHAR(100) | - | Área de experticia del docente. |

### 2. Tabla: `ESTUDIANTES`
| Atributo | Tipo de Dato | Restricciones | Descripción |
| :--- | :--- | :--- | :--- |
| `id_estudiante`| INT | PRIMARY KEY, AUTO_INCREMENT | Identificador único del alumno. |
| `nombre` | VARCHAR(100) | NOT NULL | Nombre completo del estudiante. |
| `email` | VARCHAR(150) | UNIQUE, NOT NULL | Correo electrónico de contacto. |
| `fecha_registro`| DATE | NOT NULL | Fecha de alta en el sistema. |

### 3. Tabla: `CURSOS`
| Atributo | Tipo de Dato | Restricciones | Descripción |
| :--- | :--- | :--- | :--- |
| `id_curso` | INT | PRIMARY KEY, AUTO_INCREMENT | Identificador único del curso. |
| `nombre_curso`| VARCHAR(200) | NOT NULL | Título del programa académico. |
| `descripcion` | TEXT | - | Resumen del contenido del curso. |
| `id_docente` | INT | FOREIGN KEY (DOCENTES) | Profesor asignado al curso. |

### 4. Tabla: `MODULOS`
| Atributo | Tipo de Dato | Restricciones | Descripción |
| :--- | :--- | :--- | :--- |
| `id_modulo` | INT | PRIMARY KEY, AUTO_INCREMENT | ID de la unidad temática. |
| `id_curso` | INT | FOREIGN KEY (CURSOS) ON DELETE CASCADE | Curso al que pertenece el módulo. |
| `nombre_modulo`| VARCHAR(200) | NOT NULL | Nombre del módulo específico. |
| `contenido` | TEXT | - | Detalle o recursos del módulo. |

### 5. Tabla: `INSCRIPCIONES`
| Atributo | Tipo de Dato | Restricciones | Descripción |
| :--- | :--- | :--- | :--- |
| `id_inscripcion`| INT | PRIMARY KEY, AUTO_INCREMENT | Matrícula operativa del alumno. |
| `id_estudiante`| INT | FOREIGN KEY (ESTUDIANTES) | Estudiante vinculado. |
| `id_curso` | INT | FOREIGN KEY (CURSOS) | Curso matriculado. |
| `fecha_inscripcion`| DATE | DEFAULT CURRENT_DATE | Fecha de la matrícula. |
| `estado` | VARCHAR(20) | CHECK (Activa, Inactiva) | Estado de la inscripción. |

### 6. Tabla: `PROGRESO`
| Atributo | Tipo de Dato | Restricciones | Descripción |
| :--- | :--- | :--- | :--- |
| `id_progreso` | INT | PRIMARY KEY, AUTO_INCREMENT | Seguimiento de avance granular. |
| `id_inscripcion`| INT | FOREIGN KEY (INSCRIPCIONES) ON DELETE CASCADE | Enlace a la matrícula. |
| `porcentaje_progreso`| DECIMAL(5,2)| CHECK (BETWEEN 0 AND 100) | Porcentaje real completado. |
| `estado` | VARCHAR(20) | CHECK (No iniciado, En curso, Completado) | Estado analítico del módulo. |

---

## 🛠️ Código y Scripts Técnicos del Proyecto

Haz clic en cada sección desplegable para visualizar el código correspondiente. El formato cuenta con detección automática de sintaxis por color.

### 🗂️ 1. Script de Creación de Tablas (DDL)
Estructura física de la base de datos relacional creada y ejecutada de manera exitosa en MySQL Workbench.

<details>
<summary>📝 Haz clic aquí para desplegar el Script De Creación de Tablas (SQL)</summary>

```sql
CREATE DATABASE IF NOT EXISTS plataforma_educativa;
USE plataforma_educativa;

-- CAPA 1: MAESTRA CENTRAL
CREATE TABLE DOCENTES (
    id_docente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especialidad VARCHAR(100)
);

CREATE TABLE ESTUDIANTES (
    id_estudiante INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    fecha_registro DATE NOT NULL
);

-- CAPA 2: CATÁLOGO ACADÉMICO
CREATE TABLE CURSOS (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nombre_curso VARCHAR(200) NOT NULL,
    descripcion TEXT,
    id_docente INT,
    FOREIGN KEY (id_docente) REFERENCES DOCENTES(id_docente) ON DELETE SET NULL
);

CREATE TABLE MODULOS (
    id_modulo INT AUTO_INCREMENT PRIMARY KEY,
    id_curso INT NOT NULL,
    nombre_modulo VARCHAR(200) NOT NULL,
    contenido TEXT,
    FOREIGN KEY (id_curso) REFERENCES CURSOS(id_curso) ON DELETE CASCADE
);

-- CAPA 3: TRANSACCIONAL Y SEGUIMIENTO
CREATE TABLE INSCRIPCIONES (
    id_inscripcion INT AUTO_INCREMENT PRIMARY KEY,
    id_estudiante INT NOT NULL,
    id_curso INT NOT NULL,
    fecha_inscripcion DATE DEFAULT (CURRENT_DATE),
    estado VARCHAR(20) DEFAULT 'Activa',
    FOREIGN KEY (id_estudiante) REFERENCES ESTUDIANTES(id_estudiante) ON DELETE RESTRICT,
    FOREIGN KEY (id_curso) REFERENCES CURSOS(id_curso) ON DELETE RESTRICT,
    CONSTRAINT chk_estado_insc CHECK (estado IN ('Activa', 'Inactiva'))
);

CREATE TABLE PROGRESO (
    id_progreso INT AUTO_INCREMENT PRIMARY KEY,
    id_inscripcion INT NOT NULL,
    porcentaje_progreso DECIMAL(5,2) DEFAULT 0.00,
    estado VARCHAR(20) DEFAULT 'No iniciado',
    FOREIGN KEY (id_inscripcion) REFERENCES INSCRIPCIONES(id_inscripcion) ON DELETE CASCADE,
    CONSTRAINT chk_porcentaje CHECK (porcentaje_progreso BETWEEN 0.00 AND 100.00),
    CONSTRAINT chk_estado_prog CHECK (estado IN ('No iniciado', 'En curso', 'Completado'))
);

```

</details>

### 📥 2. Script de Inserción de Datos (Python / Ingesta Masiva)

Automatización desarrollada con `Faker` y `mysql-connector-python` para poblar el sistema de manera masiva, simulando un entorno real de alta concurrencia con miles de interacciones analíticas.

<details>
<summary>📝 Haz clic aquí para desplegar el Script de Inyección Automatizada (Python)</summary>

```python
import mysql.connector
from faker import Faker
import random

# 1. Conexión con el motor de base de datos local
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

# Buscamos los cursos existentes en la base de datos para asociarlos
cursor.execute("SELECT id_curso FROM CURSOS")
cursos_existentes = [fila[0] for fila in cursor.fetchall()]

# [FASE 2] Inscripciones masivas (Matrícula completa en la oferta académica)
print("🧡 Matriculando estudiantes en la oferta académica...")
id_inscripciones = []
for id_est in id_estudiantes:
    for id_cur in cursos_existentes:
        query_ins = "INSERT INTO INSCRIPCIONES (id_estudiante, id_curso, fecha_inscripcion, estado) VALUES (%s, %s, %s, 'Activa')"
        cursor.execute(query_ins, (id_est, id_cur, fake.date_this_year()))
        id_inscripciones.append(cursor.lastrowid)

# [FASE 3] Generación masiva de registros de trazabilidad en la tabla PROGRESO
print("🔘 Generando las filas de PROGRESO para los módulos...")
for id_ins in id_inscripciones:
    for modulo_n in range(4): # 4 hitos de progreso por cada inscripción operativa
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
print("¡Carga masiva finalizada con éxito!")

```

</details>

<br>

<table>
  <tr>
    <td width="50%" valign="top" style="border: 1px solid #e1e4e8; border-radius: 6px; padding: 16px; background-color: #f6f8fa;">
      <h4 style="color: #22863a; margin-top: 0;">🧪 1,500 Alumnos Únicos</h4>
      <p style="font-size: 14px; color: #24292e;">Se inyectaron de forma masiva registros de estudiantes utilizando un algoritmo generador de identidades. Los correos electrónicos se indexaron bajo una máscara limpia y estructurada, lo que permitió validar en tiempo de ejecución el comportamiento real, el rendimiento y el blindaje de la restricción <code>UNIQUE</code> en la base de datos.</p>
    </td>
    <td width="50%" valign="top" style="border: 1px solid #e1e4e8; border-radius: 6px; padding: 16px; background-color: #f6f8fa;">
      <h4 style="color: #22863a; margin-top: 0;">📈 24,000+ Filas de Trazabilidad</h4>
      <p style="font-size: 14px; color: #24292e;">Para simular un entorno de alta concurrencia y comportamiento histórico realista, se pobló la tabla <code>PROGRESO</code> con más de 24,000 registros dinámicos. Esto permite que las métricas de negocio reflejen estados de avance variados (No iniciado, En curso, Completado) y distribuciones porcentuales aleatorias pero controladas.</p>
    </td>
  </tr>
</table>

<br>

### 📊 3. Inserciones Base de Control (DML SQL)
Registros iniciales de validación manual unitaria para verificar herencias lógicas en cascada.

<details>
<summary>📝 Haz clic aquí para desplegar el Script de Inserción de Datos (SQL)</summary>

```sql
-- POBLACIÓN DE CONTROL INICIAL
INSERT INTO DOCENTES (nombre, especialidad) VALUES 
('Ingri Johana Rolón', 'Bases de Datos Relacionales'), 
('Alejandro Cadavid', 'Ingeniería de Datos'),
('Luz Angelith Espinosa', 'Inteligencia de Negocios');

INSERT INTO CURSOS (nombre_curso, descripcion, id_docente) VALUES
('Bootcamp de Analítica de Datos', 'Curso intensivo de SQL, Python y Power BI', 2),
('Inteligencia de Negocios Avanzada', 'Modelado dimensional y arquitectura DAX', 3);

INSERT INTO ESTUDIANTES (nombre, email, fecha_registro) VALUES 
('Carlos Mendoza', 'carlos.mendoza@fakermail.com', '2026-01-15'), 
('Diana Arbelaez', 'diana.arbelaez@fakermail.com', '2026-02-10');

INSERT INTO INSCRIPCIONES (id_estudiante, id_curso, fecha_inscripcion) VALUES 
(1, 1, '2026-01-16'),
(2, 2, '2026-02-11');

INSERT INTO PROGRESO (id_inscripcion, porcentaje_progreso, estado) VALUES
(1, 0.00, 'No iniciado'),
(2, 15.50, 'En curso');

```

</details>

### 📊 4. Consultas Analíticas de Negocio (SQL Avanzado)
Para garantizar la toma de decisiones estratégicas dentro de la plataforma educativa, se diseñaron e implementaron consultas de agregación y análisis de datos enfocadas en métricas de rendimiento y comportamiento estudiantil.


<details>
<summary>📝 Haz clic aquí para desplegar el Script de Consultas Analíticas de Negocio (SQL Avanzado)</summary>

```sql
USE plataforma_educativa;

-- ==============================================================================
-- 1. RESUMEN EJECUTIVO: Métricas clave de rendimiento por oferta académica
-- ==============================================================================
-- Extrae el total de estudiantes matriculados reales y el porcentaje de progreso 
-- promedio general de cada curso para el reporte gerencial.

SELECT 
    c.nombre_curso AS 'Curso Ofertado',
    COUNT(DISTINCT i.id_estudiante) AS 'Total Estudiantes Matriculados',
    ROUND(AVG(p.porcentaje_progreso), 2) AS 'Progreso Promedio General (%)'
FROM CURSOS c
LEFT JOIN INSCRIPCIONES i ON c.id_curso = i.id_curso
LEFT JOIN PROGRESO p ON i.id_inscripcion = p.id_inscripcion
GROUP BY c.id_curso, c.nombre_curso
ORDER BY  `Total Estudiantes Matriculados` DESC;


-- ==============================================================================
-- 2. EMBUDO DE CONVERSIÓN: Distribución de estados por curso (Para Power BI)
-- ==============================================================================
-- Permite estructurar gráficos de barras o donas en el tablero, midiendo cuántos 
-- hitos están en "No iniciado", "En curso" o "Completado".

SELECT 
    c.nombre_curso AS 'Curso',
    p.estado AS 'Estado del Progreso',
    COUNT(*) AS 'Cantidad de Hitos Registrados',
    ROUND((COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY c.id_curso)), 2) AS 'Porcentaje de Representación (%)'
FROM CURSOS c
JOIN INSCRIPCIONES i ON c.id_curso = i.id_curso
JOIN PROGRESO p ON i.id_inscripcion = p.id_inscripcion
GROUP BY c.id_curso, c.nombre_curso, p.estado
ORDER BY c.nombre_curso, `Cantidad de Hitos Registrados` DESC;


-- ==============================================================================
-- 3. CUADRO DE HONOR: Top 10 Estudiantes con Mayor Rendimiento Acumulado
-- ==============================================================================
-- Identifica de forma proactiva a los alumnos con mejores métricas de avance 
-- a lo largo de toda su ruta de aprendizaje activa.

SELECT 
    e.id_estudiante AS 'ID Alumno',
    e.nombre AS 'Estudiante',
    COUNT(DISTINCT i.id_curso) AS 'Cursos Inscritos',
    ROUND(AVG(p.porcentaje_progreso), 2) AS 'Promedio de Progreso General (%)'
FROM ESTUDIANTES e
JOIN INSCRIPCIONES i ON e.id_estudiante = i.id_estudiante
JOIN PROGRESO p ON i.id_inscripcion = p.id_inscripcion
GROUP BY e.id_estudiante, e.nombre
ORDER BY `Promedio de Progreso General (%)` DESC
LIMIT 10;


-- ==============================================================================
-- 4. CONTROL DE RETENCIÓN: Alumnos en riesgo (Progreso bajo en cursos activos)
-- ==============================================================================
-- Alerta temprana para el equipo de tutorías: Estudiantes con un avance promedio 
-- inferior al 25% a pesar de estar matriculados.

SELECT 
    e.nombre AS 'Estudiante',
    e.email AS 'Correo de Contacto',
    c.nombre_curso AS 'Curso',
    ROUND(AVG(p.porcentaje_progreso), 2) AS 'Progreso Crítico (%)'
FROM ESTUDIANTES e
JOIN INSCRIPCIONES i ON e.id_estudiante = i.id_estudiante
JOIN CURSOS c ON i.id_curso = c.id_curso
JOIN PROGRESO p ON i.id_inscripcion = p.id_inscripcion
GROUP BY e.id_estudiante, e.nombre, e.email, c.nombre_curso
HAVING `Progreso Crítico (%)` < 25.00
ORDER BY `Progreso Crítico (%)` ASC
LIMIT 15;


```

</details>


### 📈 Objetivo Analítico (Explotación del Dato)
El diseño e implementación física del modelo permite dar respuesta directa a las siguientes necesidades de analítica empresarial en tableros de Business Intelligence (Power BI):

* Progreso de los Estudiantes: Cálculo automatizado de la tasa de completitud por módulo mediante agregaciones de la entidad PROGRESO.
* Cursos más Activos: Identificación de tendencias y demanda comercial contabilizando el volumen de registros históricos almacenados en la tabla INSCRIPCIONES.
* Tasa de Finalización: Métrica estratégica de negocio para evaluar la efectividad y retención del material educativo.
* Participación por Curso y Carga Docente: Monitoreo del balance operativo entre la cantidad de alumnos matriculados frente al profesor asignado para garantizar la calidad del acompañamiento académico.

### 🏁 Conclusiones del Proyecto

Integridad Absoluta: La normalización estricta en Tercera Forma Normal (3FN) mitiga redundancias y resguarda la base transaccional contra anomalías operativas de inserción, actualización o borrado.

Visibilidad de Negocio Granular: La capa analítica de progreso proporciona la infraestructura idónea para rastrear el éxito y estancamiento del estudiante en tiempo real.

Escalabilidad Tecnológica: El ecosistema físico se encuentra completamente optimizado para su integración directa con pasarelas ETL, visualizadores analíticos avanzados en Power BI y modelos algorítmicos predictivos de deserción.

## 📊 Entregable 3 — Dashboard y Análisis

En esta fase final, transformamos las más de 24,000 filas de trazabilidad analítica procesadas en el motor de base de datos en un entorno visual interactivo diseñado para la toma de decisiones estratégicas.

---

### 🖥️ 1. Dashboard Interactivo (Power BI)

> 💡 **Nota de entrega:** *(En Construcción diseño tablero en Power BI, captura de pantalla).*

![Diseño del Dashboard Analítico](Construcción)


