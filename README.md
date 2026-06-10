# Database Management System Laboratory

This repository contains SQL lab exercises for DBMS coursework. Each `.sql` file in the `lab` folder contains SQL statements you can run against a relational database (MySQL/Postgres). This README explains the repository layout and how to run and push the files to GitHub.

Contents
 - `lab1.sql`  — Basic DDL/DML: schema, inserts, simple queries
 - `lab2.sql`  — Joins, WHERE, ORDER BY, subqueries
 - `lab2practise.sql` — Views and set operations
 - `lab3.sql`  — Aggregation, GROUP BY, HAVING
 - `lab4.sql`  — Transactions, constraints, examples
 - `lab5.sql`  — Indexing and query-plan examples
 - `lab6.sql`  — Normalization and migration notes
 - `lab7.sql`  — Stored functions / procedures examples
 - `lab9.sql`  — Backup/export examples

Prerequisites
- A relational DBMS (MySQL, PostgreSQL, or SQLite). Some statements (e.g., `SERIAL`, `plpgsql`, `COPY`) are DB-specific — adjust if necessary.

How to run a single lab file (MySQL)

```bash
mysql -u your_user -p your_database < lab1.sql
```

How to run a single lab file (Postgres)

```bash
psql -U your_user -d your_database -f lab1.sql
```

Git / GitHub quick guide

1. Initialize repository (if not already):

```bash
git init
git add .
git commit -m "Add DBMS lab files"
```

2. Set remote and push. If your remote default branch is `main` but your local branch is `master`, rename locally then push:

```bash
git branch -m master main
git remote add origin <REMOTE_URL>
git push -u origin main
```

Or push the local `master` branch to remote `main`:

```bash
git push origin master:main
```

Notes and recommendations
- Keep this README short and include only essential instructions — the SQL files contain the examples and exercises. Replace placeholder names (database/user) before running commands.
- If a SQL file uses DB-specific features, search and replace or modify to match your target DBMS.

If you want, I can:
- create a ZIP archive of the `lab` folder for upload;
- prepare a `git` commit and push script that you can run locally;
- or adapt all `.sql` files for a specific DBMS (MySQL or Postgres).

---

## LAB1.sql

```sql
-- LAB1.sql
-- DBMS Lab 1: Schema design and basic DDL/DML
-- Author: Your Name
-- Date: 2026-06-10
-- Objective: Create sample schema, insert data, run simple queries.

-- Drop existing objects (safe for testing)
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS Enrollments;

-- Create tables
CREATE TABLE Students (
	student_id   SERIAL PRIMARY KEY,
	first_name   VARCHAR(50) NOT NULL,
	last_name    VARCHAR(50) NOT NULL,
	email        VARCHAR(100) UNIQUE,
	enrolled_on  DATE DEFAULT CURRENT_DATE
);

CREATE TABLE Courses (
	course_id    SERIAL PRIMARY KEY,
	code         VARCHAR(10) NOT NULL UNIQUE,
	title        VARCHAR(150) NOT NULL,
	credits      INT NOT NULL
);

CREATE TABLE Enrollments (
	enrollment_id SERIAL PRIMARY KEY,
	student_id    INT NOT NULL REFERENCES Students(student_id),
	course_id     INT NOT NULL REFERENCES Courses(course_id),
	grade         VARCHAR(2),
	enrolled_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	UNIQUE(student_id, course_id)
);

-- Sample inserts
INSERT INTO Students (first_name, last_name, email) VALUES
('Alice','Nguyen','alice@example.com'),
('Bob','Smith','bob@example.com'),
('Carol','Kumar','carol@example.com');

INSERT INTO Courses (code, title, credits) VALUES
('CS101','Introduction to Databases',4),
('CS102','SQL and Relational Theory',3),
('MATH01','Discrete Mathematics',3);

INSERT INTO Enrollments (student_id, course_id, grade) VALUES
(1,1,'A'),
(2,1,'B'),
(1,2,'A-'),
(3,3,NULL);

-- Basic queries
SELECT s.student_id, s.first_name, s.last_name, c.code, c.title, e.grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
ORDER BY s.student_id;

-- Aggregate example
SELECT c.code, c.title, COUNT(e.student_id) AS num_students
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.code, c.title;
```

