create database lab6;

create table locations (
    location_id serial primary key,
    street_address varchar(25),
    postal_code varchar(12),
    city varchar(30),
    state_province varchar(12)
);

create table departments(
    department_id serial primary key,
    department_name varchar(50) unique,
    budget int,
    location_id int references locations
);

create table employees (
    employee_id serial primary key,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(50),
    phone_number varchar(20),
    salary int,
    department_id int references departments
);

insert into locations(street_address, postal_code, city, state_province) VALUES ('Tole bi', 050000, 'Almaty', 'Almaty');
insert into locations (street_address, postal_code, city, state_province) values ('Baizakov', 050006, 'Almaty', 'Almaty');
insert into locations (street_address, postal_code, city, state_province) values ('Kabanbay batyr', 050012, 'Astana', 'Akmola');
insert into locations(street_address, postal_code, city, state_province) VALUES ('Nursaya', 060100, 'Atyrau', 'Atyrau');
insert into locations(street_address, postal_code, city, state_province) VALUES ('Zharylgasov', 060203, 'Kulsary', 'Atyrau');

insert into departments (department_id, department_name, budget, location_id) values (30, 'Finance', 47000000, 1);
insert into departments (department_id, department_name, budget, location_id) values (50, 'Marketing', 23000, 2);
insert into departments (department_id, department_name, budget, location_id) values (60, 'Dev', 12000, 3);
insert into departments (department_id, department_name, budget, location_id) values (70, 'Product', 34000, 4);
insert into departments (department_id, department_name, budget, location_id) values (80, 'Support', 450000, 5);

insert into employees (first_name, last_name, email, phone_number, salary) VALUES ('Nurs', 'Berikbayev', 'nurs@gmail.com', '87787787878', 1000000);
insert into employees (first_name, last_name, email, phone_number, salary, department_id) VALUES ('Aigerim', 'Mukatova', 'aigera@gmail.com', '87017017171', 1000000, 30);
insert into employees (first_name, last_name, email, phone_number, salary, department_id) VALUES ('Kaisar', 'Abdigaliev', 'kais@gmail.com', '87717717771', 1000000, 80);
insert into employees (first_name, last_name, email, phone_number, salary, department_id) VALUES ('Yerla', 'Yesmoldin', 'yerla@gmail.com', '87767767676', 1000000, 60);
insert into employees (first_name, last_name, email, phone_number, salary, department_id) VALUES ('Aidana', 'Zhaksylyk', 'aidana@gmail.com', '87087087878', 1000000, 70);

--4 Select  the  first  name,  last  name,  department  id, and department name for each employee.
SELECT
    e.first_name,
    e.last_name,
    e.department_id AS dept_id,
    d.department_name
FROM
    employees e
JOIN
    departments d ON e.department_id = d.department_id;

--5 Select  the  first  name,  last  name,  department  id  and department name, for all employees for departments 80 or 30.
select e.first_name, e.last_name, e.department_id, d.department_name from employees e
    join departments d on d.department_id = e.department_id where d.department_id = 80 or d.department_id = 30;

--6 Select the first and last name, department, city, and state province for each employee
select e.first_name, e.last_name, d.department_name, l.city, l.state_province from employees e
    join departments d on e.department_id = d.department_id join locations l on d.location_id = l.location_id;

--7 Select all departments including those where does not have any employee.
delete from employees where department_id = 30;
select d.department_id, d.department_name, d.budget, d.location_id, e.last_name, e.first_name from departments d left join employees e on d.department_id = e.department_id;

--8 Select the first name, last name, department id and name,for all employees who have or have not any department.
delete from employees where first_name = 'Nurs';
select e.first_name, e.last_name, e.department_id, d.department_name from employees e
    left join departments d on e.department_id = d.department_id;

--9 Select the employee last name, first name, who works in Almaty.
select e.last_name, e.first_name from employees e join departments d on e.department_id = d.department_id
    join locations l on d.location_id = l.location_id WHERE l.city = 'Almaty';