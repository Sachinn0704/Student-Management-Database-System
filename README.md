# Student Management Database & Performance Analysis

A SQL-based student management project that demonstrates relational database design, data manipulation, and analytical querying for academic performance data.

## Project Summary

The database stores student information and subject scores and supports both foundational SQL practice and portfolio-oriented performance analysis.

## Main Features

- Student record management
- Subject-wise score tracking
- Grade classification
- Average-score analysis
- Top-performer identification
- Grade-distribution analysis
- Gender-based performance comparison
- High-performing student filtering
- SQL `UPDATE` operations
- Advanced ranking and window-function analysis
- Performance quartiles
- Student-vs-overall-average comparisons
- Subject-level reporting summaries

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

1. Create the `StudentManagement` database and `Students` table.
2. Insert the sample student records.
3. Run foundational retrieval and aggregation queries.
4. Compare subject averages and student totals.
5. Identify top performers and grade distributions.
6. Run `advanced_analytics.sql` for ranking, quartile, comparison, and subject-summary analysis.
7. Review the results as portfolio-style analytical outputs.

## Advanced Analytics

`advanced_analytics.sql` adds MySQL 8+ analytical patterns including:

- `DENSE_RANK()` for overall student ranking
- CTEs for reusable analytical steps
- `AVG() OVER()`-style window analysis concepts
- `NTILE(4)` for performance quartiles
- Difference-from-average analysis
- `CASE`-based strongest-subject classification
- `UNION ALL` subject-level KPI reporting

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

- MySQL 8+ or another compatible relational database
- MySQL Workbench, pgAdmin, or a SQL client

### Steps

1. Open your SQL client.
2. Run the database/table setup script containing the `Students` table.
3. Select the `StudentManagement` database.
4. Execute the foundational analysis queries.
5. Run `advanced_analytics.sql` for the advanced reporting layer.
6. Review the generated rankings, quartiles, comparisons, and subject KPIs.

## Project Structure

```text
.
├── advanced_analytics.sql
├── README.md
└── docs/
```

## Skills Demonstrated

- SQL database design
- `CREATE`, `INSERT`, `SELECT`, `UPDATE`
- `WHERE` and `ORDER BY`
- Aggregate functions such as `AVG`, `COUNT`, `MAX`, and `SUM`
- `GROUP BY` and filtering
- Calculated fields and ranking
- CTEs and window functions
- `CASE` expressions
- Portfolio-oriented relational data analysis

## Notes

The advanced script is intentionally separated from the foundational database setup so learners can progress from basic SQL operations to analytical SQL patterns without changing the underlying student data model.
