create database employee_mgmt;
show databases;
use employee_mgmt;
create table employee(
	empno int primary key,
    empname varchar(30),
    designation varchar(30),
    departid int,
    licenseno varchar(30),
    gender enum('m','f'),
    salary int
    );
create table department(
	did int primary key,
    departname varchar(30),
    departcode varchar(30),
    email varchar(30)
    );
alter table employee add constraint std foreign key (departid) references department(did) on update cascade on delete cascade;
select *from employee;
select *from department;
alter table employee add constraint emp_salary check(salary>15000);
alter table employee alter column departid set default 302;
insert into department values(301,"Information Technology","IT","it@ourmail.com"),
							 (302,"Human Resource","HR","hr@ourmail.com"),
                             (303,"Finance","FI","fi@ourmail.com"),
                             (304,"Marketing","MK","mk@ourmail.com"),
                             (305,"Sales","SL","sl@ourmail.com");
insert into employee values(5004, "Sameer Sharma","Officer",301, "323-525", "m", 38000),
    (5010, "Rakshya Acharya",   "Manager",     303, "987-321", "f", 45000),
    (5005, "Krishna Devkota",   "Officer",     301, "547-685", "m", 38000),
    (5009, "Ram Yadav",         "Salesperson", 304, "342-154", "m", 35000),
    (5003, "Sunita Chaudhary",  "Salesperson", 305, "241-654", "f", 35000);
insert into department values(306,"account","ac","as@ourmail.com");
insert into employee values(5008,"Ashul Limbu","accountant",306,"982-704",'m',40000);
update employee set departid=306 where empno=5010;
update department set did=308 where departcode="ac";
select empno,empname,departid,salary from employee;
delete from department where did=308;
create table salesman(
	s_id int primary key,
    name varchar(30),
    city varchar(30),
    email varchar(30)
    );
    drop table salesman;


