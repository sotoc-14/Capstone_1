-- Sales Territory: Colorado (Sales Manager: Jim Heck, Region: West)
-- Question 1: Total revenue, start date, and end date
SELECT *
FROM store_locations
WHERE state = 'Colorado'
;
SELECT  * 
FROM  online_sales
; 
SELECT *
FROM management
;
SELECT SUM(Sale_Amount) AS total_revenue
FROM store_sales
WHERE Store_ID BETWEEN 701 AND 718
;
-- total revenue for Colorado: 6,412,632.22
SELECT MIN(Transaction_Date) AS start_date
FROM store_sales
WHERE Store_ID BETWEEN 701 AND 718
;
SELECT MAX(Transaction_Date) AS end_date
FROM store_sales
WHERE Store_ID BETWEEN 701 AND 718
;
-- start date: 2022-01-01
-- end date: 2025-12-31
SELECT 
YEAR(Transaction_Date), MONTH(Transaction_Date)
FROM store_sales
LIMIT 5
;
SELECT Store_ID, COUNT(*) AS num_transactions
FROM store_sales
GROUP BY Store_ID
ORDER BY Store_ID
;
SELECT sales_month, sales_year, SUM(revenue) AS total_revenue
FROM (SELECT MONTH(Transaction_Date) AS sales_month,
    YEAR(Transaction_Date) AS sales_year, Sale_Amount AS revenue
    FROM store_sales
    WHERE Store_ID BETWEEN 701 AND 718) AS combined_sales
GROUP BY sales_year, sales_month
ORDER BY sales_year, sales_month
;
-- Question 2: Revenue by year and month


