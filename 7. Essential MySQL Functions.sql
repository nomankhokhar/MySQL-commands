-- These are buildin function's

SELECT ROUND(5.7345 , 2) as Round; -- 5.73
SELECT TRUNCATE(5.7345, 2); -- 5.7 
SELECT CEILING(5.7); -- 5
SELECT ROUND(5.2); -- 5 
SELECT FLOOR(5.2); -- 5 
SELECT ABS(-5.2); -- Return Positive Number 
SELECT RAND();


-- MySQL numberic functions


-- String Functions

SELECT LENGTH('sky');
SELECT LOWER('SKKK');
SELECT TRIM('   kk   ');
SELECT LTRIM('   kkkk ');
SELECT RTRIM('Kkkkk    ');
SELECT LEFT('Noman Ali', 4);
SELECT RIGHT('KHAN SAHIB', 3);
SELECT SUBSTRING('Ma a Hitler Fan', 5,6); --  Start , length
SELECT LOCATE('n' , 'Khan Bhai LOL'); -- return length of the char or string
SELECT LOCATE('garten', 'BigGarten'); -- Start from 4th index ans will be 4 -> key , string
SELECT REPLACE('BigGarten', 'garten', 'garden'); -- String , word, replac by word
SELECT CONCAT('Noman' , 'Ali');


USE sql_store;

SELECT CONCAT(first_name, ' ' , last_name) as fullname
FROM customers;


-- Dates Functions

 
SELECT NOW(), CURDATE(), CURTIME();
SELECT YEAR(NOW());
SELECT HOUR(NOW());
SELECT DAY(NOW());

-- Date function can be get from Documentation's

SELECT EXTRACT(YEAR FROM NOW());


-- Exercise Get orders from the Current Date using Builtin fun's

SELECT *
FROM  orders
WHERE YEAR(order_date) = YEAR(NOW());

USE sql_store;

-- IFNULL vs COALESCE

SELECT 
	order_id,
    IFNULL(shipper_id , 'Not Assign') as shipper
FROM orders;



SELECT 
	order_id,
    COALESCE(shipper_id , comments ,'Not Assign') as shipper -- If shiiper_id is nullthen comments if comments null then  'Not Assign' 
FROM orders;


-- Exercise Customers , phone

SELECT
	CONCAT(first_name, ' ' , last_name) AS customer,
    COALESCE(phone, 'Unknow') AS phone
FROM customers;



-- IF Functions
-- IF(expression , first, second);

SELECT 
	order_id,
    order_date,
    IF(
    YEAR(order_date) = YEAR(NOW()) ,
    'Active' , 
    'Archive') AS Category
FROM orders;


-- Exercise product_id, name, orders,  frequency

SELECT 
	product_id,
    name,
    IF(COUNT(*) > 1, 'Many times', 'Once') AS frequency
FROM products
JOIN order_items USING (product_id)
GROUP BY product_id , name;



-- CASE Operator

SELECT 
	order_id,
    CASE
		WHEN YEAR(order_date) = YEAR(NOW()) THEN 'Active'
        WHEN YEAR(order_date) = YEAR(NOW()) - 1 THEN 'Last Year'
        ELSE 'Future'
	END as Status
FROM orders;