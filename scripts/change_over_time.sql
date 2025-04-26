/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.
	- [Measure] by [Date Dimension]

SQL Functions Used:
    - Date Functions: DATEPART(), DATETRUNC(), FORMAT()
    - Aggregate Functions: SUM(), COUNT(), AVG()
===============================================================================
*/

-- 1. Analyze the sales performance over time

-- (a) Yearly Trends
SELECT 
      YEAR(order_date) AS order_year,
      SUM(sales_amount) AS total_sales,
      COUNT(DISTINCT customer_key) AS total_customers,
      SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date)

-- (b) Monthly Trends (Detailed insights to discover seasonality in your data)
SELECT 
      MONTH(order_date) AS order_month,
      SUM(sales_amount) AS total_sales,
      COUNT(DISTINCT customer_key) AS total_customers,
      SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY MONTH(order_date)
ORDER BY MONTH(order_date)

-- (c) Year + Month Trends
SELECT 
      DATETRUNC(month, order_date) AS order_date, -- (Can use FORMAT(order_date, 'yyy-MM') - but wont be sorted correctly as the putput will be a string
      SUM(sales_amount) AS total_sales,
      COUNT(DISTINCT customer_key) AS total_customers,
      SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
ORDER BY DATETRUNC(month, order_date)
