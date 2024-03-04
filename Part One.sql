show databases;

use sql_store;

show tables;

-- SELECT , FROM,  WHERE ORDER BY  - 

SELECT * FROM customers;


SELECT * 
FROM customers 
where customer_id = 1  
ORDER BY first_name;

-- * + - / can be use According to USE 
-- We can use () to Execute Operation like (points + 10) * 100 
-- Alias for Naming to show the Columns like dis_fact , "dis fact"
  
SELECT 	last_name , 
		first_name , 
        points , 
        points * 10 + 100 AS 'discount factor'
FROM customers;


SELECT DISTINCT state 
FROM customers;

-- Exercise to increase Price of the Product
 
SELECT * from products;

SELECT 	name ,
		unit_price ,
		unit_price * 1.1 AS "New Price"
FROM products;


