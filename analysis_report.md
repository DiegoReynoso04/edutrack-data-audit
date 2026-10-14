# EduTrack — Informe de auditoría de `enrollments` (tercer trimestre)

Todas las consultas se ejecutaron en Supabase en orden (Q1 → Q12).
Q1–Q5 reflejan los datos originales; Q9–Q12 se calcularon después de las correcciones (Q6–Q8).

## Q1 - Inscripciones en 'Intro to Python'

Resultado: 5

| student_name | student_email                     | completion_percentage |
| ------------ | --------------------------------- | --------------------- |
| Emily Watson | emily.watson@student.edutrack.com | 85                    |
| Klaus Weber  | klaus.weber@student.edutrack.com  | 92                    |
| Marco Rossi  | marco.rossi@student.edutrack.com  | 88                    |
| James Miller | james.miller@test.com             | 30                    |
| Priya Sharma | priya.sharma@student.edutrack.com | 55                    |

Nota: James Miller (`@test.com`) es una cuenta de prueba; esta inscripción se elimina en Q8.

## Q2 - Inscripciones con progreso menor al 10 % (posibles abandonos)

Resultado: 4

| id | student_id | student_name    | student_email                        | course_id | course_title          | category  | enrollment_date | completion_percentage | passed | monthly_fee_paid | instructor   |
| -- | ---------- | --------------- | ------------------------------------ | --------- | --------------------- | --------- | --------------- | --------------------- | ------ | ---------------- | ------------ |
| 5  | 3          | Lucia Fernandes | lucia.fernandes@student.edutrack.com | 2         | Web Design Basics     | Design    | 2024-06-20      | 5                     | false  | 39.99            | Carlos Vega  |
| 6  | 3          | Lucia Fernandes | lucia.fernandes@student.edutrack.com | 4         | Digital Marketing 101 | Marketing | 2024-07-01      | 3                     | false  | 29.99            | Lucia Prades |
| 10 | 5          | Yuki Nakamura   | yuki.nakamura@student.edutrack.com   | 6         | UI/UX Fundamentals    | Design    | 2024-10-11      | 0                     | false  | 44.99            | null         |
| 11 | 6          | Pierre Dubois   | pierre.dubois@student.edutrack.com   | 6         | UI/UX Fundamentals    | Design    | 2024-11-05      | 0                     | false  | 44.99            | null         |

Observaciones:

- Lucia Fernandes aparece dos veces: tiene un progreso muy bajo en sus dos cursos (5 % y 3 %). Es la estudiante con más riesgo de abandono.
- Las dos inscripciones de UI/UX Fundamentals están al 0 % y no tienen instructor asignado. Es probable que el bajo progreso se deba a la falta de instructor más que a un abandono (ver Q3 y Q7).
- Alex Chen (`@test.com`) tiene exactamente un 10 %, por lo que queda fuera del filtro. Es una cuenta de prueba que se elimina en Q8.


## Q3 - Inscripciones sin instructor

Resultado: 2

| id | student_id | student_name  | student_email                      | course_id | course_title       | category | enrollment_date | completion_percentage | passed | monthly_fee_paid | instructor |
| -- | ---------- | ------------- | ---------------------------------- | --------- | ------------------ | -------- | --------------- | --------------------- | ------ | ---------------- | ---------- |
| 10 | 5          | Yuki Nakamura | yuki.nakamura@student.edutrack.com | 6         | UI/UX Fundamentals | Design   | 2024-10-11      | 0                     | false  | 44.99            | null       |
| 11 | 6          | Pierre Dubois | pierre.dubois@student.edutrack.com | 6         | UI/UX Fundamentals | Design   | 2024-11-05      | 0                     | false  | 44.99            | null       |

Observaciones:

- Las dos inscripciones sin instructor son del mismo curso, UI/UX Fundamentals, y las dos tienen un 0 % de completado (ver Q2).
- No hay instructores con texto vacío: los registros incompletos tienen el campo a `NULL`.
- Estas dos filas se corrigen en Q7, asignándoles el valor `'Pending assignment'`.


## Q4 - Top 5 estudiantes con mayor progreso que no han aprobado

Resultado: 5

