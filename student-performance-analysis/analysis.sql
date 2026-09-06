-- 1. Overall subject averages.
SELECT
    ROUND(AVG(math_score), 2) AS avg_math,
    ROUND(AVG(reading_score), 2) AS avg_reading,
    ROUND(AVG(writing_score), 2) AS avg_writing,
    ROUND(AVG((math_score + reading_score + writing_score) / 3.0), 2) AS avg_overall
FROM students;

-- 2. Average performance by gender.
SELECT
    gender,
    COUNT(*) AS student_count,
    ROUND(AVG(math_score), 2) AS avg_math,
    ROUND(AVG(reading_score), 2) AS avg_reading,
    ROUND(AVG(writing_score), 2) AS avg_writing
FROM students
GROUP BY gender
ORDER BY gender;

-- 3. Test-preparation comparison.
SELECT
    test_prep,
    COUNT(*) AS student_count,
    ROUND(AVG((math_score + reading_score + writing_score) / 3.0), 2) AS avg_overall
FROM students
GROUP BY test_prep
ORDER BY avg_overall DESC;

-- 4. Lunch-status comparison.
SELECT
    lunch,
    COUNT(*) AS student_count,
    ROUND(AVG((math_score + reading_score + writing_score) / 3.0), 2) AS avg_overall
FROM students
GROUP BY lunch
ORDER BY avg_overall DESC;

-- 5. Performance by parental education.
SELECT
    parental_education,
    COUNT(*) AS student_count,
    ROUND(AVG((math_score + reading_score + writing_score) / 3.0), 2) AS avg_overall
FROM students
GROUP BY parental_education
ORDER BY avg_overall DESC;

-- 6. At-risk students: average score below 65.
WITH student_averages AS (
    SELECT
        student_id,
        gender,
        lunch,
        test_prep,
        ROUND((math_score + reading_score + writing_score) / 3.0, 2) AS avg_score
    FROM students
)
SELECT *
FROM student_averages
WHERE avg_score < 65
ORDER BY avg_score, student_id;

-- 7. At-risk rate by lunch status.
WITH student_averages AS (
    SELECT
        lunch,
        (math_score + reading_score + writing_score) / 3.0 AS avg_score
    FROM students
)
SELECT
    lunch,
    COUNT(*) AS students,
    COUNT(*) FILTER (WHERE avg_score < 65) AS at_risk_students,
    ROUND(100.0 * COUNT(*) FILTER (WHERE avg_score < 65) / COUNT(*), 2) AS at_risk_rate_pct
FROM student_averages
GROUP BY lunch
ORDER BY at_risk_rate_pct DESC;

-- 8. Rank students within each demographic group.
SELECT
    student_id,
    race_ethnicity,
    ROUND((math_score + reading_score + writing_score) / 3.0, 2) AS avg_score,
    DENSE_RANK() OVER (
        PARTITION BY race_ethnicity
        ORDER BY (math_score + reading_score + writing_score) DESC
    ) AS group_rank
FROM students
ORDER BY race_ethnicity, group_rank, student_id;

-- 9. Score bands for intervention planning.
WITH scored AS (
    SELECT (math_score + reading_score + writing_score) / 3.0 AS avg_score
    FROM students
)
SELECT
    CASE
        WHEN avg_score >= 85 THEN 'Advanced (85-100)'
        WHEN avg_score >= 75 THEN 'Proficient (75-84)'
        WHEN avg_score >= 65 THEN 'Developing (65-74)'
        ELSE 'At Risk (Below 65)'
    END AS performance_band,
    COUNT(*) AS student_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_students
FROM scored
GROUP BY performance_band
ORDER BY MIN(avg_score) DESC;

