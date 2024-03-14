-- Mastering the complex Queries
-- SubQueries in MySQL
-- SubQueries return only one Result 
-- Find product that are more expensive than lettuce (id = 3)

USE sql_store;

SELECT *
FROM products
WHERE unit_price > (
	SELECT unit_price
    FROM products 
    WHERE product_id = 3
);


-- Example Find employees whose earn more than average

USE sql_hr;

SELECT *
FROM employees
WHERE salary >  (
	SELECT AVG(salary)
    FROM employees
);


-- IN Operator in MySQL

USE sql_store;

SELECT *
FROM products
WHERE product_id NOT IN (
	SELECT DISTINCT product_id
	FROM order_items
);


-- Exercise Find clients without invoices

USE sql_invoicing;

SELECT *
FROM clients
WHERE client_id NOT IN(
	SELECT DISTINCT client_id
	FROM invoices
);


-- 