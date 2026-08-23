select * from customer

Superstore queries sqlserver · SQL
-- ============================================================
-- SUPERSTORE SALES ANALYSIS -- SQL SERVER (T-SQL) VERSION
-- ============================================================
-- Table name used below: dbo.customer  (rename if you used a
-- different name -- e.g. EXEC sp_rename 'customer', 'orders';)
--
-- Key differences from the SQLite version:
--   * TOP N        instead of LIMIT N
--   * [Order Date] instead of "Order Date"  (brackets, not quotes)
--   * Everything else (GROUP BY, HAVING, window functions) is the same
-- ============================================================
 
 
-- ------------------------------------------------------------
-- 0. Quick sanity check -- confirm the upload worked
-- ------------------------------------------------------------
SELECT COUNT(*) AS row_count FROM dbo.customer;
 
SELECT TOP 5 * FROM dbo.customer;
 
 
-- ------------------------------------------------------------
-- 1. Sales, Profit & Margin by Category
-- ------------------------------------------------------------
SELECT
    Category,
    ROUND(SUM(Sales), 2)  AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) * 100.0 / SUM(Sales), 2) AS margin_pct
FROM dbo.customer
GROUP BY Category
ORDER BY total_sales DESC;
 
 
-- ------------------------------------------------------------
-- 2. Year-over-Year Sales & Profit
-- ------------------------------------------------------------
SELECT
    [Order Year] AS year,
    ROUND(SUM(Sales), 2)  AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM dbo.customer
GROUP BY [Order Year]
ORDER BY year;
 
 
-- ------------------------------------------------------------
-- 3. Loss-Making Region + Sub-Category Combinations
-- ------------------------------------------------------------
SELECT
    Region,
    [Sub-Category],
    ROUND(SUM(Profit), 2) AS total_profit,
    COUNT(*) AS num_orders
FROM dbo.customer
GROUP BY Region, [Sub-Category]
HAVING SUM(Profit) < 0
ORDER BY total_profit ASC;
 
 
-- ------------------------------------------------------------
-- 4. Top 10 Customers by Lifetime Sales
-- ------------------------------------------------------------
SELECT TOP 10
    [Customer Name],
    Segment,
    COUNT(DISTINCT [Order ID]) AS num_orders,
    ROUND(SUM(Sales), 2)  AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM dbo.customer
GROUP BY [Customer Name], Segment
ORDER BY total_sales DESC;
 
 
-- ------------------------------------------------------------
-- 5. Monthly Sales Trend with Running Total (window function)
-- ------------------------------------------------------------
SELECT
    [Order Month-Year] AS month,
    ROUND(SUM(Sales), 2) AS monthly_sales,
    ROUND(SUM(SUM(Sales)) OVER (ORDER BY [Order Month-Year]), 2) AS running_total
FROM dbo.customer
GROUP BY [Order Month-Year]
ORDER BY month;
 
 
-- ------------------------------------------------------------
-- 6. Discount Impact -- Avg Discount vs Avg Profit Margin
-- ------------------------------------------------------------
SELECT
    Category,
    ROUND(AVG(Discount), 3) AS avg_discount,
    ROUND(AVG([Profit Margin]), 3) AS avg_profit_margin
FROM dbo.customer
GROUP BY Category
ORDER BY avg_discount DESC;
 
 
-- ------------------------------------------------------------
-- 7. Best-Selling Products by Quantity
-- ------------------------------------------------------------
SELECT TOP 10
    [Product Name],
    Category,
    SUM(Quantity) AS total_units_sold,
    ROUND(SUM(Sales), 2) AS total_sales
FROM dbo.customer
GROUP BY [Product Name], Category
ORDER BY total_units_sold DESC;
 
 
-- ------------------------------------------------------------
-- 8. Regional Performance Summary
-- ------------------------------------------------------------
SELECT
    Region,
    ROUND(SUM(Sales), 2)  AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) * 100.0 / SUM(Sales), 2) AS margin_pct,
    COUNT(DISTINCT [Order ID]) AS num_orders
FROM dbo.customer
GROUP BY Region
ORDER BY total_sales DESC;
 
 
-- ------------------------------------------------------------
-- 9. Average Shipping Days by Ship Mode
-- ------------------------------------------------------------
SELECT
    [Ship Mode],
    COUNT(DISTINCT [Order ID]) AS num_orders,
    ROUND(AVG(CAST([Shipping Days] AS FLOAT)), 2) AS avg_shipping_days
FROM dbo.customer
GROUP BY [Ship Mode]
ORDER BY avg_shipping_days;
 
 
-- ------------------------------------------------------------
-- 10. Customer Segment Contribution
-- ------------------------------------------------------------
SELECT
    Segment,
    ROUND(SUM(Sales), 2)  AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Sales) * 100.0 / (SELECT SUM(Sales) FROM dbo.customer), 1) AS pct_of_total_sales
FROM dbo.customer
GROUP BY Segment
ORDER BY total_sales DESC;
 

