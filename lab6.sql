SHOW DATABASES;
USE employees;
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM salaries;
SELECT * FROM dept_emp;
SELECT * FROM titles;
SELECT gender,count(*) FROM employees GROUP BY gender;
SELECT d.dept_name, count(de.emp_no) as employee_count FROM dept_emp as de JOIN departments as d ON  de.dept_no = d.dept_no
GROUP BY d.dept_name;
SELECT d.dept_name, AVG(s.salary) FROM dept_emp as de
 JOIN salaries as s ON de.emp_no = s.emp_no
 JOIN departments as d ON d.dept_no = de.dept_no
 GROUP BY d.dept_name;
 SELECT t.title, MAX(s.salary) FROM employees as e
 JOIN titles as t ON t.emp_no = e.emp_no
 JOIN salaries as s ON e.emp_no = s.emp_no
 GROUP BY t.title;
SELECT d.dept_name, count(de.emp_no) as employee_count FROM dept_emp as de 
JOIN departments as d ON  de.dept_no = d.dept_no
GROUP BY d.dept_name HAVING COUNT(de.emp_no)>20000;
 SELECT t.title, AVG(s.salary) as average_salary FROM employees as e
 JOIN titles as t ON t.emp_no = e.emp_no
 JOIN salaries as s ON e.emp_no = s.emp_no
 GROUP BY t.title HAVING AVG(s.salary)>60000;
SELECT d.dept_name, MAX(s.salary) FROM dept_emp as de
 JOIN salaries as s ON de.emp_no = s.emp_no
 JOIN departments as d ON d.dept_no = de.dept_no
 GROUP BY d.dept_name HAVING MAX(s.salary)>100000;
 SELECT t.title, MIN(s.salary) FROM employees as e
 JOIN titles as t ON t.emp_no = e.emp_no
 JOIN salaries as s ON e.emp_no = s.emp_no
 GROUP BY t.title;
 SELECT YEAR(hire_date) as hire_year, count(*) as total_employees FROM employees GROUP BY YEAR(hire_date);
 SELECT title, count(*) FROM titles GROUP BY title;
 SELECT emp_no, first_name, last_name FROM employees
 WHERE emp_no IN (SELECT emp_no FROM salaries WHERE SALARY>(SELECT AVG(salary) FROM salaries));
SELECT emp_no, first_name, last_name FROM employees
 WHERE emp_no IN (SELECT emp_no FROM salaries WHERE SALARY=(SELECT MAX(salary) FROM salaries));
SELECT first_name, last_name FROM employees WHERE 
emp_no IN (SELECT emp_no FROM dept_manager);
SELECT first_name, last_name FROM employees WHERE 
emp_no NOT IN (SELECT emp_no FROM dept_manager);
 
