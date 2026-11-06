-- Sales Territory: Colorado (Sales Manager: Jim Heck, Region: West)
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
-- Question 1: Total revenue, start date, and end date
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
SELECT
    YEAR(Transaction_Date) AS sales_year,
    MONTH(Transaction_Date) AS sales_month,
    SUM(Sale_Amount) AS total_revenue
FROM store_sales
WHERE Store_ID BETWEEN 701 AND 718
GROUP BY sales_year, sales_month
ORDER BY sales_year, sales_month;

-- Question 3
SELECT group_label, SUM(revenue) AS total_revenue
FROM (
    SELECT 'Colorado' AS group_label,
           Sale_Amount AS revenue
				FROM store_sales
		WHERE Store_ID BETWEEN 701 AND 718
			UNION ALL
    SELECT 'Online' AS group_label,
           SalesTotal AS revenue
				FROM online_sales
			UNION ALL
    SELECT 'West Region' AS group_label,
           Sale_Amount AS revenue
		FROM store_sales
		WHERE Store_ID BETWEEN 701 AND 718
			UNION ALL
    SELECT 'West Region' AS group_label,
           SalesTotal AS revenue
    FROM online_sales
) AS combined_sales
GROUP BY group_label;
-- Colorado: 6,412,632.22
-- Online:   68,004,827.05

-- Question 4: Transactions per month and average
-- transaction amount by product category

SELECT 
    YEAR(ss.Transaction_Date) AS sales_year,
    MONTH(ss.Transaction_Date) AS sales_month,
    ic.Category AS product_category,
    COUNT(*) AS num_transactions,
    ROUND(AVG(ss.Sale_Amount), 2) AS avg_transaction_amount
FROM store_sales ss
JOIN products p
    ON ss.Prod_Num = p.ProdNum
JOIN inventory_categories ic
    ON p.Categoryid = ic.Categoryid
WHERE ss.Store_ID BETWEEN 701 AND 718
GROUP BY sales_year, sales_month, ic.Category
ORDER BY sales_year, sales_month, ic.Category
;
-- Question 4 Findings:
-- Technology & Accessories had 505 sales
-- records in October 2025, with an average
-- sale amount of $508.91.
-- This category is important to Colorado's
-- revenue because of its high average sale amount.

-- Question 5: Ranking Colorado stores by revenue

SELECT
    ss.Store_ID,
    sl.StoreLocation AS City,
    SUM(ss.Sale_Amount) AS total_revenue
FROM store_sales ss
JOIN store_locations sl
    ON ss.Store_ID = sl.StoreId
WHERE sl.State = 'Colorado'
GROUP BY ss.Store_ID, sl.StoreLocation
ORDER BY total_revenue DESC;



-- Question 6: Recommendation for Next Quarter
-- I recommend focusing sales attention on Stores
-- 715, 718, and 702 because they generated the
-- lowest total revenue in Colorado.
-- Store 705 had the highest revenue at $917,471.53,
-- while Store 715 had the lowest at $279,268.94.
-- I recommend reviewing what makes Store 705
-- successful and seeing if similar strategies
-- could improve sales at the lower-performing stores.

