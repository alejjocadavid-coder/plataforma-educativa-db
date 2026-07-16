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
Se requiere diseñar una base de datos para una plataforma de educación en línea que ofrece cursos a estudiantes. El sistema debe permitir gestionar cursos, módulos, estudiantes, asignación docente y el progreso de aprendizaje detallado por unidad didáctica.

### 🎯 2. Alcance
El modelo de datos incluye de forma estricta las siguientes dimensiones de información:
* **Estudiantes:** Información básica del estudiante y cursos en los que está inscrito.
* **Cursos:** Estructura principal del contenido educativo, compuesta por varios módulos.
* **Docentes:** Gestión de profesores especializados vinculados a la oferta académica.
* **Módulos:** Unidades temáticas específicas que conforman la ruta secuencial de un curso.
* **Progreso:** Registro granular del avance y estado del estudiante por cada módulo izquierdo e individual.

### ⚠️ 3. Simplificaciones Técnicas Autorizadas
Para garantizar un enfoque 100% centrado en la analítica educativa, se han aplicado las siguientes exclusiones al diseño:
* No se modelan evaluaciones o exámenes.
* No se incluyen foros o interacciones sociales.
* No se gestionan certificados.

---

## 💼 Reglas de Negocio Universales
1. Un estudiante puede inscribirse en múltiples cursos de forma simultánea.
2. Un curso contiene y está estructurado obligatoriamente por múltiples módulos académicos (8 módulos fijos por programa).
3. Un docente cuenta con una especialidad específica y puede ser asignado a la instrucción de la oferta académica alineada.
4. Un estudiante tiene un registro de progreso asociado de forma única a cada módulo de la inscripción que cursa (Relación Histórica Granular).
5. El progreso se mide de forma exacta mediante porcentaje matemático (0.00% a 100.00%) o un estado lógico (completado / en curso / no iniciado).

---

## 🎨 Estrategia de Diseño: Categorización Semántica

Para optimizar la interpretación técnica y funcional del modelo, se ha implementado una codificación visual por colores en el diagrama institucional:

* 🔵 **Azul (Entidades Maestras):** `ESTUDIANTES` y `DOCENTES`. Constituyen los pilares de identidad del sistema.
* 🟢 **Verde (Catálogo y Estructura):** `CURSOS` y `MODULOS`. Definen la oferta académica y la jerarquía del contenido.
* 🟠 **Naranja (Transaccional):** `INSCRIPCIONES`. Representa el evento de negocio donde el usuario adquiere o se registra en el producto.
* 🔘 **Gris (Seguimiento / Log):** `PROGRESO`. Registro detallado y dinámico de la actividad del estudiante por cada hito académico.

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

### 4. Tabla: `CURSO_DOCENTE`
| Atributo | Tipo de Dato | Restricciones | Descripción |
| :--- | :--- | :--- | :--- |
| `id_curso` | INT | FOREIGN KEY (CURSOS), PRIMARY KEY | Curso asociado. |
| `id_docente` | INT | FOREIGN KEY (DOCENTES), PRIMARY KEY | Profesor asignado al curso. |

### 5. Tabla: `MODULOS`
| Atributo | Tipo de Dato | Restricciones | Descripción |
| :--- | :--- | :--- | :--- |
| `id_modulo` | INT | PRIMARY KEY, AUTO_INCREMENT | ID de la unidad temática. |
| `id_curso` | INT | FOREIGN KEY (CURSOS) ON DELETE CASCADE | Curso al que pertenece el módulo. |
| `nombre_modulo`| VARCHAR(200) | NOT NULL | Nombre del módulo específico. |
| `contenido` | TEXT | - | Detalle o recursos del módulo. |

### 6. Tabla: `INSCRIPCIONES`
| Atributo | Tipo de Dato | Restricciones | Descripción |
| :--- | :--- | :--- | :--- |
| `id_inscripcion`| INT | PRIMARY KEY, AUTO_INCREMENT | Matrícula operativa consecutiva limpia del alumno. |
| `id_estudiante`| INT | FOREIGN KEY (ESTUDIANTES) | Estudiante vinculado. |
| `id_curso` | INT | FOREIGN KEY (CURSOS) | Curso matriculado. |
| `fecha_inscripcion`| DATE | DEFAULT CURRENT_DATE | Fecha de la matrícula del alumno. |
| `estado` | VARCHAR(20) | CHECK (Activa, Inactiva) | Estado operativo de la inscripción. |

