-- Confirm record count.
SELECT COUNT(*) AS total_students
FROM students;

-- Check for missing values.
SELECT
    COUNT(*) FILTER (WHERE gender IS NULL) AS missing_gender,
    COUNT(*) FILTER (WHERE parental_education IS NULL) AS missing_parental_education,
    COUNT(*) FILTER (WHERE lunch IS NULL) AS missing_lunch,
    COUNT(*) FILTER (WHERE test_prep IS NULL) AS missing_test_prep,
    COUNT(*) FILTER (WHERE math_score IS NULL) AS missing_math_scores,
    COUNT(*) FILTER (WHERE reading_score IS NULL) AS missing_reading_scores,
    COUNT(*) FILTER (WHERE writing_score IS NULL) AS missing_writing_scores
FROM students;

-- Check score ranges.
SELECT
    MIN(math_score) AS min_math,
    MAX(math_score) AS max_math,
    MIN(reading_score) AS min_reading,
    MAX(reading_score) AS max_reading,
    MIN(writing_score) AS min_writing,
    MAX(writing_score) AS max_writing
FROM students;

-- Check categorical values.
SELECT DISTINCT gender, lunch, test_prep
FROM students
ORDER BY gender, lunch, test_prep;

