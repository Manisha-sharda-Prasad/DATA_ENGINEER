
--DDL (DATA DEFINITION LANGUAGE)- (CREATE, ALTER, DROP)
-- 1. CREATE TABLE-------------------------------------

-- Customers Table
CREATE TABLE IF NOT EXISTS  retailapp.Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255) NOT NULL,
    ContactName VARCHAR(255),
    Country VARCHAR(255),
    Address VARCHAR(255),
    City VARCHAR(255),
    PostalCode VARCHAR(20)
);

-- Categories Table
CREATE TABLE IF NOT EXISTS  retailapp.Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(255) NOT NULL,
    Description TEXT
);

-- Employees Table
CREATE TABLE IF NOT EXISTS  retailapp.Employees (
    EmployeeID INT PRIMARY KEY,
    LastName VARCHAR(255) NOT NULL,
    FirstName VARCHAR(255) NOT NULL,
    BirthDate DATE,
    Photo VARCHAR(255),
    Notes TEXT
);

-- Suppliers Table
CREATE TABLE IF NOT EXISTS  retailapp.Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(255) NOT NULL,
    ContactName VARCHAR(255),
    Country VARCHAR(255),
    Address VARCHAR(255),
    City VARCHAR(255),
    PostalCode VARCHAR(20)
);

-- Shippers Table
CREATE TABLE IF NOT EXISTS  retailapp.Shippers (
    ShipperID INT PRIMARY KEY,
    ShipperName VARCHAR(255) NOT NULL,
    Phone VARCHAR(255)
);

-- Products Table
CREATE TABLE IF NOT EXISTS  retailapp.Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    SupplierID INT,
    CategoryID INT,
    Unit VARCHAR(255),
    Price DECIMAL(10, 2),
    FOREIGN KEY (SupplierID) REFERENCES retailapp.Suppliers(SupplierID),
    FOREIGN KEY (CategoryID) REFERENCES retailapp.Categories(CategoryID)
);

-- Orders Table
CREATE TABLE IF NOT EXISTS  retailapp. Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    EmployeeID INT,
    OrderDate DATE,
    ShipperID INT,
    FOREIGN KEY (CustomerID) REFERENCES retailapp.Customers(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES retailapp.Employees(EmployeeID),
    FOREIGN KEY (ShipperID) REFERENCES retailapp.Shippers(ShipperID)
    --FOREIGN KEY (PaymentID) REFERENCES retailapp.Payments(PaymentID)
);

-- OrderDetails Table
CREATE TABLE IF NOT EXISTS  retailapp. OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES retailapp.Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES retailapp.Products(ProductID)
);    

-- SHOP Table
CREATE TABLE IF NOT EXISTS  retailapp. Shop (
    ShopID INT PRIMARY KEY,
    ShopName VARCHAR(255) NOT NULL,
    Address VARCHAR(255),
    City VARCHAR(255),
    PostalCode VARCHAR(20),
    Country VARCHAR(255)
);

-- CART Table
CREATE TABLE IF NOT EXISTS  retailapp. Cart (
    CartID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Quantity INT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES retailapp.Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES retailapp.Products(ProductID)
);

-- Payments Table
CREATE TABLE IF NOT EXISTS retailapp.Payments (
    PaymentID INT Primary Key,
    PaymentDate TimeStamp,
    Currency Varchar(10),
    Amount Decimal(10, 2),
    OrderID INT,
    CustomerID INT,
    FOREIGN KEY (OrderID) REFERENCES retailapp.orders(OrderID),
    FOREIGN KEY (CustomerID) REFERENCES retailapp.Customers(CustomerID)
);



-- 2. ALTER TABLE--------------------------------------

-- Payments-
Alter table retailapp.Payments
ADD COLUMN IF NOT EXISTS PaymentMethod VARCHAR(50);

-- Shop-
Alter table retailapp.SHOP
RENAME COLUMN POSTALCODE TO ZIPCODE;

-- Cart-
Alter table retailapp.Cart
DROP COLUMN IF EXISTS CreatedAt;

--alter Cart
--MODIFY column Quantity INT NOT NULL;



--3. DROP TABLE--------------------------------------

-- DROP TABLE IF NOT EXISTS  retailapp. CATEGORIES ;
-- DROP TABLE IF NOT EXISTS  retailapp. CUSTOMERS ;
-- DROP TABLE IF NOT EXISTS  retailapp. EMPLOYEES ;
-- DROP TABLE IF NOT EXISTS  retailapp. ORDER_DETAILS ;
-- DROP TABLE IF NOT EXISTS  retailapp. ORDERS ;
-- DROP TABLE IF NOT EXISTS  retailapp. PRODUCTS ;
-- DROP TABLE IF NOT EXISTS  retailapp.  SHIPPERS ;
-- DROP TABLE IF NOT EXISTS  retailapp. SUPPLIERS ;




