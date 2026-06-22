CREATE TABLE Orders (
       order_id VARCHAR(50) PRIMARY KEY,
       order_date DATE,
       ship_date DATE,
       ship_mode VARCHAR(50),
       order_priority VARCHAR(50),
       shipping_days INT,
       customer_id INT, 
       FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Orders (order_id, order_date, ship_date, ship_mode, order_priority, shipping_days, customer_id)
SELECT r.order_id, MIN(order_date_clean), MIN(ship_date_clean), MIN(ship_mode), MIN(order_priority), MIN(shipping_days), MIN(c.customer_id)
FROM retail_sales_clean r JOIN Customers c ON r.customer_name = c.customer_name
GROUP BY r.order_id; 

