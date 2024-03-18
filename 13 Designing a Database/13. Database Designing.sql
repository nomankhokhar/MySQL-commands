-- First Step is Data Modeling
  -- |
  -- v

-- Understand the requirements
-- Build a Conceptual Model do not have -> 1-M, M-1, 1-1,M-M relational Table
-- Build a Logical Model
-- Build a Physical Model


-- Conceptual Models in MySQL

-- ERD and UML these use in Conceptual Models
-- MicroSoft Visio, draw.io, LucidCharts

-- Student and Course Database Implementation.


-- Normalizaiton 


-- 1NF mean Each cell should have a single value 
-- and we cannot have repeated columns values like tags in courses table


-- 2NF mean Every table should describe one entity and every column in
-- that table should describe that entity | Not repeated values in different table 
-- one value at one table


-- A column in a table should not be derived from other columns
-- 3NF -> invoice , payment_total, balance 
-- Balance is calculated by invoice and payment_total 
-- we do not need to add this columns in the table for 
-- inconsist data



-- When you do not have Database then You have to do Forward Engineering Options
-- When you modify any column then use Synchonizing Model from Top Database Options


-- Logical Model of Flight Booking System
-- Logical Model of Rent Video Booking System


-- Creating and Droping Database

CREATE DATABASE sql_store2;
CREATE DATABASE IF NOT EXISTS sql_store2;


DROP DATABASE sql_store2;
DROP DATABASE IF EXISTS sql_store2;


-- Create Tables in MySQL

USE sql_store2;

DROP TABLE IF EXISTS customers;
CREATE TABLE IF NOT EXISTS customers
(
	customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name  VARCHAR(50) NOT NULL,
    points      INT NOT NULL DEFAULT 0,
    email 		VARCHAR(255) NOT NULL UNIQUE
);

show tables;


-- Altering Tables in MySQL

-- If you have space in column name then use backSpace
ALTER TABLE customers 
	ADD last_name VARCHAR(50) NOT NULL AFTER `first_name`,
    ADD city      VARCHAR(50) NOT NULL,
    MODIFY COLUMN first_name VARCHAR(55) DEFAULT '',
    DROP points
;
    
    
describe customers;