### 7. Tabla: `PROGRESO`
| Atributo | Tipo de Dato | Restricciones | Descripción |
| :--- | :--- | :--- | :--- |
| `id_progreso` | INT | PRIMARY KEY, AUTO_INCREMENT | Seguimiento de avance granular e histórico. |
| `id_inscripcion`| INT | FOREIGN KEY (INSCRIPCIONES) ON DELETE CASCADE | Enlace a la matrícula. |
| `id_modulo` | INT | FOREIGN KEY (MODULOS) | Enlace al módulo específico evaluado. |
| `porcentaje_progreso`| DECIMAL(5,2)| CHECK (BETWEEN 0 AND 100) | Porcentaje de avance real. |
| `estado` | VARCHAR(20) | CHECK (No iniciado, En curso, Completado) | Estado analítico del módulo. |

---

## 🛠️ Código y Scripts Técnicos del Proyecto

### 🗂️ 1. Script de Creación de Tablas (DDL)
Estructura física relacional optimizada para auditoría histórica masiva, creada y ejecutada en MySQL Workbench.

<details>
<summary>📝 Haz clic aquí para desplegar el Script De Creación de Tablas (SQL)</summary>

```sql
CREATE DATABASE IF NOT EXISTS plataforma_educativa;
USE plataforma_educativ```sql
CREATE DATABASE IF NOT EXISTS plataforma_educativa;
USE plataforma_educativa;

