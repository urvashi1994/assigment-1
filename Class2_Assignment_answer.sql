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
select * from customer;

select name, commission from salesman;
select * from salesman where commission > '0.12';
---------------------Assignment-2-----------------------------------------------------------------------------------------------------------------------
select salesman.name, customer.cust_name, customer.city from salesman 
JOIN customer 
ON salesman.city = customer.city
---------------------Assignment-2-----------------------------------------------------------------------------------------------------------------------
select s.name, c.cust_name, s.city, s.commission
from salesman s
JOIN customer c
ON s.city = c.city
---------------------Assignment-2-----------------------------------------------------------------------------------------------------------------------

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

---------------------Assignment-2--------------------------------------------
select c.cust_name, c.city, s.name AS salesman, s.commission
from customer c
INNER JOIN 
salesman s
ON s.salesman_id = c.salesman_id
where s.commission>.12; 
---------------------Assignment-2--------------------------------------------
select c.cust_name, c.city, c.grade, s.name AS salesman, s.city
from customer c
LEFT OUTER JOIN
salesman s 
ON s.salesman_id = c.salesman_id
where c.grade < 300
ORDER BY c.cust_name;
----------------------Assignment-2----------------------------------------
select * from customer where grade > 100;
select * from customer where city = 'New York' AND grade > 100;
select * from customer where city = 'New York' OR grade > 100;
select COUNT(distinct salesman_id) from customer;
select COUNT(*) from customer;


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
insert into orders (order_no, purch_amt, ord_date, customer_id, salesman_id) values(70011, 75.29, '8/17/12', 3003, 5007);
insert into orders (order_no, purch_amt, ord_date, customer_id, salesman_id) values(70013, 3045.6, '4/25/12', 3002, 5001);

update orders
set ord_date='10/5/2012'
where customer_id = 3005;

select * from orders;
select * from orders where purch_amt < 2000;
---------------------Assignment-2-----------------------------------------------------------------------------------------------------------------------
select orders.order_no, orders.purch_amt, customer.cust_name, customer.city
from orders, customer
where orders.customer_id = customer.customer_id
AND orders.purch_amt BETWEEN 500 AND 2000
---------------------Assignment-2-----------------------------------------------------------------------------------------------------------------------
select * 
from orders 
where NOT ((ord_date = '9/10/12' AND salesman_id <= 505) OR purch_amt <= 1000);----my solution
----their solutionwhere NOT ((ord_date = '9/10/12' AND salesman_id >= 505) OR purch_amt >= 1000);
---------------------Assignment-2--------------------------------------------------------------------------------------------------------------------
select * from orders where ((ord_date = '8/17/12' OR customer_id > 3005) AND purch_amt < 1000);
select SUM(purch_amt) from orders;
select AVG(purch_amt) from orders;
select MAX(purch_amt) from orders;
select MIN(purch_amt) from orders;
---------------------Assignment-2----------------------------------------------------------------------------------------------------------------------------
select customer_id, MAX(purch_amt) AS Highest_Purchase_Amount
from orders 
GROUP BY customer_id
order by  MAX(purch_amt)desc;
---------------------Assignment-2----------------------------------------------------------------------------------------------------------------------------
select customer_id, MAX(purch_amt), ord_date
from orders
GROUP BY  customer_id, ord_date 
HAVING MAX(purch_amt) BETWEEN 2000 AND 6000;
---------------------Assignment-2----------------------------------------------------------------------------------------------------------------------------
select salesman_id, ord_date,COUNT(*) AS count
from orders
GROUP BY ord_date, salesman_id;
---------------------Assignment-2----------------------------------------------------------------------------------------------------------------------------
select * from orders order by order_no ASC;
select * from orders order by ord_date DESC;

select * from orders order by ord_date, purch_amt DESC;

---------------------Assignment-2----------------------------------------------------------------------------------------------------------------------------
SELECT o.order_no, o.ord_date, o.purch_amt,
c.customer_id, c.cust_name AS "Customer Name", c.city, c.grade, c.salesman_id, 
s.name AS "Salesman", s.commission 
FROM orders o
INNER JOIN customer c
ON o.customer_id=c.customer_id 
INNER JOIN salesman s
ON o.salesman_id=s.salesman_id;

