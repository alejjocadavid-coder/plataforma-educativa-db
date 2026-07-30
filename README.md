# 🎓 Proyecto 4 — EduAnalytics Platform
**Inteligencia de Negocios aplicada a la retención y progresión académica en entornos virtuales.**

### 🚀 BeTek / Makaia — Misión 15 (Análisis de Datos)
**Fecha de Actualización:** 16 de julio de 2026  
**Estado:** Implementación Finalizada y Operativa

---

## 👥 Integrantes del Equipo (Grupo 1)
* **Alejandro Cadavid Velásquez** — Ingeniero de Datos y Analista de Datos
* **Ingri Johana Rolón Torres** — Estudiante de Tecnología ADSO y Analista de Datos
* **Luz Angelith Espinosa Mendoza** — Analista de Datos

---

## ⚠️ El Problema: Detección Tardía y Deserción Silenciosa
> *"¿Qué pasaría si una institución pudiera saber que un estudiante está a punto de abandonar sus estudios antes de que realmente lo haga?"*

En la educación virtual, el gran desafío no es la inscripción, sino evitar la **deserción silenciosa**. Históricamente, las instituciones enfrentan los siguientes retos:
* **Detección Tardía:** Se identificaba que un alumno había abandonado el curso semanas después de su última conexión.
* **Pérdida de Oportunidades:** La deserción se detectaba cuando la oportunidad de recuperar al usuario era nula, afectando la retención, los ingresos y la reputación institucional.
* **Datos Desconectados:** Contábamos con más de **24,000 registros históricos**, pero la información estaba atrapada en un análisis manual y reactivo.

---

## 💡 La Solución: EduAnalytics Platform
Transformamos los datos académicos en información accionable para anticiparnos al riesgo de deserción:
* **Monitoreo:** Seguimiento continuo del progreso y desempeño académico.
* **Alertas Tempranas:** Identificación oportuna de inactividad y señales de riesgo crítico.
* **Priorización:** Clasificación y enfoque en los estudiantes que requieren intervención inmediata.
* **Toma de Decisiones:** Visualizaciones y reportes directos para directivos y tutores.

---

## 🏗️ Estado Actual del Proyecto (Julio 2026)
* **Estructura de Base de Datos:** Implementada totalmente en MySQL, con integridad referencial verificada y normalizada en Tercera Forma Normal (3FN).
* **Volumen de Datos:** Ingesta y validación exitosa de **24,000 registros de progreso**, asegurando coherencia temporal y lógica.
* **Integración BI:** Conexión validada con Power BI; las relaciones de datos permiten interactividad avanzada sin errores.
* **Impacto Operativo:** Tableros directivos para análisis de deserción, rendimiento y retención en tiempo real.

---

## 📝 Contexto y Alcance del Sistema

### 1. Contexto
Se diseñó y materializó una base de datos relacional para una plataforma de educación en línea. El sistema gestiona cursos, módulos, estudiantes, asignación docente y progreso de aprendizaje detallado.

### 🎯 2. Alcance
El modelo de datos incluye:
* **Estudiantes:** Información básica, género, correo electrónico y cursos inscritos.
* **Cursos:** Estructura de contenido por módulos especializados.
* **Docentes:** Gestión de profesores y áreas de especialidad.
* **Módulos:** Unidades temáticas secuenciales por programa.
* **Progreso:** Registro granular de avance, porcentaje y estado analítico.

### ⚠️ 3. Simplificaciones Técnicas Autorizadas
Para garantizar un enfoque 100% centrado en la analítica educativa y de retención, se han aplicado las siguientes exclusiones:
* No se modelan evaluaciones o exámenes escritos.
* No se incluyen foros o interacciones sociales en la plataforma.
* No se gestionan emisiones de certificados digitales.

---

