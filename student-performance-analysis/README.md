# Student Performance Analysis

## Business Question

Which student groups show the strongest outcomes, where are the largest performance gaps, and which students may need additional academic support?

## Dataset

- **Source:** [Students Performance in Exams on Kaggle](https://www.kaggle.com/datasets/spscientist/students-performance-in-exams)
- **Records:** 1,000
- **Fields:** gender, race/ethnicity, parental education, lunch status, test preparation, and three exam scores
- The dataset is synthetic and contains no personally identifiable student information.

## Tools and Skills

PostgreSQL, data validation, aggregate functions, `GROUP BY`, CTEs, conditional logic, filtered aggregates, subqueries, and window functions.

## Project Files

- `data/students_performance.csv` — original source data; import maps its columns to SQL-friendly field names
- `schema.sql` — table definition and import instructions
- `data_quality.sql` — completeness, category, and score-range checks
- `analysis.sql` — nine analysis questions from summary metrics through ranking

## How to Run

1. Create a PostgreSQL database.
2. Run `schema.sql`.
3. From `psql`, run the `\copy` command shown at the bottom of `schema.sql`.
4. Run `data_quality.sql`, followed by `analysis.sql`.

## Key Findings

The findings below are generated from the included 1,000-row dataset and were independently recalculated during project validation.

- Overall average performance was **67.77**, with reading (**69.17**) and writing (**68.05**) above math (**66.09**).
- Students who completed test preparation averaged **72.67**, compared with **65.04** for students who did not—a **7.63-point difference**.
- Students receiving standard lunch averaged **70.84**, compared with **62.20** for students receiving free/reduced lunch.
- **399 students** had an overall average below 65 and were identified for potential academic support.
- The results show associations within this dataset; they do not establish that lunch status, parental education, or test preparation caused the score differences.

## Recommendations

1. Prioritize targeted intervention for students averaging below 65, beginning with the lowest performance band.
2. Review access to and completion of test-preparation supports because the completion group showed stronger average outcomes.
3. Monitor performance gaps alongside other school-level evidence before assigning cause or selecting an intervention.
