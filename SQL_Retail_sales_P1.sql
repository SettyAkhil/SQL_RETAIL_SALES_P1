-- SQL Retail Sales Analysis

Create database sql_project1;

USE sql_project1;

Drop table if exists retail_sales;
Create table retail_sales
(
transactions_id INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id INT,
gender VARCHAR(20),
age INT,
category VARCHAR(20),
quantity INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT
);

select * from retail_sales;

-- For checking the Null Values
SELECT COUNT(*) 
FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

-- For deleting the Null Values

DELETE FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

-- Data Exploration

-- How  many sales we have? 
select count(*) as total_sales from retail_sales;

-- How many unique customers we have?
select count(distinct customer_id) as total_sales from retail_sales

-- How many unique categories we have?
select distinct category from retail_sales;

-- Data Analysis and Business Key problems

-- Q1) Write a SQL Query to retreive all columns for sales made on '2022-11-05'?

select * from retail_sales
WHERE  sale_date = '2022-11-05';

-- Q2) Write a SQL query to retrive all transaction where the category is "Clothing" and the quantity sold is more than 4 in month NOV-2022?

SELECT * from retail_sales
WHERE category = 'Clothing'
AND sale_date BETWEEN '2022-11-01' AND '2022-11-30'
AND quantity >=4; 

-- Q3) Write a query to calculate the total sales for each category ?

select category,
sum(total_sale) as net_sales,
count(*) as total_count
from retail_sales
group by 1;

-- Q4) Write a query to find the avg of the customers who purchased items from category "Beauty'?

select avg(age) as avg_age from retail_sales
where category = 'Beauty'

-- Q5) Write a query to find all the transaction where the total_sale is greater than 1000?

select * from retail_sales
where total_sale >1000,

-- Q6) Write a query to find the total number of transcations made by each gender in each category?

select category,gender, count(*) as total_trans from retail_sales
group by category,gender
order by 1

-- Q7) Write a query to calculate the average sale for each month. Find the best selling month in each year?
 
 select 
	extract(YEAR from sale_date) as year,
	extract(MONTH from sale_date) as month,
    avg(total_sale) as avg_sale
from retail_sales
group by 1,2
order by 1, 3 desc;

-- Q8) Write a query to find the top 5 customers based on the highest total sales?

select customer_id, sum(total_sale) as total_sales from retail_sales
group by 1
order by 2 desc
limit 5;

-- Q9) Write a query to find the number of unique customers who purchased items from each category?

select category, count(distinct customer_id) from retail_sales
group by category

-- Q10) Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17) 

with hourly_sales as(
select *,
case
	when extract(HOUR from sale_time) < 12 then 'Morning'
    when extract(HOUR from sale_time) between 12 and 17 then 'AfterNoon'
    else 'Evening'
end as shift from retail_sales
)
select shift, count(*) as total_orders
from hourly_sales
group by shift

-- END OF PROJECT