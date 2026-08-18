-- =====================================================
-- SQL SALES ANALYSIS PROJECT
-- Business Analysis Queries
-- SQL Server / SSMS
-- =====================================================


-- =====================================================
-- 1. TOTAL SALES
-- =====================================================

SELECT
    SUM(p.Price * od.Quantity) AS TotalSales
FROM Orders o
INNER JOIN OrderDetails od
    ON o.OrderID = od.OrderID
INNER JOIN Products p
    ON od.ProductID = p.ProductID;


-- =====================================================
-- 2. PRODUCT-WISE SALES
-- =====================================================

SELECT
    p.ProductName,
    SUM(p.Price * od.Quantity) AS TotalSales
FROM OrderDetails od
INNER JOIN Products p
    ON od.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalSales DESC;


-- =====================================================
-- 3. TOP PRODUCT
-- =====================================================

SELECT TOP 1
    p.ProductName,
    SUM(p.Price * od.Quantity) AS TotalSales
FROM OrderDetails od
INNER JOIN Products p
    ON od.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalSales DESC;


-- =====================================================
-- 4. CUSTOMER-WISE TOTAL SALES
-- =====================================================

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


-- =====================================================
-- 5. CATEGORY-WISE SALES
-- =====================================================

SELECT
    p.Category,
    SUM(p.Price * od.Quantity) AS TotalSales
FROM OrderDetails od
INNER JOIN Products p
    ON od.ProductID = p.ProductID
GROUP BY p.Category
ORDER BY TotalSales DESC;


-- =====================================================
-- 6. MONTHLY SALES
-- =====================================================

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
ORDER BY
    SalesYear,
    SalesMonth;


-- =====================================================
-- 7. TOP 3 PRODUCTS USING RANK()
-- =====================================================

WITH ProductSales AS
(
    SELECT
        p.ProductName,
        SUM(p.Price * od.Quantity) AS TotalSales,
        RANK() OVER
        (
            ORDER BY SUM(p.Price * od.Quantity) DESC
        ) AS SalesRank
    FROM OrderDetails od
    INNER JOIN Products p
        ON od.ProductID = p.ProductID
    GROUP BY p.ProductName
)
SELECT
    ProductName,
    TotalSales,
    SalesRank
FROM ProductSales
WHERE SalesRank <= 3
ORDER BY SalesRank;


-- =====================================================
-- 8. CUSTOMER ORDER COUNT
-- =====================================================

SELECT
    c.CustomerName,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName
ORDER BY TotalOrders DESC;


-- =====================================================
-- 9. CUSTOMER PERFORMANCE USING CASE WHEN
-- =====================================================

SELECT
    c.CustomerName,
    SUM(p.Price * od.Quantity) AS TotalSpent,
    CASE
        WHEN SUM(p.Price * od.Quantity) >= 100000
            THEN 'High'
        WHEN SUM(p.Price * od.Quantity) >= 50000
            THEN 'Medium'
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


-- =====================================================
-- 10. MOST SOLD PRODUCT BY QUANTITY
-- =====================================================

SELECT
    p.ProductName,
    SUM(od.Quantity) AS TotalQuantity
FROM OrderDetails od
INNER JOIN Products p
    ON od.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalQuantity DESC;


-- =====================================================
-- 11. AVERAGE ORDER VALUE
-- =====================================================

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


-- =====================================================
-- 12. CITY-WISE SALES
-- =====================================================

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


-- =====================================================
-- 13. CATEGORY-WISE QUANTITY SOLD
-- =====================================================

SELECT
    p.Category,
    SUM(od.Quantity) AS TotalQuantity
FROM OrderDetails od
INNER JOIN Products p
    ON od.ProductID = p.ProductID
GROUP BY p.Category
ORDER BY TotalQuantity DESC;


-- =====================================================
-- 14. AVERAGE PRICE BY CATEGORY
-- =====================================================

SELECT
    Category,
    AVG(Price) AS AveragePrice
FROM Products
GROUP BY Category
ORDER BY AveragePrice DESC;


-- =====================================================
-- 15. CUSTOMERS SPENDING MORE THAN 50000
-- =====================================================

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


-- =====================================================
-- 16. CUSTOMER RANKING
-- =====================================================

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


-- =====================================================
-- 17. COALESCE - NULL SAFE ORDER COUNT
-- =====================================================

SELECT
    c.CustomerName,
    COALESCE(COUNT(o.OrderID), 0) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName;


-- =====================================================
-- END OF SALES ANALYSIS
-- =====================================================