---

## lab2.sql

```sql
-- lab2.sql
-- DBMS Lab 2: Queries, WHERE, ORDER BY, DISTINCT, joins
-- Author: Your Name
-- Date: 2026-06-10

-- Example dataset reuse of LAB1 schema assumed.

-- Select distinct courses taken by students
SELECT DISTINCT c.code, c.title
FROM Courses c
JOIN Enrollments e USING (course_id);

-- Filtering and ordering
SELECT s.first_name, s.last_name, c.code, e.grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE e.grade IS NOT NULL
ORDER BY s.last_name, s.first_name;

-- Subquery example: students enrolled in more than one course
SELECT s.student_id, s.first_name, s.last_name
FROM Students s
WHERE (SELECT COUNT(*) FROM Enrollments e WHERE e.student_id = s.student_id) > 1;
```

---

## lab2practise.sql (lab2re.sql)

```sql
-- lab2re.sql
-- DBMS Lab 2 (revised): Views, subqueries, and set operations
-- Author: Your Name
-- Date: 2026-06-10

-- Create a view of active enrollments with course info
CREATE OR REPLACE VIEW StudentCourseView AS
SELECT s.student_id, s.first_name, s.last_name, c.code, c.title, e.grade
FROM Students s
JOIN Enrollments e USING (student_id)
JOIN Courses c USING (course_id);

-- Use the view
SELECT * FROM StudentCourseView ORDER BY student_id;

-- Set operation example - list all people who are either enrolled or have no enrollments (left join + union)
SELECT s.student_id, s.first_name, s.last_name, 'Enrolled' AS status
FROM Students s
JOIN Enrollments e USING (student_id)
GROUP BY s.student_id, s.first_name, s.last_name

UNION

SELECT s.student_id, s.first_name, s.last_name, 'Not Enrolled' AS status
FROM Students s
LEFT JOIN Enrollments e USING (student_id)
WHERE e.enrollment_id IS NULL;
```

---

## lab3.sql

```sql
-- lab3.sql
-- DBMS Lab 3: Joins, aggregate functions, HAVING, group by
-- Author: Your Name
-- Date: 2026-06-10

-- Average grade per course (assuming grade mapping)
-- We'll illustrate with a grade->numeric mapping using CASE
SELECT c.code, c.title,
	   AVG(CASE
		   WHEN e.grade IN ('A','A-') THEN 4.0
		   WHEN e.grade = 'B' THEN 3.0
		   WHEN e.grade = 'B-' THEN 2.7
		   WHEN e.grade = 'C' THEN 2.0
		   ELSE NULL END) AS avg_gpa
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.code, c.title
HAVING COUNT(e.student_id) >= 1
ORDER BY avg_gpa DESC NULLS LAST;

-- Top N example (Postgres: use LIMIT)
SELECT s.student_id, s.first_name, s.last_name, COUNT(e.course_id) AS courses_taken
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.first_name, s.last_name
ORDER BY courses_taken DESC
LIMIT 5;
```

---

## lab4.sql

```sql
-- lab4.sql
-- DBMS Lab 4: Transactions, constraints, and error handling
-- Author: Your Name
-- Date: 2026-06-10

-- Example transaction: move a student from one course to another
BEGIN;

-- Find enrollment id we will move (example student 2)
UPDATE Enrollments
SET course_id = (SELECT course_id FROM Courses WHERE code = 'CS102')
WHERE student_id = 2 AND course_id = (SELECT course_id FROM Courses WHERE code = 'CS101');

-- Simulate constraint check: ensure no duplicate enrollment after move
-- If constraint violated, rollback would be triggered by DBMS.

COMMIT;

-- Demonstrate adding a NOT NULL / CHECK constraint
ALTER TABLE Students
	ADD COLUMN status VARCHAR(20) DEFAULT 'active';

ALTER TABLE Students
	ADD CONSTRAINT chk_status CHECK (status IN ('active','inactive','graduated'));
```

