USE StudentManagement;

-- Data-quality checks for the Students table.
-- Run after creating and loading the Students table.
-- Assumes scores are expected to be between 0 and 100.

-- 1. Find records with missing or blank key fields.
SELECT
    StudentID,
    Name,
    Gender,
    Age,
    Grade,
    MathScore,
    ScienceScore,
    EnglishScore
FROM Students
WHERE StudentID IS NULL
   OR Name IS NULL
   OR TRIM(Name) = ''
   OR Gender IS NULL
   OR Age IS NULL
   OR Grade IS NULL
   OR MathScore IS NULL
   OR ScienceScore IS NULL
   OR EnglishScore IS NULL
ORDER BY StudentID;

-- 2. Find scores outside the expected 0-100 range.
SELECT
    StudentID,
    Name,
    MathScore,
    ScienceScore,
    EnglishScore
FROM Students
WHERE (MathScore < 0 OR MathScore > 100)
   OR (ScienceScore < 0 OR ScienceScore > 100)
   OR (EnglishScore < 0 OR EnglishScore > 100)
ORDER BY StudentID;

-- 3. Find implausible ages for manual review.
-- Adjust the upper bound if the project uses a different age policy.
SELECT
    StudentID,
    Name,
    Age
FROM Students
WHERE Age <= 0 OR Age > 120
ORDER BY Age, StudentID;

-- 4. Flag possible duplicate profiles for manual review.
-- Matching names alone do not prove that two records are duplicates.
SELECT
    Name,
    Gender,
    Age,
    Grade,
    COUNT(*) AS MatchingRecords
FROM Students
GROUP BY Name, Gender, Age, Grade
HAVING COUNT(*) > 1
ORDER BY MatchingRecords DESC, Name;

-- 5. Produce a compact data-quality summary.
SELECT
    'Missing or blank required fields' AS CheckName,
    COUNT(*) AS IssueCount
FROM Students
WHERE StudentID IS NULL
   OR Name IS NULL
   OR TRIM(Name) = ''
   OR Gender IS NULL
   OR Age IS NULL
   OR Grade IS NULL
   OR MathScore IS NULL
   OR ScienceScore IS NULL
   OR EnglishScore IS NULL

UNION ALL

SELECT
    'Out-of-range subject scores',
    COUNT(*)
FROM Students
WHERE (MathScore < 0 OR MathScore > 100)
   OR (ScienceScore < 0 OR ScienceScore > 100)
   OR (EnglishScore < 0 OR EnglishScore > 100)

UNION ALL

SELECT
    'Implausible ages',
    COUNT(*)
FROM Students
WHERE Age <= 0 OR Age > 120;
