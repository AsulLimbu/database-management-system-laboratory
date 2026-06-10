show databases;
create database COLLEGE_MGMT;
use COLLEGE_MGMT;
create table STUDENT(
		crn integer(4),
        fullname varchar(30),
        address varchar(30),
        cgpa float(3),
        dob date,
        gender enum('m','f'),
        status enum("active","inative")
        );
alter table student modify status enum("active","inactive");
show tables;
select *from STUDENT;
insert into STUDENT values(1001,"Laxamn Shrestha","Pokhara",3.6,"2052-02-04",'m',"active");
insert into STUDENT values(1002,"Gita Sharma","Kathmandu",3.2,"2049-03-07",'f',"active");
insert into STUDENT values(1003,"Sita Baraili","Pokhara",2.5,"2051-10-28",'f',"active");
insert into STUDENT values(1004,"Dipendra Shahi","Kailali",3.1,"2053-09-27",'m',"active");
insert into STUDENT values(1005,"Hari Dhakal","Makwanpur",2.2,"2053-07-20",'m',"inactive");
select *from student_info;
truncate student_info;
select *from student where address="Pokhara";      
select fullname,address from student where address="Pokhara";
select *from student where gender='m' and status="active";
select *from student where cgpa>3.0;
update student SET address="Bhaktapur" WHERE crn=1001;
update student set status="active" where cgpa>3.0;
alter table student add email varchar(30);
alter table student change address district varchar(30); 
rename table student to student_info;  
alter table student_info drop district;
delete from student_info where crn=1005;
delete from student_info where status="inactive";
drop table student_info;
dROP database COLLEGE_MGMT;
