-- ----------------------------------------------------------------------------
-- 1). First, How Many Rows (Products) are in the Products Table?
-- ----------------------------------------------------------------------------
use northwind;

select count(*) as product_count
 from northwind.products;

-- ----------------------------------------------------------------------------
-- 2). Fetch Each Product Name and its Quantity per Unit
-- ----------------------------------------------------------------------------
select product_name
, quantity_per_unit
 from northwind.products;

-- ----------------------------------------------------------------------------
-- 3). Fetch the Product ID and Name of Currently Available Products
-- ----------------------------------------------------------------------------
select id as product_id 
	, product_name
from northwind.products
where discontinued = 0;

-- ----------------------------------------------------------------------------
-- 4). Fetch the Product ID, Name & List Price Costing Less Than $20
--     Sort the results with the most expensive Products first.
-- ----------------------------------------------------------------------------
select id as product_id 
	, product_name
    , list_price
from northwind.products
where list_price < 20
order by list_price desc;

-- ----------------------------------------------------------------------------
-- 5). Fetch the Product ID, Name & List Price Costing Between $15 and $20
--     Sort the results with the most expensive Products first.
-- ----------------------------------------------------------------------------
select id as product_id 
	, product_name
    , list_price
from northwind.products
where list_price between 15 and 20
order by list_price desc;

-- Older (Equivalent) Syntax -----
select id as product_id 
	, product_name
    , list_price
from northwind.products
where list_price <= 15 
and list_price >= 20
order by list_price desc;

-- ----------------------------------------------------------------------------
-- 6). Fetch the Product Name & List Price of the 10 Most Expensive Products 
--     Sort the results with the most expensive Products first.
-- ----------------------------------------------------------------------------
select id as product_id 
	, product_name
    , list_price
from northwind.products
order by list_price desc
 limit 10;

-- ----------------------------------------------------------------------------
-- 7). Fetch the Name & List Price of the Most & Least Expensive Products
-- ----------------------------------------------------------------------------
select id as product_id 
	, product_name
    , list_price
from northwind.products
where list_price = (select min(list_price) from northwind.products)
or list_price = (select max(list_price) from northwind.products);

-- ----------------------------------------------------------------------------
-- 8). Fetch the Product Name & List Price Costing Above Average List Price
--     Sort the results with the most expensive Products first.
-- ----------------------------------------------------------------------------
select id as product_id 
	, product_name
    , list_price
from northwind.products
where list_price > (select avg(list_price) from northwind.products)
order by list_price desc;

-- ---------------------------------------------------------------------------- 
-- 9). Fetch & Label the Count of Current and Discontinued Products using
-- 	   the "CASE... WHEN" syntax to create a column named "availablity"
--     that contains the values "discontinued" and "current". 
-- ----------------------------------------------------------------------------
UPDATE northwind.products SET discontinued = 1 WHERE id IN (95, 96, 97);

-- TODO: Insert query here.
select case discontinued
			when 1 then 'discontinued'
			else 'current'
		end as availability
	, count(*) as product_count
from northwind.products
group by discontinued;

UPDATE northwind.products SET discontinued = 0 WHERE id in (95, 96, 97);

-- ----------------------------------------------------------------------------
-- 10). Fetch Product Name, Reorder Level, Target Level and "Reorder Threshold"
-- 	    Where Reorder Level is Less Than or Equal to 20% of Target Level
-- ----------------------------------------------------------------------------
select product_name
	, reorder_level
    , target_level
    , round(target_level/5 as reorder_threshold)
from northind.products
where reorder_level <= round(target_level/5);

-- ----------------------------------------------------------------------------
-- 11). Fetch the Number of Products per Category Priced Less Than $20.00
-- ----------------------------------------------------------------------------
select category
	, count(*) as product_count
from northwind.products
where list_price < 20.00
group by category
order by category;

-- ----------------------------------------------------------------------------
-- 12). Fetch the Number of Products per Category With Less Than 5 Units In Stock
-- ----------------------------------------------------------------------------
select category
	, count(*) as units_in_stock
from northwind.products
group by category
having units_in_stock < 5;

-- ----------------------------------------------------------------------------
-- 13). Fetch Products along with their Supplier Company & Address Info
-- ----------------------------------------------------------------------------
select p.product_name
	, s.company
    , s.address
    , s.city
    , s.state_province
    , s.zip_postal_code
from northwind.products as p
inner join northwind.suppliers as s
on s.id = p.supplier_ids;

-- ----------------------------------------------------------------------------
-- 14). Fetch the Customer ID and Full Name for All Customers along with
-- 		the Order ID and Order Date for Any Orders they may have
-- ----------------------------------------------------------------------------
select c.id as customer_id
	, concat(c.first_name, " ", c.last_name) as customer_name
    , o.id as order_id
    , o.order_date
from northwind.customers as c
left outer join northwind.orders as o
on c.id = o.customer_id
order by customer_id;

-- ----------------------------------------------------------------------------
-- 15). Fetch the Order ID and Order Date for All Orders along with
--   	the Customr ID and Full Name for Any Associated Customers
-- ----------------------------------------------------------------------------
select o.id as order_id
	 , o.order_date
     , c.id as customer_id
	, concat(c.first_name, " ", c.last_name) as customer_name
from northwind.customers as c
right outer join northwind.orders as o
on c.id = o.customer_id
order by customer_id;