## 💼 Reglas de Negocio Universales
1. Un estudiante puede inscribirse en múltiples cursos de forma simultánea.
2. Un curso contiene y está estructurado obligatoriamente por múltiples módulos académicos (8 módulos fijos por programa).
3. Un docente cuenta con una especialidad específica y puede ser asignado a la instrucción de la oferta académica alineada.
4. Un estudiante tiene un registro de progreso asociado de forma única a cada módulo de la inscripción que cursa (Relación Histórica Granular).
5. El progreso se mide de forma exacta mediante porcentaje matemático (0.00% a 100.00%) o un estado lógico (`No iniciado` / `En curso` / `Completado`).

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
| `especialidad` | VARCHAR(100) | - | Área de experticia del docente. |

### 2. Tabla: `ESTUDIANTES`
| Atributo | Tipo de Dato | Restricciones | Descripción |
| :--- | :--- | :--- | :--- |
| `id_estudiante` | INT | PRIMARY KEY, AUTO_INCREMENT | Identificador único del alumno. |
| `nombre` | VARCHAR(100) | NOT NULL | Nombre completo del estudiante. |
| `email` | VARCHAR(150) | UNIQUE, NOT NULL | Correo electrónico de contacto. |
| `fecha_registro` | DATE | NOT NULL | Fecha de alta en el sistema. |

### 3. Tabla: `CURSOS`
| Atributo | Tipo de Dato | Restricciones | Descripción |
| :--- | :--- | :--- | :--- |
| `id_curso` | INT | PRIMARY KEY, AUTO_INCREMENT | Identificador único del curso. |
| `nombre_curso` | VARCHAR(200) | NOT NULL | Título del programa académico. |
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
| `nombre_modulo` | VARCHAR(200) | NOT NULL | Nombre del módulo específico. |
| `contenido` | TEXT | - | Detalle o recursos del módulo. |

### 6. Tabla: `INSCRIPCIONES`
| Atributo | Tipo de Dato | Restricciones | Descripción |
| :--- | :--- | :--- | :--- |
| `id_inscripcion` | INT | PRIMARY KEY, AUTO_INCREMENT | Matrícula operativa consecutiva limpia del alumno. |
| `id_estudiante` | INT | FOREIGN KEY (ESTUDIANTES) | Estudiante vinculado. |
| `id_curso` | INT | FOREIGN KEY (CURSOS) | Curso matriculado. |
| `fecha_inscripcion` | DATE | DEFAULT CURRENT_DATE | Fecha de la matrícula del alumno. |
| `estado` | VARCHAR(20) | CHECK (Activa, Inactiva, Completada) | Estado operativo de la inscripción. |

### 7. Tabla: `PROGRESO`
| Atributo | Tipo de Dato | Restricciones | Descripción |
| :--- | :--- | :--- | :--- |
| `id_progreso` | INT | PRIMARY KEY, AUTO_INCREMENT | Seguimiento de avance granular e histórico. |
| `id_inscripcion` | INT | FOREIGN KEY (INSCRIPCIONES) ON DELETE CASCADE | Enlace a la matrícula. |
| `id_modulo` | INT | FOREIGN KEY (MODULOS) | Enlace al módulo específico evaluado. |
| `porcentaje_progreso` | DECIMAL(5,2) | CHECK (BETWEEN 0 AND 100) | Porcentaje de avance real. |
| `estado` | VARCHAR(20) | CHECK (No iniciado, En curso, Completado) | Estado analítico del módulo. |

---

## 🛠️ Código y Scripts Técnicos del Proyecto

### 🗂️ 1. Script de Creación de Tablas (DDL)
Estructura física relacional optimizada para auditoría histórica masiva, creada y ejecutada en MySQL Workbench.

<details>
<summary>📝 Haz clic aquí para desplegar el Script de Creación de Tablas (SQL)</summary>

```sql
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

### 🗂️ 1. Script de Creación de Tablas (DDL)
Estructura física relacional optimizada para auditoría histórica masiva, creada y ejecutada en MySQL Workbench.

<details>
<summary>📝 Haz clic aquí para desplegar el Script de Creación de Tablas (SQL)</summary>

```sql
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
