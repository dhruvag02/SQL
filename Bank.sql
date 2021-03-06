show databases;
create  database bank;
use bank;
create table branch(br_name varchar(30),
br_city varchar(30),assets real,primary key(br_name));

create table bankaccount(accno int,
br_name varchar(30),bal real,primary key(accno,br_name),
foreign key(br_name) references branch(br_name));

create table bankcustomer(cust_name varchar(30),
cust_street varchar(30),cust_city varchar(30),primary key(cust_name));

create table depositer(cust_name varchar(30),accno int,primary key(cust_name,accno),
foreign key(cust_name) references bankcustomer(cust_name),
foreign key(accno) references bankaccount(accno));

create table loan(loan_no int,
br_name varchar(30),amount real,primary key(loan_no,br_name),
foreign key(br_name) references branch(br_name));

show tables;
 
insert into branch values("SBI-Chamrajpet","Bangalore",50000);
insert into branch values("SBI-ResidencyRoad","Bangalore",10000);
insert into branch values("SBI-ShivajiRoad","Bombay",20000);
insert into branch values("SBI-parliamentRoad","Delhi",10000);
insert into branch values("SBI-Jantarmantar","Delhi",20000);
select *
from branch;

insert into bankaccount values(1,"SBI-Chamrajpet",2000);
insert into bankaccount values(2,"SBI-ResidencyRoad",5000);
insert into bankaccount values(3,"SBI-ShivajiRoad",6000);
insert into bankaccount values(4,"SBI-parliamentRoad",9000);
insert into bankaccount values(5,"SBI-Jantarmantar",8000);
insert into bankaccount values(6,"SBI-ShivajiRoad",4000);
insert into bankaccount values(8,"SBI-ResidencyRoad",4000);
insert into bankaccount values(9,"SBI-parliamentRoad",3000);
insert into bankaccount values(10,"SBI-ResidencyRoad",5000);
insert into bankaccount values(11,"SBI-Jantarmantar",2000);
select *
from bankaccount;

insert into bankcustomer values("Avinash","BULL_TEMPLE_ROAD","Bangalore");
insert into bankcustomer values("Dinesh","Bannergatta_ROAD","Bangalore");
insert into bankcustomer values("Mohan","NationalColege_ROAD","Bangalore");
insert into bankcustomer values("Nikil","Akbar_Road","Delhi");
insert into bankcustomer values("Ravi","PrithviRaj_ROAD","Delhi");

insert into depositer values("Avinash",1);
insert into depositer values("Dinesh",2);
insert into depositer values("Nikil",4);
insert into depositer values("Ravi",5);
insert into depositer values("Avinash",8);
insert into depositer values("Nikil",9);
insert into depositer values("Dinesh",10);
insert into depositer values("Nikil",11);

insert into loan values(1,"SBI-Chamrajpet",1000);
insert into loan values(2,"SBI-ResidencyRoad",2000);
insert into loan values(3,"SBI-ShivajiRoad",3000);
insert into loan values(4,"SBI-parliamentRoad",4000);
insert into loan values(5,"SBI-Jantarmantar",5000);
                                       
# Query
select D.*
from branch B, bankaccount A, depositer D
where A.accno=D.accno and A.branchname=B.branchname and A.branchname='SBI-RESIDENCYROAD'
group by D.customername
having count(D.accno)>=2;
# Alternate
select C.customername
from bankcustomer C
where exists(select D.customername, count(D.customername)
			 from depositer D, bankaccount A
             where D.accno=A.accno and C.customername=D.customername and A.branchname='SBI-RESIDENCYROAD'
             group by D.customername
             having count(D.customername)>=2);
             
create view MAX_LOAN1(branchname, amount)as
select branchname, sum(amount)
from loan
group by branchname;
select *
from MAX_LOAN1;
drop view MAX_LOAN1;

select BC.customername
from bankcustomer BC
where not exists(select branchname from branch where branchcity='Delhi' not in(
select BA.branchname from depositer D, bankaccount BA where D.accno=BA.accno and BC.customername=D.customername));
                  
select D.customername 
from depositer D, bankaccount A
where D.accno=A.accno and A.branchname='SBI-ResidencyRoad'
group by D.customername
having count(D.accno)>=2;

select branchname, branchcity, 1.05*assests as newassets
from branch;

(select C.customername
from bankcustomer C
where C.customername in(select D.customername
						from depositer D))
union
(select D.customername
from depositer D,bankaccount A,branch B
where D.accno=A.accno and A.branchname=B.branchname and B.branchname in(select L.branchname
																		from loan L)); 
                                                                        
select distinct(C.customername)
from bankcustomer C
where not exists(select branchname
				 from branch 
                 where branchcity='Delhi' and branchname not in
                 (select A.branchname
						from bankaccount A, depositer D
                        where A.accno=D.accno and C.customername=D.customername));
                        
(select C.customername
from bankcustomer C)
union
(select B.customername
from borrower B);                  