| id | student_id | student_name  | student_email                      | course_id | course_title           | category    | enrollment_date | completion_percentage | passed | monthly_fee_paid | instructor  |
| -- | ---------- | ------------- | ---------------------------------- | --------- | ---------------------- | ----------- | --------------- | --------------------- | ------ | ---------------- | ----------- |
| 2  | 1          | Emily Watson  | emily.watson@student.edutrack.com  | 2         | Web Design Basics      | Design      | 2024-04-15      | 60                    | false  | 39.99            | Carlos Vega |
| 15 | 7          | Priya Sharma  | priya.sharma@student.edutrack.com  | 1         | Intro to Python        | Programming | 2025-01-10      | 55                    | false  | 49.99            | Marta López |
| 9  | 5          | Yuki Nakamura | yuki.nakamura@student.edutrack.com | 3         | Data Analysis with SQL | Data        | 2024-09-03      | 45                    | false  | 59.99            | Marta López |
| 17 | 1          | Emily Watson  | emily.watson@student.edutrack.com  | 5         | Advanced Python        | Programming | 2025-03-05      | 40                    | false  | 69.99            | Carlos Vega |
| 13 | 8          | James Miller  | james.miller@test.com              | 1         | Intro to Python        | Programming | 2024-05-22      | 30                    | false  | 49.99            | Marta López |

Observaciones:

- El resultado son 5 inscripciones, no 5 estudiantes distintos: Emily Watson aparece dos veces (Web Design Basics, 60 %, y Advanced Python, 40 %).
- No hay empate en el quinto puesto: la siguiente inscripción sin aprobar tiene un 20 %.
- James Miller (`@test.com`) es una cuenta de prueba que se elimina en Q8. Sin ella, el quinto puesto sería Pierre Dubois en Data Analysis with SQL (20 %).
- Estas inscripciones son las más cercanas a aprobar: un seguimiento con ellas tendría más impacto que con los casos de Q2.


## Q5 - Inscripciones desde el 2024-07-01

Resultado: 9

| id | student_id | student_name    | student_email                        | course_id | course_title           | category    | enrollment_date | completion_percentage | passed | monthly_fee_paid | instructor   |
| -- | ---------- | --------------- | ------------------------------------ | --------- | ---------------------- | ----------- | --------------- | --------------------- | ------ | ---------------- | ------------ |
| 17 | 1          | Emily Watson    | emily.watson@student.edutrack.com    | 5         | Advanced Python        | Programming | 2025-03-05      | 40                    | false  | 69.99            | Carlos Vega  |
| 16 | 6          | Pierre Dubois   | pierre.dubois@student.edutrack.com   | 3         | Data Analysis with SQL | Data        | 2025-02-20      | 20                    | false  | 59.99            | Marta López  |
| 15 | 7          | Priya Sharma    | priya.sharma@student.edutrack.com    | 1         | Intro to Python        | Programming | 2025-01-10      | 55                    | false  | 49.99            | Marta López  |
| 12 | 7          | Priya Sharma    | priya.sharma@student.edutrack.com    | 4         | Digital Marketing 101  | Marketing   | 2024-12-01      | 70                    | true   | 29.99            | Lucia Prades |
| 11 | 6          | Pierre Dubois   | pierre.dubois@student.edutrack.com   | 6         | UI/UX Fundamentals     | Design      | 2024-11-05      | 0                     | false  | 44.99            | null         |
| 10 | 5          | Yuki Nakamura   | yuki.nakamura@student.edutrack.com   | 6         | UI/UX Fundamentals     | Design      | 2024-10-11      | 0                     | false  | 44.99            | null         |
| 9  | 5          | Yuki Nakamura   | yuki.nakamura@student.edutrack.com   | 3         | Data Analysis with SQL | Data        | 2024-09-03      | 45                    | false  | 59.99            | Marta López  |
| 8  | 4          | Marco Rossi     | marco.rossi@student.edutrack.com     | 1         | Intro to Python        | Programming | 2024-08-09      | 88                    | true   | 49.99            | Marta López  |
| 6  | 3          | Lucia Fernandes | lucia.fernandes@student.edutrack.com | 4         | Digital Marketing 101  | Marketing   | 2024-07-01      | 3                     | false  | 29.99            | Lucia Prades |

Observaciones:

- 9 de las 17 inscripciones originales son del 2024-07-01 en adelante. La inscripción del mismo 2024-07-01 (Lucia Fernandes) está incluida.
- Solo 2 de estas 9 inscripciones están aprobadas (Priya Sharma en Digital Marketing 101 y Marco Rossi en Intro to Python).
- Ninguna de las cuentas de prueba (`@test.com`) se inscribió en este periodo.


## Q6 - Inscripción faltante añadida

## Q7 - Instructores NULL actualizados a 'Pending assignment'

## Q8 - Inscripciones de cuentas de prueba (@test.com) eliminadas

## Q9 - Inscripciones por categoría

## Q10 - Promedio de completado por curso

## Q11 - Cursos con más de 3 inscripciones

## Q12 - Ingresos totales por categoría
