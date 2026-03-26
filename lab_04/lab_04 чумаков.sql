-- Лабораторная работа #4

-- Задание №1

select customer_id, product_id, dealership_id, sales_amount,
dense_rank() over(partition by product_id order by sales_amount, customer_id) as sales_rank
from sales
limit 30;

-- Задание №2

select distinct customer_id, first_name, last_name, date_added,
case
when ntile(2) over (order by date_added, customer_id) = 1 then 'Старые'
when ntile(2) over (order by date_added, customer_id) = 2 then 'Новые'
end as customer_group
from customers
order by date_added;

-- Задание №3
-- Скользящее среднее значение широты (latitude) последних 5 добавленных клиентов

select customer_id, first_name, last_name, latitude, date_added, 
avg(latitude) over (order by date_added rows between 4 preceding and current row) as moving_latitude
from customers
order by date_added
limit 10;

