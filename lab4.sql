CREATE DATABASE labsheet4;
USE labsheet4;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    email VARCHAR(50),
    salary DECIMAL(10,2),
    join_date DATE,
    login_time DATETIME
);

INSERT INTO employees VALUES
(1, 'Ramesh', 'Prajapati', 'ramesh@gmail.com', 45000.50, '2022-01-15', '2022-01-15 09:15:30'),
(2, 'Sita', 'Shrestha', 'sita@company.com', 38000.00, '2021-07-10', '2021-07-10 10:05:20'),
(3, 'Hari', 'Thapa', 'hari@yahoo.com', 52000.75, '2020-03-22', '2020-03-22 08:55:10'),
(4, 'Gita', 'Koirala', 'gita@outlook.com', 60000.00, '2019-11-01', '2019-11-01 09:45:00');

select concat(first_name,' ',last_name) as full_name from employees;
select upper(first_name),lower(last_name) from employees;
select length(email) as email_length from employees;
select substring(email,1,5) from employees;
select locate('@',email) as position from employees;
select replace(email,'gmail.com','company.com') as new_email from employees;
select *from employees;
update employees set first_name=' Ramesh' where emp_id=1;
select trim(first_name) as trimmed_first_name from employees;
select round(salary) as round_figure from employees;
select round(salary,1) from employees;
select ceiling(salary) from employees;
select floor(salary) from employees;
select first_name, salary*12 as annual_salary from employees;
select abs(-1500) as absolute_value from dual;
select power(35,3) as volume from dual;
select curdate() from dual;
select curtime() from dual;
select now();
select year(curdate())-year(join_date) as joining_year from employees;
select month(curdate())-month(join_date) as joining_month from employees;
select day(curdate())-day(join_date) as joining_day from employees;
select datediff(curdate(),join_date) as experience from employees; 

