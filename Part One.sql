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

-- WHERE clause Working
-- != , <> , > , >= , < , <= , =

SELECT *
FROM Customers
WHERE points > 3000; 


SELECT *
FROM Customers
WHERE state <> 'va';



SELECT *
FROM Customers
WHERE birth_date > '1990-01-01';


-- Get the orders placed this year

SELECT *
FROM orders
WHERE order_date >= '2019-01-01'; 

-- Multiple Search Conditions using WHERE Clause
-- AND has High Precedence than the OR
 
SELECT *
FROM Customers
WHERE birth_date >  '1990-01-01' OR 
	  (points > 1000 AND state = 'VA');



-- Show the data that not in condition 1990-01-01 , less than ( < ) 1000 points 
--  Both are same Query but last one is more readable

SELECT *
FROM Customers
WHERE NOT (birth_date >  '1990-01-01' OR points > 1000);

SELECT *
FROM Customers
WHERE birth_date <= '1990-01-01' AND points <= 1000;

-- Exercise Get the Item where Order ID is 6 , Where Total price will be grater than > 30 

SELECT *
FROM order_items 
WHERE order_id = 6 AND unit_price * quantity > 30;


-- IN operator Advantage when multiple condition are needed
-- NOT IN Operator also working 
SELECT *
FROM Customers
WHERE state NOT IN ('VA', 'FL', 'GA'); 

-- Return products with quantity in stock equal to 49 , 38 , 72

SELECT *
FROM products
WHERE quantity_in_stock in (49 , 38, 72);  


-- Between Operator
-- Both Query is the same but below one is Good One for Readable  

SELECT *
FROM customers
WHERE points >= 1000 AND points <= 3000; 

SELECT *
FROM customers
WHERE points BETWEEN 1000 AND 3000;

-- Exercise customers born between 1/1/1990 and 1/1/2000

SELECT *
FROM customers
WHERE birth_date between '1990-01-01' AND '2000-01-01';



-- like Operator in MySQL 
