-- Лабораторная работа №1 
-- Задание №1

select *
from sales
where sales_transaction_date between '2017-01-01' and '2017-12-31'
order by sales_transaction_date asc
limit 20;

-- Задание №2

select *
from dealerships
where state not in ('CA', 'TX')
limit 20;

-- Задание №3

create table managers as 
select 
salesperson_id + 1 as manager_id,
salesperson_id,
dealership_id,
title,
first_name,
last_name,
suffix,
username,
gender,
hire_date,
termination_date
from salespeople 
where hire_date >= '2010-01-01';

alter table managers
add column salary decimal(10,2);

update managers 
set salary = 65000;

select * 
from managers;
