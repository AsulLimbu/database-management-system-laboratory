CREATE DATABASE IF NOT EXISTS company;
USE company;

CREATE TABLE IF NOT EXISTS manager(
	mid int(4),
    mname varchar(30),
    did int(4),
    gender enum('m','f'),
    salary float(7,2)
    );

CREATE TABLE IF NOT EXISTS employee(
	empno int(4),
    empname varchar(30),
    designation varchar(20),
    did int(4),
    gender enum('m','f'),
    salary float(7,2),
    mid int(4)
    );

CREATE TABLE IF NOT EXISTS department(
	did int(4),
    departname varchar(30),
    departcode varchar(4),
    email varchar(30)
    );
    
ALTER TABLE employee ADD PRIMARY KEY(empno);
ALTER TABLE manager ADD PRIMARY KEY(mid);
ALTER TABLE department ADD PRIMARY KEY(did);

ALTER TABLE employee ADD CONSTRAINT dept_fkey FOREIGN KEY(did) REFERENCES department(did) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE manager ADD CONSTRAINT mdept_fkey FOREIGN KEY(did)REFERENCES department(did) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE employee ADD CONSTRAINT mid_fkey FOREIGN KEY(mid) REFERENCES manager(mid) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE department ADD CONSTRAINT dcode_ukey UNIQUE KEY(departcode);

INSERT INTO department VALUES
	(301, "Information Technology", "IT","it@ourmail.com"),
    (302, "Human Resource", "HR","hr@ourmail.com"),
    (303, "Finance", "FI","fi@ourmail.com"),
    (304, "Marketing", "MK","mk@ourmail.com"),
    (305, "Sales", "SL","sl@ourmail.com");

INSERT INTO manager VALUES
	(601,"Rohit Sharma", 301, 'm', 38000),
    (603,"Geeta Chand", 303, 'f', 45000),
    (604,"Raj Shrestha", 304, 'm', 38000),
    (602,"Mukunda Ghimire", 302, 'm', 50000),
    (605,"Sushil Shah", null, 'm', 60000);

INSERT INTO employee VALUES
	(601,"Rohit Sharma","Manager", 301, 'm', 38000, 602),
    (603,"Geeta Chand", "Manager", 303, 'f', 45000, 602),
	(504,"Sameer Sharma", "Officer", 301, 'm', 38000,601),
    (510,"Rakshya Acharya", "Accountant", 303, 'f', 45000,603),
    (505,"Krishna Devkota", "Officer", 301, 'm', 38000,601),
    (509,"Ram Yadav", "Salesperson", 304, 'm', 35000,604),
    (503,"Sunita Chaudhary", "Salesperson", 305, 'f', 35000, null),
    (506,"Ashmita Lama", "Salesperson", 305, 'f', 35000, null);
    
select mid, mname, salary from manager union all select mid, empname, salary from employee;
select empname from employee union select mname from manager;
select empname from employee where gender = 'f' union all select mname from manager where gender = 'm';
select salary from employee union select salary from manager;
select * from employee cross join manager;
select * from manager natural join department;  
select e.empname, d.departname from employee as e natural join department as d;
select * from employee natural join department;
select employee.empname, manager.mname from employee natural join  manager;
select e.empname, d.departname from employee as e 
left join
department as d 
on e.did=d.did; 
select e.empname, m.mname from manager as m right join employee as e on e.mid=m.mid;
select * from department left join manager on department.did = manager.did;
select distinct(manager.mid) from manager inner join employee on manager.mid=employee.mid;
select empname from employee where mid is null;
select d.departcode, d.departname, m.mname, e.empname, e.designation from department as d natural join manager as m natural join employee as e;