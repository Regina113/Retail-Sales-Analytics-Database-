-- 1. Total Sales & Profit (Baseline Metrics)
SELECT 
     SUM(sales) AS Total_Sales,
     SUM(profit) AS Total_Profit
FROM Order_Items; 

-- 2. Top Selling Products
SELECT p.product_name, SUM(oi.sales) AS total_sales
FROM Order_Items oi JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC
LIMIT 10;

-- 3. Most Profitable Products 
SELECT p.product_name, SUM(oi.profit) AS total_profit 
FROM Order_Items oi JOIN Products p ON oi.product_id = p.product_id 
GROUP BY p.product_name
ORDER BY total_profit DESC
LIMIT 10; 

-- 4. Loss-Making Products 
SELECT p.product_name, SUM(oi.profit) AS total_profit 
FROM Order_Items oi JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.product_name 
HAVING total_profit < 0
ORDER BY total_profit; 

-- 5. Sales By Region
SELECT c.region, SUM(oi.sales) AS total_sales
FROM Order_Items oi JOIN Orders o ON oi.order_id = o.order_id
                    JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY c.region
ORDER BY total_sales DESC;

-- 6. Impact Of Discounts On Profit
SELECT discount, AVG(profit) AS Avg_profit
FROM Order_Items 
GROUP BY discount
ORDER BY discount;

-- 7. Shipping Performance
SELECT AVG(shipping_days) AS Avg_shipping_time
FROM Orders;

-- 8. Running Total Sales (Window Function)
SELECT o.order_date, SUM(oi.sales) AS daily_sales,
                     SUM(SUM(oi.sales)) OVER (ORDER BY o.order_date) AS running_total
FROM Order_Items oi JOIN Orders o ON oi.order_id = o.order_id 
GROUP BY o.order_date 
ORDER BY o.order_date;

-- 9. Monthly Sales Trend 
SELECT YEAR(o.order_date) AS year,
       MONTH(o.order_date) AS month,
       SUM(oi.sales) AS monthly_sales
FROM Order_Items oi JOIN Orders o ON oi.order_id = o.order_id 
GROUP BY YEAR(o.order_date), MONTH(o.order_date)
ORDER BY year, month;

-- 10. Month-Over-Month Growth 
SELECT year, month, monthly_sales, 
       LAG(monthly_sales) OVER (ORDER BY year, month) AS prev_month_sales,
       (monthly_sales - LAG(monthly_sales) OVER (ORDER BY year, month))
       / LAG(monthly_sales) OVER (ORDER BY year, month) * 100 AS growth_percentage
FROM (
     SELECT 
          YEAR(o.order_date) AS year,
          MONTH(o.order_date) AS month,
          SUM(oi.sales) AS monthly_sales
	 FROM order_items oi
     JOIN Orders o ON oi.order_id = o.order_id
     GROUP BY YEAR(o.order_date), MONTH(o.order_date)
) t; 

-- 11. Top Customers By Revenue (Ranking)
SELECT c.customer_name, 
       SUM(oi.sales) AS total_sales,
       RANK() OVER (ORDER BY SUM(oi.sales) DESC) AS rank_position
FROM Order_Items oi JOIN Orders o ON oi.order_id = o.order_id
                    JOIN Customers c ON o.customer_id = c.customer_id 
GROUP BY c.customer_name;

-- 12. Customer Lifetime Value 
SELECT c.customer_name, 
       COUNT(DISTINCT o.order_id) AS total_orders,
       SUM(oi.sales) AS lifetime_value
FROM Customers c JOIN Orders o ON c.customer_id = o.customer_id
				 JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY c.customer_name
ORDER BY lifetime_value DESC;

-- 13. Profit Margin by Product 
SELECT 
     p.product_name,
     SUM(oi.sales) AS total_sales,
     SUM(oi.profit) AS total_profit,
     (SUM(oi.profit) / SUM(oi.sales)) * 100 AS profit_margin
FROM Order_Items oi JOIN Products p ON oi.product_id = p.product_id 
GROUP BY p.product_name
ORDER BY profit_margin DESC;

-- 14. Top 3 Products Per Category
SELECT * 
FROM ( 
     SELECT 
         p.category,
         p.product_name,
         SUM(oi.sales) AS total_sales,
         RANK() OVER (PARTITION BY p.category ORDER BY SUM(oi.sales) DESC) AS rank_in_category
	  FROM Order_Items oi JOIN Products p ON oi.product_id = p.product_id
      GROUP BY p.category, p.product_name 
) ranked 
WHERE rank_in_category <= 3;

-- 15. Core KPIs
SELECT 
     SUM(sales) AS total_revenue,
     SUM(profit) AS total_profit,
     AVG(profit) AS avg_profit_per_order,
     COUNT(DISTINCT order_id) AS total_orders
FROM Order_Items;

-- 16. Average Order Value (AOV)
SELECT 
     SUM(sales) / COUNT(DISTINCT order_id) AS avg_order_value
FROM Order_Items;

-- 17. Profit Ratio
SELECT 
     SUM(profit) / SUM(sales) * 100 AS profit_ratio
FROM Order_Items;

-- PART 3: Basic Forecasting 
-- 18. Moving Average (3-month trend)
SELECT
     year, 
     month, 
     monthly_sales,
     AVG(monthly_sales) OVER (
         ORDER BY year, month
         ROWS BETWEEN 2 PRECEDING AND CURRENT ROW 
	) AS moving_avg_3_months
FROM (
     SELECT 
          YEAR(o.order_date) AS year,
          MONTH(o.order_date) AS month,
          SUM(oi.sales) AS monthly_sales
	FROM Order_Items oi JOIN Orders o ON oi.order_id = o.order_id
    GROUP BY YEAR(o.order_date), MONTH(o.order_date)
) t; 