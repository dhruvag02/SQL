create database faculty;
use faculty;
create table student(snum int primary key,
sname varchar(30),
major varchar(2),
lvl varchar(2),
sage int);
desc student;
insert into student values(1,'John','CS','Sr',19);
insert into student values(2,'Smith','CS','Jr',20);
insert into student values(3,'Jacob','CV','Sr',20);
insert into student values(4,'Tom','CS','Jr',20);
insert into student values(5,'Rahul','CS','Jr',20);
insert into student values(6,'Rita','CS','Sr',21);

select * from student;

create table faculty(fid int primary key,
fname varchar(30),
deptid int); 
desc faculty;

insert into faculty values(11,'harish',1000);
insert into faculty values(12,'MV',1000);
insert into faculty values(13,'Mira',1001);
insert into faculty values(14,'Shiva',1002);
insert into faculty values(15,'Nupur',1000);
select * from faculty;

create table class(cname varchar(30),
metts_at timestamp,
room varchar(30),
fid int,
primary key(cname),
foreign key(fid) references faculty(fid));
desc class;

create table enrolled(snum int,
cname varchar(30),
primary key(snum,cname),
foreign key(snum) references student(snum),
foreign key(cname) references class(cname));
desc enrolled;

insert into class values('class1','12/11/15 10:15:16','R1',14);
insert into class values('class10','12/11/15 10:15:16','R128',14);
insert into class values('class2','12/11/15 10:15:20','R2',12);
insert into class values('class3','12/11/15 10:15:25','R3',11);
insert into class values('class4','12/11/15 20:15:20','R4',14);
insert into class values('class5','12/11/15 20:15:20','R3',15);
insert into class values('class6','12/11/15 13:20:20','R2',14);
insert into class values('class7','12/11/15 10:10:10','R3',14);
select * from class;

 insert into enrolled values(1,'class1');
 insert into enrolled values(2,'class1');
 insert into enrolled values(3,'class3');
 insert into enrolled values(4,'class3');
 insert into enrolled values(5,'class4');
 insert into enrolled values(1,'class5');
 insert into enrolled values(2,'class5');
 insert into enrolled values(3,'class5');
 insert into enrolled values(4,'class5');
 insert into enrolled values(5,'class5');
 select * from enrolled;
 
 select distinct S.sname
 from student S,class C,faculty F,enrolled E
 where S.snum=E.snum and C.cname=E.cname and C.fid=F.fid and F.fname='Harish'and S.lvl='jr';
 
 select C.cname
 from class C 
 where C.room='128'or C.cname in (select E.cname
								  from enrolled E
                                  group by E.cname
                                  having count(*)>=5);
                                  #should include 'class10' in answer of above query

SELECT DISTINCT S.sname
FROM Student S
WHERE S.snum IN (SELECT E1.snum
			FROM Enrolled E1, Enrolled E2, Class C1, Class C2
			WHERE E1.snum = E2.snum AND E1.cname <> E2.cname
			AND E1.cname = C1.cname
			AND E2.cname = C2.cname AND C1.metts_at = C2.metts_at);
            
SELECT DISTINCT F.fname
FROM Faculty F
WHERE NOT EXISTS ((SELECT C.room 
				   FROM Class C )
				MINUS
				(SELECTC1.room
				FROM Class C1
				WHERE C1.fid = F.fid ));
                
                
                
SELECT DISTINCT F.fname
FROM Faculty F
WHERE 5 > (SELECT COUNT (E.snum)
FROM Class C, Enrolled E
WHERE C.cname = E.cname
AND C.fid = F.fid)


SELECT DISTINCT sname
FROM Student 
WHERE snum NOT IN (SELECT snum
				   FROM Enrolled E );
                   
			
SELECT S.age, S.lvl
FROM Student S
GROUP BY S.age, S.lvl
HAVING S.lvl IN (SELECT S1.lvl FROM Student S1
      WHERE S1.age = S.age
GROUP BY S1.lvl, S1.age
HAVING COUNT (*) >= ALL (SELECT COUNT (*)
FROM Student S2
WHERE s1.age = S2.age
GROUP BY S2.lvl, S2.age));