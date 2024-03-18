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