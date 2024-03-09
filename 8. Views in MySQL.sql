-- Views 

USE sql_invoicing;

CREATE VIEW sales_by_client AS
SELECT 
	c.client_id,
    c.name,
    SUM(invoice_total) AS total_sales
FROM clients c
JOIN invoices USING (client_id)
GROUP BY client_id, name;


SELECT *
FROM sales_by_client
ORDER BY total_sales DESC;


SELECT *
FROM sales_by_client
WHERE total_sales > 500;


SELECT *
FROM sales_by_client
JOIN clients USING (client_id);


-- Exercise Create View for clients_balance to get 
-- client_id, name, balance



SELECT 
	c.client_id,
    c.name
    -- invoice_total - payment_total AS balance
FROM clients c
JOIN invoices i USING (client_id)
GROUP BY c.client_id;



CREATE VIEW client_balance AS
SELECT 
	c.client_id,
    c.name,
    SUM(invoice_total - payment_total) AS balance
FROM clients c
JOIN invoices i USING (client_id)
GROUP BY client_id;



SELECT * 
FROM client_balance;


-- Altering and Dripping Views

DROP VIEW client_balance;


CREATE OR REPLACE VIEW client_balance AS
SELECT 
	c.client_id,
    c.name,
    SUM(invoice_total - payment_total) AS balance
FROM clients c
JOIN invoices i USING (client_id)
GROUP BY client_id;



-- Updatable Views

-- DISTINCT , Aggregate functions, GROUP BY, HAVING, UNION 
-- If the above function are not in VIEWS then Views are Updatable Views

USE sql_invoicing;

DROP VIEW invoices_with_balance;

CREATE OR REPLACE VIEW invoices_with_balance AS
SELECT 
	invoice_id,
    number,
    client_id,
    invoice_total,
    payment_total,
    invoice_total - payment_total AS balance,
    invoice_date,
    due_date,
    payment_date
FROM invoices
WHERE (invoice_total - payment_total) > 0
WITH CHECK OPTION;


DELETE FROM invoices_with_balance
WHERE invoice_id = 1;


SELECT * from invoices_with_balance;

UPDATE invoices_with_balance
SET due_date = DATE_ADD(due_date, INTERVAL 2 DAY)
WHERE invoice_id = 2;

-- WITH OPTION CHECK Clause


UPDATE invoices_with_balance
SET payment_total = invoice_total
WHERE invoice_id = 2


-- Others Benefits of Views

-- 1 Abstraction of Database
-- 2 Simplify Queries
-- 3 Reduce the impact of changes
-- 4 Restrict access to the data