DROP TABLE IF EXISTS students;

CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    gender VARCHAR(10) NOT NULL,
    race_ethnicity VARCHAR(20) NOT NULL,
    parental_education VARCHAR(50) NOT NULL,
    lunch VARCHAR(20) NOT NULL,
    test_prep VARCHAR(20) NOT NULL,
    math_score INTEGER NOT NULL CHECK (math_score BETWEEN 0 AND 100),
    reading_score INTEGER NOT NULL CHECK (reading_score BETWEEN 0 AND 100),
    writing_score INTEGER NOT NULL CHECK (writing_score BETWEEN 0 AND 100)
);

-- Run this command from psql after creating the table:
-- \copy students(gender, race_ethnicity, parental_education, lunch, test_prep, math_score, reading_score, writing_score)
-- FROM 'data/students_performance.csv' WITH (FORMAT csv, HEADER true);

