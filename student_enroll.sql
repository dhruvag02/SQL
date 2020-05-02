create database student_enroll;
show databases;
use student_enroll;
create table student(regno varchar(20) primary key,
name varchar(20) not null,
major varchar(20) not null,
bdate date not null);
desc student;

create table course(courseno int primary key,
cname varchar(20) not null,
dept varchar(20) not null);
desc course;

create table enroll(regno varchar(20),
courseno int,
sem int not null,
marks int  not null,
constraint ENROLL_PK primary key(regno,courseno),
foreign key(regno) references student(regno) on delete cascade on update cascade,
foreign key(courseno)references course(courseno) on delete cascade on update cascade);
desc enroll;

create table text(book_isbn int primary key,
book_title varchar(20) not null,
publisher varchar(20) not null,
author varchar(20) not null);
desc text;

create table book_adoption(courseno int,
book_isbn int,
sem int not null,
constraint ADOPT_PK primary key(courseno,book_isbn),
foreign key(courseno) references course(courseno) on delete cascade on update cascade,
foreign key(book_isbn) references text(book_isbn) on delete cascade on update cascade);
desc book_adoption;



INSERT INTO student VALUES('1pe11cs002','b','sr','1993-09-24'),
						  ('1pe11cs003','c','sr','1993-11-27'),
						  ('1pe11cs004','d','sr','1993-04-13'),
						  ('1pe11cs005','e','jr','1994-08-24');
INSERT INTO student VALUES('1pe11cs001','a','jr','1994-07-20');
select *
from student;


INSERT INTO course VALUES (111,'OS','CSE'),
						  (112,'EC','CSE'),
						  (113,'SS','ISE'),
						  (114,'DBMS','CSE'),
						  (115,'SIGNALS','ECE');
select *
from course;


INSERT INTO text VALUES (10,'DATABASE SYSTEMS','PEARSON','SCHIELD'),
					    (900,'OPERATING SYS','PEARSON','LELAND'),
					    (901,'CIRCUITS','HALL INDIA','BOB'),
						(902,'SYSTEM SOFTWARE','PETERSON','JACOB'),
						(903,'SCHEDULING','PEARSON','PATIL'),
						(904,'DATABASE SYSTEMS','PEARSON','JACOB'),
						(905,'DATABASE MANAGER','PEARSON','BOB'),
						(906,'SIGNALS','HALL INDIA','SUMIT');
select *
from text;

INSERT INTO enroll VALUES ('1pe11cs001',115,3,100),
     ('1pe11cs002',114,5,100),
     ('1pe11cs003',113,5,100),
     ('1pe11cs004',111,5,100),
     ('1pe11cs005',112,3,100);
     select *
     from enroll;
     
INSERT INTO book_adoption VALUES
(111,900,5),
(111,903,5),
(111,904,5),
(112,901,3),
(113,10,3),
(114,905,5),
(113,902,5),
(115,906,3);
select *
from book_adoption;
 
# Query
select T.book_isbn, T.book_title, C.courseno
from text T, book_adoption B,course C 
where T.book_isbn=B.book_isbn and B.courseno=C.courseno and C.dept='CSE'
 group by C.courseno
 having count(B.courseno)>2;
 # Alternate
 SELECT c.courseno,t.book_isbn,t.book_title
     FROM course c,book_adoption ba,text t
     WHERE c.courseno=ba.courseno
     AND ba.book_isbn=t.book_isbn
     AND c.dept='CSE'
     AND 2<(
     SELECT COUNT(book_isbn)
     FROM book_adoption b
     WHERE c.courseno=b.courseno)
     ORDER BY t.book_title;
     
	
SELECT DISTINCT c.dept
     FROM course c
     WHERE c.dept IN
     ( SELECT c.dept
     FROM course c,book_adoption b,text t
     WHERE c.courseno=b.courseno
     AND t.book_isbn=b.book_isbn
     AND t.publisher='PEARSON')
     AND c.dept NOT IN
     (SELECT c.dept
     FROM course c,book_adoption b,text t
     WHERE c.courseno=b.courseno
     AND t.book_isbn=b.book_isbn
     AND t.publisher <> 'PEARSON');