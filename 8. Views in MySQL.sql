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
FROM client_balance