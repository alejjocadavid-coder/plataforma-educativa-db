# Proyecto 4: Diseño e Implementación de Base de Datos para Plataforma Educativa (E-Learning)
### BeTek / Makaia - Misión 15 (Análisis de Datos) 🚀
**Año:** 2026

---

## 👥 Integrantes del Equipo (Grupo 1)
1. **Alejandro Cadavid Velásquez**
2. **Ingri Johana Rolón Torres**
3. **Luz Angelith Espinosa Mendoza**

---

## 📄 Resumen / Abstract
Este proyecto presenta el diseño y la implementación de un modelo de datos relacional normalizado en **Tercera Forma Normal (3FN)**, optimizado para gestionar plataformas de educación virtual de alta escalabilidad. La arquitectura se fundamenta en una estrategia de categorización semántica que organiza las entidades en capas maestras, de catálogo, transaccionales y de seguimiento detallado. 

El modelo no solo garantiza la integridad referencial y la eficiencia en el almacenamiento, sino que actúa como un motor de inteligencia de negocios. Mediante el análisis de métricas clave como la **Tasa de Finalización (Completion Rate)**, el seguimiento granular del progreso por módulos y el balance de carga académica, el sistema permite identificar cuellos de botella en el aprendizaje y optimizar la retención estudiantil. Los resultados ofrecen una infraestructura técnica capaz de transformar datos operativos en decisiones estratégicas para mejorar la experiencia educativa.

---

## 🗺️ Alcance y Reglas de Negocio

### Alcance Operativo
El sistema restringe su diseño al núcleo operativo del ciclo de vida del aprendizaje, modelando:
*   **Estudiantes:** Gestión de perfiles y trazabilidad de registros.
*   **Docentes:** Expertos a cargo de las asignaturas académicas.
*   **Catálogo:** Estructura jerárquica de cursos vinculados a docentes y compuestos por módulos.
*   **Inscripciones:** Evento transaccional de matrícula de un estudiante a un curso.
*   **Progreso:** Registro dinámico del avance por competencias individuales.

### Simplificaciones Técnicas Autorizadas
Para garantizar un enfoque 100% centrado en la analítica educativa, se omitieron módulos no académicos como pasarelas de pago/facturación, foros sociales o emisión automatizada de certificados.

### Reglas de Negocio Universales
1. Un estudiante puede registrar múltiples inscripciones académicas a lo largo del tiempo.
2. Un curso está estructurado de manera obligatoria por uno o muchos módulos independientes.
3. Un docente tiene la capacidad de coordinar y dictar diferentes cursos dentro de su especialidad.
4. Cada inscripción efectuada genera un registro síncrono de progreso para monitorear el avance del alumno por cada módulo.

---

## 🏛️ Arquitectura de Capas Semánticas (3FN)
Para mitigar anomalías de inserción, actualización o borrado, implementamos una codificación de arquitectura semántica basada en 4 capas funcionales:

1.  **Capa Maestra Central (Identidades Independientes):** `ESTUDIANTES` y `DOCENTES`. Pilares esenciales del ecosistema.
2.  **Capa de Catálogo Académico (Oferta Educativa):** `CURSOS` y `MODULOS`. Jerarquía estructural de contenidos.
3.  **Capa Transaccional (Dinámica de Negocio):** `INSCRIPCIONES`. Mapea el acceso del usuario al producto.
4.  **Capa de Detalle Analítico (Logs de Seguimiento):** `PROGRESO`. Captura la evolución métrica en tiempo real.

---

## 📖 Diccionario de Datos Técnico

### 1. Tabla: `DOCENTES`
| Atributo | Tipo de Dato | Restricciones / Comportamiento | Descripción |
| :--- | :--- | :--- | :--- |
| `id_docente` | INT | PRIMARY KEY, AUTO_INCREMENT | Identificador único del docente. |
| `nombre` | VARCHAR(100) | NOT NULL | Nombre completo del docente. |
| `especialidad`| VARCHAR(100) | - | Área de experticia técnica del docente. |

