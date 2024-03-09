-- Store Procedures in MySQL

-- 1 Store and Organize SQL
-- 2 Faster Execution
-- 3 Data Security
-- 4 Very Powerfull


-- Creating the Store

DELIMITER $$
CREATE PROCEDURE get_clients()
BEGIN
	SELECT * FROM clients;
END $$
DELIMITER ;


CALL get_clients();


-- Example Create a store procedure called
--    get_invoices_with_balance
-- 	  to return all the invoice with a balance > 0

DELIMITER $$
CREATE PROCEDURE get_invoices_with_balance()
BEGIN 
	SELECT *
    FROM invoices_with_balance
    WHERE balance > 0;
END$$

DELIMITER ;


CALL get_invoices_with_balance();


-- Creating Procedure Using MySQLWorkBench
-- Creating Store Procedure using MySQLWorkBench 
-- Right Click the Store Proceduer then You do not 
-- need to change DELIMITER




-- DROPING the Store Procedure
-- Usually Procedures and Views are Store in Separate File

DROP PROCEDURE IF EXISTS get_clients_by_state;

DELIMITER $$
CREATE PROCEDURE get_clients_by_state()
BEGIN
	SELECT * FROM clients;
END $$
DELIMITER ;



-- Parameters in Store Procedures

DELIMITER $$
CREATE PROCEDURE get_clients_by_state
(
	state CHAR(2)
)
BEGIN
	SELECT * FROM clients c
    WHERE c.state = state;
END $$
DELIMITER ;


CALL get_clients_by_state('NY');

-- Exercise Write Store proceduer to return invoices
-- for a given clients
-- get_invoices_by_client

DELIMITER $$
CREATE PROCEDURE get_invoices_by_client
(
	client_id INT
)
BEGIN
	SELECT *
    FROM invoices i
    WHERE i.client_id = client_id;
END $$

DELIMITER ;


CALL get_invoices_by_client(1);


-- Parameters with Defaault Values


DROP PROCEDURE get_clients_by_state;

DELIMITER $$
CREATE PROCEDURE get_clients_by_state
(
	state CHAR(2)
)
BEGIN
	IF state IS NULL THEN
		SET state = 'CA';
    END IF;
    
    SELECT * FROM clients c
    WHERE c.state = state;
END $$
DELIMITER ;


CALL get_clients_by_state(NULL);


-- Store Procedure IF state is NULL with Default Parameters


DROP PROCEDURE get_clients_by_state;


DELIMITER $$
CREATE PROCEDURE get_clients_by_state
(
	state CHAR(2)
)
BEGIN
	IF state IS NULL THEN
		SELECT * FROM clients;
    ELSE
		SELECT * FROM clients c
		WHERE c.state = state;
    END IF;
END $$
DELIMITER ;


-- Best way to right the Query

DELIMITER $$
CREATE PROCEDURE get_clients_by_state
(
	state CHAR(2)
)
BEGIN
	SELECT * FROM clients c
	WHERE c.state = IFNULL(state, c.state);
END $$
DELIMITER ;


CALL get_clients_by_state(null);
CALL get_clients_by_state('CA');


-- Example Write a Stored proceduer called get_payments
-- with two parameters
-- client => INT(4)
-- payment_method_id => TINYINT (1) 0-255 type Only



DELIMITER $$
CREATE PROCEDURE get_payments
(
	client_id INT,
    payment_method_id TINYINT
)
BEGIN 
	SELECT *
    FROM payments p
    WHERE 
		p.client_id = IFNULL(client_id, p.client_id) AND
        p.payment_method = IFNULL(payment_method_id, p.payment_method);
END $$
DELIMITER ;


CALL get_payments(null , null);
CALL get_payments(null , 2);


-- Parameters Validation of Store Procedure

DROP PROCEDURE make_payment;

DELIMITER $$
CREATE PROCEDURE make_payment
(
	invoice_id INT,
    payment_amount DECIMAL(9, 2),
    payment_date DATE
)
BEGIN
	IF payment_amount <= 0 THEN
     SIGNAL SQLSTATE '22003'
		SET MESSAGE_TEXT = 'Invalid payment amount';
    END IF;    
	UPDATE invoices i
    SET 
		i.payment_total = payment_amount,
        i.payment_date = payment_date
	WHERE i.invoice_id = invoice_id;
END $$

DELIMITER ;


CALL make_payment(2, -100 , '2019-01-01')


-- Output Parameters

DROP PROCEDURE get_unpaid_invoices_for_client


DELIMITER $$
CREATE PROCEDURE get_unpaid_invoices_for_client
(
	client_id INT,
    OUT invoices_count INT,
    OUT invoices_total DECIMAL(9, 2)
)
BEGIN 
	SELECT COUNT(*), SUM(invoice_total)
    INTO invoices_count, invoice_total
    FROM invoices i
    WHERE i.client_id = client_id
		AND payment_total = 0;
END $$

DELIMITER ;


-- OutPut Parameter 

SET @invoices_count = 0;
SET @invoices_total = 0;
CALL get_unpaid_invoices_for_client(3);
SELECT @invoices_count, @invoices_total;



-- Variable in Store Procedure Local Variable is usefull for Store Procedure

DELIMITER $$
CREATE PROCEDURE get_risk_factor()
BEGIN 
	DECLARE risk_factor DECIMAL(9, 2) DEFAULT 0;
    DECLARE invoices_total DECIMAL(9, 2);
    DECLARE invoices_count INT;
    
    SELECT COUNT(*), SUM(invoice_total)
    INTO invoices_count, invoices_total
    FROM invoices;
    
    SET risk_factor = invoices_total / invoices_count * 5;
    
    SELECT risk_factor;
END $$

DELIMITER ;


DROP PROCEDURE get_risk_factor;


CALL get_risk_factor();



--  Functions in MySQL

DROP FUNCTION get_risk_factor_for_client;

DELIMITER $$
CREATE FUNCTION get_risk_factor_for_client
(
	client_id INT
)
RETURNS INTEGER
READS SQL DATA
BEGIN
	DECLARE risk_factor DECIMAL(9, 2) DEFAULT 0;
	DECLARE invoices_total DECIMAL(9, 2);
	DECLARE invoices_count INT;
		
	SELECT COUNT(*), SUM(invoice_total)
	INTO invoices_count, invoices_total
	FROM invoices i
    WHERE i.client_id = client_id;
		
	SET risk_factor = invoices_total / invoices_count * 5;
		
	RETURN IFNULL(risk_factor, 0);
END $$

DELIMITER ;



SELECT 
	client_id,
    name,
    get_risk_factor_for_client(client_id) as risk_factor
FROM clients;