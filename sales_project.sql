-- ==========================================================
-- PROJECT: Sales & Customer Insights Database
-- AUTHOR: [MHD Bilal Al Rahmani]
-- TOOLS: SQL (MySQL / PostgreSQL / SQL Server)
-- ==========================================================

-- 1. Create Schema
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    City VARCHAR(50),
    JoinDate DATE
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    OrderDate DATE,
    Quantity INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- 2. Insert Realistic Data
INSERT INTO Customers VALUES 
(1, 'Ahmed', 'Mansour', 'Berlin', '2023-01-15'),
(2, 'Sara', 'Schmidt', 'Munich', '2023-02-20'),
(3, 'Omar', 'Ali', 'Berlin', '2023-03-10'),
(4, 'Lina', 'Meyer', 'Hamburg', '2023-05-05');

INSERT INTO Products VALUES 
(101, 'Laptop Pro', 'Electronics', 1200.00),
(102, 'Wireless Mouse', 'Electronics', 25.50),
(103, 'Office Chair', 'Furniture', 150.00),
(104, 'Coffee Maker', 'Appliances', 85.00);

INSERT INTO Orders VALUES 
(501, 1, 101, '2024-01-05', 1),
(502, 2, 103, '2024-01-10', 2),
(503, 1, 102, '2024-01-15', 1),
(504, 3, 101, '2024-01-20', 1),
(505, 4, 104, '2024-02-01', 3);

-- 3. Business Analysis Queries
-- Query 1: Total Sales per Customer (Using JOIN, GROUP BY, SUM)
-- This shows who spent the most money.
SELECT 
    c.FirstName, 
    c.City, 
    SUM(o.Quantity * p.Price) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY c.CustomerID, c.FirstName, c.City
ORDER BY TotalSpent DESC;

-- Query 2: Category Performance (Where, Group By)
-- Which category is most profitable?
SELECT 
    p.Category, 
    COUNT(o.OrderID) AS NumberOfOrders,
    SUM(o.Quantity * p.Price) AS CategoryRevenue
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.Category
HAVING CategoryRevenue > 100;