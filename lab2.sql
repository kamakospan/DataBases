create database lab2;
--2
create table employees(
    emp_no serial not null primary key,
    first_name varchar(50),
    last_name varchar(50),
    hire_date date,
    birth_date date,
    gender char(1) check (gender in ('F', 'M'))
);
select * from employees;

--3
create table titles (
  title varchar(50),
  from_date date,
  to_date date,
  emp_no int,
  foreign key (emp_no) references employees(emp_no)
);

create table salaries (
    salary int not null,
    from_date date,
    to_date date,
    emp_no int,
    foreign key (emp_no) references employees(emp_no)
);

create table departments(
    dept_name varchar(50),
    dept_no char(4) primary key
);

create table dept_manager(
    dept_no char(4),
    emp_no int,
    foreign key (dept_no) references departments(dept_no),
    foreign key (emp_no) references employees(emp_no),
    from_date date,
    to_date date
);

create table dept_emp(
    dept_no char(4),
    emp_no int,
    foreign key (dept_no) references departments(dept_no),
    foreign key (emp_no) references employees(emp_no),
    from_date date,
    to_date date
);
--5
/*
 . A 'students' table storing data such as full name,
 age, birth date, gender, average grade, nationality,
 phone number, and social category.
 */
create table students(
    full_name varchar(100) primary key,
    age int,
    gender char,
    birth_date date,
    average_grade float, --for example 3.75
    nationality varchar(50),
    phone_number varchar(50),
    social_category varchar(100)
);

create table academic_status(
    stud_name varchar(50),
    status boolean,
    foreign key (stud_name) references students(full_name),
);

/*
 An 'instructors' table storing data such as
 full name, spoken languages, work experience, and the possibility of having remote lessons.
 */

create table languages(
    lang_name varchar(50) primary key
);

create table instructors(
    full_name varchar(100),
    spoken_lang varchar(100),
    foreign key (spoken_lang) references languages(lang_name),
    work_exp varchar(100),
    is_possible_remote boolean
);

/*
 A 'student_relatives' table storing data such as full name, address, phone number, and position.
 */

 create table student_relatives(
   full_name varchar(100) primary key,
   whose_relative varchar(100),
   foreign key (whose_relative) references students(full_name),
   position varchar(50),
   phone_num varchar(50),
   address varchar(100)
 );

/*
 A 'student_social_data' table storing data such as
 school, graduation date, address, region, country, GPA, and honors.
 */

 create table student_social_data(
     whose_data varchar(100),
     foreign key (whose_data) references students(full_name),
     school varchar(100),
     grad_date date,
     address varchar(50),
     region varchar(50),
     country varchar(50),
     gpa float,
     honors varchar(200)
 );

--11
insert into employees(first_name, last_name, hire_date, birth_date, gender)
values ('Zhansulu', 'Jolie', '2023-05-24', '2005-06-12', 'F');

insert into employees(first_name, last_name, hire_date, birth_date, gender)
values ('Uldana', 'Minaj', '2023-09-30', '2005-03-05', 'M'),
       ('Baha', 'Toleu', '2023-08-23', '2005-10-24', 'F'),
       ('Darkhan', 'Usen', '2023-10-23', '2005-07-08', 'M');

update employees
set last_name = 'Shakhizada'
where first_name = 'Zhansulu';

update employees set last_name = 'Shyndali',
                     gender = 'F'
                 where first_name = 'Uldana';

delete from employees
where first_name = 'Zhansulu';

drop table employees;
drop database lab2;

/*
 difference between ddl and dml?
 */

 /*
DDL (Data Definition Language):
DDL is used to define and manage the structure of database objects, such as tables, indexes, views, and schemas.
DDL statements include commands like CREATE, ALTER, DROP, and TRUNCATE.
Creating tables, altering table structures (e.g., adding columns), dropping tables, creating indexes,
and defining database schemas.
  */
create table studs(id int not null, name varchar(50));
alter table studs add column retake boolean;
create index index_name on studs(retake);
drop table studs;

/*
DML (Data Manipulation Language):
DML is used to manipulate the data stored within the database.
It allows you to insert, retrieve, update, and delete data.
DML statements include commands like SELECT, INSERT, UPDATE, and DELETE.
Retrieving records from a table, inserting new records, modifying existing records, and deleting records.
 */

select * from studs;
insert into studs(id, name) values(1, 'Uldana');
insert into studs(id, name) values(2, 'Kama');
update studs set id = 2 where name = 'Uldana';
delete from studs where name = 'Uldana';

