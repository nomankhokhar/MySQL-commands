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

-- this will show Unique State from the table

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


-- Orignal Dates are Stored in DB like below condition


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
-- b% Start with b, %b end with b, %b% b in the middle of the string mean Name 
-- String Pattern
 
SELECT * 
FROM customers
WHERE last_name LIKE 'b%';

--  _o% -> first any char second will be o

SELECT * 
FROM customers
WHERE last_name LIKE '_o%';


-- Exercise Get the customers whose 
-- addresses contain TRAIL or AVENUE  
-- Phone numbers end with 9

SELECT *
FROM customers
WHERE address LIKE '%trail%' OR 
	  address LIKE '%avenue%' AND 
      phone like "%9";
      

SELECT *
FROM customers
WHERE phone like "%9";

-- NOT END with 9


SELECT *
FROM customers
WHERE phone NOT LIKE "%9";

-- REGENXP Operator 
-- Both the RegeXP and LIKE Query Work the Same
 
SELECT *
FROM customers
WHERE last_name LIKE '%field%';

--  ^field -> last name must start with field 
-- String must contain field in the end of the string like (Brushfield)

SELECT *
FROM customers
WHERE last_name REGEXP 'field$';
 
-- Find the Data that contains field|mac|rose like (MacCaffrey and Roseburgh) 
-- ^field start of the string
-- field$ end of the string 
-- | logical
-- [abcd] match for the single character in the Bracket
-- [a-f] match range using the given range

 
SELECT *
FROM customers
WHERE last_name REGEXP '^field|mac|rose';

-- '[gim]e' -> this will search like 
-- ge, 
-- ie, 
-- me in the string
-- e[fmq] -> ef , em, eq

SELECT *
FROM customers
WHERE last_name REGEXP '[gim]e';


--  We can also define range in the Regex
-- like this ae, be and so on 

SELECT *
FROM customers
WHERE last_name REGEXP '[a-h]e';


-- Exercise Get customers whose
-- first names are ELSE or AMBUR

SELECT *
FROM customers
WHERE first_name REGEXP 'elka|ambur';

-- last names end with EY or ON

SELECT *
FROM customers
WHERE last_name REGEXP 'ey$|on$';


-- last names start with MY or contains SE

SELECT *
FROM customers
WHERE last_name REGEXP '^my|se';

-- last names contains B followed by R or U
-- b[ru] and br|bu

SELECT *
FROM customers
WHERE last_name REGEXP 'b[ru]';


-- NUll Operator to check the NULL values
 
SELECT *
FROM customers
WHERE phone IS NULL;

--  Exercise Get the Orders that are not shipped

SELECT *
FROM orders
WHERE shipper_id IS NULL;


-- Order BY  Clause ASC byDeafult
-- first sort the state then sort first_name base on that state
 
SELECT * 
FROM customers
ORDER BY state ,first_name;

-- this is valid Query But in Other Databases this will not work
 
SELECT first_name , 10 as points
FROM customers
ORDER BY points;


-- Exercise Get all orders_items
-- Repetion in the Query

SELECT * , quantity * unit_price as total_price
FROM order_items
WHERE order_id = 2
ORDER BY quantity * unit_price DESC;

-- No repetion in the Query 

SELECT * , quantity * unit_price as total_price
FROM order_items
WHERE order_id = 2
ORDER BY total_price DESC;


-- LIMIT Clause

SELECT *
FROM customers 
LIMIT 4; 


-- Exercise Get the top three loyal customers

SELECT *
FROM customers
ORDER BY points DESC
LIMIT 3;

-- Orders Matter During Execution
-- SELECT 
-- FROM
-- WHERE
-- ORDER BY
-- LIMIT 