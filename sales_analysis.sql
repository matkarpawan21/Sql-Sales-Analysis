-- SQL Sales Analysis Project
-- Business Analysis Queries
-- SQL Server / SSMS


-- 1. Total Sales
SELECT
    SUM(p.Price * od.Quantity) AS TotalSales
FROM Orders o
INNER JOIN OrderDetails od
    ON o.OrderID = od.OrderID
INNER JOIN Products p
    ON od.ProductID = p.ProductID;


-- 2. Product-wise Sales
SELECT
    p.[Products Name],
    SUM(p.Price * od.Quantity) AS TotalSales
FROM OrderDetails od
INNER JOIN Products p
    ON od.ProductID = p.ProductID
GROUP BY p.[Products Name]
ORDER BY TotalSales DESC;


-- 3. Top Product
SELECT TOP 1
    p.[Products Name],
    SUM(p.Price * od.Quantity) AS TotalSales
FROM OrderDetails od
INNER JOIN Products p
    ON od.ProductID = p.ProductID
GROUP BY p.[Products Name]
ORDER BY TotalSales DESC;


-- 4. Customer-wise Total Sales
SELECT
    c.CustomerName,
    SUM(p.Price * od.Quantity) AS TotalSpent
FROM Customers c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID
INNER JOIN OrderDetails od
    ON o.OrderID = od.OrderID
INNER JOIN Products p
    ON od.ProductID = p.ProductID
GROUP BY c.CustomerName
ORDER BY TotalSpent DESC;


-- 5. Category-wise Sales
SELECT
    p.Category,
    SUM(p.Price * od.Quantity) AS TotalSales
FROM OrderDetails od
INNER JOIN Products p
    ON od.ProductID = p.ProductID
GROUP BY p.Category
ORDER BY TotalSales DESC;


-- 6. Monthly Sales
SELECT
    YEAR(o.OrderDate) AS SalesYear,
    MONTH(o.OrderDate) AS SalesMonth,
    SUM(p.Price * od.Quantity) AS TotalSales
FROM Orders o
INNER JOIN OrderDetails od
    ON o.OrderID = od.OrderID
INNER JOIN Products p
    ON od.ProductID = p.ProductID
GROUP BY
    YEAR(o.OrderDate),
    MONTH(o.OrderDate)
ORDER BY TotalSales DESC;


-- 7. Top 3 Products using RANK()
WITH ProductSales AS
(
    SELECT
        p.[Products Name],
        SUM(p.Price * od.Quantity) AS TotalSales,
        RANK() OVER
        (
            ORDER BY SUM(p.Price * od.Quantity) DESC
        ) AS SalesRank
    FROM OrderDetails od
    INNER JOIN Products p
        ON od.ProductID = p.ProductID
    GROUP BY p.[Products Name]
)
SELECT
    [Products Name],
    TotalSales,
    SalesRank
FROM ProductSales
WHERE SalesRank <= 3
ORDER BY SalesRank;


-- 8. Customer Order Count
SELECT
    c.CustomerName,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName
ORDER BY TotalOrders DESC;


-- 9. Customer Performance using CASE WHEN
SELECT
    c.CustomerName,
    SUM(p.Price * od.Quantity) AS TotalSpent,
    CASE
        WHEN SUM(p.Price * od.Quantity) >= 100000 THEN 'High'
        WHEN SUM(p.Price * od.Quantity) >= 50000 THEN 'Medium'
        ELSE 'Low'
    END AS CustomerCategory
FROM Customers c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID
INNER JOIN OrderDetails od
    ON o.OrderID = od.OrderID
INNER JOIN Products p
    ON od.ProductID = p.ProductID
GROUP BY c.CustomerName
ORDER BY TotalSpent DESC;


-- 10. Most Sold Product by Quantity
SELECT
    p.[Products Name],
    SUM(od.Quantity) AS TotalQuantity
FROM OrderDetails od
INNER JOIN Products p
    ON od.ProductID = p.ProductID
GROUP BY p.[Products Name]
ORDER BY TotalQuantity DESC;


-- 11. Average Order Value
SELECT
    AVG(OrderTotal) AS AverageOrderValue
FROM
(
    SELECT
        od.OrderID,
        SUM(p.Price * od.Quantity) AS OrderTotal
    FROM OrderDetails od
    INNER JOIN Products p
        ON od.ProductID = p.ProductID
    GROUP BY od.OrderID
) AS OrderSales;


-- 12. City-wise Sales
SELECT
    c.City,
    SUM(p.Price * od.Quantity) AS TotalSales
FROM Customers c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID
INNER JOIN OrderDetails od
    ON o.OrderID = od.OrderID
INNER JOIN Products p
    ON od.ProductID = p.ProductID
GROUP BY c.City
ORDER BY TotalSales DESC;


-- 13. Category-wise Quantity Sold
SELECT
    p.Category,
    SUM(od.Quantity) AS TotalQuantity
FROM OrderDetails od
INNER JOIN Products p
    ON od.ProductID = p.ProductID
GROUP BY p.Category
ORDER BY TotalQuantity DESC;


-- 14. Average Price by Category
SELECT
    Category,
    AVG(Price) AS AveragePrice
FROM Products
GROUP BY Category
ORDER BY AveragePrice DESC;


-- 15. Customers Spending More Than 50000
SELECT
    c.CustomerName,
    SUM(p.Price * od.Quantity) AS TotalSpent
FROM Customers c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID
INNER JOIN OrderDetails od
    ON o.OrderID = od.OrderID
INNER JOIN Products p
    ON od.ProductID = p.ProductID
GROUP BY c.CustomerName
HAVING SUM(p.Price * od.Quantity) > 50000
ORDER BY TotalSpent DESC;


-- 16. Customer Ranking
SELECT
    c.CustomerName,
    SUM(p.Price * od.Quantity) AS TotalSpent,
    RANK() OVER
    (
        ORDER BY SUM(p.Price * od.Quantity) DESC
    ) AS CustomerRank
FROM Customers c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID
INNER JOIN OrderDetails od
    ON o.OrderID = od.OrderID
INNER JOIN Products p
    ON od.ProductID = p.ProductID
GROUP BY c.CustomerName
ORDER BY CustomerRank;


-- 17. COALESCE - NULL Safe Order Count
SELECT
    c.CustomerName,
    COALESCE(COUNT(o.OrderID), 0) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName;
