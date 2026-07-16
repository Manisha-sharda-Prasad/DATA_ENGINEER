-- DQL (Data Query Language) queries- retrieve data from the database.
--- (SELECT, FROM, WHERE, JOIN, GROUP BY, HAVING, ORDER BY, LIMIT)

-- SQL Queries for Retail Application Database--
-- This script contains various SQL queries to interact with the retail application database.


-- Beginner-level :--

--1. Show all customers with their city and country.
select  c.customername, c.country, c.city
from retailapp.customers c;

--2.List all products with their price greater than 20.
select p.productname , p.price
from retailapp.products p
where p.price > 20;

--3. Get all orders placed by a customer named “Antonio Moreno Taquería”.
select distinct
	c.customername,
	p.productname
from retailapp.customers c
	join retailapp.orders o 			on o.customerid  = c.customerid
	join retailapp.orderdetails od 	on od.orderid 	 = o.orderid
	join retailapp.products p 		on p.productid   = od.productid
where
	c.customername = 'Antonio Moreno Taquería' -- condition
order by
	p.productname;

--4.Find all products in the “Beverages” category.
select p.productname ,c.categoryid, c.categoryname
from retailapp.products p , retailapp.categories c
where c.categoryname = 'Beverages' and p.categoryid = c.categoryid ;


--5.Show the order details (OrderID, ProductName, Quantity) for a specific OrderID = 1.
select od.orderid, p.productname, od.quantity
from retailapp.orderdetails od
join retailapp.products p on od.productid = p.productid
where od.orderid = 1;

--6.Display all orders with the customer name and order date.
select   c.customername , o.orderdate
from retailapp.orders o
join retailapp.customers c on o.customerid = c.customerid;

--6.1. Get the 2 most recent Orders
select o.orderid, o.orderdate
from retailapp.orders o
order by o.orderdate DESC
limit 2;

--7.Show all product names along with their supplier name.
select p.productname , s.suppliername
from retailapp.products p
join retailapp.suppliers s on p.supplierid = s.supplierid;

--8.List all order details with OrderID, ProductName, Price, Quantity and Total (Price * Quantity).
select od.orderid, p.productname, p.price, od.quantity , (p.price * od.quantity) as Total
from retailapp.orderdetails od
join retailapp.products p on od.productid = p.productid;


--9.Show all products in each category (CategoryName and ProductName).
select p.productname, c.categoryname
from retailapp.products p , retailapp.categories c;


--10.Get all orders with Shipper Name (Orders + Shippers + Customers).
select s.shippername , o.orderid , c.contactname
from retailapp.orders o
join retailapp.shippers s on o.shipperid = s.shipperid
join retailapp.customers c on o.customerid = c.customerid;

-- WHERE filters before Aggregation --HAVING filters after Aggregation,

--Aggregation:--
--11.Count total orders placed by each customer.
select count(o.orderid), c.customername
from retailapp.orders o
join retailapp.customers c on o.customerid = c.customerid
group by c.customername;


--12.Show total revenue (sum of Price * Quantity) generated per product.
select  p.productname,  sum(p.price * od.quantity) as "Total Revenue"
from retailapp.products p
join retailapp.orderdetails od on od.productid = p.productid
group by p.productname ;


--13.Find the average price of products supplied by each supplier.
select p.productname, s.suppliername, avg(p.price)
from retailapp.products p
join retailapp.suppliers s on  p.supplierid = s.supplierid
group by p.productname , s.suppliername;


--13.1. Find the average price of products. Considering only customers who paid price not equal to 0,and return only those products with an avg price greater than 20.
select p.productname, avg(p.price) as Avg_Price
from retailapp.products p
where p.price != 0
group by p.productname
having avg(p.price) > 30;


--14.Show the total number of products in each category.
select c.categoryname , count(p.productname ) as Total
from retailapp.products p
join retailapp.categories c on p.categoryid = c.categoryid
group by c.categoryname;

--15.Find the maximum and minimum product price.
select p.productname, min(p.price) , max(p.price)
from retailapp.products p
group by p.productname;

-- 15.Find the maximum and minimum product price. (in whole -table) ☑️
select min(p.price) , max(p.price)
from retailapp.products p;

--Subqueries--
--16. Find customers who have not placed any order.
select *
from retailapp.customers c
where c.customerid not in
    (select distinct o.customerid from retailapp.orders o );


--17.List products that have never been ordered.
select  p.productname
from retailapp.products p
where p.productid not in
       (select distinct od.productid from retailapp.orderdetails od);


--18.Get the most expensive product ordered by each customer.

select  distinct c.customername, p.productname, p.price
from retailapp.customers c
join retailapp.orders o on c.customerid = o.customerid
join retailapp.orderdetails od on o.orderid = od.orderid
join retailapp.products p on p.productid = od.productid
where (c.customerid , p.price ) in (
        select c2.customerid, max(p2.price)
         from retailapp.customers c2
         join retailapp.orders o2 on c2.customerid = o2.customerid
         join retailapp.orderdetails od2 on o.orderid = od2.orderid
         join retailapp.products p2 on p2.productid = od2.productid
         group by c2.customerid);



--19.Find employees who handled more than 5 orders.

select e.firstname, count(o.orderid) > 5 as Total_Orders
from retailapp.employees e
join retailapp.orders o on e.employeeid = o.employeeid
where e.employeeid = o.employeeid
group by e.employeeid, e.firstname
;

SELECT e.firstname, COUNT(o.orderid) AS total_orders
FROM retailapp.employees e
JOIN retailapp.orders o ON e.employeeid = o.employeeid
GROUP BY e.employeeid, e.firstname
HAVING COUNT(o.orderid) > 5;


--20.List suppliers who supply products in the same category as “Beverages”.

select distinct s.suppliername, p.productname , c.categoryname as "Beverages"
from retailapp.suppliers s
join retailapp.products p on s.supplierid = p.supplierid
join retailapp.categories c on c.categoryid = p.categoryid
where c.categoryname = 'Beverages';


select distinct s.suppliername, p.productname
from retailapp.suppliers s
join retailapp.products p on s.supplierid = p.supplierid
where p.categoryid = (
        select c.categoryid
        from retailapp.categories c
        where c.categoryname = 'Beverages'
    );


--Where operators :-
--1.Comparison op. - ( =, > , <=, =! )
--2.Logical op- ( AND, OR , NOT )
--3.Range op. - ( BETWEEN )
--4.Membership op- ( IN, Not IN )
--5.Search op - ( LIKE , NOT LIKE )- ('%' , '_')
--6.Null op - ( IS NULL, IS NOT NULL )

--Complex Queries
--Show top 3 customers who spent the most.

--Find products that were ordered by all customers.

--Find the month that had the highest total sales.

--Get the latest order placed by each customer.

--Find the shops (from Shop table) that have the most carts (from Cart table).




