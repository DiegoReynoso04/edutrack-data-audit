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

Resultado: 1 fila insertada (`id` = 18). La comprobación previa (`id` = 18) devolvió 0 filas y la posterior devolvió el registro:

| id | student_id | student_name    | student_email                        | course_id | course_title    | category    | enrollment_date | completion_percentage | passed | monthly_fee_paid | instructor  |
| -- | ---------- | --------------- | ------------------------------------ | --------- | --------------- | ----------- | --------------- | --------------------- | ------ | ---------------- | ----------- |
| 18 | 3          | Lucia Fernandes | lucia.fernandes@student.edutrack.com | 5         | Advanced Python | Programming | 2025-04-01      | 0                     | false  | 69.99            | Carlos Vega |

Observaciones:

- Es la inscripción confirmada por email que nunca se registró. Todos los campos coinciden con los datos indicados en `edutrack.sql`.
- La tabla pasa de 17 a 18 inscripciones.
- Lucia Fernandes ya tenía un progreso muy bajo en sus otros dos cursos (Q2); conviene hacer seguimiento de esta nueva inscripción desde el inicio.


## Q7 - Instructores NULL actualizados a 'Pending assignment'

Resultado: 2 filas actualizadas (`id` 10 y 11). La comprobación previa (`instructor IS NULL`) devolvió esas 2 filas; después del UPDATE, las inscripciones con `'Pending assignment'` son:

| id | student_id | student_name  | student_email                      | course_id | course_title       | category | enrollment_date | completion_percentage | passed | monthly_fee_paid | instructor         |
| -- | ---------- | ------------- | ---------------------------------- | --------- | ------------------ | -------- | --------------- | --------------------- | ------ | ---------------- | ------------------ |
| 10 | 5          | Yuki Nakamura | yuki.nakamura@student.edutrack.com | 6         | UI/UX Fundamentals | Design   | 2024-10-11      | 0                     | false  | 44.99            | Pending assignment |
| 11 | 6          | Pierre Dubois | pierre.dubois@student.edutrack.com | 6         | UI/UX Fundamentals | Design   | 2024-11-05      | 0                     | false  | 44.99            | Pending assignment |

Observaciones:

- Solo se modificaron las dos inscripciones que no tenían instructor; el resto de la tabla no cambia.
- `'Pending assignment'` es un valor provisional: UI/UX Fundamentals sigue sin un instructor real asignado, y sus dos estudiantes están al 0 % (Q2). Es la primera acción pendiente que sale de esta auditoría.


## Q8 - Inscripciones de cuentas de prueba (@test.com) eliminadas

Resultado: 2 filas eliminadas (`id` 13 y 14).

Inscripciones eliminadas (datos originales):

| id | student_id | student_name | student_email         | course_id | course_title      | category    | enrollment_date | completion_percentage | passed | monthly_fee_paid | instructor  |
| -- | ---------- | ------------ | --------------------- | --------- | ----------------- | ----------- | --------------- | --------------------- | ------ | ---------------- | ----------- |
| 13 | 8          | James Miller | james.miller@test.com | 1         | Intro to Python   | Programming | 2024-05-22      | 30                    | false  | 49.99            | Marta López |
| 14 | 9          | Alex Chen    | alex.chen@test.com    | 2         | Web Design Basics | Design      | 2024-06-30      | 10                    | false  | 39.99            | Carlos Vega |

Comprobaciones:

- Después del DELETE, la búsqueda de emails `@test.com` devuelve 0 filas.
- `COUNT(*)` de la tabla: 16 inscripciones (17 originales + 1 añadida en Q6 − 2 eliminadas en Q8). Ninguna otra fila se vio afectada.

Observaciones:

- El patrón `'%@test.com'` incluye la `@`, de modo que solo coincide con emails del dominio `test.com` y no con dominios que terminen en esas letras (p. ej. `contest.com`).
- Estas dos inscripciones aparecían en los resultados de Q1 (James Miller) y Q4 (James Miller, 5.º puesto). A partir de aquí ya no influyen en las agregaciones (Q9–Q12).


## Q9 - Inscripciones por categoría

Resultado:

- Programming: 7
- Design: 4
- Data: 3
- Marketing: 2

Total: 16 inscripciones (después de las correcciones de Q6–Q8).

Observaciones:

