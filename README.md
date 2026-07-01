# 🎓 PROYECTO 4 — PLATAFORMA EDUCATIVA (E-LEARNING)

## 📝 Contexto
Se requiere diseñar una base de datos para una plataforma de educación en línea que ofrece cursos a estudiantes. El sistema debe permitir gestionar cursos, módulos, estudiantes y el progreso de aprendizaje.

## 🎯 Alcance
El modelo de datos debe incluir:
* Estudiantes
* Cursos
* Módulos
* Progreso

## 🔍 Descripción de las entidades
* **Estudiantes:** Información básica del estudiante y cursos en los que está inscrito.
* **Cursos:** Estructura principal del contenido educativo, compuesta por varios módulos.
* **Módulos:** Unidades que conforman un curso, con contenido específico.
* **Progreso:** Registro del avance del estudiante en cada curso o módulo.

## 💼 Reglas de negocio
* Un estudiante puede inscribirse en múltiples cursos.
* Un curso contiene múltiples módulos.
* Un estudiante tiene un progreso asociado a cada curso o módulo.
* El progreso se mide en porcentaje o estado (completado / en curso).

## ⚠️ Simplificaciones
* No se modelan evaluaciones o exámenes.
* No se incluyen foros o interacciones sociales.
* No se gestionan certificados.

## 📊 Objetivo analítico
El modelo debe permitir analizar:
* Progreso de los estudiantes
* Cursos más activos
* Tasa de finalización
* Participación por curso

# 📑 Modelado de Datos – Proyecto 4 E-Learning

## 🎨 1. Estrategia de Diseño: Categorización Semántica

Para optimizar la interpretación técnica y funcional del modelo, se ha implementado una codificación visual por colores en el diagrama:

* 🔵 **Azul (Entidades Maestras):** `ESTUDIANTES` y `DOCENTES`. Constituyen los pilares de identidad del sistema.
* 🟢 **Verde (Catálogo y Estructura):** `CURSOS` y `MODULOS`. Definen la oferta académica y la jerarquía del contenido.
* 🟠 **Naranja (Transaccional):** `INSCRIPCIONES`. Representa el evento de negocio donde el usuario adquiere el producto.
* 🔘 **Gris (Seguimiento / Log):** `PROGRESO`. Registro detallado y dinámico de la actividad del estudiante.
