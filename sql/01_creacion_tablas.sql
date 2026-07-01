CREATE DATABASE IF NOT EXISTS plataforma_educativa;
USE plataforma_educativa;

-- =========================================================
-- CAPA 1: MAESTRA CENTRAL (IDENTIDADES INDEPENDIENTES)
-- =========================================================

-- 1. Crear Tabla de Docentes (Corrección de sintaxis y paréntesis)
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