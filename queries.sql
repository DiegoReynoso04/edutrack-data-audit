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

-- Q6: inscripción faltante (confirmada por email, nunca registrada)
-- Comprobación previa: debe devolver 0 filas
SELECT * FROM enrollments WHERE id = 18;

INSERT INTO enrollments (id, student_id, student_name, student_email, course_id, course_title, category, enrollment_date, completion_percentage, passed, monthly_fee_paid, instructor)
VALUES (18, 3, 'Lucia Fernandes', 'lucia.fernandes@student.edutrack.com', 5, 'Advanced Python', 'Programming', '2025-04-01', 0, false, 69.99, 'Carlos Vega');

-- Comprobación posterior: debe devolver 1 fila
SELECT * FROM enrollments WHERE id = 18;

-- Q7: asignar 'Pending assignment' a las inscripciones con instructor NULL
-- Comprobación previa: debe devolver 2 filas (id 10 y 11)
SELECT * FROM enrollments WHERE instructor IS NULL;

UPDATE enrollments SET instructor = 'Pending assignment' WHERE instructor IS NULL;

-- Comprobación posterior: la primera debe devolver 0 filas y la segunda las 2 filas actualizadas
SELECT * FROM enrollments WHERE instructor IS NULL;
SELECT * FROM enrollments WHERE instructor = 'Pending assignment';

-- Q8: eliminar las inscripciones de las cuentas de prueba (@test.com)
-- Comprobación previa: debe devolver 2 filas (id 13 y 14)
SELECT * FROM enrollments WHERE student_email LIKE '%@test.com';

DELETE FROM enrollments WHERE student_email LIKE '%@test.com';

-- Comprobación posterior: debe devolver 0 filas
SELECT * FROM enrollments WHERE student_email LIKE '%@test.com';

-- Comprobación del total: 17 originales + 1 (Q6) - 2 (Q8) = 16
SELECT COUNT(*) FROM enrollments;

-- Q9: número de inscripciones por categoría (después de Q6-Q8)
SELECT category, COUNT(*) AS total_inscripciones FROM enrollments GROUP BY category ORDER BY total_inscripciones DESC;

-- Q10: promedio de completion_percentage por curso, de menor a mayor
SELECT course_title, ROUND(AVG(completion_percentage), 2) AS promedio_completado FROM enrollments GROUP BY course_title ORDER BY promedio_completado ASC;

-- Q11: cursos con más de 3 inscripciones
SELECT course_title, COUNT(*) AS total_inscripciones FROM enrollments GROUP BY course_title HAVING COUNT(*) > 3;

-- Q12: ingresos totales (SUM de monthly_fee_paid) por categoría, de mayor a menor
SELECT category, SUM(monthly_fee_paid) AS ingresos_totales FROM enrollments GROUP BY category ORDER BY ingresos_totales DESC;