-- CAPA 1: MAESTRA CENTRAL
CREATE TABLE estudiantes (
    id_estudiante INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    fecha_registro DATE NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE docentes (
    id_docente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especialidad VARCHAR(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- CAPA 2: CATÁLOGO ACADÉMICO Y ASIGNACIÓN
CREATE TABLE cursos (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nombre_curso VARCHAR(200) NOT NULL,
    descripcion TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE curso_docente (
    id_curso INT,
    id_docente INT,
    PRIMARY KEY (id_curso, id_docente),
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso) ON DELETE CASCADE,
    FOREIGN KEY (id_docente) REFERENCES docentes(id_docente) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE modulos (
    id_modulo INT AUTO_INCREMENT PRIMARY KEY,
    id_curso INT NOT NULL,
    nombre_modulo VARCHAR(200) NOT NULL,
    contenido TEXT,
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- CAPA 3: TRANSACCIONAL Y SEGUIMIENTO HISTÓRICO
CREATE TABLE inscripciones (
    id_inscripcion INT AUTO_INCREMENT PRIMARY KEY,
    id_estudiante INT NOT NULL,
    id_curso INT NOT NULL,
    fecha_inscripcion DATE DEFAULT (CURRENT_DATE()),
    estado VARCHAR(20) DEFAULT 'Activa',
    FOREIGN KEY (id_estudiante) REFERENCES estudiantes(id_estudiante) ON DELETE RESTRICT,
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso) ON DELETE RESTRICT,
    CONSTRAINT chk_estado_insc CHECK (estado IN ('Activa', 'Inactiva', 'Completada'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE progreso (
    id_progreso INT AUTO_INCREMENT PRIMARY KEY,
    id_inscripcion INT NOT NULL,
    id_modulo INT NOT NULL,
    porcentaje_progreso DECIMAL(5,2) DEFAULT 0.00,
    estado VARCHAR(20) DEFAULT 'No iniciado',
    fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_inscripcion) REFERENCES inscripciones(id_inscripcion) ON DELETE CASCADE,
    FOREIGN KEY (id_modulo) REFERENCES modulos(id_modulo) ON DELETE CASCADE,
    CONSTRAINT chk_porcentaje CHECK (porcentaje_progreso BETWEEN 0.00 AND 100.00),
    CONSTRAINT chk_estado_prog CHECK (estado IN ('No iniciado', 'En curso', 'Completado'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



```

</details>

## 📥 2. Script de Inserción de Datos (Python / Ingesta Masiva) (poblar_datos.py)

Inyección masiva automatizada y controlada que restringe temporalmente las marcas de tiempo para asegurar coherencia lógica.

<details>
<summary>📝 Haz clic aquí para desplegar el Script de Inyección Automatizada (Python)</summary>

```python
# Script para forzar la carga de 24,000 registros en PROGRESO
# Proyecto: EduAnalytics
# Autor: Alejandro Cadavid Velásquez

import mysql.connector
from mysql.connector import Error
import random

db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': 'tu_password',
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

```

</details>

<br>

<table width="100%" border="0" cellpadding="0" cellspacing="12" style="border-collapse: separate; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">
  <tr>
    <td width="50%" valign="top" style="border: 1px solid #e1e4e8; border-radius: 8px; padding: 20px; background-color: #f6f8fa;">
      <h4 style="color: #1e7e34; margin-top: 0; margin-bottom: 12px; font-size: 16px; display: flex; align-items: center; gap: 8px;">
        <span>🧪</span> 1,500 Estudiantes Únicos
      </h4>
      <p style="font-size: 14px; color: #24292e; line-height: 1.6; margin: 0;">
        Se inyectaron de forma masiva registros de estudiantes utilizando un algoritmo generador de identidades. Los correos electrónicos se indexaron bajo una máscara limpia y estructurada, lo que permitió validar en tiempo de ejecución el comportamiento real, el rendimiento y el blindaje de la restricción UNIQUE en la base de datos.
      </p>
    </td>
    <td width="50%" valign="top" style="border: 1px solid #e1e4e8; border-radius: 8px; padding: 20px; background-color: #f6f8fa;">
      <h4 style="color: #1e7e34; margin-top: 0; margin-bottom: 12px; font-size: 16px; display: flex; align-items: center; gap: 8px;">
        <span>📊</span> 24,000+ Filas de Trazabilidad
      </h4>
      <p style="font-size: 14px; color: #24292e; line-height: 1.6; margin: 0;">
        Para simular un volumen real de datos masivos y un comportamiento histórico, se pobló la base de datos MySQL con más de 24,000 registros dinámicos de inscripciones y progreso. Este volumen permite que el tablero de Power BI analice patrones complejos de deserción y estados de avance variados, dejando de ser un análisis manual y reactivo.
      </p>
    </td>
  </tr>
</table>

<div style="margin: 12px; border-left: 4px solid #e67e22; border-radius: 4px; padding: 16px 20px; background-color: #fff9f2; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif; line-height: 1.6;">
  <p style="font-size: 14px; color: #24292e; margin: 0;">
    <strong style="color: #24292e;">Coherencia Temporal Blindada:</strong> El script lógico de generación matemática restringe y gobierna las marcas de tiempo. Mediante validaciones condicionales, se asegura que ninguna fecha en las tablas transaccionales de INSCRIPCIONES o en los logs de PROGRESO sea menor o anterior a la fecha de registro inicial (fecha_registro) del estudiante en el ecosistema.
  </p>
</div>
<br>

### 📊 3. Inserciones Base de Control (DML SQL)
Registros iniciales de validación manual unitaria para verificar herencias lógicas en cascada.

<details>
<summary>📝 Haz clic aquí para desplegar el Script de Inserción de Datos (SQL)</summary>

```sql
-- POBLACIÓN DE CONTROL INICIAL

USE plataforma_educativa;

-- =========================================================================
-- 1. INSERCIÓN DE DOCENTES
-- =========================================================================
INSERT INTO docentes (id_docente, nombre, specialty) VALUES
(1, 'Sonia Rodríguez', 'Ciencia de Datos y Python'),
(2, 'Carlos Mendoza', 'Visualización de Datos y Business Intelligence'),
(3, 'Sonia Patricia Cadavid', 'Administración de Proyectos Ágiles'),
(4, 'Andrés Felipe Restrepo', 'Ciberseguridad y Redes');

-- =========================================================================
-- 2. INSERCIÓN DE CURSOS
-- =========================================================================
INSERT INTO cursos (id_curso, nombre_curso, descripcion) VALUES
(1, 'Análisis de Datos con Python', 'Aprende a manipular, limpiar y analizar grandes volúmenes de datos usando Pandas, NumPy y Seaborn.'),
(2, 'Visualización de Datos con Power BI', 'Diseña dashboards interactivos profesionales, modelado de datos en DAX y conexión a bases de datos relacionales.'),
(3, 'Fundamentos de Ciberseguridad', 'Conceptos clave de seguridad de la información, análisis de vulnerabilidades y defensa de redes.');

-- =========================================================================
-- 3. ASIGNACIÓN DE DOCENTES A CURSOS
-- =========================================================================
INSERT INTO curso_docente (id_curso, id_docente) VALUES
(1, 1), -- Sonia Rodríguez en Python
(2, 2), -- Carlos Mendoza en Power BI
(3, 4); -- Andrés Restrepo en Ciberseguridad

-- =========================================================================
-- 4. INSERCIÓN DE MÓDULOS POR CURSO (4 Módulos obligatorios por curso)
-- =========================================================================
-- Módulos de Python (id_curso = 1)
INSERT INTO modulos (id_modulo, id_curso, nombre_modulo, contenido) VALUES
(1, 1, 'Introducción a Python y Sintaxis Básica', 'Variables, tipos de datos, listas y estructuras de control.'),
(2, 1, 'Estructuras de Datos Avanzadas', 'Diccionarios, tuplas, conjuntos y comprensión de listas.'),
(3, 1, 'Manipulación de Datos con Pandas', 'Carga de datasets, filtrado, manejo de valores nulos y agrupaciones.'),
(4, 1, 'Visualización Estática con Matplotlib y Seaborn', 'Creación de gráficos de barras, dispersión, histogramas y personalización.');

-- Módulos de Power BI (id_curso = 2)
INSERT INTO modulos (id_modulo, id_curso, nombre_modulo, contenido) VALUES
(5, 2, 'Introducción a Power BI y Power Query', 'Conexión a orígenes de datos, transformación y limpieza de tablas.'),
(6, 2, 'Modelado de Datos y Relaciones', 'Creación de relaciones, cardinalidad (1 a muchos) y esquemas en estrella.'),
(7, 2, 'Cálculos Avanzados con DAX', 'Creación de columnas calculadas, medidas y funciones de inteligencia de tiempo.'),
(8, 2, 'Diseño de Reportes y Dashboards', 'Mejores prácticas de UX/UI, uso de filtros, marcadores y distribución visual.');

-- Módulos de Ciberseguridad (id_curso = 3)
INSERT INTO modulos (id_modulo, id_curso, nombre_modulo, contenido) VALUES
(9, 3, 'Introducción a la Seguridad de la Información', 'Principios de confidencialidad, integridad y disponibilidad (CÍA).'),
(10, 3, 'Seguridad en Redes y Protocolos', 'Análisis de tráfico de red, firewalls, VPNs y configuración segura de routers.'),
(11, 3, 'Análisis de Vulnerabilidades y Amenazas', 'Identificación de malware, ingeniería social y técnicas comunes de ataque.'),
(12, 3, 'Mitigación y Respuesta a Incidentes', 'Protocolos de acción ante brechas de seguridad y planes de recuperación.');

-- =========================================================================
-- 5. PRUEBA TRANSACCIONAL DE CONTROL (Estudiantes, Inscripciones y Progreso)
-- =========================================================================
INSERT INTO estudiantes (id_estudiante, nombre, email, fecha_registro) VALUES 
(1, 'Estudiante de Prueba A', 'prueba.a@eduanalytics.com', '2026-01-15'), 
(2, 'Estudiante de Prueba B', 'prueba.b@eduanalytics.com', '2026-02-10');

INSERT INTO inscripciones (id_inscripcion, id_estudiante, id_curso, fecha_inscripcion) VALUES 
(1, 1, 1, '2026-01-16'), -- Inscrito en Python
(2, 2, 2, '2026-02-11'); -- Inscrito en Power BI

INSERT INTO progreso (id_inscripcion, id_modulo, porcentaje_progreso, estado) VALUES
(1, 1, 100.00, 'Completado'), -- Progreso del Estudiante 1 en el Módulo 1 de Python
(1, 2, 25.00, 'En curso'),     -- Progreso del Estudiante 1 en el Módulo 2 de Python
(2, 5, 0.00, 'No iniciado');    -- Progreso del Estudiante 2 en el Módulo 1 de Power BI
```

</details>

### 📊 4. Consultas Analíticas de Negocio (SQL Avanzado)
Para garantizar la toma de decisiones estratégicas dentro del ecosistema EduAnalytics, se diseñaron e implementaron consultas de agregación y análisis de datos enfocadas en métricas de rendimiento y comportamiento estudiantil.


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


### 📈 5. Objetivo Analítico (Explotación del Dato)
El diseño e implementación física del modelo de EduAnalytics permite dar respuesta directa a las siguientes necesidades de analítica empresarial en tableros de Business Intelligence (Power BI):

* Progreso de los Estudiantes: Cálculo automatizado de la tasa de completitud por módulo mediante agregaciones de la entidad PROGRESO.
* Cursos más Activos: Identificación de tendencias y demanda comercial contabilizando el volumen de registros históricos almacenados en la tabla INSCRIPCIONES.
* Tasa de Finalización: Métrica estratégica de negocio para evaluar la efectividad y retención del material educativo.
* Participación por Curso y Carga Docente: Monitoreo del balance operativo entre la cantidad de alumnos matriculados frente al profesor asignado para garantizar la calidad del acompañamiento académico.

## 📝  Dashboard Interactivo (Power BI) 

A través de la extracción, transformación y modelado de las tablas transaccionales, se ha consolidado el tablero de control directivo. El informe está conectado directamente al motor relacional y proporciona una interfaz fluida e interactiva de KPIs académicos.

![Diseño del Dashboard Analítico](Construcción)

---

### 🏁 Conclusiones del Proyecto

De lo reactivo a lo preventivo:
Transformamos datos históricos en una herramienta operativa que detecta y frena la deserción antes de que ocurra.

Optimización de recursos:
Priorizamos la retención sobre la adquisición, protegiendo tanto la sostenibilidad financiera como el éxito académico.

Decisiones basadas en evidencia:
Consolidamos un ecosistema donde la analítica de datos es el motor principal para la toma de decisiones estratégicas.

