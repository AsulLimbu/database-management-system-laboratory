create database engineering_college;
use engineering_college;
create table department(
		dept_id int primary key,
        dept_name varchar(50) not null unique,
        block varchar(20) not null);
create table student( 
		student_id int primary key,
        name varchar(50) not null, 
        email varchar(50) unique,
        gender varchar(10),
        dob date,
        dept_id int,
        constraint fk foreign key (dept_id) references department(dept_id) on update cascade on delete cascade );
create table  course(
		course_id int primary key,
        course_name varchar(50),
        credit int check(credit>0),
        dept_id int, 
        constraint fk_course foreign key (dept_id) references department(dept_id) on update cascade on delete cascade);
desc department;
desc student;
desc course;
alter table student add column phone varchar(15);
alter table student modify column gender varchar(15);
alter table student drop column dob;
alter table department rename column block to building;

-------------------------------------------------------  part b: data insertion 
insert into department values
		(1001,'computer engineering','a'),
        (1002,'electrical engineering','b'),
        (1003,'mechanical engineering','c');

INSERT INTO student (student_id, name, email, gender, dept_id) VALUES
    (1,  'Aarav Shrestha',   'aarav.shrestha@example.com',   'Male',    1001),
    (2,  'Sita Gurung',      'sita.gurung@example.com',      'Female',  1002),
    (3,  'Rahul Rai',        'rahul.rai@example.com',        'Male',    1003),
    (4,  'Anisha Limbu',     'anisha.limbu@example.com',     'Female',  1001),
    (5,  'Bikash Khadka',    'bikash.khadka@example.com',    'Male',    1002),
    (6,  'Pratima Tamang',   'pratima.tamang@example.com',   'Female',  1003);

INSERT INTO course (course_id, course_name, credit, dept_id) VALUES
    (101, 'Operating Systems',        3, 1001),
    (102, 'Database Systems',         3, 1001),
    (201, 'Circuit Analysis',         4, 1002),
    (202, 'Power Systems I',          3, 1002),
    (301, 'Thermodynamics',           4, 1003),
    (302, 'Fluid Mechanics',          3, 1003);
insert into student(student_id,name,email) values (7,'Dipa Khanal','deepa@gmail.com');
 
 
 ---------------------------------------- part c:data retrieval
select * from student;
select name,email,phone from student;
select * from student where dept_id=1002;
select * from course where credit>3;
select * from student where email is not null;
------------------------------------------ part d:data modification
update student set phone='987654321' where student_id=5;        
update student set dept_id=1002 where student_id=3;
update course set credit=credit+1 where dept_id=1001;
------------------------------------------- part e: data deletion
delete from student where student_id=2;
delete from student where dept_id=1002;
truncate table course;
-------- part f: table&database removal
drop table course;
drop table student;
drop table department;
drop database engineering_college;
