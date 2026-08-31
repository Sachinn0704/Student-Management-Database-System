# Student Management Database & Performance Analysis

A SQL-based student management project that demonstrates relational database design, data manipulation, and analytical querying for academic performance data.

## Project Summary

The database stores student information and subject scores and provides SQL queries for averages, rankings, grade distributions, demographic comparisons, and subject-level performance.

## Main Features

- Student record management
- Subject-wise score tracking
- Grade classification
- Average-score analysis
- Top-performer identification
- Grade-distribution analysis
- Gender-based performance comparison
- High-performing student filtering
- SQL UPDATE operations

## Database Schema

The primary `Students` table contains fields for:

- Student ID
- Name
- Gender
- Age
- Grade
- Mathematics score
- Science score
- English score

## Analysis Workflow

1. Create the `StudentManagement` database.
2. Create the `Students` table with the required constraints.
3. Insert the sample student records.
4. Run data-retrieval and aggregation queries.
5. Compare subject averages and student totals.
6. Identify top performers and grade distributions.
7. Apply data modifications where required.

## Example Queries

### Average subject scores

```sql
SELECT
    AVG(MathScore) AS AvgMathScore,
    AVG(ScienceScore) AS AvgScienceScore,
    AVG(EnglishScore) AS AvgEnglishScore
FROM Students;
```

### Top performer

```sql
SELECT Name,
       (MathScore + ScienceScore + EnglishScore) AS TotalScore
FROM Students
ORDER BY TotalScore DESC
LIMIT 1;
```

## How to Run

### Requirements

- MySQL or another compatible relational database
- MySQL Workbench, pgAdmin, or a SQL client

### Steps

1. Open your SQL client.
2. Run `student_management.sql`.
3. Select the `StudentManagement` database.
4. Execute individual analytical queries or the complete script.
5. Review the generated results.

## Project Structure

```text
.
├── student_management.sql
├── analysis_report.md
├── README.md
└── docs/
```

## Skills Demonstrated

- SQL database design
- CREATE, INSERT, SELECT, UPDATE
- WHERE and ORDER BY
- Aggregate functions such as AVG, COUNT, MAX, and SUM
- GROUP BY and filtering
- Ranking and calculated fields
- Relational data analysis

## Notes

The README focuses on the database-analysis workflow and avoids hard-coded personal repository URLs so the project documentation remains reusable and maintainable.
