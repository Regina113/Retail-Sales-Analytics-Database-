CREATE TABLE Products (
       product_id VARCHAR(50) PRIMARY KEY,
       product_name VARCHAR(255),
       category VARCHAR(50),
       sub_category VARCHAR(50)
);

INSERT INTO Products (product_id, product_name, category, sub_category)
SELECT product_id, MIN(product_name), MIN(category), MIN(sub_category)
FROM retail_sales_clean
GROUP BY product_id;

SELECT product_id, COUNT(*)
FROM retail_sales_clean
GROUP BY product_id
HAVING COUNT(*) > 1;

SELECT * 
FROM retail_sales_clean
WHERE product_id = 'OFF-BI-10003708';