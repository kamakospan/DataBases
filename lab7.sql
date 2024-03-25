create database lab7;

create table dealer (
    id integer primary key ,
    name varchar(255),x
    location varchar(255),
    commission float
);

INSERT INTO dealer (id, name, location, commission) VALUES (101, 'Oleg', 'Astana', 0.15);
INSERT INTO dealer (id, name, location, commission) VALUES (102, 'Amirzhan', 'Almaty', 0.13);
INSERT INTO dealer (id, name, location, commission) VALUES (105, 'Ademi', 'Taldykorgan', 0.11);
INSERT INTO dealer (id, name, location, commission) VALUES (106, 'Azamat', 'Kyzylorda', 0.14);
INSERT INTO dealer (id, name, location, commission) VALUES (107, 'Rahat', 'Satpayev', 0.13);
INSERT INTO dealer (id, name, location, commission) VALUES (103, 'Damir', 'Aktobe', 0.12);

create table client (
    id integer primary key ,
    name varchar(255),
    city varchar(255),
    priority integer,
    dealer_id integer references dealer(id)
);

INSERT INTO client (id, name, city, priority, dealer_id) VALUES (802, 'Bekzat', 'Satpayev', 100, 101);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (807, 'Aruzhan', 'Almaty', 200, 101);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (805, 'Али', 'Almaty', 200, 102);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (808, 'Yerkhan', 'Taraz', 300, 102);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (804, 'Aibek', 'Kyzylorda', 300, 106);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (809, 'Arsen', 'Taldykorgan', 100, 103);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (803, 'Alen', 'Shymkent', 200, 107);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (801, 'Zhandos', 'Astana', null, 105);

create table sell (
    id integer primary key,
    amount float,
    date timestamp,
    client_id integer references client(id),
    dealer_id integer references dealer(id)
);

INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (201, 150.5, '2021-10-05 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (209, 270.65, '2021-09-10 00:00:00.000000', 801, 105);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (202, 65.26, '2021-10-05 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (204, 110.5, '2021-08-17 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (207, 948.5, '2021-09-10 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (205, 2400.6, '2021-07-27 00:00:00.000000', 807, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (208, 5760, '2021-09-10 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (210, 1983.43, '2021-10-10 00:00:00.000000', 804, 106);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (203, 2480.4, '2021-10-10 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (212, 250.45, '2021-06-27 00:00:00.000000', 808, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (211, 75.29, '2021-08-17 00:00:00.000000', 803, 107);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (213, 3045.6, '2021-04-25 00:00:00.000000', 802, 101);

drop table client;
drop table dealer;
drop table sell;

--1
--a find those clients with a priority less than 300
select * from client where priority < 300;

--b combine each row of dealer table with each row of client table
select * from dealer cross join client;

--c find all dealers along with client name, city, priority, sell number, date, and amount
select d.id as dealer_id, d.name as dealer_name, c.name as client_name, c.city, c.priority, s.id as sale_number, s.date, s.amount from dealer d join client c on d.id = c.dealer_id join sell s on s.dealer_id = d.id and c.id = s.client_id;

--d find the dealer and client who reside in the same city
select d.name, c.name, d.location as their_city from dealer d join client c on c.city = d.location;

--e find sell id, amount, client name, city those sells where sell amount exists between 200 and 500.
select s.id as sell_id, s.amount, s.client_id, c.name, c.city from sell s join client c on s.client_id = c.id where s.amount >= 200 and s.amount <=500;

--f find dealers who work either for one or more client or not yet join under any of the clients. задание не пон
select * from dealer d left join client c on d.id = c.dealer_id;

--g find the dealers and the clients he service, return client name, city, dealer name, commission.
select c.name, d.location as their_city, d.name, d.commission from dealer d right join client c on d.id = c.dealer_id;

--h find client name, client city, dealer, commission those dealers who received a commission from the sell more than 13%
select c.name, c.city, d.name as dealer_name, d.commission from dealer d join client c on d.id = c.dealer_id where d.commission > 0.13;

--i make a report with client name, city, sell id, sell date, sell amount, dealer name and commission
-- to find that either any of the existing clients haven’t made a purchase(sell) or
-- made one or more purchase(sell) by their dealer or by own.

select c.name, c.city, s.id, s.date, s.amount, d.name, d.commission
from client c
         left join sell s on s.client_id = c.id
         join dealer d on c.dealer_id = d.id;


--j find dealers who either work for one or more clients.
-- The client may have made, either one or more purchases, or purchase
-- amount above 2000 and must have a priority, or
-- he may not have made any purchase to the associated dealer.
-- Print client name, client priority, dealer name, sell id, sell amount.

select c.name AS client_name, c.priority, d.name AS dealer_name, s.id AS sell_id, s.amount
from client c
join dealer d ON c.dealer_id = d.id
left join sell s ON c.id = s.client_id
where
    s.amount > 2000 AND c.priority IS NOT NULL OR
    s.id IS NOT NULL AND c.priority IS NOT NULL OR
    s.id IS NULL AND c.priority IS NOT NULL;
--2
--a. count the number of unique clients, compute average and total purchase amount of client orders by each date.
create view clients_satyp_alulary as
select s.date as date, count(distinct c.id) as unique_ppl, avg(s.amount) as avg_spend, sum(s.amount) as total_spend from client c join sell s on c.id = s.client_id group by s.date;

--b. find top 5 dates with the greatest total sell amount.
create or replace view top5dates as select date, total_spend from clients_satyp_alulary order by total_spend desc limit 5;

--c. count the number of sales, compute average and total amount of all sales of each dealer.
create or replace view sales_stats as
select count(distinct s.id), avg(s.amount), sum(s.amount) from sell s join dealer d on s.dealer_id = d.id group by d.name;

--d. compute how much all dealers earned from commission (total sell amount*commission) in each location.
create view dealers_earn as
select d.location, d.name as dealer, sum(s.amount * d.commission) as total_earn
from dealer d join sell s on d.id = s.dealer_id group by d.location, d.id;

--e. compute number of sales, average and total amount of all sales dealers made in each location.
CREATE VIEW dealer_sales_summary AS
SELECT
    d.location,
    d.name AS dealer_name,
    COUNT(s.id) AS number_of_sales,
    AVG(s.amount) AS average_sale_amount,
    SUM(s.amount) AS total_sale_amount
FROM
    dealer d
JOIN sell s ON d.id = s.dealer_id
GROUP BY
    d.location, d.id;


--f. compute number of sales, average and total amount of expenses in each city clients made.
CREATE VIEW client_expenses_summary AS
SELECT
    c.city,
    COUNT(s.id) AS number_of_sales,
    AVG(s.amount) AS average_sale_amount,
    SUM(s.amount) AS total_sale_amount
FROM
    client c
JOIN sell s ON c.id = s.client_id
GROUP BY
    c.city, c.id;


--g. find cities where total expenses more than total amount of sales in locations.
CREATE VIEW cities_with_more_expenses AS
SELECT
    c.city,
    SUM(s.amount) AS total_expenses,
    SUM(dss.total_sale_amount) AS total_sales
FROM
    client c
JOIN sell s ON c.id = s.client_id
JOIN dealer_sales_summary dss ON c.dealer_id = dss.id
GROUP BY
    c.city
HAVING
    SUM(s.amount) > SUM(dss.total_sale_amount);

-- For part e
SELECT * FROM dealer_sales_summary;

-- For part f
SELECT * FROM client_expenses_summary;

-- For part g
SELECT * FROM cities_with_more_expenses;