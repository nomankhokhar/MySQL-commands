show databases;

use sql_store;

SELECT *
FROM orders
JOIN customers
	ON orders.customer_id = customers.customer_id;
    
    
    
SELECT order_id , orders.customer_id ,first_name , last_name
FROM orders
JOIN customers
	ON orders.customer_id = customers.customer_id;
    
-- Repetion Remove with Alias

SELECT order_id , o.customer_id ,first_name , last_name
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id;
    
-- Exercise show Order item that are in Product Table

SELECT *
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;

-- Exercise   

SELECT order_id, oi.product_id, quantity, oi.unit_price
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;
 

-- Joining Acros Databases
-- First use the database then use non running database for the joining across the database
 
USE sql_store;

SELECT *
FROM order_items oi
JOIN sql_inventory.products p
	ON oi.product_id = p.product_id;


-- Self Join Table

USE sql_hr;

-- Check Weather Employee is Manager or not 
SELECT *
FROM employees e
JOIN employees m
	ON e.reports_to = m.employee_id;


SELECT e.employee_id, 
	   e.first_name,
       m.first_name as manager
FROM employees e
JOIN employees m
	ON e.reports_to = m.employee_id;


-- Joining Multiple Tables

 