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