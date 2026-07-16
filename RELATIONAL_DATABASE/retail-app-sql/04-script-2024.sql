--1. Retrieve all shops and their addresses.
select s.shopname, s.address from retailapp.shop s ;

--2. Select all products from a specific category:
select * from retailapp.products p
where p.categoryid = 1 ; 

--3. Select all orders placed by a specific customer:
select * from retailapp.orders o 
where o.customerid = 3;

--4. Select all order details for a specific order:
select * from retailapp.orderdetails o2  
where o2.orderid = 3;

--5. Join Orders and Customers tables to get customer details for each order.
select * from retailapp.customers c 
join 
retailapp.orders o 
on
c.customerid = o.customerid ;

select o.orderid ,o.orderdate , c.customername  
from retailapp.customers c 
join retailapp.orders o 
on c.customerid = o.customerid ;


--6. Join OrderDetails, Orders,Products to get product details for each order.

select p.productname, od.quantity, o.orderdate 
from retailapp.products p ,retailapp.orderdetails od ,retailapp.orders o 
where  od.orderid = o.orderid ;
and  p.productid = od.productid;

--7.Count the number of orders for each customer.
select  c.customername , count(o.orderid) 
from  retailapp.orders o, retailapp.customers c 
where o.customerid = c.customerid 
group by c.customername
--having count(o.orderid) = 2
order by c.customername
;


--8. Get the average price of products in each category
select c.categoryname , avg(p.price)
from retailapp.products p , retailapp.categories c 
where p.categoryid  = c.categoryid 
group by c.categoryname ;

retailapp.orders

-- Complex Queries--

-- 1. Get the total sales amount for each product.
select p.productname ,(od.quantity * p.price) as TotalSales
from retailapp.orderdetails od, retailapp.products p;


-- 2. Find customers who have placed orders but not yet shipped.
update retailapp.orders
set shipperid = NULL 
where orderid in (13,14,15);

select c.customername, o.orderid 
from retailapp.orders o 
	inner join retailapp.customers c on o.customerid = c.customerid 
	left outer join retailapp.shippers s on o.shipperid = s.shipperid
where o.shipperid IS NULL
; 
-- join 		: inner   join 
-- left-join,   : outer   left-join
-- right-join	: outer	  right-join 


-- 3. Get the most ordered product.
select *
from retailapp.orderdetails od 
where od.quantity = (
		select max(od.quantity)
		from retailapp.orderdetails od
);

--4. Find the top 5 customers who have placed the highest number of orders.
select o.customerid ,Count(*) as OrderCount  
from  retailapp.orders o 
group by o.customerid 
order by OrderCount desc 
limit 5;

--5.Get the list of products that have never been ordered.

select p.productname ,p.productid 
from retailapp.products p , retailapp.orderdetails o 
where p.productid = o.productid 
and p.productid not in (o.productid) ;


--6.Find the average order value for each customer.

select o.customerid,  avg (od.quantity * p.price) as AvgOrderValue 
from retailapp.orders o, retailapp.orderdetails od, retailapp.products p 
where o.orderid = od.orderid
and od.productid = p.productid 
group by  o.customerid 
order by o.customerid;

--7.List the employees who have processed orders for more than one customer.

select e.employeeid , e.firstname ,count(distinct o.customerid) as CustomerCount
from  retailapp.employees e ,retailapp.orders o
where o.employeeid = e.employeeid 
group by e.employeeid , e.firstname ;



--8.Get the list of products supplied by suppliers from a specific country (e.g., 'USA').
select p.productname , s.country 
from retailapp.suppliers s , retailapp.products p 
where s.supplierid = p.supplierid 
and s.country = 'USA';



--9.Find the total sales amount for each category.
select  distinct (c.categoryname) , sum(p.price * o.quantity) as TotalSales , c.categoryid 
from retailapp.categories c , retailapp.orderdetails o , retailapp.products p 
where o.productid = p.productid 
and p.categoryid = c.categoryid
group by c.categoryid 
order by c.categoryid ;


--10.List all customers along with the total amount they have spent on orders.
select c.customerid , c.customername , sum(od.quantity * p.price) as TotalAmountSpent
from retailapp.customers c ,retailapp.products p ,retailapp.orderdetails od, retailapp.orders o 
where od.productid = p.productid 
and o.customerid = c.customerid 
group by c.customerid ;


--11.Get the list of orders that contain more than three distinct products.
select distinct o.orderid , count(od.productid) as NoOfProducts
from retailapp.orders o , retailapp.orderdetails od 
where o.orderid = od.orderid 
group by o.orderid 
having count(od.productid) > 3 ;


--12.Find the products that have been ordered by all customers.
select od.productid ,count(o.customerid) as NoOfCustomers
from retailapp.orders o , retailapp.orderdetails od 
where o.orderid = od.orderid 
group by od.productid 
having count(o.customerid) = (select  count(c.customerid) 
							from retailapp.customers c );


--13.Get the most recent order placed by each customer.
select distinct c.customerid ,o.orderid, max(o.orderdate) as RecentOrder   
from retailapp.orders o, retailapp.customers c
where o.customerid =c.customerid 
group by c.customerid ,o.orderid 
order by c.customerid ,o.orderid ;


--14.Find customers who have never placed an order.
select c.customerid ,c.customername 
from retailapp.customers c , retailapp.orders o 
where c.customerid = o.customerid 
and c.customerid not in (o.customerid) ;


--15.get the details of the most expensive product ordered by each customer.
select distinct o.orderid , c.customername , max(p.price)  as MostExpensive
from retailapp.products p , retailapp.orderdetails od , retailapp.orders o ,retailapp.customers c 
where p.productid = od.productid 
and  c.customerid = o.customerid 
group by o.orderid , c.customername
order by o.orderid , c.customername;


--16.Get the total sales for each product, grouped by the month of the order date.
select p.productname , o.orderdate ,sum(p.price * od.quantity) as TotalSalesInMonth
from retailapp.products p , retailapp.orderdetails od , retailapp.orders o 
where p.productid = od.productid 
and  od.orderid = o.orderid
group by p.productname , o.orderdate; 


--17.List the customers who have placed orders with a total quantity-
select c.customername ,od.quantity 
from retailapp.customers c , retailapp.orderdetails od , retailapp.orders o 
where c.customerid = o.customerid 
and od.orderid  = o.orderid
and od.quantity > 20
; 

--18.Get the total quantity of products ordered from suppliers in each country.
select s.supplierid , s.country , sum (od.quantity) as TotalQuantity
from retailapp.orderdetails od , retailapp.products p ,retailapp.suppliers s
where od.productid = p.productid 
and s.supplierid = p.supplierid 
group by s.supplierid , s.country 
order by s.supplierid , s.country ;


--Find the average price of products for each supplier.

--Get the list of customers along with the number of different products they have ordered.























































