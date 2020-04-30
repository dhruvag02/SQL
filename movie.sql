create database movie;
show databases;
use movie;
create table actor(acy_id int primary key,
act_name varchar(30) not null,
act_gender char(1));
desc actor;
alter table actor
rename column acy_id to act_id;
alter table actor 
modify act_gender char(1) not null;

create table director(dir_id int primary key,
dir_name varchar(30) not null,
dir_phone varchar(10) not null);
desc director;

create table movies(mov_id int primary key,
mov_title varchar(30) not null,
mov_year year not null,
mov_lang varchar(30) not null,
dir_id int,
foreign key(dir_id)references director(dir_id) on delete cascade);
desc movies;

create table movie_cast(act_id int,
mov_id int,
role varchar(30) not null,
constraint CAST_PR primary key(act_id, mov_id),
foreign key(act_id) references actor(act_id) on delete cascade,
foreign key(mov_id) references movies(mov_id) on delete cascade);
desc movie_cast;

create table rating(mov_id int primary key,
rev_stars int,
foreign key(mov_id) references movies(mov_id) on delete cascade);
desc rating;
alter table rating
modify rev_stars int  not null;

INSERT INTO ACTOR VALUES (301,'ANUSHKA','F'); 
INSERT INTO ACTOR VALUES (302,'PRABHAS','M'); 
INSERT INTO ACTOR VALUES (303,'PUNITH','M'); 
INSERT INTO ACTOR VALUES (304,'JERMY','M');
select *
from actor;


INSERT INTO DIRECTOR VALUES (60,'RAJAMOULI', 8751611001); 
INSERT INTO DIRECTOR VALUES (61,'HITCHCOCK', 7766138911); 
INSERT INTO DIRECTOR VALUES (62,'FARAN', 9986776531); 
INSERT INTO DIRECTOR VALUES (63,'STEVEN SPIELBERG', 8989776530);
select *
from director;


INSERT INTO MOVIES VALUES (1001,'BAHUBALI-2', 2017, 'TELAGU', 60); 
INSERT INTO MOVIES VALUES (1002,'BAHUBALI-1', 2015, 'TELAGU', 60); 
INSERT INTO MOVIES VALUES (1003,'AKASH', 2008, 'KANNADA', 61); 
INSERT INTO MOVIES VALUES (1004,'WAR HORSE', 2011, 'ENGLISH', 63);
select * from movies;

INSERT INTO MOVIE_CAST VALUES (301, 1002, 'HEROINE'); 
INSERT INTO MOVIE_CAST VALUES (301, 1001, 'HEROINE'); 
INSERT INTO MOVIE_CAST VALUES (303, 1003, 'HERO'); 
INSERT INTO MOVIE_CAST VALUES (303, 1002, 'GUEST'); 
INSERT INTO MOVIE_CAST VALUES (304, 1004, 'HERO');
select * 
from movie_cast;

INSERT INTO RATING VALUES (1001, 4); 
INSERT INTO RATING VALUES (1002, 2);
INSERT INTO RATING VALUES (1003, 5); 
INSERT INTO RATING VALUES (1004, 4);
select *
from rating;

# Query
select M.mov_title
from movies M, director D
where  M.dir_id=D.dir_id and D.dir_name='Hitchcock';

 select M.mov_title
 from movies M, movie_cast C
 where M.mov_id=C.mov_id
 group by C.mov_id
 having count(*)>=2;
 # Alternate
 select mov_title from movies m, movie_cast mv where m.mov_id=mv.mov_id and act_id in( select act_id from movie_cast group by act_id having count( act_id)>1) group by mov_title having count(*)>1;
 
( select A.act_id, A.act_name
 from actor A,movies M, movie_cast C
 where M.mov_id=C.mov_id and A.act_id=C.act_id and M.mov_year<'2000')
 union
 (select A.act_id,A.act_name
 from actor A,movies M,movie_cast C
 where M.mov_id=C.mov_id and A.act_id=C.act_id and M.mov_year>'2015');
 # Alternate
 select act_name from actor a join movie_cast c on a.act_id=c.act_id join movies m on c.mov_id=m.mov_id where m.mov_year not between 2000 and 2015;

# Extra query 
 select M.mov_title, count(*), max(R.rev_stars)
 from movies M,rating R,movie_cast C,actor A
 where M.mov_id=R.mov_id and M.mov_id=C.mov_id and C.act_id=A.act_id and R.rev_stars>=1
 order by M.mov_title;
 
 select M.mov_title, R.rev_stars
 from movies M,rating R
 where M.mov_id=R.mov_id and R.rev_stars>=1
 order by M.mov_title;
 # Alternate
 select mov_title ,max(rev_stars) from movies inner join rating using(mov_id) group by mov_title having max(rev_stars)>0 order by mov_title;
 
 SET SQL_SAFE_UPDATES=1;
 update rating
 set rev_stars=5
 where rating.mov_id in (select M.mov_id
						 from movies M, director D
                         where M.dir_id=D.dir_id and d.dir_name='Steven Spielberg');
select R.mov_id, R.rev_stars
from rating R, movies M, director D
where R.mov_id=M.mov_id and M.dir_id=D.dir_id and D.dir_name='Steven Spielberg';
# Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.
