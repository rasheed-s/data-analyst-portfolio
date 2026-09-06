-- Original PostgreSQL practice completed before the full portfolio analysis.
DROP TABLE IF EXISTS student_performance;

CREATE TABLE student_performance (
    student_id INTEGER PRIMARY KEY,
    student_name VARCHAR(50),
    class VARCHAR(20),
    subject VARCHAR(30),
    grade INTEGER,
    attendance_percent INTEGER
);

INSERT INTO student_performance VALUES
    (1, 'Sarah', 'Class A', 'Math', 90, 95),
    (2, 'John', 'Class A', 'Math', 85, 88),
    (3, 'Emily', 'Class B', 'Science', 95, 97),
    (4, 'Mike', 'Class B', 'Science', 78, 80),
    (5, 'Anna', 'Class A', 'Math', 92, 96),
    (6, 'David', 'Class C', 'English', 87, 89),
    (7, 'Sophia', 'Class C', 'English', 93, 98),
    (8, 'James', 'Class B', 'Science', 84, 85);

SELECT * FROM student_performance ORDER BY student_id;

SELECT class, ROUND(AVG(grade), 2) AS average_grade
FROM student_performance
GROUP BY class
ORDER BY average_grade DESC;

SELECT * FROM student_performance
WHERE attendance_percent < 90
ORDER BY attendance_percent;

SELECT subject, ROUND(AVG(grade), 2) AS average_grade
FROM student_performance
GROUP BY subject
ORDER BY average_grade DESC;

SELECT * FROM student_performance
WHERE grade < 85
ORDER BY grade;

SELECT student_name, grade, attendance_percent
FROM student_performance
ORDER BY attendance_percent;

