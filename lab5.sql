show databases;
use employees;
select * from employees;
select count(*) from employees;
select * from employees limit 100;
select  first_name from employees where first_name like 'R%' limit 100;
select e.emp_no, e.first_name, s.salary as current_salary, s.salary*0.1 as increased_salary
from employees as e natural join salaries as s limit 100;
select concat(e.first_name,' ',e.last_name) as emp_name, s.salary*12 as annual_salary 
from employees as e natural join salaries as s limit 100;
select concat(e.first_name,' ',e.last_name) as emp_name
from employees as e natural join salaries as s  where s.salary/2 > 30000 limit 100;
select emp_no,concat(first_name,' ',last_name) as emp_name, hire_date from employees 
where year(hire_date)>=1995 and gender='M'; 
select emp_no,concat(first_name,' ',last_name) as emp_name, hire_date from employees 
where year(hire_date)<=1990 or gender='F'; 
select concat(first_name,' ',last_name) as emp_name from employees 
where  gender<>'F'; 
select concat(e.first_name,' ',e.last_name) as emp_name
from employees as e natural join salaries as s  where s.salary>6000 limit 100;
select emp_no,concat(first_name,' ',last_name) as emp_name, hire_date from employees 
where hire_date<='1992-12-31';
select concat(e.first_name,' ',e.last_name) as emp_name 
from employees as e natural join departments as d
where dept_no='d001' or dept_no='d002' limit 100;
select concat(e.first_name,' ',e.last_name) as emp_name, s.salary 
from employees as e natural join salaries as s
where s.salary between 50000 and 80000 limit 100;
select concat(e.first_name,' ',e.last_name) as currently_working_emp_name 
from employees as e natural join salaries as s where s.to_date='9999-01-01' limit 100;
select concat(first_name,' ',last_name) as emp_name from employees 
where first_name like 'A%' limit 100;
select concat(first_name,' ',last_name) as emp_name from employees 
where last_name like '%son' limit 100;
select concat(first_name,' ',last_name) as emp_name from employees 
where first_name like '%an%' limit 100;
select concat(first_name,' ',last_name) as emp_name from employees 
where first_name like '_____' limit 100;
select concat(first_name,' ',last_name) as emp_name from employees 
where first_name like '_____%' limit 100;
select concat(first_name,' ',last_name) as emp_name from employees 
where first_name not like 'Ba%' limit 100;
select avg(salary) as average_salary from salaries;
select max(salary) as highest_salary from salaries;
select min(salary) as lowest_salary from salaries;
select * from departments;
select sum(s.salary) as total_amount_of_salary from departments
 natural join salaries as s where dept_no = 'd008';

