show databases;
use insurance;
show tables;
create table person(driver_id varchar(20),
name1 varchar(25),address varchar(30),primary key(driver_id));

create table car(reg_num varchar(10),
model varchar(10),year1 int,primary key(reg_num));

create table accident(report_num varchar(10),accident_date varchar(10),
location varchar(20),primary key(report_num));

create table owns(driver_id varchar(20),reg_num varchar(10),primary key(driver_id,reg_num),
foreign key(driver_id) references person(driver_id),foreign key(reg_num) references car(reg_num));

create table participated(driver_id varchar(20),reg_num varchar(10),report_num varchar(10),
damage_amount int,primary key(driver_id,reg_num,report_num),
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num),foreign key(report_num) references accident(report_num));
show tables;

insert into person values("A01", "Richard", "Srinivas nagar");
insert into person values("A02", "Pradeep", "Rajaji nagar" );
insert into person values("A03", "Smith", "Ashok nagar" );
insert into person values("A04", "Vema", "N R Colony" );
insert into person values("A05", "Jhon", "Hanumanth nagar" );

insert into car values("KA052250", "Indica", 1990);
insert into car values("KA031181", "Lancer", 1957);
insert into car values("KA095477", "Toyota", 1998);
insert into car values("KA053408", "Honda", 2008);
insert into car values("KA041702", "Audi", 2005);

insert into accident values("11","1-Jan-03","Mysore");
insert into accident values("12","2-Feb-04","SouthEnd");
insert into accident values("13","3-Jan-03","Bull Temple");
insert into accident values("14","4-Feb-08","Mysore");
insert into accident values("15","5-Mar-05","Kanakpura");

insert into owns values("A01","KA052250");
insert into owns values("A02","KA031181");
insert into owns values("A03","KA095477");
insert into owns values("A04","KA053408");
insert into owns values("A05","KA041702");

insert into participated values("A01","KA052250","11",1000);
insert into participated values("A02","KA031181","12",5000);
insert into participated values("A03","KA095477","13",2500);
insert into participated values("A04","KA053408","14",300);
insert into participated values("A05","KA041702","15",5000);
select * from person;
select * from car ;
select * from accident;
select * from owns;
select * from participated;
update participated set damage_amount=25000 where reg_num="KA053408" AND report_num="14";
select * from participated;
insert into accident values("16","04-Apr-05","Kanakpura");
select count(distinct "A01") from participated,accident where participated.report_num=accident.report_num and accident_date like '%08';
select count(participated.report_num) as count from participated,car where participated.reg_num=car.reg_num and car.model="Honda";
