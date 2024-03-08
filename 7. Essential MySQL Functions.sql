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
SELECT 