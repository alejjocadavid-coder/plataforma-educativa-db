# Implementación Física de Base de Datos Relacional - Caso E-Learning

Este repositorio contiene la estructura física, estrategia de datos y automatización para la plataforma educativa del Grupo 1.

## Arquitectura del Modelo (3FN)
La base de datos se divide en tres capas funcionales:
1. **Capa Maestra Central**: Controla las identidades de DOCENTES y ESTUDIANTES.
2. **Capa de Catálogo Académico**: Administra la oferta educativa mediante CURSOS y MODULOS.
3. **Capa Transaccional y de Avance**: Captura eventos en tiempo real mediante INSCRIPCIONES y PROGRESO.

## Estructura del Repositorio
* `/sql`: Contiene los scripts DDL y DML para levantar la base de datos.
* `/src`: Código fuente del script de población automatizada en Python.
* `/docs`: Presentación y diccionarios técnicos de datos.