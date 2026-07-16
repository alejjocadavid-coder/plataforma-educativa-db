USE plataforma_educativa;

-- ==============================================================================
-- 1. RESUMEN EJECUTIVO: Métricas clave de rendimiento por oferta académica
-- ==============================================================================
-- Extrae el total de estudiantes matriculados reales y el progreso promedio 
-- de cada curso para el análisis de los directores de programa.

SELECT 
    c.nombre_curso AS 'Curso Ofertado',
    COUNT(DISTINCT i.id_estudiante) AS 'Total Estudiantes Matriculados',
    ROUND(AVG(p.porcentaje_progreso), 2) AS 'Progreso Promedio General (%)'
FROM cursos c
LEFT JOIN inscripciones i ON c.id_curso = i.id_curso
LEFT JOIN progreso p ON i.id_inscripcion = p.id_inscripcion
GROUP BY c.id_curso, c.nombre_curso
ORDER BY `Total Estudiantes Matriculados` DESC;

-- ==============================================================================
-- 2. EMBUDO DE CONVERSIÓN: Distribución de estados por curso
-- ==============================================================================
-- Mide cuántos hitos de progreso están en "No iniciado", "En curso" o "Completado"
-- para alimentar los gráficos de barras o donas de Power BI.

SELECT 
    c.nombre_curso AS 'Curso',
    p.estado AS 'Estado del Progreso',
    COUNT(*) AS 'Cantidad de Hitos Registrados',
    ROUND((COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY c.id_curso)), 2) AS 'Porcentaje de Representación (%)'
FROM cursos c
JOIN inscripciones i ON c.id_curso = i.id_curso
JOIN progreso p ON i.id_inscripcion = p.id_inscripcion
GROUP BY c.id_curso, c.nombre_curso, p.estado
ORDER BY c.nombre_curso, `Cantidad de Hitos Registrados` DESC;

-- ==============================================================================
-- 3. CUADRO DE HONOR: Top 10 Estudiantes con Mayor Rendimiento Acumulado
-- ==============================================================================
-- Identifica de forma proactiva a los alumnos con mejores métricas de avance 
-- a lo largo de toda su ruta de aprendizaje activa en la plataforma.

SELECT 
    e.id_estudiante AS 'ID Alumno',
    e.nombre AS 'Estudiante',
    COUNT(DISTINCT i.id_curso) AS 'Cursos Inscritos',
    ROUND(AVG(p.porcentaje_progreso), 2) AS 'Promedio de Progreso General (%)'
FROM estudiantes e
JOIN inscripciones i ON e.id_estudiante = i.id_estudiante
JOIN progreso p ON i.id_inscripcion = p.id_inscripcion
GROUP BY e.id_estudiante, e.nombre
ORDER BY `Promedio de Progreso General (%)` DESC
LIMIT 10;

-- ==============================================================================
-- 4. CONTROL DE RETENCIÓN: Alumnos en riesgo de deserción
-- ==============================================================================
-- Alerta temprana para tutores: Filtra estudiantes activos con un progreso promedio 
-- inferior al 25% para realizar campañas de acompañamiento personalizado.

SELECT 
    e.nombre AS 'Estudiante',
    e.email AS 'Correo de Contacto',
    c.nombre_curso AS 'Curso',
    ROUND(AVG(p.porcentaje_progreso), 2) AS 'Progreso Crítico (%)'
FROM estudiantes e
JOIN inscripciones i ON e.id_estudiante = i.id_estudiante
JOIN cursos c ON i.id_curso = c.id_curso
JOIN progreso p ON i.id_inscripcion = p.id_inscripcion
GROUP BY e.id_estudiante, e.nombre, e.email, c.nombre_curso
HAVING `Progreso Crítico (%)` < 25.00
ORDER BY `Progreso Crítico (%)` ASC
LIMIT 15;
