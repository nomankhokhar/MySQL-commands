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