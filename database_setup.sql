-- =====================================================
-- SQL SALES ANALYSIS PROJECT
-- Database Setup
-- SQL Server
-- =====================================================

-- Create Database
IF DB_ID('SQL_Sales_Analysis') IS NULL
BEGIN
    CREATE DATABASE SQL_Sales_Analysis;
END;
GO

USE SQL_Sales_Analysis;
GO


-- =====================================================
-- 1. Customers Table
-- =====================================================

CREATE TABLE Customers
(
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(100)
);
GO


-- =====================================================
-- 2. Products Table
-- =====================================================

CREATE TABLE Products
(
    ProductID INT PRIMARY KEY,
    [Products Name] VARCHAR(100),
    Category VARCHAR(100),
    Price DECIMAL(10,2)
);
GO


-- =====================================================
-- 3. Orders Table
-- =====================================================

CREATE TABLE Orders
(
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,

    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
);
GO


-- =====================================================
-- 4. OrderDetails Table
-- =====================================================

CREATE TABLE OrderDetails
(
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,

    CONSTRAINT FK_OrderDetails_Orders
        FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID),

    CONSTRAINT FK_OrderDetails_Products
        FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID)
);
GO


-- =====================================================
-- Database Structure
-- Customers
--      ↓
-- Orders
--      ↓
-- OrderDetails
--      ↓
-- Products
-- =====================================================

-- NOTE:
-- Sample INSERT data will be added separately after
-- verifying the exact data from the original database.
