show tables;

desc sales;

select * from sales;

select SaleDate, Amount, Customers , Boxes from sales; # You can reArrange the Columns

select SaleDate, Amount, Boxes, Amount / boxes as 'Amount per box' from sales;

select * from sales where Amount > 5000;

select * from sales where Amount > 5000 and Customers = 276;

select * from sales where Amount > 10000 order by Amount asc;

select * from sales where Amount > 10000 order by Amount desc;

select * from sales where GeoID = 'g1' order by PID , Amount desc; 