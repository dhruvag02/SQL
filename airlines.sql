create database Airlines;
use Airlines;
create table Flights(flno int primary key,
ffrom varchar(15) not null,
tto varchar(15) not null,
distance int,
departs timestamp,
arrives timestamp,
price int);
desc flights;

create table Aircraft(aid int primary key,
aname varchar(10),
cruisingrange int); 
desc aircraft;

create table Employees(eid int primary key,
ename varchar(15),
salary int);
desc employees;

create table Certified(eid int not null,
aid int not null,
constraint cerprkey primary key(eid, aid),
foreign key(eid) references employees(eid),
foreign key(aid) references aircraft(aid));
desc certified;

insert into aircraft values(101,'747', 3000),(102,'Boeing', 900),(103,'647',800),(104,'Dreamliner',10000),(105,'Boeing',3500),(106,'707',1500);
insert into aircraft values(107,'Dream',120000);
select *
from aircraft;

insert into employees values(701,'A',50000),(702,'B',100000),(703,'C',150000),(704,'D',90000),(705,'E', 40000),(706,'F',60000),(707,'G',90000);
select *
from employees;

insert into certified values(701,101),(701,102),(701,106),(701,105),(702,104),(702,107),(703,104),(703,107),(704,104),(704,107),(702,101),(703,105),(704,105),(705,103);
select *
from certified
order by eid;

insert into flights values(101,'Bangalore','Delhi',2500,'2005-05-13 07:15:31','2005-05-13 17:15:31',5000);
insert into flights values(102,'Bangalore','Lucknow',3000,'2005-05-13 07:15:31','2005-05-13 11:15:31',6000),(103,'Lucknow','Delhi',500,'2005-05-13 12:15:31','2005-05-13 17:15:31',3000),(107,'Bangalore','Frankfurt',8000,'2005-05-13 07:15:31','2005-05-13 22:15:31',60000),(104,'Bangalore','Frankfurt',8500,'2005-05-13 07:15:31','2005-05-13 23:15:31',75000),(105,'Kolkata','Delhi',3400,'2005-05-13 07:15:31','2005-05-13 09:15:31',7000);
select * from flights;

# Query
 select A.aid, A.aname
 from aircraft A
 where A.aid in(select C.aid
				from certified C, employees E
                where C.eid=E.eid and E.salary>80000);

select C.eid, A.aname, A.cruisingrange
from certified C, aircraft A
where C.aid=A.aid
group by C.eid
having count(*)>3;

select E.eid, E.ename,E.salary
from Employees E
group by E.eid
having E.salary<ALL(select min(price)
				   from flights 
                   where ffrom='Bangalore' and tto='Frankfurt');
                   

select A.aid, A.aname, avg(E.salary)
from aircraft A,certified C, employees E
where A.aid=C.aid and C.eid=E.eid and A.cruisingrange>1000
group by A.aid,A.aname;

select A.aid, A.aname
from aircraft A
where A.cruisingrange>= All(select F.distance
						from flights F
                        where ffrom='Bangalore' and tto='Frankfurt');
select distinct(E.eid), E.ename, E.salary
from employees E, certified C
where E.eid not in(select distinct C.eid from certified C) and E.salary>all(select avg(E1.salary)
																			from employees E1
																			where E1.eid in (select C.eid from certified C));