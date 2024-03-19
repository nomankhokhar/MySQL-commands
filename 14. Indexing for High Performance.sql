-- Indexing for High Performances
-- Indexes speed up the Queries

-- COST OF INDEXES
	-- Increase the database
    -- Slow down the writes

-- For the Above reason we Reserve indexes for performance critical queries
-- Design indexes based on your queries not your tables.



-- Creating Indexes in MYSQL

USE sql_store;

SELECT customer_id 
FROM customers 
WHERE state = 'CA';



EXPLAIN SELECT customer_id 
FROM customers 
WHERE state = 'CA';


-- Creating the Index in Code MySQL

CREATE INDEX  idx_state ON customers (state);

-- Now below code Use Index to Search the  Code.
EXPLAIN SELECT customer_id 
FROM customers 
WHERE state = 'CA';


-- Example Write a Query to find customers with more than 
-- 1000 Points

EXPLAIN SELECT customer_id 
FROM customers
WHERE points > 100;


CREATE INDEX idx_points ON customers (points);


-- Now below query use Index of points for Searching

SELECT customer_id 
FROM customers
WHERE points > 100;


-- Viewing in Index in MySQL
-- MySQL byDefault index Primary key

SHOW INDEXES IN customers;