- Programming concentra casi la mitad de las inscripciones (7 de 16), con la nueva inscripción de Q6 incluida.
- Respecto a los datos originales, Programming gana 1 (Q6) y pierde 1 (Q8, James Miller), y Design pierde 1 (Q8, Alex Chen).


## Q10 - Promedio de completado por curso

Resultado (de menor a mayor):

| course_title           | promedio_completado |
| ---------------------- | ------------------- |
| UI/UX Fundamentals     | 0.00                |
| Web Design Basics      | 32.50               |
| Digital Marketing 101  | 36.50               |
| Advanced Python        | 45.00               |
| Data Analysis with SQL | 47.67               |
| Intro to Python        | 80.00               |

Observaciones:

- UI/UX Fundamentals tiene un promedio de 0 %: sus dos estudiantes no han avanzado nada y el curso no tiene instructor asignado (Q3, Q7).
- Los dos cursos de Design (UI/UX Fundamentals y Web Design Basics) son los de peor rendimiento.
- Intro to Python es claramente el curso con mejor rendimiento (80 %).
- El promedio de Advanced Python (45 %) incluye la inscripción añadida en Q6, que empieza en 0 %; sin ella sería 67,5 %.
- Email Campaigns no aparece porque no tiene ninguna inscripción.


## Q11 - Cursos con más de 3 inscripciones

Resultado: 1

| course_title    | total_inscripciones |
| --------------- | ------------------- |
| Intro to Python | 4                   |

Observaciones:

- Solo Intro to Python supera las 3 inscripciones. Advanced Python y Data Analysis with SQL tienen exactamente 3, por lo que quedan fuera (`> 3` no incluye el 3).
- Intro to Python es a la vez el curso con más inscripciones y el de mejor promedio de completado (80 %, Q10).
- Antes de Q8 tenía 5 inscripciones; la eliminada era la de la cuenta de prueba de James Miller.


## Q12 - Ingresos totales por categoría

Resultado (de mayor a menor):

- Programming: 409.93
- Data: 179.97
- Design: 169.96
- Marketing: 59.98

Total: 819.84 (16 inscripciones, después de las correcciones de Q6–Q8).

Observaciones:

- Programming genera la mitad de los ingresos (409.93 de 819.84): tiene más inscripciones (7, Q9) y los cursos más caros (Advanced Python, 69.99).
- Marketing es la categoría que menos ingresa: solo 2 inscripciones en Digital Marketing 101, a 29.99 cada una.
- Design ingresa casi lo mismo que Data (169.96 frente a 179.97) con más inscripciones (4 frente a 3), pero es la categoría con peor progreso (Q10).

---

## Resumen para el equipo de Operaciones

| Petición | Resultado |
| -------- | --------- |
| Estudiantes con progreso muy bajo | 4 inscripciones por debajo del 10 % (Q2). Lucia Fernandes en dos cursos, y las dos inscripciones de UI/UX Fundamentals al 0 %. |
| Cuentas de prueba (`@test.com`) | 2 inscripciones eliminadas: James Miller y Alex Chen (Q8). La tabla queda con 16 inscripciones. |
| Instructor sin asignar | 2 inscripciones de UI/UX Fundamentals corregidas a `'Pending assignment'` (Q3, Q7). |
| Inscripción confirmada sin registrar | Añadida: Lucia Fernandes en Advanced Python, `id` 18 (Q6). |
| Cifras por categoría | Ingresos totales 819.84; Programming lidera en inscripciones (7) e ingresos (409.93) (Q9, Q12). |

Categorías y cursos con peor rendimiento:

- **Design** es la categoría con peor rendimiento: sus dos cursos tienen los promedios más bajos (UI/UX Fundamentals 0 %, Web Design Basics 32,5 %; Q10).
- **Marketing** es la categoría con menos inscripciones e ingresos (2 inscripciones, 59.98; Q9, Q12), y Digital Marketing 101 tiene un promedio del 36,5 %.

Acciones recomendadas:

1. Asignar un instructor real a UI/UX Fundamentals; sus estudiantes no han avanzado nada.
2. Contactar con Lucia Fernandes, con progreso muy bajo en dos cursos y una inscripción nueva en Advanced Python.
3. Revisar el proceso de importación del partner para que el instructor llegue informado, y el del sistema antiguo para que no entren cuentas de prueba.
