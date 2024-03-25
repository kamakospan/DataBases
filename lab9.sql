create database lab9;

-- Write a stored procedure named increase_value that takes one integer parameter and returns the parameter value increased by 10.

create or replace function increase_value (in value_parameter int)
returns int as
$$
    BEGIN
    return value_parameter + 10;
    END;
$$ LANGUAGE plpgsql;
select increase_value(17);

-- Create a stored procedure compare_numbers that takes two integers and returns 'Greater', 'Equal', or ‘Lesser' as an out parameter, depending on the comparison result of these two numbers.

create or replace function compare (in num1 int, num2 int, out result varchar)
returns varchar as
$$
    BEGIN
        if num1 > num2 then
            result := 'num1 greater';
        elsif num1 < num2 then
            result:= 'num1 lesser';
        else
            result := 'equal';
        end if;
    END;
$$ language plpgsql;

select compare(9, 4);
-- Write a stored procedure number_series that takes an integer n and returns a series from 1 to n. Use a looping construct within the procedure.

create or replace function series (in n int)
returns table (num int) as
$$
    begin
        for i in 1..n loop
        return query select i;
end loop;
    end;
$$ language plpgsql;

select series(9);
-- Write a stored procedure find_employee that takes an employee name as a parameter and returns the employee details by performing a query.
create table employee (
    name varchar,
    dept varchar,
    age int,
    salary int
);

drop table employee;
truncate table employee;

insert into employee(name, dept, age, salary) values('Zhansik', 'Math', 18, 200);
insert into employee(name, dept, age, salary) VALUES ('Uldash', 'CS', 18, 200);
insert into employee(name, dept, age, salary) VALUES ('Zhuzik', 'Bio', 22, 500);

delete from employee where name = 'Zhuzik';

create or replace function find_employee (in employee_name varchar)
returns table (emp_name varchar, emp_dept varchar, emp_age int) as
$$
BEGIN
    return query select name, dept, age from employee where name = employee_name;
end;

$$ language plpgsql;

drop function find_employee(employee_name varchar);

select find_employee('Zhuzik');

-- Develop a stored procedure list_products that returns a table with product details from a given category.

create table products (
    prod_name varchar,
    prod_country varchar,
    prod_year int,
    prod_company varchar,
    prod_category varchar
);

insert into products(prod_name, prod_country, prod_year, prod_company, prod_category) VALUES ('bounty', 'kz', 2000, 'bountycompany', 'chocolate');
insert into products(prod_name, prod_country, prod_year, prod_company, prod_category) VALUES ('glasses', 'usa', 1980, 'rayban', 'accessories');
insert into products(prod_name, prod_country, prod_year, prod_company, prod_category) VALUES ('twix', 'kz', 1670, 'twixcomp', 'chocolate');

create or replace function list_products (in category varchar)
returns table (name varchar, country varchar, year int, company varchar, categoryprod varchar) as
$$
begin
    return query select prod_name, prod_country, prod_year, prod_company, prod_category from products where prod_category = category;
end;

$$ language plpgsql;

select list_products('chocolate');

-- Create two stored procedures where the first procedure calls the second one.
-- For example, a procedure calculate_bonus that calculates a bonus, and another procedure update_salary that uses calculate_bonus to update the salary of an employee.

create or replace function calculate_bonus (in employee_name varchar)
returns int as
$$
    declare bonus int;
    BEGIN
        select salary * 0.05 into bonus from employee where name = employee_name;
        return bonus;
    end;
$$ language plpgsql;

select calculate_bonus('Zhuzik');

create or replace function update_salary (in employee_name varchar)
returns void as
$$
    declare bonus int;
    begin
        bonus := calculate_bonus(employee_name);
        update employee set salary = salary + bonus where name = employee_name;
    end;
    $$ language plpgsql;

select update_salary('Zhuzik');
select salary, name from employee where name = 'Zhuzik';

-- Write a stored procedure named complex_calculation.The procedure should accept multiple parameters of various types (e.g., INTEGER, VARCHAR).
-- The main block should include at least two nested subblocks.•Each subblock should perform a distinct operation (e.g., a string manipulation and a numeric computation).
-- The main block should then combine results from these subblocks in some way.
-- Return a final result that depends on both subblocks' outputs.
-- Use labels to differentiate the main block and subblocks.

create or replace function complex_calculation (in param1 int, param2 varchar)
returns varchar as
$$
    declare
        result1 varchar;
        result2 int;
        fin_res varchar;
    BEGIN
        <<string_manipulation>>
        begin
            result1 := 'Result of string mainpulation' || ' ' || param2;
        end string_manipulation;

        <<numeric_computation>>
        begin
            result2 := param1 * 3;
        end numeric_computation;

        fin_res = result1 || ' ' || result2::varchar;
        return fin_res;
    end;
    $$ language plpgsql;

select complex_calculation(9, '78');

--lab 10