### 2. Tabla: `ESTUDIANTES`
| Atributo | Tipo de Dato | Restricciones / Comportamiento | Descripción |
| :--- | :--- | :--- | :--- |
| `id_estudiante`| INT | PRIMARY KEY, AUTO_INCREMENT | Identificador único del alumno. |
| `nombre` | VARCHAR(100) | NOT NULL | Nombre completo del estudiante. |
| `email` | VARCHAR(150) | UNIQUE, NOT NULL | Correo único de contacto y login. |
| `fecha_registro`| DATE | NOT NULL | Fecha de alta en la plataforma. |

### 3. Tabla: `CURSOS`
| Atributo | Tipo de Dato | Restricciones / Comportamiento | Descripción |
| :--- | :--- | :--- | :--- |
| `id_curso` | INT | PRIMARY KEY, AUTO_INCREMENT | Identificador único del curso. |
| `nombre_curso`| VARCHAR(200) | NOT NULL | Título oficial del programa académico. |
| `descripcion` | TEXT | - | Objetivos y alcance del curso. |
| `id_docente` | INT | FOREIGN KEY (DOCENTES) ON DELETE SET NULL | Docente a cargo de dictar el curso. |

### 4. Tabla: `MODULOS`
| Atributo | Tipo de Dato | Restricciones / Comportamiento | Descripción |
| :--- | :--- | :--- | :--- |
| `id_modulo` | INT | PRIMARY KEY, AUTO_INCREMENT | Identificador de la unidad temática. |
| `id_curso` | INT | FOREIGN KEY (CURSOS) ON DELETE CASCADE | Curso al que pertenece el módulo. |
| `nombre_modulo`| VARCHAR(200) | NOT NULL | Título estructurado del módulo. |
| `contenido` | TEXT | - | Recursos didácticos o guías asociadas.|

### 5. Tabla: `INSCRIPCIONES`
| Atributo | Tipo de Dato | Restricciones / Comportamiento | Descripción |
| :--- | :--- | :--- | :--- |
| `id_inscripcion`| INT | PRIMARY KEY, AUTO_INCREMENT | Control operativo de la matrícula. |
| `id_estudiante`| INT | FOREIGN KEY (ESTUDIANTES) ON DELETE RESTRICT | Estudiante vinculado a la matrícula. |
| `id_curso` | INT | FOREIGN KEY (CURSOS) ON DELETE RESTRICT | Curso matriculado. |
| `fecha_inscripcion`| DATE | DEFAULT CURRENT_DATE | Registro cronológico del evento. |
| `estado` | VARCHAR(20) | CHECK (In 'Activa', 'Inactiva') DEFAULT 'Activa' | Estado actual de la matrícula. |

### 6. Tabla: `PROGRESO`
| Atributo | Tipo de Dato | Restricciones / Comportamiento | Descripción |
| :--- | :--- | :--- | :--- |
| `id_progreso` | INT | PRIMARY KEY, AUTO_INCREMENT | ID de seguimiento individual dinámico. |
| `id_inscripcion`| INT | FOREIGN KEY (INSCRIPCIONES) ON DELETE CASCADE | Enlace directo con la matrícula base. |
| `porcentaje_progreso`| DECIMAL(5,2)| CHECK (BETWEEN 0.00 AND 100.00) DEFAULT 0.00 | Avance porcentual real del módulo. |
| `estado` | VARCHAR(20) | CHECK (In 'No iniciado', 'En curso', 'Completado') | Estado analítico del módulo. |

> **Justificación de Integridad:** El uso de `ON DELETE CASCADE` en la tabla `PROGRESO` garantiza que ante una baja de matrícula controlada, el sistema purgue los logs asociados de manera síncrona, eliminando basura lógica y optimizando el almacenamiento.

### Reglas de Negocio Universales
```sql
CREATE DATABASE IF NOT EXISTS plataforma_educativa;
USE plataforma_educativa;

CREATE TABLE DOCENTES (
    id_docente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especialidad VARCHAR(100)
);
2. Un curso está estructurado de manera obligatoria por uno o muchos módulos independientes.
3. Un docente tiene la capacidad de coordinar y dictar diferentes cursos dentro de su especialidad.
4. Cada inscripción efectuada genera un registro síncrono de progreso para monitorear el avance del alumno por cada módulo.

---

```sql
CREATE DATABASE IF NOT EXISTS plataforma_educativa;
USE plataforma_educativa;

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
---






