-- =====================================================================================
-- FILE: 01_data_cleaning.sql
-- PURPOSE: Clean retail sales raw data
-- -Trim text
-- -Standardize categories
-- -Handle NULLs
-- -Convert dates
-- -Remove duplicates
-- ======================================================================================retail_sales_rawretail_sales_clean

SELECT * FROM retail_sales_raw
LIMIT 10;

SELECT order_date, ship_date
FROM retail_sales_raw
LIMIT 10;

SELECT COUNT(*)
FROM retail_sales_raw
WHERE order_id IS NULL;

SELECT COUNT(*) FROM retail_sales_raw;

DESCRIBE retail_sales_raw;

SELECT `ï»¿order_id` FROM retail_sales_raw;
ALTER TABLE retail_sales_raw
RENAME COLUMN `ï»¿order_id` TO order_id;

SELECT COUNT(*)
FROM retail_sales_raw
WHERE order_id IS NULL;

CREATE TABLE retail_sales_clean AS 
SELECT * FROM retail_sales_raw;

SELECT * FROM retail_sales_clean
LIMIT 10;

SET SQL_SAFE_UPDATES = 0;

UPDATE retail_sales_clean 
SET customer_name = TRIM(customer_name),
    state = TRIM(state),
    country = TRIM(country),
    product_name = TRIM(product_name);
    
UPDATE retail_sales_clean
SET country = 'United States'
WHERE country IN ('USA', 'US', 'U.S.');

SELECT order_id, product_id, COUNT(*)
FROM retail_sales_clean
GROUP BY order_id, product_id
HAVING COUNT(*) > 1;

SELECT order_date
FROM retail_sales_clean
WHERE STR_TO_DATE(order_date, '%m/%d/%Y') IS NULL
LIMIT 50;

ALTER TABLE retail_sales_clean
ADD COLUMN order_date_clean DATE,
ADD COLUMN ship_date_clean DATE;

UPDATE retail_sales_clean
SET order_date_clean = CASE
    WHEN order_date LIKE '%/%/%' THEN STR_TO_DATE(order_date, '%m/%d/%Y')
    WHEN order_date LIKE '%-%-%' THEN STR_TO_DATE(order_date, '%d-%m-%Y')
    ELSE NULL
END,
ship_date_clean = CASE
    WHEN ship_date LIKE '%/%/%' THEN STR_TO_DATE(ship_date, '%m/%d/%Y')
    WHEN ship_date LIKE '%-%-%' THEN STR_TO_DATE(ship_date, '%d-%m-%Y')
    ELSE NULL
END;

SELECT order_date, order_date_clean
FROM retail_sales_clean
WHERE order_date_clean IS NULL;

ALTER TABLE retail_sales_clean 
ADD COLUMN shipping_days INT;

UPDATE retail_sales_clean
SET shipping_days = DATEDIFF(ship_date_clean, order_date_clean);

DESCRIBE retail_sales_clean;

SET SQL_SAFE_UPDATES = 1;