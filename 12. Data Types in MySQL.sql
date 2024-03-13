-- DataTypes in MySQL
-- String, Numberic, Date and Time Types, Blob, Spatial

-- String Types

-- Char(x)
-- VarChar(x) 

-- TinyText      max : 255 bytes
-- VarChar(50)   for short strings 
-- VarChar(255)  for medium-length strings 65535 characters (64Kb)
-- MediumText    max : 16MB Million Character
-- LongText      max : 4GB textbook and log files
-- Text          max : 64KB


-- Integer Types


-- TinyINT     1bytes [-128 , 127]
-- Unsigned    TinyINT  [0 , 255]
-- SMALLINT    2b [-32K , 32K]
-- MediumINT   3b [-8m , 8m]
-- INT         4b [-2B, 2B]
-- BigInt      8B [-9Z , 9Z]

-- Small the smallest Datatype in the Designing Database 
-- for small size of database



-- Fixed Point vs Floating-Point Types

-- DECIMAL(p , s) => 1234567.89
-- DEC
-- Numeric
-- Fixed

-- Float
-- Double


-- Boolean Types in MySQL

-- BOOL vs BOOLEAN

-- Enum and Set Types

-- ENUM('small','medium','large') -- We can store only three values 


-- Blods datatypes in MySQL

-- Binery data is Blob datatypes 

-- TinyBlob 255Bytes
-- Blob 65KB
-- Medium 16MB 
-- LONGBLOB 4GB


--  JSON datatypes in MySQL

-- Lightweight in key : value pair


UPDATE products
SET properties = JSON_SET(
	'weight', 10,
    'dimensions' , JSON_ARRAY(1 , 2, 3),
    'manufacturer' , JSON_OBJECT('name', 'sony')
)
WHERE product_id = 1;