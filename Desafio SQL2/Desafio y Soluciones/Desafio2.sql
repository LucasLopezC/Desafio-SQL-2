/*
==========================================
OBJETIVO:
Aprender a usar funciones básicas de análisis en SQL para entender mejor el rendimiento de los estudiantes.

CONTEXTO:
Trabajaremos con una base de datos simple de estudiantes que contiene:

Tabla students:
    - student_id
    - nombre
    - ciudad
    - horas_estudio
    - calificacion

EJERCICIOS:

1️⃣ **Ranking Simple**  
   ❓ Pregunta: ¿Quiénes son los 3 estudiantes que más estudian en cada ciudad?

2️⃣ **Promedio por Ciudad**  
   ❓ Pregunta: ¿Cómo se compara cada estudiante con el promedio de su ciudad?

PUNTOS DE APRENDIZAJE:

✅ **Window Functions básicas**:  
   - `RANK()`: Para crear rankings  
   - `AVG()`: Para calcular promedios  

✅ **WITH (CTE - Common Table Expressions)**:  
   - Cómo crear tablas temporales  
   - Cómo hacer el código más legible  
==========================================
*/

-- Ejercicio 1: Ranking de estudiantes por horas de estudio dentro de cada ciudad

WITH estudiantes_rankeados AS (
    SELECT
        s.student_id,
        s.first_name,
        s.city_id,
        s.hours_studied,
        -- Se usa RANK() para clasificar estudiantes dentro de cada ciudad según sus horas de estudio
        RANK() OVER (PARTITION BY s.city_id ORDER BY s.hours_studied DESC) AS ranking_estudio,
        -- Se usa ROW_NUMBER() para manejar empates dentro de cada puntaje de examen
        ROW_NUMBER() OVER (PARTITION BY s.exam_score ORDER BY s.hours_studied DESC) AS desempate
    FROM `make-it-real-tarea-clase.clase_mir.students` AS s
)

SELECT
    student_id,
    first_name,
    city_id,
    hours_studied,
    ranking_estudio,
    desempate
FROM estudiantes_rankeados
-- Limitamos a los tres primeros para obtener un resumen rápido, pero este límite puede ajustarse según el análisis requerido
LIMIT 3;


-- Ejercicio 2: Comparación de estudiantes con el promedio de su ciudad

WITH promedio_ciudad AS (
    SELECT 
        s.city_id,
        sc.city_name, 
        AVG(s.hours_studied) AS avg_student
    FROM `make-it-real-tarea-clase.clase_mir.students` AS s
    LEFT JOIN `make-it-real-tarea-clase.clase_mir.citys` AS sc
        ON s.city_id = sc.city_id
    GROUP BY s.city_id, sc.city_name
)

SELECT 
    s.student_id,
    s.first_name,
    s.city_id,
    sc.city_name,
    s.hours_studied,
    p.avg_student,
    -- Calculamos la diferencia entre el estudiante y el promedio de su ciudad
    (s.hours_studied - p.avg_student) AS diferencia,
    -- Clasificación de estudiantes según su desempeño respecto al promedio de su ciudad
    CASE
        WHEN s.hours_studied < p.avg_student THEN "Por debajo del promedio"
        WHEN s.hours_studied = p.avg_student THEN "Buen nivel en promedio"
        WHEN s.hours_studied > p.avg_student THEN "Sobre el nivel promedio"
    END AS comparacion
FROM `make-it-real-tarea-clase.clase_mir.students` AS s
LEFT JOIN promedio_ciudad AS p
    ON s.city_id = p.city_id
LEFT JOIN `make-it-real-tarea-clase.clase_mir.citys` AS sc
    ON s.city_id = sc.city_id
ORDER BY s.city_id, s.hours_studied DESC; -- Ordenamos para facilitar el análisis de tendencias
