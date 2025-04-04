# Desafío SQL2: Análisis de Estudiantes con SQL

Este repositorio tiene como objetivo practicar y aprender el uso de funciones básicas de análisis en SQL, enfocándose en el rendimiento de los estudiantes a partir de una base de datos simple.

## Contexto

Trabajaremos con una base de datos que contiene la siguiente tabla:

- **Tabla `students`:**
  - `student_id`: Identificador único del estudiante
  - `nombre`: Nombre del estudiante
  - `ciudad`: Ciudad donde reside el estudiante
  - `horas_estudio`: Número de horas dedicadas al estudio
  - `calificacion`: Calificación final del estudiante

## Ejercicios

1. **Ranking Simple**  
   **Pregunta:** ¿Quiénes son los 3 estudiantes que más estudian en cada ciudad?  
   Se utiliza la función de ventana `RANK()` para crear un ranking de estudiantes según sus horas de estudio.

2. **Promedio por Ciudad**  
   **Pregunta:** ¿Cómo se compara cada estudiante con el promedio de su ciudad?  
   Se utiliza la función agregada `AVG()` para calcular el promedio de horas de estudio por ciudad y comparar a cada estudiante con dicho promedio.

## Puntos de Aprendizaje

- **Funciones de Ventana:**
  - `RANK()`: Para crear rankings.
  - `AVG()`: Para calcular promedios.
  
- **CTEs (Common Table Expressions):**
  - Aprender a usar la cláusula `WITH` para crear tablas temporales y mejorar la legibilidad del código.

## Requisitos

- Un sistema con acceso a una base de datos SQL.
- Conocimientos básicos de SQL (SELECT, WHERE, JOIN, etc.).

## Ejecución

1. Clona este repositorio:  
   ```bash
   git clone [<url_del_repositorio>](https://github.com/LucasLopezC/Desafio-SQL-2.git)
