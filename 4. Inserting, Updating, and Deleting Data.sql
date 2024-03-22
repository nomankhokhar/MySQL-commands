-- Datatypes in SQL for Columns of the tables
-- int(11)
-- varchar(50)
-- Date
-- char(2)
-- Primary key, Not Null, Auto Increment
-- We can specify the default values as well as null , empty like ''
-- All types are Bigger elements 

-- Inserting the data into the tables Queries
-- Below are two ways to insert the data into the tables

INSERT INTO customers
VALUES (
	DEFAULT, -- customer_id because this is primary key
    'Noman',
    'Ali',
    '2002-02-16',
    NULL,
    'address',
    'Mul',
    'PJ',
    DEFAULT
    );
    
    
    
INSERT INTO customers(
	first_name,
    last_name,
    birth_date,
    address,
    city,
    state
    )
VALUES (
    'Noman',
    'Ali',
    '2002-02-16',
    'address',
    'Mul',
    'PJ'
    );
    
SELECT * 
FROM sql_store.customers;


-- Inserting Multiple Rows in One Query

INSERT INTO shippers (name)
VALUES ("Noman"),
	   ("Noman"), 
       ("Noman");



-- Exercise -> Insert three rows in the products table

INSERT INTO products
VALUES (11, "Strawbery", 100, 10),
	   (12, "Ice Strawbery", 100, 10),
       (13, "Chocolate", 100, 10);
       
       
-- Inserting Hirarchical Rows in the table mean 
-- inserting data into Multiple Tables
 
INSERT INTO orders (customer_id , order_date , status)
VALUES (1 , '2002-02-16',1);

INSERT INTO order_items
VALUES 
	(LAST_INSERT_ID(), 1, 1, 2.95),
    (LAST_INSERT_ID(), 2, 1, 2.95);
    
-- Creating a copy of a tables
-- When you copy the table then SQL remove
-- all primary key and not null validation
-- and default values as well 

CREATE TABLE orders_archived AS
SELECT * 
FROM orders;

-- Copy specific Data from the table after creating
INSERT INTO orders_archived
SELECT *
FROM orders
WHERE order_date < '2019-01-01';


-- Exercise Save Archived Invoice to another table 

USE sql_invoicing;

CREATE TABLE invoices_archived AS
SELECT 
	i.invoice_id,
    i.number,
    c.name AS client,
    i.invoice_total,
    i.payment_total,
    i.invoice_date,
    i.payment_date,
    i.due_date
FROM invoices i
JOIN clients c
	USING (client_id)
WHERE payment_date IS NOT NULL;


-- Updating a Single Row in the Data 

UPDATE invoices
SET payment_total = 0, 
	payment_date = NULL
WHERE invoice_id = 1;


-- Updating the column with column name as well like due_date 

UPDATE invoices
SET 
	payment_total = invoice_total * 0.5,
    payment_date = due_date
WHERE invoice_id = 3;


-- Updating the Multiple Rows.

UPDATE invoices
SET 
	payment_total = invoice_total * 0.5,
    payment_date = due_date
WHERE invoice_id in (3, 4);


-- Exercise Give any customer born before 1990
--  50 Extra Points 

USE sql_store;

UPDATE customers
SET points = points + 50
WHERE birth_date < '1990-01-01';

-- Update Data using SubQueries

-- Both of the Queries is Same

UPDATE invoices
SET 
	payment_total = invoice_total * 0.5,
    payment_date = due_date
WHERE client_id =
				(SELECT client_id
				FROM clients
				WHERE name = 'Myworks');


UPDATE invoices
SET 
	payment_total = invoice_total * 0.5,
    payment_date = due_date
WHERE client_id =
				(SELECT client_id
				FROM clients
				WHERE state IN ('CA', 'NY'));
                

-- Deleting Rows in the Table

DELETE FROM invoices
WHERE invoice_id = 1;

-- We can use subqueries as well to del the data

DELETE FROM invoices
WHERE invoice_id = 
				(SELECT *
                FROM clients
                WHERE name = 'Myworks');


-- Restoring the Databases
-- Follow the First Lecture 