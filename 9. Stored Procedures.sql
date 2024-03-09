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


CALL get_clients_by_state(null);
CALL get_clients_by_state('CA');