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

SELECT *
FROM sql_store.orders;


SELECT *
FROM sql_store.order_statuses;

USE sql_store;

-- Fetch all Data from Tables

SELECT *
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
JOIN order_statuses os
	ON o.status = os.order_status_id;
    
-- Fetch only Specific Tables
-- Show Order Status with Name and ID

SELECT o.order_id,
	   o.order_date,
       c.first_name,
       c.last_name,
       os.name AS statis
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
JOIN order_statuses os
	ON o.status = os.order_status_id; 
    
-- Exercise Find name and Payment Methods of the Clients

USE sql_invoicing;

SELECT *
FROM payments p
JOIN clients c
	ON p.client_id = c.client_id
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id;
    
    
-- Compount Join Conditions when One table 
-- have more than one Primary key we use
-- Compound Key to Fetch Data  

USE sql_store;

SELECT *
FROM order_items oi
JOIN order_item_notes oin
	ON oi.order_id = oin.order_id
    AND oi.product_id = oin.product_id; 
    
    
-- Implicit Join Syntax
-- Writing Query withoud JOIN KeyWord
 
 -- Simple Way
 SELECT *
 FROM orders o
 JOIN customers c
	ON o.customer_id = c.customer_id;
 
-- Implicit way of writing the Query
SELECT *
FROM orders o, customers c
WHERE o.customer_id = c.customer_id;


-- Outer Join Table
-- LEFT and RIGHT are the Outer Joins
 
USE sql_store;

SELECT
	c.customer_id,
    c.first_name,
    o.order_id
FROM customers c
LEFT JOIN orders o
	ON c.customer_id = o.customer_id
ORDER BY c.customer_id;


-- Outer Join Between Multiple Tables

SELECT
	c.customer_id,
    c.first_name,
    o.order_id,
    sh.name AS shipper
FROM customers c
LEFT JOIN orders o
	ON c.customer_id = o.customer_id
LEFT JOIN shippers sh
	ON o.shipper_id = sh.shipper_id
ORDER BY c.customer_id;


-- Exercise that fine order_date, order_id,
-- first_name. shipper, status

SELECT
	o.order_id,
    o.order_date,
    c.first_name AS customer,
    sh.name AS shipper,
    os.name AS status
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
LEFT JOIN shippers sh
	ON o.shipper_id = sh.shipper_id
JOIN order_statuses os
	ON o.status = os.order_status_id;
    

-- Self Outer Joins
-- Find the Employee Does not have Manager within the Table
 
USE sql_hr;

SELECT 
	e.employee_id,
    e.first_name,
    m.first_name AS manager
FROM employees e
LEFT JOIN employees m
	ON e.reports_to = m.employee_id;


-- USING Clause
-- USING keyword is best for the columns that multiple have same columns
 
USE sql_store;

SELECT 
	o.order_id,
    c.first_name,
    sh.name AS shipper
FROM orders o
JOIN customers c
	USING (customer_id)
LEFT JOIN shippers sh
	USING (shipper_id);
    
-- When have diff column Name     
SELECT *
FROM order_items oi
JOIN order_item_notes oin
	USING (order_id, product_id);
    
-- Exercise Show date client amount name from sql_inventory

USE sql_invoicing;

SELECT 
	p.date,
    c.name AS client,
    p.amount,
    pm.name AS payment_method
FROM payments p
JOIN clients c USING (client_id)
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id;
    

-- Natural Joins joind the same columns with different table
-- This is dangerious as well we can not control over it.
 
USE sql_store;

SELECT 
	o.order_id,
    c.first_name
FROM orders o
NATURAL JOIN customers c;


--  CRROS JOIN is to select every record from two tables
--  Both of the Query are the Same that produce same results
 
SELECT *
FROM customers c
CROSS JOIN products p
ORDER BY c.first_name; 

SELECT *
FROM customers c, orders o
ORDER BY c.first_name;


-- Cross JOIN bt shippers and products
-- one is implicit then explicit

-- Implicit
SELECT 
	sh.name AS shipper,
    p.name AS product
FROM shippers sh, products p
ORDER BY sh.name;

-- Explicit
SELECT 
	sh.name AS shipper,
    p.name AS product
FROM shippers sh
CROSS JOIN products p
ORDER BY sh.name; 


--  UNIONs Rows from Multiple Results
-- Like Below 

SELECT 
	order_id,
    order_date,
    'Active' AS status
FROM orders
WHERE order_date >= '2019-01-01';



SELECT 
	order_id,
    order_date,
    'Archived' AS status
FROM orders
WHERE order_date < '2019-01-01';

-- Combine Both of them Using UNION KeyWords 
SELECT 
	order_id,
    order_date,
    'Active' AS status
FROM orders
WHERE order_date >= '2019-01-01'
UNION
SELECT 
	order_id,
    order_date,
    'Archived' AS status
FROM orders
WHERE order_date < '2019-01-01'
