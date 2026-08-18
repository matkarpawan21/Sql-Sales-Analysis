USE [SQL Sales Analysis];
GO

/* =========================================
   SQL SALES ANALYSIS PROJECT
   ========================================= */


/* 1. VIEW ALL CUSTOMERS */
SELECT *
FROM Customers;


/* 2. VIEW ALL PRODUCTS */
SELECT *
FROM Products;


/* 3. VIEW ALL ORDERS */
SELECT *
FROM Orders;


/* 4. VIEW ALL ORDER DETAILS */
SELECT *
FROM OrderDetails;


/* =========================================
   BASIC SALES ANALYSIS
   ========================================= */


/* 5. TOTAL NUMBER OF ORDERS */
SELECT COUNT(*) AS TotalOrders
FROM Orders;


/* 6. TOTAL NUMBER OF CUSTOMERS */
SELECT COUNT(*) AS TotalCustomers
FROM Customers;


/* 7. TOTAL NUMBER OF PRODUCTS */
SELECT COUNT(*) AS TotalProducts
FROM Products;


/* 8. TOTAL QUANTITY SOLD */
SELECT SUM(Quantity) AS TotalQuantitySold
FROM OrderDetails;


/* 9. TOTAL SALES */
SELECT
    SUM(od.Quantity * p.Price) AS TotalSales
FROM OrderDetails od
JOIN Products p
    ON od.ProductID = p.ProductID;


/* =========================================
   CUSTOMER ANALYSIS
   ========================================= */


/* 10. CUSTOMER-WISE ORDER COUNT */
SELECT
    c.CustomerID,
    c.CustomerName,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.CustomerName
ORDER BY TotalOrders DESC;


/* 11. CUSTOMER-WISE SALES */
SELECT
    c.CustomerID,
    c.CustomerName,
    SUM(od.Quantity * p.Price) AS TotalSales
FROM Customers c
JOIN Orders o
    ON c.CustomerID = o.CustomerID
JOIN OrderDetails od
    ON o.OrderID = od.OrderID
JOIN Products p
    ON od.ProductID = p.ProductID
GROUP BY
    c.CustomerID,
    c.CustomerName
ORDER BY TotalSales DESC;


/* =========================================
   PRODUCT ANALYSIS
   ========================================= */


/* 12. PRODUCT-WISE QUANTITY SOLD */
SELECT
    p.ProductID,
    p.ProductName,
    SUM(od.Quantity) AS TotalQuantitySold
FROM Products p
JOIN OrderDetails od
    ON p.ProductID = od.ProductID
GROUP BY
    p.ProductID,
    p.ProductName
ORDER BY TotalQuantitySold DESC;


/* 13. PRODUCT-WISE SALES */
SELECT
    p.ProductID,
    p.ProductName,
    SUM(od.Quantity * p.Price) AS TotalSales
FROM Products p
JOIN OrderDetails od
    ON p.ProductID = od.ProductID
GROUP BY
    p.ProductID,
    p.ProductName
ORDER BY TotalSales DESC;


/* =========================================
   CATEGORY ANALYSIS
   ========================================= */


/* 14. CATEGORY-WISE SALES */
SELECT
    p.Category,
    SUM(od.Quantity * p.Price) AS TotalSales
FROM Products p
JOIN OrderDetails od
    ON p.ProductID = od.ProductID
GROUP BY p.Category
ORDER BY TotalSales DESC;


/* 15. CATEGORY-WISE QUANTITY SOLD */
SELECT
    p.Category,
    SUM(od.Quantity) AS TotalQuantitySold
FROM Products p
JOIN OrderDetails od
    ON p.ProductID = od.ProductID
GROUP BY p.Category
ORDER BY TotalQuantitySold DESC;


/* =========================================
   CITY ANALYSIS
   ========================================= */


/* 16. CITY-WISE CUSTOMER COUNT */
SELECT
    City,
    COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY City
ORDER BY TotalCustomers DESC;


/* 17. STATE-WISE CUSTOMER COUNT */
SELECT
    State,
    COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY State
ORDER BY TotalCustomers DESC;


/* =========================================
   DATE ANALYSIS
   ========================================= */


/* 18. DAILY SALES */
SELECT
    o.OrderDate,
    SUM(od.Quantity * p.Price) AS DailySales
FROM Orders o
JOIN OrderDetails od
    ON o.OrderID = od.OrderID
JOIN Products p
    ON od.ProductID = p.ProductID
GROUP BY o.OrderDate
ORDER BY o.OrderDate;


/* =========================================
   TOP PRODUCTS
   ========================================= */


/* 19. TOP 5 PRODUCTS BY SALES */
SELECT TOP 5
    p.ProductName,
    SUM(od.Quantity * p.Price) AS TotalSales
FROM Products p
JOIN OrderDetails od
    ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY TotalSales DESC;


/* =========================================
   ADVANCED SQL
   ========================================= */


/* 20. PRODUCT RANKING BY SALES */
SELECT
    p.ProductName,
    SUM(od.Quantity * p.Price) AS TotalSales,
    RANK() OVER (
        ORDER BY SUM(od.Quantity * p.Price) DESC
    ) AS SalesRank
FROM Products p
JOIN OrderDetails od
    ON p.ProductID = od.ProductID
GROUP BY p.ProductName;


/* 21. CUSTOMER RANKING BY SALES */
SELECT
    c.CustomerName,
    SUM(od.Quantity * p.Price) AS TotalSales,
    DENSE_RANK() OVER (
        ORDER BY SUM(od.Quantity * p.Price) DESC
    ) AS CustomerRank
FROM Customers c
JOIN Orders o
    ON c.CustomerID = o.CustomerID
JOIN OrderDetails od
    ON o.OrderID = od.OrderID
JOIN Products p
    ON od.ProductID = p.ProductID
GROUP BY c.CustomerName;


/* =========================================
   END OF PROJECT
   ========================================= */