## 🛠️ Código Estructurado DDL (SQL)

```sql
CREATE DATABASE IF NOT EXISTS plataforma_educativa;
USE plataforma_educativa;

-- ========================================================
-- CAPA 1: MAESTRA CENTRAL
-- ========================================================

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

-- ========================================================
-- CAPA 2: CATÁLOGO ACADÉMICO
-- ========================================================

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

-- ========================================================
-- CAPA 3: TRANSACCIONAL Y DE AVANCE
-- ========================================================

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

# Proyecto 4: Diseño e Implementación de Base de Datos para Plataforma Educativa (E-Learning)
### BeTek / Makaia - Misión 15 (Análisis de Datos) 🚀
**Año:** 2026

---
### 🐍 Estrategia DML e Inyección Automática (Python)
Para simular un entorno empresarial de alta concurrencia previo a la analítica en Power BI, descartamos las inserciones manuales y desarrollamos un script en Python utilizando Pandas, mysql-connector-python y la librería Faker.

Logros de Calidad del Dato (Data Quality)
1,500 Alumnos Únicos: Generados algorítmicamente blindando la restricción UNIQUE del correo electrónico.

12,000+ Filas de Trazabilidad: Población masiva de logs en la tabla PROGRESO distribuyendo estados de avance de forma probabilística.

Coherencia Temporal Blindada: Reglas lógicas impiden que una fecha de inscripción o progreso sea anterior a la fecha de creación del registro maestro del alumno.

import mysql.connector
from faker import Faker
import random

# 1. Establecer conexión con la base de datos
conexion = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Alejjo2026",
    database="plataforma_educativa"
)
cursor = conexion.cursor()
fake = Faker()

print("Iniciando inyección de datos masiva...")

# Ejemplo del bloque de población para 1,500 estudiantes
for _ in range(1500):
    nombre = fake.name()
    email = fake.unique.email()
    fecha_registro = fake.date_this_year()
    
    query = "INSERT INTO ESTUDIANTES (nombre, email, fecha_registro) VALUES (%s, %s, %s)"
    valores = (nombre, email, fecha_registro)
    cursor.execute(query, valores)

conexion.commit()
cursor.close()
conexion.close()
print("¡Carga masiva completada con éxito!")

📈 Objetivos Analíticos SoportadosEl modelo físico y relacional se encuentra optimizado para la conexión directa con herramientas de Business Intelligence (Power BI) resolviendo las siguientes métricas de negocio:A. Tasa de Finalización (Completion Rate)Mide el porcentaje real de avance de los estudiantes matriculados en un programa:$$\text{Tasa de Finalización} = \left( \frac{\sum \text{Módulos Completados}}{\text{Total Módulos del Curso}} \right) \times 100$$Valor Comercial: Permite identificar la retención y el abandono estudiantil en módulos críticos del "libro digital".B. Cursos de Mayor Demanda (Popularidad)Identifica tendencias de mercado mediante la agrupación y conteo analítico de registros en INSCRIPCIONES por cada id_curso.C. Análisis de Retención / Deserción GranularEvaluación de cuellos de botella en la tabla PROGRESO. Si múltiples alumnos se estancan en un estado "En curso" con porcentajes fijos, el equipo de producto puede intervenir un tema de alta dificultad.D. Balance de Carga Académica por DocenteGarantiza el control de calidad, auditando el volumen de estudiantes activos asignados a cada profesor (id_docente en CURSOS).🏁 ConclusionesIntegridad Extrema: Arquitectura libre de redundancia gracias a la normalización estricta en 3FN.Visibilidad de Negocio: El modelo provee un rastro granular del éxito académico del usuario en tiempo real.Escalabilidad: Infraestructura técnica 100% lista para ser explotada por tableros directivos en Power BI y algoritmos predictivos de Machine Learning.
