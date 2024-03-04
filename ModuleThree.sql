show databases;

use sql_store;

SELECT *
FROM orders
JOIN customers
	ON orders.customer_id = customers.customer_id;
    
    
    
SELECT order_id , first_name , last_name
FROM orders
JOIN customers
	ON orders.customer_id = customers.customer_id;