-- EduTrack — Auditoría de la tabla enrollments (ciclo de reportes del tercer trimestre)
-- Ejecutar en orden: Q1 → Q12.

-- Q1: inscripciones del curso 'Intro to Python'
SELECT student_name, student_email, completion_percentage FROM enrollments where course_title = 'Intro to Python';

-- Q2: inscripciones con completion_percentage menor que 10 (posibles abandonos)
SELECT * FROM enrollments where completion_percentage < 10;

-- Q3: inscripciones sin instructor (instructor NULL)
SELECT * FROM enrollments where instructor IS null ;

-- Q4: top 5 inscripciones con mayor completion_percentage que todavía no han aprobado (passed = false)
SELECT * FROM enrollments WHERE passed = false order by completion_percentage desc limit 5 ;

-- Q5: inscripciones desde el 2024-07-01 (incluido), de la más reciente a la más antigua
SELECT * FROM enrollments WHERE enrollment_date >= '2024-07-01' ORDER BY enrollment_date DESC;
