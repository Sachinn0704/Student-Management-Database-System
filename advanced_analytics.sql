USE StudentManagement;

-- Advanced student-performance analytics
-- Compatible with MySQL 8+

-- 1. Calculate each student's total and average score.
SELECT
    StudentID,
    Name,
    (MathScore + ScienceScore + EnglishScore) AS TotalScore,
    ROUND((MathScore + ScienceScore + EnglishScore) / 3, 2) AS AverageScore
FROM Students
ORDER BY AverageScore DESC;

-- 2. Rank students by overall performance.
SELECT
    StudentID,
    Name,
    (MathScore + ScienceScore + EnglishScore) AS TotalScore,
    DENSE_RANK() OVER (
        ORDER BY (MathScore + ScienceScore + EnglishScore) DESC
    ) AS PerformanceRank
FROM Students
ORDER BY PerformanceRank, Name;

-- 3. Compare each student with the overall average.
WITH student_scores AS (
    SELECT
        StudentID,
        Name,
        (MathScore + ScienceScore + EnglishScore) / 3.0 AS AverageScore
    FROM Students
), overall_average AS (
    SELECT AVG(AverageScore) AS OverallAverage
    FROM student_scores
)
SELECT
    s.StudentID,
    s.Name,
    ROUND(s.AverageScore, 2) AS AverageScore,
    ROUND(o.OverallAverage, 2) AS OverallAverage,
    ROUND(s.AverageScore - o.OverallAverage, 2) AS DifferenceFromAverage
FROM student_scores s
CROSS JOIN overall_average o
ORDER BY DifferenceFromAverage DESC;

-- 4. Assign students to performance quartiles.
SELECT
    StudentID,
    Name,
    ROUND((MathScore + ScienceScore + EnglishScore) / 3.0, 2) AS AverageScore,
    NTILE(4) OVER (
        ORDER BY (MathScore + ScienceScore + EnglishScore) DESC
    ) AS PerformanceQuartile
FROM Students;

-- 5. Find the strongest subject for each student.
SELECT
    StudentID,
    Name,
    CASE
        WHEN MathScore >= ScienceScore AND MathScore >= EnglishScore THEN 'Mathematics'
        WHEN ScienceScore >= MathScore AND ScienceScore >= EnglishScore THEN 'Science'
        ELSE 'English'
    END AS StrongestSubject
FROM Students;

-- 6. Subject-level summary for reporting.
SELECT 'Mathematics' AS Subject, ROUND(AVG(MathScore), 2) AS AverageScore, MAX(MathScore) AS HighestScore, MIN(MathScore) AS LowestScore FROM Students
UNION ALL
SELECT 'Science', ROUND(AVG(ScienceScore), 2), MAX(ScienceScore), MIN(ScienceScore) FROM Students
UNION ALL
SELECT 'English', ROUND(AVG(EnglishScore), 2), MAX(EnglishScore), MIN(EnglishScore) FROM Students;

-- 7. Calculate each student's percentile position.
-- PERCENT_RANK() shows the student's relative standing from 0 to 1.
WITH student_scores AS (
    SELECT
        StudentID,
        Name,
        ROUND((MathScore + ScienceScore + EnglishScore) / 3.0, 2) AS AverageScore
    FROM Students
)
SELECT
    StudentID,
    Name,
    AverageScore,
    ROUND(PERCENT_RANK() OVER (ORDER BY AverageScore), 2) AS PercentileRank
FROM student_scores
ORDER BY PercentileRank DESC, Name;

-- 8. Produce a compact KPI summary for dashboard/reporting use.
SELECT
    COUNT(*) AS TotalStudents,
    ROUND(AVG((MathScore + ScienceScore + EnglishScore) / 3.0), 2) AS OverallAverage,
    ROUND(MAX((MathScore + ScienceScore + EnglishScore) / 3.0), 2) AS HighestAverage,
    ROUND(MIN((MathScore + ScienceScore + EnglishScore) / 3.0), 2) AS LowestAverage,
    SUM(
        CASE
            WHEN (MathScore + ScienceScore + EnglishScore) / 3.0 >= 75 THEN 1
            ELSE 0
        END
    ) AS StudentsAbove75
FROM Students;

-- 9. Segment students into actionable performance bands.
-- The labels can be used directly in dashboards or intervention reports.
WITH student_scores AS (
    SELECT
        StudentID,
        Name,
        ROUND((MathScore + ScienceScore + EnglishScore) / 3.0, 2) AS AverageScore
    FROM Students
)
SELECT
    StudentID,
    Name,
    AverageScore,
    CASE
        WHEN AverageScore >= 85 THEN 'Excellent'
        WHEN AverageScore >= 70 THEN 'Good'
        WHEN AverageScore >= 50 THEN 'Needs Improvement'
        ELSE 'At Risk'
    END AS PerformanceBand
FROM student_scores
ORDER BY AverageScore DESC, Name;

-- 10. Measure score consistency across subjects.
-- A smaller gap indicates a more balanced student profile.
SELECT
    StudentID,
    Name,
    GREATEST(MathScore, ScienceScore, EnglishScore) AS HighestSubjectScore,
    LEAST(MathScore, ScienceScore, EnglishScore) AS LowestSubjectScore,
    GREATEST(MathScore, ScienceScore, EnglishScore)
        - LEAST(MathScore, ScienceScore, EnglishScore) AS SubjectScoreGap,
    CASE
        WHEN GREATEST(MathScore, ScienceScore, EnglishScore)
             - LEAST(MathScore, ScienceScore, EnglishScore) <= 10 THEN 'Balanced'
        WHEN GREATEST(MathScore, ScienceScore, EnglishScore)
             - LEAST(MathScore, ScienceScore, EnglishScore) <= 25 THEN 'Moderate Variation'
        ELSE 'High Variation'
    END AS ScoreConsistency
FROM Students
ORDER BY SubjectScoreGap ASC, Name;

-- 11. Identify students needing targeted intervention.
-- Combines overall performance, weakest subject, and subject gap into one actionable view.
WITH student_profiles AS (
    SELECT
        StudentID,
        Name,
        ROUND((MathScore + ScienceScore + EnglishScore) / 3.0, 2) AS AverageScore,
        CASE
            WHEN MathScore <= ScienceScore AND MathScore <= EnglishScore THEN 'Mathematics'
            WHEN ScienceScore <= MathScore AND ScienceScore <= EnglishScore THEN 'Science'
            ELSE 'English'
        END AS WeakestSubject,
        GREATEST(MathScore, ScienceScore, EnglishScore)
            - LEAST(MathScore, ScienceScore, EnglishScore) AS SubjectScoreGap
    FROM Students
)
SELECT
    StudentID,
    Name,
    AverageScore,
    WeakestSubject,
    SubjectScoreGap,
    CASE
        WHEN AverageScore < 50 THEN 'High Priority'
        WHEN AverageScore < 70 OR SubjectScoreGap > 25 THEN 'Medium Priority'
        ELSE 'Monitor'
    END AS InterventionPriority
FROM student_profiles
WHERE AverageScore < 70 OR SubjectScoreGap > 25
ORDER BY
    CASE
        WHEN AverageScore < 50 THEN 1
        WHEN AverageScore < 70 OR SubjectScoreGap > 25 THEN 2
        ELSE 3
    END,
    AverageScore ASC,
    Name;
