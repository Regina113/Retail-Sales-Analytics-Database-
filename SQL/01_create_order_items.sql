CREATE TABLE Order_Items(
       order_item_id INT AUTO_INCREMENT PRIMARY KEY,
       order_id VARCHAR(50),
       product_id VARCHAR(50),
       quantity INT,
       sales DECIMAL(10,2),
       discount DECIMAL(5,2),
       profit DECIMAL(10,2),
       shipping_cost DECIMAL(10,2),
       FOREIGN KEY (order_id) REFERENCES Orders(order_id),
       FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO Order_Items (order_id, product_id, quantity, sales, discount, profit, shipping_cost)
SELECT order_id, product_id, quantity, sales, discount, profit, shipping_cost 
FROM retail_sales_clean;

