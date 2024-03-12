-- Tiggers is a Functions that execute before 
-- and after an insert, update, delete statement.


USE sql_invoicing;


DELIMITER $$
CREATE TRIGGER payments_after_insert
	AFTER INSERT ON payments
    FOR EACH ROW
BEGIN
	UPDATE invoices
    SET payment_total = payment_total + NEW.amount
    WHERE invoice_id = NEW.invoice_id;
END $$
DELIMITER ;


SELECT * FROM sql_invoicing.invoices;


INSERT INTO payments
VALUES (DEFAULT, 5, 3, '2019-01-01', 10, 1);


-- Exercise Create a trigger that gets fired when we 
-- delete a payment.

  
DELIMITER $$
CREATE TRIGGER payments_after_delete
	AFTER DELETE ON payments
    FOR EACH ROW
BEGIN
	UPDATE invoice
    SET payment_total = payment_total - OLD.amount
    WHERE invoice_id = OLD.invoice_id;
END $$
DELIMITER ;

SELECT * FROM sql_invoicing.payments;

DELETE 
FROM payments
WHERE payment_id = 9;


-- Viewing the Triggers in the DB

SHOW TRIGGERS;

SHOW TRIGGERS LIKE 'payment%';


-- DROPING THE TRIGGER

DROP TRIGGER IF EXISTS payments_after_insert;


-- Using Triggers for Auditing