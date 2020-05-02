create database Oorder;
show databases;
use Oorder;
create table salesman(salesman_id int primary key,
s_name varchar(20) not null,
city varchar(20),
commission decimal(3,2));
desc salesman;

create table customer(customer_id int primary key,
cust_name varchar(20) not null,
cust_city varchar(20),
grade int,
salesman_id int,
foreign key(salesman_id) references salesman(salesman_id) on delete cascade on update cascade);
desc customer;

create table orders(order_no int primary key,
purchase_amt real,
order_date date,
customer_id int,
salesman_id int,
foreign key(customer_id) references customer(customer_id),
foreign key(salesman_id) references salesman(salesman_id));
desc orders;
alter table orders
modify purchase_amt real;

insert into salesman values(1000,'John', 'Bangalore',0.25);
insert into salesman values(2000, 'Ravi', 'Bangalore',0.20),(3000, 'Kumar', 'Mysore', '0.15'),(4000, 'Smith', 'Delhi', 0.30),(5000, 'Harsha', 'Hyderabad',0.15);
select *
from salesman;

insert into customer values(10, 'Preethi', 'Bangalore', 100, 1000);
insert into customer values(11, 'Vivek', 'Mangalore',300, 1000),(12, 'Bhaskar', 'Chennai',400,2000),(13,'Chethan', 'Bangalore', 200, 2000),(14, 'Mamatha', 'Bangalore',400,3000);
insert into customer values(15, 'Bhagat', 'Raipur', 200, NULL);
select * from customer;

insert into orders values(50, 5000,'2017-05-04',10,1000);
insert into orders values(51,4500,'2017-06-20',10,2000),(52, 1000,'2017-02-24',13,2000),(53,3500,'2017-04-13',14,3000),(54,5500,'2017-03-09',12,2000);
select * from orders;

# Query
select count(*)
from customer
where grade>(select avg(grade)
			from customer
            where cust_city='Bangalore');
            
select S.s_name, S.salesman_id ,count(*)
from salesman S, customer C
where S.salesman_id=C.salesman_id   
group by C.salesman_id
having count(*)>1;         

(select S.salesman_id, S.s_name, S.city, S.commission
from salesman S, customer C
where s.salesman_id=C.salesman_id)
union
(select S.salesman_id, S.s_name, S.city, S.commission
from salesman S
where S.salesman_id not in(select C.salesman_id
						   from customer C));
                           
create view HIGH_ORD(name, id,city, customers) as
select S.s_name, S.salesman_id,S.city, O.customer_id
from salesman S,customer C, orders O
where S.salesman_id=C.salesman_id and S.salesman_id=O.salesman_id and C.customer_id=O.customer_id
group by O.order_date
having max(O.customer_id);

delete from salesman 
where salesman_id=1000;
ALTER TABLE ORDERS
ADD CONSTRAINT ON_DEL foreign key(salesman_id) references salesman(salesman_id) on DELETE CASCADE;
ALTER TABLE ORDERS
ADD CONSTRAINT ON_DELE foreign key(customer_id) references customer(customer_id) on DELETE CASCADE;  