---------------------Assignment-2-STORED PROCEDURE---------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE SelectOrderInformation
AS
select *
from orders a
JOIN 
customer c
ON c.customer_id=a.customer_id

GO;
EXEC SelectOrderInformation;
EXEC SelectCustomerInformation;
---------------------Assignment-2-DATE FUNCTION---------------------------------------------------------------------------------------------------------------------------
select ord_date,
	YEAR(ord_date) AS [Year] from orders

SELECT * 
FROM orders
WHERE MONTH(date_stamp)=01;
Display Order that were made between 15 to 30th date of any month from order table

select order_no, FORMAT(ord_date,'dd/MM/yy') AS date from orders;
select order_no, MONTH(ord_date) AS Month FROM orders where MONTH(ord_date)=9
select order_no, DAY(ord_date) AS day from orders where DAY(ord_date) BETWEEN 15 AND 30;;

---------------------Assignment-2-STORED PROCEDURE---------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE SelectCustomerInformation
AS
select * from customer
GO;
EXEC SelectCustomerInformation;
---------------------Assignment-2-STORED PROCEDURE---------------------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE SelectSalesmanDetails 
@salesman_id int
AS
BEGIN
	select *
	from salesman 
	where salesman_id = @salesman_id
END
EXEC SelectSalesmanDetails 5002
---------------------Assignment-2-STORED PROCEDURE---------------------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE UpdateCityValue
@city varchar(20),
@customer_id int
AS
BEGIN
	select * from customer

	update customer 
	set city  = @city
	where customer_id = @customer_id

	select * from customer where customer_id = @customer_id
END
EXEC UpdateCityValue @city='Huntsville', @customer_id = 300
---------------------Assignment-2-USER DEFINE FUNCTION---------------------------------------------------------------------------------------------------------------------------
DROP FUNCTION if exists ufnGetTotalAmount
GO
CREATE FUNCTION dbo.ufnGetTotalAmount (@customer_id int)
RETURNS money 

BEGIN
	DECLARE @ret money;
	SELECT @ret = SUM(purch_amt)
	FROM orders 
	WHERE customer_id = @customer_id

	RETURN @ret;
END;
--to use the function
select dbo.ufnGetTotalAmount(3005)

---------------------Assignment-2-USER DEFINE FUNCTION---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION if exists fnSalesmanCommission
GO
CREATE FUNCTION dbo.fnSalesmanCommission (@salesman_id int)
RETURNS smallmoney 

BEGIN
	DECLARE @commission smallmoney;
	select @commission=(commission)
	FROM salesman 
	WHERE salesman_id = @salesman_id

	RETURN @commission;
END;
--to use the function
select dbo.fnSalesmanCommission(5002)
---------------------Assignment-2-USER DEFINE FUNCTION---------------------------------------------------------------------------------------------------------------------------

--create userdefined function which takes orderid as input and returns who placed this order.
DROP FUNCTION if exists OrderPlacedByCustomer
GO
ALTER FUNCTION dbo.OrderPlacedByCustomer (@order_no int)
RETURNS int
BEGIN
	DECLARE @placed int;
	select @placed = (customer_id)
	from orders
	where order_no = @order_no;
	RETURN @placed;
END;
select dbo.OrderPlacedByCustomer(70002)
---------------------Assignment-2-VIEW---------------------------------------------------------------------------------------------------------------------------
--Create a view that has following information, customer_id, cust_name, city, grade, salesman_id, salesman_name, Commission, Ord_no, purch_amt and ord_date

CREATE VIEW customer_info AS 
select c.customer_id, c.cust_name, c.city, c.grade,
s.salesman_id, s.name, s.commission,
o.order_no, o.purch_amt, o.ord_date
from salesman s, customer c, orders o
where s.salesman_id = c.salesman_id
AND c.customer_id = o.customer_id;

select * from customer_info;