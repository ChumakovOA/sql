-- Лабораторная работа №3
-- 1

select count(distinct state) as unique_state
from dealerships;

-- 2

select 
channel,
max(sales_amount) as max_sales,
min(sales_amount) as min_sales
from sales
group by channel
order by channel;

-- 3

select 
product_type,
avg(base_msrp) as avg_msrp
from products
group by product_type
having avg(base_msrp) > 1 and avg(base_msrp) < 80000;


