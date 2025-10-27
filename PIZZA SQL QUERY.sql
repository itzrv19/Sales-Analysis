SELECT * 
FROM pizza_sales;

-- TOTAL REVENUE 

SELECT SUM(total_price) AS Total_Revenue 
FROM pizza_sales;


-- AVG ORDER VALUE 

SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value 
FROM pizza_sales;


-- TOTAL PIZZA SOLD 

SELECT SUM(quantity) AS Total_pizza_sold 
FROM pizza_sales;


-- TOTAL ORDERS 

SELECT COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales;


-- AVG. PIZZAS PER ORDER 

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM pizza_sales;



-- MY DATE FORMAT WAS DIFFERENT (TEXT) SO CREATING A NEW TABLE AND CHANGING DATE FORMAT  


-- CREATE TABLE `pizza_sales2` (
--     `pizza_id` INT DEFAULT NULL,
--     `order_id` INT DEFAULT NULL,
--     `pizza_name_id` TEXT,
--     `quantity` INT DEFAULT NULL,
--     `order_date` DATE,
--     `order_time` TEXT,
--     `unit_price` DOUBLE DEFAULT NULL,
--     `total_price` DOUBLE DEFAULT NULL,
--     `pizza_size` TEXT,
--     `pizza_category` TEXT,
--     `pizza_ingredients` TEXT,
--     `pizza_name` TEXT
-- )  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4 COLLATE = UTF8MB4_0900_AI_CI;

-- INSERT INTO pizza_sales2 (
--     pizza_id,
--     order_id,
--     pizza_name_id,
--     quantity,
--     order_date,
--     order_time,
--     unit_price,
--     total_price,
--     pizza_size,
--     pizza_category,
--     pizza_ingredients,
--     pizza_name
-- )
-- SELECT
--     pizza_id,
--     order_id,
--     pizza_name_id,
--     quantity,
--     STR_TO_DATE(order_date, '%d-%m-%Y'),  
--     order_time,
--     unit_price,
--     total_price,
--     pizza_size,
--     pizza_category,
--     pizza_ingredients,
--     pizza_name
-- FROM pizza_sales;


-- order_time FROM TEXT TO TIME 

-- SET SQL_SAFE_UPDATES = 0;
-- UPDATE pizza_sales2
-- SET order_time = STR_TO_DATE(order_time, '%H:%i:%s');
-- SET SQL_SAFE_UPDATES = 1;


-- DAY WISE ORDERS 

SELECT 
    DAYNAME(order_date) AS order_day, 
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
-- WHERE MONTH(order_date) = 1   (IN A MONTH ON DAYS , 1 = JAN , 2 = FEB ETC.  )
GROUP BY DAYNAME(order_date)
ORDER BY total_orders DESC;


-- ORDERS BY HOUR 

SELECT 
    HOUR(order_time) AS order_hours, 
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY HOUR(order_time)
ORDER BY order_hours;


-- %age OF SALES BY PIZZA CATEGORY 

SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category;


-- %age OF SALES BY PIZZA SIZE 

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;


-- TOTAL PIZZA SOLD BY CATEGORY 

SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;


-- PIZZA NAME AND SOLD TOTAL QUANTITY  TOP 5 

SELECT  pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold  DESC LIMIT 5 ;

-- LOWER 5 

SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC LIMIT 5 ;





