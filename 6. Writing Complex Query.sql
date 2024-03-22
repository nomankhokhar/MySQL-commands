-- Mastering the complex Queries
-- SubQueries in MySQL
-- SubQueries return only one Result 
-- Find product that are more expensive than lettuce (id = 3)



-- we use subQuery when one Query data is consist of another Query data

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
);


-- ANY keyword in MySQL
-- Select client with at least two invoices

-- One way  
SELECT * 
FROM clients
WHERE client_id IN (
	SELECT client_id
	FROM invoices
	GROUP BY client_id
	HAVING COUNT(*) >= 2
);


-- Another way
SELECT * 
FROM clients
WHERE client_id = ANY (
	SELECT client_id
	FROM invoices
	GROUP BY client_id
	HAVING COUNT(*) >= 2
);



-- Correlated Subqueries

-- Select emplyess whose salary is
-- above averge in their office

USE sql_hr;

-- The Query that have correlated with outer query 
-- is Correlated Query
-- This slow due to lot of data

SELECT *
FROM employees e
WHERE salary > (
	SELECT AVG(salary)
    FROM employees
    WHERE office_id = e.office_id
);


-- Get Invoices that are larger than the
-- client's average invoice amount

USE sql_invoicing;

SELECT *
FROM invoices i
WHERE invoice_total > (
	SELECT AVG(invoice_total)
    FROM invoices
    WHERE client_id = i.client_id
);



-- The EXISTS Operator in MySQL

-- Select Clients that have an invoice

-- Exits operator is Fast whenever record is matched than show the result

SELECT *
FROM clients c
WHERE EXISTS (
	SELECT client_id
    FROM invoices
    WHERE client_id = c.client_id
);


-- Exercise Find the products that have never been never
-- orderd

USE sql_store;

SELECT *
FROM products p
WHERE NOT EXISTS (
	SELECT product_id
    FROM order_items
    WHERE product_id = p.product_id
);



-- SubQueries in Select statement
-- SubQueries in From Clause 
-- Learn both youself