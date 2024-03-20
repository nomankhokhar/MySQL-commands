-- Giving Access to User with Specific Access

-- Creating new User in MySQL

-- sub Domain Noman@'%.codewithmosh.com
-- Domain  Noman@codewithmosh.com
-- localhost -> Noman@localhost

CREATE USER Noman IDENTIFIED BY '1234';


-- Viewing the Users

SELECT * FROM mysql.user;

-- Droping the User
-- use full name as you create

DROP USER Noman;

-- Changing the Passwords in MySQL

-- For Specific user
SET PASSWORD FOR Noman = '1234';

-- For Root user
SET PASSWORD = '1234';


-- Granting the Privilages in MySQL

-- web/destop
-- admin

CREATE USER noman_app IDENTIFIED BY '12345';

-- sql_store.* ->  whole database
-- sql_store.customer -> only customer table
GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE
ON sql_store.*
TO noman_app;


-- Admin Level give all permission
GRANT ALL
ON *.*
TO noman_app;


-- Viewing Privillages in MySQL

SHOW GRANTS FOR noman_app;

-- root levels

SHOW GRANTS;