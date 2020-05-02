create database book;
show databases;
use book;
create table book(book_id int primary key,
title varchar(10) not null,
pub_year year not null,
publisher_name varchar(20) not null);
alter table book
add constraint BOOK_FK foreign key(publisher_name) references publisher(publisher_name) on delete cascade on update cascade;
alter table book
modify pub_year date;
desc book;

create table book_author(book_id int,
author_name varchar(20),
constraint AUTHOR_PR primary key(book_id,author_name),
foreign key(book_id) references book(book_id) on delete cascade on update cascade);
desc book_author;

create table publisher(publisher_name varchar(20) primary key,
phone_no varchar(10) not null,
address varchar(20) not null);

create table book_copies(book_id int,
branch_id int ,
no_of_copies int not null,
constraint COPIES_PR primary key(book_id,branch_id),
foreign key(book_id) references book(book_id) on delete cascade on update cascade);
alter table book_copies
add constraint COPIES_FK foreign key(branch_id) references library_branch(branch_id) on delete cascade on update cascade;
desc book_copies;

create table book_lending(book_id int ,
branch_id int,
card_no int,
date_out datetime not null,
due_date datetime not null,
constraint LEND_PR primary key(book_id,branch_id,card_no),
foreign key(book_id) references book(book_id) on delete cascade on update cascade);
alter table book_lending
add constraint LEND_FK foreign key(branch_id) references library_branch(branch_id) on delete cascade on update cascade;
desc book_lending;

create table library_branch(branch_id int primary key,
address varchar(20) not null,
branch_name varchar(20) not null);
desc library_branch;

INSERT INTO PUBLISHER VALUES ('MCGRAW-HILL', '9989076587', 'BANGALORE'); 
INSERT INTO PUBLISHER VALUES ('PEARSON', '9889076565', 'NEWDELHI'); 
INSERT INTO PUBLISHER VALUES ('RANDOM HOUSE', '7455679345', 'HYDRABAD'); 
INSERT INTO PUBLISHER VALUES ('HACHETTE LIVRE', '8970862340', 'CHENAI'); 
INSERT INTO PUBLISHER VALUES ('GRUPO PLANETA', '7756120238', 'BANGALORE'); 
select *
from publisher;

INSERT INTO BOOK VALUES (1,'DBMS','2017-01-01', 'MCGRAW-HILL'); 
INSERT INTO BOOK VALUES (2,'ADBMS','2016-06-01', 'MCGRAW-HILL'); 
INSERT INTO BOOK VALUES (3,'CN','2016-09-01', 'PEARSON'); 
INSERT INTO BOOK VALUES (4,'CG','2015-09-01', 'GRUPO PLANETA'); 
INSERT INTO BOOK VALUES (5,'OS','2016-05-01', 'PEARSON'); 
select *
from book;

INSERT INTO BOOK_AUTHOR VALUES (1,'NAVATHE'); 
INSERT INTO BOOK_AUTHOR VALUES (2,'NAVATHE'); 
INSERT INTO BOOK_AUTHOR VALUES (3,'TANENBAUM'); 
INSERT INTO BOOK_AUTHOR VALUES (4,'EDWARD ANGEL'); 
INSERT INTO BOOK_AUTHOR VALUES (5,'EDWARD ANGEL');
select *
from book_author;

INSERT INTO LIBRARY_BRANCH VALUES (10,'RR NAGAR','BANGALORE'); 
INSERT INTO LIBRARY_BRANCH VALUES (11,'RNSIT','BANGALORE'); 
INSERT INTO LIBRARY_BRANCH VALUES (12,'RAJAJI NAGAR', 'BANGALORE'); 
INSERT INTO LIBRARY_BRANCH VALUES (13,'NITTE','MANGALORE'); 
INSERT INTO LIBRARY_BRANCH VALUES (14,'MANIPAL','UDUPI'); 
select *
from library_branch;

INSERT INTO BOOK_COPIES VALUES (1, 10, 10); 
INSERT INTO BOOK_COPIES VALUES (1, 11,5); 
INSERT INTO BOOK_COPIES VALUES (2, 12,2); 
INSERT INTO BOOK_COPIES VALUES (2, 13,5); 
INSERT INTO BOOK_COPIES VALUES (3, 14,7); 
INSERT INTO BOOK_COPIES VALUES (5, 10,1); 
INSERT INTO BOOK_COPIES VALUES (4, 11,3);
select *
from book_copies; 


INSERT INTO BOOK_LENDING VALUES (1, 10, 101,'01-01-17','01-06-17'); 
INSERT INTO BOOK_LENDING VALUES (3, 14, 101,'11-01-17','11-03-17'); 
INSERT INTO BOOK_LENDING VALUES (2, 13, 101,'21-02-17','21-04-17'); 
INSERT INTO BOOK_LENDING VALUES (4, 11, 101,'15-03-17','15-07-17'); 
INSERT INTO BOOK_LENDING VALUES (1, 11, 104,'12-04-17','12-05-17'); 
select *
from book_lending;

select B.book_id, B.title, B.publisher_name, A.author_name, C.no_of_copies, R.branch_name
from book B, book_author A, book_copies C, library_branch R
where B.book_id=A.book_id and B.book_id=C.book_id and C.branch_id=R.branch_id;

select card_no
from book_lending 
where date_out >='2001-01-17 00:00:00' and date_out<='2001-06-17 00:00:00'
group by card_no
having count(*)>3; 

delete from book
where book_id=5;
# Already all foreign key are set with cascade constraint

create view BOOK_PART(book_id, title, publisher_year) as
select book_id, title,pub_year
from book
group by pub_year;
select *
from BOOK_PART;

create view BOOK_COPY(book_id,title,number_of_copies, library_branch) as
select B.book_id,B.title,C.no_of_copies, C.branch_id
from book B,book_copies C,library_branch R
where B.book_id=C.book_id and C.branch_id=R.branch_id;
select *
from BOOK_COPY;