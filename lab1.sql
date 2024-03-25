--
create database lab1;

create table students(
    id serial not null primary key,
    firstname varchar(50),
    lastname varchar(50)
);

select * from students;

insert into students (firstname, lastname)
values ('Angelina', 'Jolie');

insert into students (firstname, lastname)
values ('Eminem', 'Eminem');

truncate table students; -- clears the whole table

alter table students
add column isadmin int;

alter table students
alter column isadmin type boolean
USING isadmin::boolean;

alter table students
alter isadmin set default false;

/* alter table students
add constraint pk_students_id primary key (id); */

create table tasks(
    id serial not null primary key,
    name varchar(50),
    user_id int
);
drop table students;
drop table tasks;

drop database lab1;




















create table student1(
    id int not null primary key,
    firstname varchar(50)
);

alter table student1
add column age int ;