---

## lab5.sql

```sql
-- lab5.sql
-- DBMS Lab 5: Indexing and query plans (examples)
-- Author: Your Name
-- Date: 2026-06-10

-- Create indexes to speed up common lookups
CREATE INDEX IF NOT EXISTS idx_students_email ON Students(email);
CREATE INDEX IF NOT EXISTS idx_enrollments_student ON Enrollments(student_id);
CREATE INDEX IF NOT EXISTS idx_enrollments_course ON Enrollments(course_id);

-- Example query to check explain plan (DB-specific command, e.g., EXPLAIN ANALYZE)
-- EXPLAIN ANALYZE SELECT * FROM Enrollments WHERE student_id = 1;

-- Demonstrate when an index helps: SELECT using WHERE on indexed column
SELECT * FROM Students WHERE email = 'alice@example.com';
```

---

## lab6.sql

```sql
-- lab6.sql
-- DBMS Lab 6: Normalization, schema redesign, and sample migrations
-- Author: Your Name
-- Date: 2026-06-10

-- Example: split a combined name column into first/last (if legacy schema)
-- Suppose we had a legacy table LegacyStudents(name, email)
-- We would migrate like:
-- CREATE TABLE LegacyStudents (legacy_id SERIAL PRIMARY KEY, name TEXT, email TEXT);
-- INSERT INTO LegacyStudents (name,email) VALUES ('David Lee','david@example.com');

-- Migration: parse and insert into Students (simple split by space)
-- INSERT INTO Students (first_name, last_name, email)
-- SELECT split_part(name,' ',1), substring(name FROM position(' ' IN name)+1), email FROM LegacyStudents;

-- Demonstrate 3NF rationale: avoid storing derived data, keep single responsibility per table.
```

---

## lab7.sql

```sql
-- lab7.sql
-- DBMS Lab 7: Stored procedures / functions (example)
-- Author: Your Name
-- Date: 2026-06-10

-- Example function to compute student GPA (Postgres-style)
CREATE OR REPLACE FUNCTION compute_gpa(p_student_id INT)
RETURNS NUMERIC AS $$
DECLARE
	gpa NUMERIC;
BEGIN
	SELECT AVG(
		CASE
			WHEN grade IN ('A','A-') THEN 4.0
			WHEN grade = 'B' THEN 3.0
			WHEN grade = 'B-' THEN 2.7
			WHEN grade = 'C' THEN 2.0
			ELSE NULL
		END)
	INTO gpa
	FROM Enrollments
	WHERE student_id = p_student_id;
	RETURN gpa;
END;
$$ LANGUAGE plpgsql;

-- Use the function
-- SELECT compute_gpa(1);
```

---

## lab9.sql

```sql
-- lab9.sql
-- DBMS Lab 9: Backup/restore notes and sample data export queries
-- Author: Your Name
-- Date: 2026-06-10

-- Export example: generate CSV from a query (Postgres syntax)
-- COPY (SELECT s.student_id, s.first_name, s.last_name, c.code, c.title, e.grade
--       FROM Students s
--       JOIN Enrollments e USING (student_id)
--       JOIN Courses c USING (course_id)) TO '/tmp/student_courses.csv' WITH CSV HEADER;

-- Simple backup: create a snapshot table
CREATE TABLE IF NOT EXISTS Students_snapshot AS SELECT * FROM Students WHERE false;
INSERT INTO Students_snapshot SELECT * FROM Students;
```

---