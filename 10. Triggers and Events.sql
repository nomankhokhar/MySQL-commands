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
VALUES (DEFAULT, 5, 3, '2019-01-01', 0, 1);


-- Exercise Create a trigger that gets fired when we 
-- delete a payment.


DROP TRIGGER IF EXISTS payments_after_delete;

DELIMITER $$
CREATE TRIGGER payments_after_delete
	AFTER DELETE ON payments
    FOR EACH ROW
BEGIN
	UPDATE invoice
    SET payment_total = payment_total - OLD.amount
    WHERE invoice_id = OLD.invoice_id;
    
    INSERT INTO payments_audit
    VALUES (OLD.client_id, OLD.date, OLD.amount, 'Delete', NOW());
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

DROP TRIGGER IF EXISTS payments_after_insert;

DELIMITER $$
CREATE TRIGGER payments_after_insert
	AFTER INSERT ON payments
    FOR EACH ROW
BEGIN
	UPDATE invoices
    SET payment_total = payment_total + NEW.amount
    WHERE invoice_id = NEW.invoice_id;
    
    INSERT INTO payments_audit
    VALUES (NEW.client_id, NEW.date, NEW.amount, 'Insert', NOW());
END $$
DELIMITER ;

USE sql_invoicing;

INSERT INTO payments
VALUES (DEFAULT, 5 ,3 , '2019-01-01', 10 , 1);



-- Events in MuSQL

SHOW VARIABLES;

SHOW VARIABLES LIKE 'event%';
SET GLOBAL event_scheduler = ON;


-- Creating Events

DROP EVENT yearly_delete_stale_audit_rows;

DELIMITER $$


-- Delete record older than 1 year

CREATE EVENT yearly_delete_stale_audit_rows
ON SCHEDULE
	-- AT '2019-05-01'
    EVERY 1 YEAR STARTS '2019-01-01' ENDS '2029-01-01'
DO BEGIN 
	DELETE FROM payments_audit
    WHERE action_date < NOW() - INTERVAL 1 YEAR;
END $$

DELIMITER ;


-- Viewing and Droping Events
 
SHOW EVENTS;

DROP EVENT IF EXISTS yearly_delete_stale_audit_rows;


-- In this Events we Alter the table in the Old Table
 
DELIMITER $$
ALTER EVENT yearly_delete_stale_audit_rows
ON SCHEDULE
	-- AT '2019-05-01'
    EVERY 1 YEAR STARTS '2019-01-01' ENDS '2029-01-01'
DO BEGIN 
	DELETE FROM payments_audit
    WHERE action_date < NOW() - INTERVAL 1 YEAR;
END $$

DELIMITER ;


-- For Enable and Disbale the Events

ALTER EVENT yearly_delete_stale_audit_rows DISABLE;