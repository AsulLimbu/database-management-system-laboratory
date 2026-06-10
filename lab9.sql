CREATE DATABASE companydb;
USE companydb;

CREATE TABLE employee (
    eid INT PRIMARY KEY,
    ename VARCHAR(50),
    age INT,
    dept VARCHAR(50)
);

CREATE TABLE company (
    compid INT PRIMARY KEY,
    companyname VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE works (
    eid INT,
    compid INT,
    salary DECIMAL(10,2),
    FOREIGN KEY (eid) REFERENCES employee(eid) ON CASCADE DELETE ON CASCADE UPDATE,
    FOREIGN KEY (compid) REFERENCES company(compid)
);

INSERT INTO employee (eid, ename, age, dept) VALUES
(1, 'Employee1', 25, 'IT'),
(2, 'Employee2', 28, 'HR'),
(3, 'Employee3', 30, 'Finance'),
(4, 'Employee4', 27, 'Marketing'),
(5, 'Employee5', 29, 'IT'),
(6, 'Employee6', 32, 'HR'),
(7, 'Employee7', 26, 'Finance'),
(8, 'Employee8', 31, 'Marketing'),
(9, 'Employee9', 24, 'IT'),
(10, 'Employee10', 33, 'Finance'),

(11, 'Employee11', 28, 'HR'),
(12, 'Employee12', 35, 'IT'),
(13, 'Employee13', 29, 'Marketing'),
(14, 'Employee14', 27, 'Finance'),
(15, 'Employee15', 30, 'IT'),
(16, 'Employee16', 26, 'HR'),
(17, 'Employee17', 34, 'Finance'),
(18, 'Employee18', 25, 'Marketing'),
(19, 'Employee19', 31, 'IT'),
(20, 'Employee20', 29, 'HR'),

(21, 'Employee21', 27, 'Finance'),
(22, 'Employee22', 33, 'Marketing'),
(23, 'Employee23', 24, 'IT'),
(24, 'Employee24', 36, 'Finance'),
(25, 'Employee25', 28, 'HR'),
(26, 'Employee26', 30, 'IT'),
(27, 'Employee27', 32, 'Marketing'),
(28, 'Employee28', 26, 'Finance'),
(29, 'Employee29', 29, 'IT'),
(30, 'Employee30', 35, 'HR'),

(31, 'Employee31', 27, 'Finance'),
(32, 'Employee32', 31, 'Marketing'),
(33, 'Employee33', 25, 'IT'),
(34, 'Employee34', 34, 'Finance'),
(35, 'Employee35', 28, 'HR'),
(36, 'Employee36', 30, 'IT'),
(37, 'Employee37', 26, 'Marketing'),
(38, 'Employee38', 33, 'Finance'),
(39, 'Employee39', 29, 'IT'),
(40, 'Employee40', 32, 'HR'),

(41, 'Employee41', 24, 'Finance'),
(42, 'Employee42', 35, 'Marketing'),
(43, 'Employee43', 27, 'IT'),
(44, 'Employee44', 31, 'HR'),
(45, 'Employee45', 28, 'Finance'),
(46, 'Employee46', 30, 'IT'),
(47, 'Employee47', 26, 'Marketing'),
(48, 'Employee48', 34, 'Finance'),
(49, 'Employee49', 29, 'HR'),
(50, 'Employee50', 33, 'IT');

INSERT INTO company (compid, companyname, city) VALUES
(101, 'NMB Bank', 'Kathmandu'),
(102, 'WorldLink', 'Lalitpur'),
(103, 'F1Soft', 'Kathmandu'),
(104, 'Leapfrog', 'Bhaktapur'),
(105, 'Deerwalk', 'Bhaktapur');

INSERT INTO works (eid, compid, salary) VALUES
(1,101,42000),(2,102,43000),(3,103,46000),(4,104,39000),(5,105,48000),
(6,101,51000),(7,102,40000),(8,103,53000),(9,104,37000),(10,105,56000),

(11,101,42000),(12,102,61000),(13,103,44000),(14,104,43000),(15,105,49000),
(16,101,38000),(17,102,59000),(18,103,36000),(19,104,52000),(20,105,45000),

(21,101,47000),(22,102,55000),(23,103,35000),(24,104,63000),(25,105,44000),
(26,101,50000),(27,102,53000),(28,103,41000),(29,104,48000),(30,105,62000),

(31,101,46000),(32,102,54000),(33,103,37000),(34,104,60000),(35,105,43000),
(36,101,51000),(37,102,40000),(38,103,57000),(39,104,49000),(40,105,53000),

(41,101,38000),(42,102,61000),(43,103,45000),(44,104,52000),(45,105,47000);

CREATE VIEW basic_details AS
SELECT eid, ename, age, dept FROM employee;
SELECT * FROM basic_details;
CREATE VIEW emp_IT_view AS 
SELECT eid, ename, age FROM employee 
WHERE dept = "IT";
SELECT * FROM emp_IT_view;
CREATE VIEW complex_details AS 
SELECT e.eid, e.ename, c.companyname, c.city, w.salary FROM employee AS e
JOIN works AS w ON w.eid = e.eid
JOIN company AS c ON c.compid = w.compid;
SELECT eid, ename, companyname, city, salary FROM complex_details;
CREATE VIEW avg_sal_per_dept AS 
SELECT e.dept, AVG(w.salary) AS avg_dept FROM employee AS e
JOIN works AS w ON w.eid = e.eid
GROUP BY e.dept;
SELECT * FROM avg_sal_per_dept;
SELECT ename, age FROM emp_IT_view WHERE age>25;
CREATE VIEW works_relation AS 
SELECT e.eid, e.ename,c.compid, c.companyname, c.city, w.salary FROM employee AS e
JOIN works AS w ON w.eid = e.eid
JOIN company AS c ON c.compid = w.compid;
SELECT * FROM works_relation;
UPDATE works_relation SET salary = salary+3000 WHERE compid=102;
CREATE VIEW comp_view AS 
SELECT compid, companyname, city FROM company;
SELECT * FROM comp_view;
UPDATE comp_view SET city = "Kavre" WHERE companyname = "F1Soft";
INSERT INTO comp_view VALUES (106, "Prime_Bank", "Lalitpur");
INSERT INTO basic_details VALUES (51, "Employee51", 23,"IT");
DELETE FROM basic_details WHERE age<25 AND dept = "IT";
DELETE FROM comp_view WHERE compid = 106;
DROP VIEW basic_details;
DROP VIEW works_relation;
DROP VIEW complex_details;
DROP VIEW avg_sal_per_dept;
DROP VIEW comp_view;