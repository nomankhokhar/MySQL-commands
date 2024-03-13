-- A group of SQL statement that represent a single unit of work
-- is called Transactions

-- ACID -> Atomicity, Consistency, Isolation, Durability.

USE sql_store;

START TRANSACTION;

INSERT INTO orders (customer_id, order_date, status)
VALUES (1, '2019-01-01', 1);

INSERT INTO order_otems
VALUES (LAST_INSERT_ID, 1, 1, 1);

COMMIT ;



SELECT *
FROM sql_store.orders;


SELECT *
FROM sql_store.order_items;


-- Whenever we execute any statement like select, update, delete and more command
-- MySQL commit it as a Transactions and return it.

 
SHOW VARIABLES LIKE 'autocommit';


-- Concurrency and Locking

USE sql_store;

SELECT * 
FROM sql_store.customers;

START TRANSACTION;
UPDATE customers
SET points = points + 10
WHERE customer_id = 1;
COMMIT;



-- By default MySQL use LOCK to update same transaction
-- but we can use more lock to solve the Concurrency Problem
-- Common Lost Updates

-- Dirty Reads Mean Show old data while updating the record as same time
-- Show and update the same date at the same time.


-- 1 -> Read Commit , Repeatable read, Phantom Reads, -> Serilizable
-- Dirty Reads: A dirty read occurs when a transaction reads data that has been modified by 
-- another transaction but not yet committed. If the modifying transaction is rolled back, 
-- the data read by the other transaction becomes invalid.

-- Non-repeatable Reads: A non-repeatable read occurs when a transaction reads the same data multiple 
-- times but gets different results because another transaction has modified the data in between the reads.

-- Phantom Reads: A phantom read occurs when a transaction reads a set of records that satisfy a certain condition,
-- but another transaction inserts or deletes records that also satisfy the same condition, causing the first
-- transaction to see different results in subsequent reads.

-- 2 -> Non-repeating Reads


-- Transaction Isolation Levels
SHOW VARIABLES LIKE 'transaction_isolation';

-- for the current session only use below command
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;


-- for the global level only use below command 
SET GLOBAL TRANSACTION ISOLATION LEVEL SERIALIZABLE;


-- Read uncommited ISOLATION Levels

-- READ UNCOMMITTED: In a transaction with the READ UNCOMMITTED isolation level, transactions can read data that 
-- has been modified by other transactions but not yet committed. This means that it allows transactions to see 
-- "dirty" data, which may be rolled back later by the modifying transaction. READ UNCOMMITTED provides the lowest 
-- level of isolation and  does not guarantee consistency or accuracy of data.

-- COMMITTED: The COMMITTED isolation level, on the other hand, ensures that transactions only read data that has been
-- committed by other transactions. This means that transactions at this isolation level will not see uncommitted 
-- changes made by other transactions. It provides a higher level of consistency and data integrity compared to READ UNCOMMITTED.

USE sql_store;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;



-- Repeatable Reads ISOLATIOn Level
-- This is By Default REPEATABLE READ in MySQL

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;


-- SERILIZABLE Isolation Level

USE sql_store;


SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
START TRANSACTION;
SELECT * 
FROM customers 
WHERE state = 'VA';
COMMIT;




-- This is Second Use Code that USE TRANSACTION
USE sql_store;
START TRANSACTION;
UPDATE customers
SET state = 'VA'
WHERE customer_id = 3;
COMMIT;  
 
 
 
-- DeadLock in MySQL 
-- When Two user Access and Modify the same table then we face deadlock Situation
USE sql_store;
START TRANSACTION;
UPDATE customers SET state = 'VA' WHERE customer_id = 1;
UPDATE orders SET status = 1 WHERE order_id = 1;
COMMIT;



USE sql_store;
START TRANSACTION;
UPDATE orders SET status = 1 WHERE order_id = 1;
UPDATE customers SET state = 'VA' WHERE customer_id = 1;
COMMIT;