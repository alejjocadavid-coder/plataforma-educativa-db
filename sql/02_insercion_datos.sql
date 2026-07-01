CREATE DATABASE IF NOT EXISTS plataforma_educativa;
USE plataforma_educativa;

-- =========================================================
-- 0. LIMPIEZA DE TABLAS ANTERIORES (Para evitar conflictos)
-- =========================================================
DROP TABLE IF EXISTS PROGRESO;
DROP TABLE IF EXISTS INSCRIPCIONES;
DROP TABLE IF EXISTS MODULOS;
DROP TABLE IF EXISTS CURSOS;
DROP TABLE IF EXISTS ESTUDIANTES;
DROP TABLE IF EXISTS DOCENTES;

-- =========================================================
-- CAPA 1: MAESTRA CENTRAL (IDENTIDADES INDEPENDIENTES)
-- =========================================================

-- 1. Crear Tabla de Docentes
CREATE TABLE DOCENTES (
    id_docente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especialidad VARCHAR(100)
);

-- 2. Crear Tabla de Estudiantes
CREATE TABLE ESTUDIANTES (
    id_estudiante INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    fecha_registro DATE NOT NULL
);

-- =========================================================
-- CAPA 2: CATÁLOGO ACADÉMICO (OFERTA EDUCATIVA)
-- =========================================================

-- 3. Crear Tabla de Cursos
CREATE TABLE CURSOS (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nombre_curso VARCHAR(200) NOT NULL,
    descripcion TEXT,
    id_docente INT,
    FOREIGN KEY (id_docente) REFERENCES DOCENTES (id_docente) ON DELETE SET NULL
);

-- 4. Crear Tabla de Módulos (Relación 1:N con Cursos)
CREATE TABLE MODULOS (
    id_modulo INT AUTO_INCREMENT PRIMARY KEY,
    id_curso INT NOT NULL,
    nombre_modulo VARCHAR(200) NOT NULL,
    contenido TEXT,
    FOREIGN KEY (id_curso) REFERENCES CURSOS (id_curso) ON DELETE CASCADE
);

-- =========================================================
-- CAPA 3: TRANSACCIONAL Y DE AVANCE (ARQUITECTURA 3FN BLINDADA)
-- =========================================================

-- 5. Crear Tabla Transaccional de Inscripciones
CREATE TABLE INSCRIPCIONES (
    id_inscripcion INT AUTO_INCREMENT PRIMARY KEY,
    id_estudiante INT NOT NULL,
    id_curso INT NOT NULL,
    fecha_inscripcion DATE DEFAULT (CURRENT_DATE),
    estado VARCHAR(20) DEFAULT 'Activa',
    FOREIGN KEY (id_estudiante) REFERENCES ESTUDIANTES (id_estudiante) ON DELETE RESTRICT,
    FOREIGN KEY (id_curso) REFERENCES CURSOS (id_curso) ON DELETE RESTRICT,
    CONSTRAINT chk_estado_insc CHECK (estado IN ('Activa', 'Inactiva'))
);

-- 6. Crear Tabla de Progreso (Vinculada atómicamente a la inscripción)
CREATE TABLE PROGRESO (
    id_progreso INT AUTO_INCREMENT PRIMARY KEY,
    id_inscripcion INT NOT NULL,
    porcentaje_progreso DECIMAL(5,2) DEFAULT 0.00,
    estado VARCHAR(20) DEFAULT 'No iniciado',
    FOREIGN KEY (id_inscripcion) REFERENCES INSCRIPCIONES (id_inscripcion) ON DELETE CASCADE,
    CONSTRAINT chk_porcentaje CHECK (porcentaje_progreso BETWEEN 0.00 AND 100.00),
    CONSTRAINT chk_estado_prog CHECK (estado IN ('No iniciado', 'En curso', 'Completado'))
);


-- =========================================================
-- CAPA DML: INSERCIÓN DE DATOS DE CONTROL UNIFICADOS
-- =========================================================

-- 1. Población del cuerpo docente
INSERT INTO DOCENTES (nombre, especialidad) VALUES 
('Ingri Johana Rolón', 'Bases de Datos Relacionales'), 
('Alejandro Cadavid', 'Ingeniería de Datos'),
('Luz Angelith Espinosa', 'Inteligencia de Negocios');

-- 2. Población del catálogo de cursos
INSERT INTO CURSOS (nombre_curso, descripcion, id_docente) VALUES
('Bootcamp de Analítica de Datos', 'Curso intensivo de SQL, Python y Power BI', 2),
('Inteligencia de Negocios Avanzada', 'Modelado dimensional y arquitectura DAX', 3);

-- 3. Población de estudiantes maestros
INSERT INTO ESTUDIANTES (nombre, email, fecha_registro) VALUES 
('Carlos Mendoza', 'carlos.mendoza@fakermail.com', '2026-01-15'), 
('Diana Arbelaez', 'diana.arbelaez@fakermail.com', '2026-02-10');

-- 4. Inserciones transaccionales correlativas
INSERT INTO INSCRIPCIONES (id_estudiante, id_curso, fecha_inscripcion) VALUES 
(1, 1, '2026-01-16'),
(2, 2, '2026-02-11');

-- 5. Logs analíticos de progreso inicial
INSERT INTO PROGRESO (id_inscripcion, porcentaje_progreso, estado) VALUES
(1, 0.00, 'No iniciado'),
(2, 15.50, 'En curso');