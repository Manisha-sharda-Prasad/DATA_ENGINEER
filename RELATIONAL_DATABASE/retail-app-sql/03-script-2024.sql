-- Practice SQL
-- #1 Start /Stop service
-- sudo /usr/local/mysql/support-files/mysql.server start
-- sudo /usr/local/mysql/support-files/mysql.server stop
-- source ~/.bash_profile 
-- startmysql -- stopmysql

Select * from orders;

SELECT o.OrderID, c.CustomerName, o.OrderDate
 FROM Orders o
 INNER JOIN Customers c
 ON o.CustomerID=c.CustomerID;

Select * From Products
where SupplierID <= 7;

SELECT CustomerName, ContactName From Customers;

SELECT distinct city
 From Suppliers
 order by city;

SELECT Price
 FROM Products
 order by Price;

SELECT distinct city
  From Customers
  order by city DESC;

Select * From Customers
 where Country = 'France' And Country = 'USA'
 And CustomerName Like '%s' or CustomerName Like '%a';

Select * From Employees
 where FirstName Not Like'%w'
 And FirstName Not Like'%t'
 And EmployeeID Not Between 7 And 8;

SELECT * FROM Suppliers
 where City Not In ('Londona','New Orleans','Tokyo')
 And Not SupplierID < 6;

SELECT * FROM Customers
 WHERE Country IN ('France','Brazil','USA');


Update Employees
 Set LastName = 'Miller', FirstName = 'Joyce'
 where EmployeeID = 2;

-- Delete From Employees where LastName = 'Miller';
SELECT * From Suppliers;

-- FETCH FIRST 4 ROWS ONLY
SELECT * FROM Suppliers
WHERE Country = 'USA' ;

-- FETCH FIRST 3 ROWS ONLY;
SELECT * From Suppliers
 where Country = 'USA'
 Limit 3;

SELECT MIN (Price)
 And Max (Price)
 From Products;

Select MIN (Price) AS SmallestPrice
 FROM Products;

Select Max (Quantity) AS SmallestQuantity
 FROM OrderDetails
 GROUP BY OrderDetailID ;

SELECT COUNT (Country)
 FROM Suppliers
 WHERE Country = 'Japan';


SELECT  ProductId, SUM(Price * 2) AS NewPrice
 FROM PRODUCTS
 GROUP BY ProductId;

SELECT AVG(Price)
 FROM Products
 WHERE CategoryID > 5;


SELECT AVG(Price) AS AveragePrice
 FROM Products
 WHERE CategoryID <= 5;


SELECT * FROM Customers
 WHERE City LIKE '_erlin'
 OR City LIKE 'Be_lin';


SELECT * FROM Customers
 WHERE City LIKE '[xyz]%'
 OR City LIKE '[s-u]%';


SELECT ContactName AS FullName, CustomerName AS ContactName
FROM Customers;


SELECT ContactName AS "Customer Full Name"
 FROM Customers;


SELECT  (Suppliers.ContactName), (Suppliers.City), (OrderDetails.OrderID)
 FROM Suppliers, OrderDetails ;


SELECT  (Orders.OrderDate), (Orders.ShipperID), (OrderDetails.OrderDetailID), (OrderDetails.ProductID)
 FROM Orders
 INNER JOIN OrderDetails
 ON (Orders.OrderID) = (OrderDetails.OrderID);


SELECT  (Orders.OrderDate), (Orders.ShipperID), (OrderDetails.ProductID)
 FROM Orders
 LEFT JOIN OrderDetails
 ON (Orders.OrderID) = (OrderDetails.OrderID);


SELECT DISTINCT cs.CustomerName
 FROM Categories c, Orders o, OrderDetails od, Products p, Customers cs
 WHERE cs.CustomerID = o.CustomerID
 AND o.OrderID = od.OrderID
 AND od.ProductID = p.ProductID
 AND p.CategoryID = c.CategoryID
 AND c.CategoryName = 'Beverages'
 ORDER BY cs.CustomerName ;


SELECT City FROM Suppliers
 UNION ALL
 SELECT City FROM Customers;


SELECT COUNT(CustomerID), city
 FROM Customers
 GROUP BY city;


SELECT COUNT(CustomerName), Country
 FROM CUSTOMERS
 GROUP BY Country
 HAVING COUNT(CustomerName) < 4;


SELECT COUNT(City), Country
 FROM CUSTOMERS
 GROUP BY Country
 HAVING COUNT(City) > 3;

SELECT OrderID, Quantity,
CASE WHEN Quantity > 30 THEN 'The quantity is greater than 30'
WHEN Quantity = 30 THEN 'The quantity is 30'
ELSE 'The quantity is under 30'
END AS QuantityText
FROM OrderDetails;


SELECT FirstName, BirthDate,
CASE
    WHEN BirthDate = '2/19/1952' THEN 'Born in 50s'
    WHEN BirthDate = '3/4/1955'  THEN 'Born in 50s'
    WHEN BirthDate = '9/19/1958' THEN 'Born in 50s'
    WHEN BirthDate = '1/9/1958'  THEN 'Born in 50s'
    ELSE 'NOT from 50s'
END AS BornINFifty
FROM Employees;

SELECT CustomerID, City,
CASE
    WHEN  City = 'Berlin' THEN 'IN Germany'
    WHEN  City = 'London' THEN 'IN UK'
    ELSE 'NOT IN GERMANY, and UK'
END AS CityInCountry
FROM Customers;

-- SELECT TOP 6 * From Products;
-- SELECT TOP 20 PERCENT * From Suppliers ;
-- SELECT ContactName,  Address + ', ' + City + ', '+ PostalCode + ', '+ Country  AS FullAddress FROM Suppliers;
-- SELECT * FROM Employees
-- where BirthDate = #8/30/1963#orders_ibfk_1
-- or BirthDate = #2/19/1952#;
-- SELECT * FROM Customers WHERE City BETWEEN ('México D.F.') AND ('Marseille')
-- SELECT SUM (Country) FROM Suppliers
-- WHERE ContactName LIKE 's%' AND ContactName LIKE 'r%';