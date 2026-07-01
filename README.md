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

## 🛠️ Código y Scripts del Proyecto

A continuación se presentan los componentes técnicos del proyecto organizados de manera interactiva. Haz clic en cada sección para desplegar el código correspondiente:

### 🗂️ 1. Script de Creación de Tablas (DDL)
Este script define la estructura física de la base de datos en MySQL Workbench, aplicando restricciones de integridad referencial y normalización en 3FN.

<details>
  <summary>📝 Haz clic aquí para desplegar el Script DDL Completo (SQL)</summary>

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
</details>
---

## 📥 2. Script de Inserción de Datos (Python / Ingesta Masiva)
Estrategia de automatización modular utilizando las librerías Faker y mysql-connector para la simulación y carga controlada de 1,500 estudiantes únicos sin violar las restricciones lógicas.

---

import mysql.connector
import pandas as pd
from faker import Faker
import random

# 1. Establecer la conexión con la base de datos local
conexion = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Alejjo2026",
    database="plataforma_educativa"
)
cursor = conexion.cursor()
fake = Faker()

print("Generando e insertando 1,500 estudiantes de forma masiva...")

# 2. Bucle controlado para inserciones masivas de alumnos únicos
for _ in range(1500):
    nombre = fake.name()
    email = fake.unique.email()  # Garantiza la restricción UNIQUE del correo
    fecha_registro = fake.date_this_year()
    
    query = "INSERT INTO ESTUDIANTES (nombre, email, fecha_registro) VALUES (%s, %s, %s)"
    valores = (nombre, email, fecha_registro)
    cursor.execute(query, valores)

# 3. Guardar cambios de forma definitiva en el motor transaccional y cerrar
conexion.commit()
cursor.close()
conexion.close()
print("¡Carga masiva finalizada con éxito!")

📊 3. Inserciones Base de Control (DML SQL)
Script complementario con inserciones manuales unitarias para verificar la correcta sincronización de las llaves foráneas en el entorno de desarrollo local.

-- =========================================================
-- CAPA DML: INSERCIÓN DE DATOS DE CONTROL UNIFICADOS
-- =========================================================

-- 1. Población del cuerpo docente básico
INSERT INTO DOCENTES (nombre, especialidad) VALUES 
('Ingri Johana Rolón', 'Bases de Datos Relacionales'), 
('Alejandro Cadavid', 'Ingeniería de Datos'),
('Luz Angelith Espinosa', 'Inteligencia de Negocios');

-- 2. Población del catálogo inicial de cursos
INSERT INTO CURSOS (nombre_curso, descripcion, id_docente) VALUES
('Bootcamp de Analítica de Datos', 'Curso intensivo de SQL, Python y Power BI', 2),
('Inteligencia de Negocios Avanzada', 'Modelado dimensional y arquitectura DAX', 3);

-- 3. Población de estudiantes maestros de prueba
INSERT INTO ESTUDIANTES (nombre, email, fecha_registro) VALUES 
('Carlos Mendoza', 'carlos.mendoza@fakermail.com', '2026-01-15'), 
('Diana Arbelaez', 'diana.arbelaez@fakermail.com', '2026-02-10');

-- 4. Inserciones transaccionales correlativas (Matrículas)
INSERT INTO INSCRIPCIONES (id_estudiante, id_curso, fecha_inscripcion) VALUES 
(1, 1, '2026-01-16'),
(2, 2, '2026-02-11');

-- 5. Logs analíticos de progreso inicial de control
INSERT INTO PROGRESO (id_inscripcion, porcentaje_progreso, estado) VALUES
(1, 0.00, 'No iniciado'),
(2, 15.50, 'En curso');
