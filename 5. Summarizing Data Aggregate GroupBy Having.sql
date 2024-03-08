-- MAX() , MIN(), AVG(), SUM(), COUNT()

USE sql_invoicing;

SELECT MAX(invoice_total) AS highest,
	   MIN(invoice_total) AS lowest,
       AVG(invoice_total) AS Average,
       SUM(invoice_total * 1.1) AS total,
       COUNT(DISTINCT client_id) AS total_records
       -- COUNT(payment_date) AS count_of_payments, -- return not null values
       -- COUNT(*) AS total_records
FROM invoices
WHERE invoice_date > '2019-07-01';

-- Exercise - show date_range, total_sales, total_payments, what_we_expect

SELECT 
	'First half of 2019' AS date_range,
    SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date
	BETWEEN '2019-01-01' AND '2019-06-30'
UNION
SELECT 
	'Second half of 2019' AS date_range,
    SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date
	BETWEEN '2019-07-01' AND '2019-12-31'
UNION
SELECT 
	'Total' AS date_range,
    SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date
	BETWEEN '2019-01-01' AND '2019-12-31';
    

-- GROUP BY Clause then ORDER BY clause

SELECT 
	client_id,
    SUM(invoice_total) AS total_sales
FROM invoices
WHERE invoice_date >= '2019-07-01'
GROUP BY client_id
ORDER BY total_sales DESC;



SELECT 
	state,
    city,
    SUM(invoice_total) AS total_sales
FROM invoices
JOIN clients USING (client_id)
WHERE invoice_date >= '2019-07-01'
GROUP BY state, city;


-- Exercise date , payment_method , total_payments

SELECT 
	date,
    pm.name AS payment_method,
    SUM(amount) AS total_payments
FROM payments p
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id
GROUP BY date, payment_method
ORDER BY date;


-- HAVING Clause is use to filter group data 
-- because We do not use where clause in that matter
-- For HAVING Clause Column should be in Selected Clause

SELECT 
	client_id,
    SUM(invoice_total) AS total_sales,
    COUNT(*) AS number_of_invoices
FROM invoices
GROUP BY client_id
HAVING total_sales > 500 AND number_of_invoices > 5;


-- Exercise Get the customer located in Virginia
-- Who have spent more than $100


USE sql_store;

SELECT 
	c.customer_id,
    c.first_name,
    c.last_name,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM customers c
JOIN orders o USING (customer_id)
JOIN order_items oi USING (order_id)
WHERE state = 'VA'
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING total_sales > 100;

-- 