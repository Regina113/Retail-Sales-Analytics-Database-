CREATE TABLE Customers (
	   customer_id INT AUTO_INCREMENT PRIMARY KEY,
       customer_name VARCHAR(255),
       segment VARCHAR(50),
       state VARCHAR(50),
       region VARCHAR(50),
       country VARCHAR(50)
);

INSERT INTO Customers (customer_name, segment, state, region, country)
SELECT DISTINCT customer_name, segment, state, region, country
FROM retail_sales_clean;