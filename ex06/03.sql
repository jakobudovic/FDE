WITH examination (MatrNr, CourseNr, PersNr, Grade) as (
        SELECT * FROM pruefen
        UNION
        VALUES (29120, 0, 0, 3.0), (29555, 0, 0, 2.0),
        (29555, 0, 0, 1.3), (29555, 0, 0, 1.0)
)