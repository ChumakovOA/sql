-- Лабораторная работа №2

-- Задание №1

select
e.email_id,
c.customer_id,
c.first_name,
c.last_name,
e.opened_date,
e.opened
from emails e
inner join customers c on e.customer_id = c.customer_id
where opened = 't'
limit 20;

-- Задание №2

select
p.product_id,
c.customer_id,
c.first_name,
c.last_name,
p.product_type
from sales s
inner join products p on s.product_id = p.product_id
inner join customers c on s.customer_id = c.customer_id
where c.city = 'New York City'
limit 20;

-- Задание №3

select 
customer_id,
first_name,
last_name,
coalesce(phone, email) as contact_info
from customers
limit 20;