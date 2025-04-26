/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - Aggregate data progressively over time.
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.
	- Helps to understand whether our business is growing or declining
	- [Cumulative Measure] by [Date Dimension]

SQL Functions Used:
    - Window Functions: SUM(), OVER(), AVG(), OVER()
===============================================================================
*/

-- 1. Total sales per month and runnig total of sales over time
SELECT 
      order_date, -- Selected these columns from the subquery
	  total_sales,
	  SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales, -- Calculated additioanl columns using the subquery. Default = Unbounded preceeding and current row. If you wish to pertition the data according to year (window) then use PARTITION BY YEAR(order_date)
	  avg_price,
	  AVG(avg_price) OVER (ORDER BY order_date) AS moving_average_price
FROM(SELECT 
		  DATETRUNC(YEAR, order_date) AS order_date,
		  SUM(sales_amount) AS total_sales,
		  AVG(price) AS avg_price
	 FROM gold.fact_sales
	 WHERE order_date IS NOT NULL
	 GROUP BY DATETRUNC(YEAR, order_date)
	 )t
