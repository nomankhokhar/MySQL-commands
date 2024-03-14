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


-- SubQueries vs Joins

-- Find customers who have ordered lettuce (id = 3)
-- Select customer_id, first_name, last_name

USE sql_store;

-- Using SubQueries

SELECT customer_id, first_name, last_name
FROM customers
WHERE customer_id IN (
	SELECT o.customer_id
    FROM order_items oi
    JOIN orders o USING(order_id)
     WHERE product_id = 3
);

-- Using Joins this is more readable

SELECT DISTINCT customer_id, first_name, last_name
FROM customers c
JOIN orders o USING (customer_id)
JOIN order_items oi USING (order_id)
WHERE oi.product_id = 3;


-- ALL keyword in MySQL

-- Select invoices larger than all invoices of
-- client 3

USE sql_invoicing;

-- This is not done by ALL keyword

SELECT *
FROM invoices
WHERE invoice_total > (
	SELECT MAX(invoice_total)
    FROM invoices
    WHERE client_id = 3
);

-- This is done by ALL Keyword
-- SubQuery return multiple result that is why ALL keyword check multiple data

SELECT *
FROM invoices
WHERE invoice_total > ALL (
	SELECT invoice_total
    FROM invoices
    WHERE client_id = 3
)
