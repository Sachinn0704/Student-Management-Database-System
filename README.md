# 🎓 Student Management Database - SQL Data Analysis Project

![SQL](https://img.shields.io/badge/SQL-Database-blue)
![MySQL](https://img.shields.io/badge/MySQL-Compatible-orange)
![Status](https://img.shields.io/badge/Status-Complete-success)
![License](https://img.shields.io/badge/License-MIT-green)

A comprehensive SQL-based Student Management System designed to analyze student performance across multiple subjects. This project demonstrates essential data analysis skills including database design, data manipulation, and analytical query writing.

---

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Database Schema](#database-schema)
- [Installation](#installation)
- [Usage](#usage)
- [Query Documentation](#query-documentation)
- [Sample Results](#sample-results)
- [Skills Demonstrated](#skills-demonstrated)
- [Project Structure](#project-structure)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

---

## 🎯 Overview

This project was developed as part of the **SQL Data Analysis Internship - Task 1** for MainCrafts Technology. It showcases the ability to:

- Design and implement a relational database
- Perform complex data analysis using SQL queries
- Extract meaningful insights from student performance data
- Generate analytical reports for decision-making

**Key Objective:** Build a Student Management Database and analyze student performance across Math, Science, and English subjects.

---

## ✨ Features

### Database Capabilities
- ✅ Automated student ID generation with AUTO_INCREMENT
- ✅ Comprehensive student information storage
- ✅ Multi-subject performance tracking
- ✅ Grade-based classification system
- ✅ Gender and age demographic tracking

### Analytical Queries
- 📊 Average score calculation per subject
- 🏆 Top performer identification
- 📈 Grade distribution analysis
- 👥 Gender-based performance comparison
- 🎯 Subject-specific filtering (e.g., Math > 80)
- 🔄 Data modification capabilities (UPDATE operations)

### Bonus Analysis
- 🌟 Above-average student identification
- 📉 Subject-wise champion finder
- 📊 Comprehensive grade-wise performance summary

---

## 🗄️ Database Schema

### Students Table

| Column Name    | Data Type    | Constraints           | Description                    |
|---------------|--------------|----------------------|--------------------------------|
| StudentID     | INT          | PRIMARY KEY, AUTO_INCREMENT | Unique student identifier |
| Name          | VARCHAR(50)  | -                    | Student's full name            |
| Gender        | CHAR(1)      | -                    | 'M' or 'F'                     |
| Age           | INT          | -                    | Student's age (15-17)          |
| Grade         | VARCHAR(2)   | -                    | Performance grade (A/B/C)      |
| MathScore     | INT          | -                    | Mathematics score (0-100)      |
| ScienceScore  | INT          | -                    | Science score (0-100)          |
| EnglishScore  | INT          | -                    | English score (0-100)          |

---

## 🚀 Installation

### Prerequisites
- MySQL Server 5.7+ or PostgreSQL 10+
- MySQL Workbench / pgAdmin / Any SQL Client
- Basic understanding of SQL

### Setup Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/student-management-db.git
   cd student-management-db
   ```

2. **Import the SQL file**
   
   **Option A: Using MySQL Command Line**
   ```bash
   mysql -u your_username -p < student_management.sql
   ```
   
   **Option B: Using MySQL Workbench**
   - Open MySQL Workbench
   - File → Run SQL Script
   - Select `student_management.sql`
   - Execute

3. **Verify Installation**
   ```sql
   USE StudentManagement;
   SELECT COUNT(*) FROM Students;
   -- Should return 14 rows
   ```

---

## 💻 Usage

### Running Individual Queries

Navigate to the SQL file and execute queries section by section:

```sql
-- Connect to database
USE StudentManagement;

-- Example: View all students
SELECT * FROM Students;

-- Example: Find top performer
SELECT Name, (MathScore + ScienceScore + EnglishScore) AS TotalScore
FROM Students
ORDER BY TotalScore DESC
LIMIT 1;
```

### Running the Complete Script

Execute the entire `student_management.sql` file to:
1. Create the database
2. Create the Students table
3. Insert sample data
4. Run all analytical queries

---

## 📊 Query Documentation

### Query 1: Display All Student Details
**Purpose:** Retrieve complete student information

```sql
SELECT * FROM Students;
```

**Output:** 14 rows with all student attributes

---

### Query 2: Average Score Per Subject
**Purpose:** Calculate mean performance across subjects

```sql
SELECT 
    AVG(MathScore) AS AvgMathScore,
    AVG(ScienceScore) AS AvgScienceScore,
    AVG(EnglishScore) AS AvgEnglishScore
FROM Students;
```

**Expected Results:**
- Math Average: ~81.29
- Science Average: ~80.07
- English Average: ~80.64

---

### Query 3: Top Performer
**Purpose:** Identify the highest-scoring student

```sql
SELECT 
    StudentID, Name,
    (MathScore + ScienceScore + EnglishScore) AS TotalScore
FROM Students
ORDER BY TotalScore DESC
LIMIT 1;
```

**Result:** Priya Sharma (Total: 277/300)

---

### Query 4: Student Count Per Grade
**Purpose:** Analyze grade distribution

```sql
SELECT Grade, COUNT(*) AS StudentCount
FROM Students
GROUP BY Grade
ORDER BY Grade;
```

**Results:**
- Grade A: 6 students
- Grade B: 5 students
- Grade C: 3 students

---

### Query 5: Performance by Gender
**Purpose:** Compare male vs female performance

```sql
SELECT 
    Gender,
    AVG(MathScore) AS AvgMath,
    AVG(ScienceScore) AS AvgScience,
    AVG(EnglishScore) AS AvgEnglish
FROM Students
GROUP BY Gender;
```

**Key Finding:** Female students outperform males by ~10 points across all subjects

---

### Query 6: High Math Performers
**Purpose:** Filter students excelling in Mathematics

```sql
SELECT StudentID, Name, MathScore
FROM Students
WHERE MathScore > 80
ORDER BY MathScore DESC;
```

**Result:** 8 students (57%) score above 80 in Math

---

### Query 7: Update Student Grade
**Purpose:** Demonstrate data modification

```sql
UPDATE Students
SET Grade = 'B'
WHERE Name = 'Vikram Singh';
```

**Action:** Updated Vikram Singh from Grade C to Grade B

---

## 📈 Sample Results

### Overall Performance Metrics

| Metric                    | Value    |
|--------------------------|----------|
| Total Students           | 14       |
| Average Total Score      | ~242     |
| Highest Total Score      | 277      |
| Lowest Total Score       | 187      |
| Students in Grade A      | 6 (43%)  |
| Students in Grade B      | 5 (36%)  |
| Students in Grade C      | 3 (21%)  |

### Top 5 Performers

| Rank | Name              | Total Score | Grade |
|------|-------------------|-------------|-------|
| 1    | Priya Sharma      | 277         | A     |
| 2    | Neha Joshi        | 273         | A     |
| 3    | Rohit Gupta       | 265         | A     |
| 4    | Divya Iyer        | 263         | A     |
| 5    | Sneha Reddy       | 263         | A     |

### Subject Champions

- 🥇 **Math:** Priya Sharma (95)
- 🥇 **Science:** Divya Iyer (91)
- 🥇 **English:** Priya Sharma (92)

---

## 🛠️ Skills Demonstrated

### SQL Fundamentals
- ✅ Database creation and management (`CREATE DATABASE`, `USE`)
- ✅ Table design with constraints (`PRIMARY KEY`, `AUTO_INCREMENT`)
- ✅ Data insertion (`INSERT INTO`)
- ✅ Data retrieval (`SELECT`, `FROM`, `WHERE`)
- ✅ Data modification (`UPDATE`, `SET`)

### Advanced SQL Techniques
- ✅ Aggregate functions (`AVG`, `COUNT`, `MAX`, `SUM`)
- ✅ Grouping and categorization (`GROUP BY`)
- ✅ Sorting results (`ORDER BY`, `DESC`, `ASC`)
- ✅ Limiting results (`LIMIT`)
- ✅ Subqueries for complex analysis
- ✅ Calculated fields and expressions

### Data Analysis Skills
- ✅ Statistical analysis (averages, counts, rankings)
- ✅ Comparative analysis (gender, grade-based)
- ✅ Filtering and segmentation
- ✅ Performance benchmarking
- ✅ Trend identification
- ✅ Report generation

---

## 📁 Project Structure

```
student-management-db/
│
├── student_management.sql      # Main SQL script with all queries
├── analysis_report.md          # Detailed analysis report
├── README.md                   # This file
│
└── docs/                       # Additional documentation (optional)
    ├── schema_diagram.png      # Database schema visualization
    └── sample_output.txt       # Sample query outputs
```

---

## 🎓 Learning Resources

### Recommended Tutorials
- [SQL Full Course - FreeCodeCamp](https://www.youtube.com/watch?v=HXV3zeQKqGY)
- [SQL Basics - Programming with Mosh](https://www.youtube.com/watch?v=7S_tz1z_5bA)

### Reference Documentation
- [W3Schools SQL Tutorial](https://www.w3schools.com/sql/)
- [SQLBolt Interactive Lessons](https://sqlbolt.com/)

### Practice Platforms
- [LeetCode SQL Problems](https://leetcode.com/problemset/database/)
- [HackerRank SQL](https://www.hackerrank.com/domains/sql)
- [Mode Analytics SQL Tutorial](https://mode.com/sql-tutorial/)
- [DB Fiddle](https://www.db-fiddle.com/) - Run SQL in browser

---

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Ideas for Enhancement
- Add more analytical queries (median scores, standard deviation)
- Implement stored procedures for complex operations
- Create views for frequently accessed data
- Add data visualization using Python/R
- Implement a web-based dashboard
- Add data validation constraints
- Create backup and restore scripts

---

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2024 [Your Name]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.


## 📊 Project Statistics

![GitHub repo size](https://img.shields.io/github/repo-size/yourusername/student-management-db)
![GitHub stars](https://img.shields.io/github/stars/yourusername/student-management-db?style=social)
![GitHub forks](https://img.shields.io/github/forks/yourusername/student-management-db?style=social)
![GitHub issues](https://img.shields.io/github/issues/yourusername/student-management-db)

---

