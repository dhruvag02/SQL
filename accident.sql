show databases;
create database insurance;
show databases;
use insurance;
create table person(driver_id varchar(20),name1 varchar(10),address varchar(20),
primary key(driver_id));
create table car(reg_num varchar(10),model varchar(10),year1 int,primary key(reg_num));
create table accident(report_num int,accident_date varchar(10),location varchar(10),
primary key(report_num));
create table owns(driver_id varchar(20),reg_num varchar(10),primary key(driver_id,reg_num),
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num));
create table participated(driver_id varchar(20),reg_num varchar(10),report_num int,damage_amount int,
primary key(driver_id,reg_num,report_num),foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num),
foreign key(report_num) references accident(report_num));
show tables;
select * from person;



insert into person values("A01","Richard","Srinivas Nagar");
insert into person values("A02","Pradeep","Rajaji Nagar");
insert into person values("A03","Smith","Ashok Nagar");
insert into person values("A04","Venu","NR Colony");
insert into person values("A05","Jhon","Hanumanth Nagar");


insert into car values("KA052250","Indica",1990);
insert into car values("KA031181","Lancer",1957);
insert into car values("KA095477","Toyota",1998);
insert into car values("KA053408","Honda",2008);
insert into car values("KA041702","Audi",2005);

insert into accident values(11,"01-01-03","Mysore");
insert into accident values(12,"02-02-04","SouthEnd");
insert into accident values(13,"21-01-03","BullTemple");
insert into accident values(14,"17-02-08","Mysore");
insert into accident values(15,"04-03-05","Kanakpura");
select * from accident;


insert into owns values("A01","KA052250");
insert into owns values("A02","KA053408");
insert into owns values("A03","KA031181");
insert into owns values("A04","KA095477");
insert into owns values("A05","KA041702");
select * from owns;


insert into participated values("A01","KA052250",11,10000);
insert into participated values("A02","KA053408",12,50000);
insert into participated values("A03","KA031181",13,25000);
insert into participated values("A04","KA095477",14,3000);
insert into participated values("A05","KA041702",15,5000);
select * from participated;

update participated set damage_amount=25000 where reg_num="KA053408" AND report_num="12";
select damage_amount from participated where reg_num="KA053408";
OUTPUT
'25000'
select * from participated;
                                            

select count(distinct "A01") from participated,
accident where participated.report_num=accident.report_num and accident_date like '%08';
                                            OUTPUT
                                            1
select count(participated.report_num) as count from participated,
car where participated.reg_num=car.reg_num and car.model="Honda";
                                            OUTPUT
                                            1
# Delete the tuple whose damage amount is less than average damage amount
delete from participated
where damage_amount<(select avg(damage_amount)
					 from participated);
# List the name of drivers whose damage amount is greater than average damage amount                                            
select A.name1
from person A,participated B
where A.driver_id=B.driver_id and damage_amount>(select avg(damage_amount)
												 from participated);
                                            OUTPUT
                                            Pradeep
                                            Smith
