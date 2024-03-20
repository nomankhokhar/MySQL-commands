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
SET PASSWORD = '1234'


-- Granting the Privilages in MySQL

-- web/destop
-- admin

