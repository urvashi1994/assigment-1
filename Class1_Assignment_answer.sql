create database Inventory;


--FIRST TABLE SALESMAN
create table salesman (
salesman_id int NOT NULL PRIMARY KEY, 
name nvarchar(25), 
city nvarchar(25), 
commission float
);
--To check the index on the table
Execute sp_helpindex salesman

--only one clustered index can be on the table
--lets's try to create another index

Create Clustered Index IX_salesman_name
ON salesman(name)

insert into salesman(salesman_id, name, city, commission) values(5001, 'James Hoog', 'New York', 0.15);
insert into salesman(salesman_id, name, city, commission) values(5002, 'Nail Kinte', 'Paris', 0.13);
insert into salesman(salesman_id, name, city, commission) values(5005, 'Pit Alex', 'London', 0.11);
insert into salesman(salesman_id, name, city, commission) values(5006, 'Mc Lyon', 'Paris', 0.14);
insert into salesman(salesman_id, name, city, commission) values(5003, 'Lauson Hen', ' ', 0.12);
insert into salesman(salesman_id, name, city, commission) values(5007, 'Purch  Adam', 'Rome', 0.13);

select * from salesman;
select name, commission from salesman;
select * from salesman where commission > '0.12';

--SECOND TABLE CUSTOMER
create table customer(
customer_id int NOT NULL PRIMARY KEY,
cust_name nvarchar(25),
city nvarchar(25),
grade int,
salesman_id int FOREIGN KEY REFERENCES salesman(salesman_id)
);

--ADD NEW COLUMN
alter table customer 
add country nvarchar(25);

insert into customer (customer_id, cust_name, city, grade, salesman_id) values(3002, 'Nick Rimando', 'New York', 100, 5001);
insert into customer (customer_id, cust_name, city, grade, salesman_id) values(3005, 'Graham Zusi', 'California', 200, 5002);
insert into customer (customer_id, cust_name, city, grade, salesman_id) values(3001, 'Brad Guzan', 'London', ' ', 5005);
insert into customer (customer_id, cust_name, city, grade, salesman_id) values(3004, 'Fabian Johns', 'Paris', 300, 5006);
insert into customer (customer_id, cust_name, city, grade, salesman_id) values(3007, 'Brad Davis', 'New York', 200, 5001);
insert into customer (customer_id, cust_name, city, grade, salesman_id) values(3009, 'Geoff Camero', 'Berlin', 100, 5003);
insert into customer (customer_id, cust_name, city, grade, salesman_id) values(3008, 'Julian Green', 'London', 300, 5002);
insert into customer (customer_id, cust_name, city, grade, salesman_id) values(3003, 'Jozy Altidor', 'Moscow', 200, 5007);

--insert into customer values('japan', 'india', 'canada', 'us', 'maxico', 'paris', 'california', 'switzerland');
--update customer set country values ('japan', 'india', 'canada', 'us', 'maxico', 'paris', 'california', 'switzerland');

INSERT INTO customer (country) VALUES ('japan');
INSERT INTO customer(country) VALUES('japan'); 

UPDATE customer
SET country = 'USA' where customer_id = 3004;


select * from customer;
select * from customer where country = 'USA';
select * from customer where grade = '200';

--DELETE NEWLY ADDED COLUMN
ALTER TABLE customer
DROP COLUMN country;

--THIRD TABLE ORDERS
create table orders(
order_no int NOT NULL PRIMARY KEY,
purch_amt float,
ord_date date,
customer_id int FOREIGN KEY REFERENCES customer(customer_id),
salesman_id int FOREIGN KEY REFERENCES salesman(salesman_id)
);

insert into orders (order_no, purch_amt, ord_date, customer_id, salesman_id) values(70001, 150.5, '10/5/12', 3005, 5002);

insert into orders (order_no, purch_amt, ord_date, customer_id, salesman_id) values(70009, 270.65, '9/10/12', 3001, 5005);

insert into orders (order_no, purch_amt, ord_date, customer_id, salesman_id) values(70002, 65.25, '10/5/12', 3002, 5001);

insert into orders (order_no, purch_amt, ord_date, customer_id, salesman_id) values(70004, 110.5, '8/17/12', 3009, 5003);

insert into orders (order_no, purch_amt, ord_date, customer_id, salesman_id) values(70007, 948.5, '9/10/12', 3005, 5002);

insert into orders (order_no, purch_amt, ord_date, customer_id, salesman_id) values(70005, 2400.6, '7/27/12', 3007, 5001);

insert into orders (order_no, purch_amt, ord_date, customer_id, salesman_id) values(70008, 5760, '9/10/12', 3002, 5001);

insert into orders (order_no, purch_amt, ord_date, customer_id, salesman_id) values(70010, 1983.43, '10/10/12', 3004, 5006);

insert into orders (order_no, purch_amt, ord_date, customer_id, salesman_id) values(70003, 2480.4, '10/10/12', 3009, 5003);

insert into orders (order_no, purch_amt, ord_date, customer_id, salesman_id) values(70012, 250.45, '6/27/12', 3008, 5002);

insert into orders (order_no, purch_amt, ord_date, customer_id, salesman_id) values(70011, 75.29, '8/17/12', 3003, 5007);--

insert into orders (order_no, purch_amt, ord_date, customer_id, salesman_id) values(70013, 3045.6, '4/25/12', 3002, 5001);

select * from orders;
select * from orders where purch_amt < 2000;
select * from orders where customer_id = 3002;
