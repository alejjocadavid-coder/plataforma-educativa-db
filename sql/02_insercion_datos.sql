- =========================================================================
-- PROYECTO: Plataforma Educativa - Base de Datos (EduAnalytics)
-- DESCRIPCIÓN: Inserción de Datos Maestros Iniciales (Semilla / Seed)
-- AUTOR: alejjocadavid-coder
-- FECHA: Julio 2026
-- =========================================================================

USE plataforma_educativa;

-- 1. INSERCIÓN DE DOCENTES
INSERT INTO docentes (id_docente, nombre, especialidad) VALUES
(1, 'Sonia Rodríguez', 'Ciencia de Datos y Python'),
(2, 'Carlos Mendoza', 'Visualización de Datos y Business Intelligence'),
(3, 'Sonia Patricia Cadavid', 'Administración de Proyectos Ágiles'),
(4, 'Andrés Felipe Restrepo', 'Ciberseguridad y Redes');

-- 2. INSERCIÓN DE CURSOS
INSERT INTO cursos (id_curso, nombre_curso, descripcion) VALUES
(1, 'Análisis de Datos con Python', 'Aprende a manipular, limpiar y analizar grandes volúmenes de datos usando Pandas, NumPy y Seaborn.'),
(2, 'Visualización de Datos con Power BI', 'Diseña dashboards interactivos profesionales, modelado de datos en DAX y conexión a bases de datos relacionales.'),
(3, 'Fundamentos de Ciberseguridad', 'Conceptos clave de seguridad de la información, análisis de vulnerabilidades y defensa de redes.');

-- 3. ASIGNACIÓN DE DOCENTES A CURSOS (Tabla intermedia curso_docente)
INSERT INTO curso_docente (id_curso, id_docente) VALUES
(1, 1), -- Sonia Rodríguez en Python
(2, 2), -- Carlos Mendoza en Power BI
(3, 4); -- Andrés Restrepo en Ciberseguridad

-- 4. INSERCIÓN DE MÓDULOS POR CURSO
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
