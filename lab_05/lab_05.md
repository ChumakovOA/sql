# Лабораторная работа №5
## Оптимизация запросов с помощью индексов и анализа плана выполнения
**Вариант 19**

### Цель работы
Изучить применение индексов (Hash и B-Tree) для оптимизации запросов, проанализировать планы выполнения с помощью `EXPLAIN ANALYZE` и сравнить производительность до и после создания индексов.

---

## Задание 1
**Условие:** найти продукты типа `product_type = 'automobile'`.  
**Тип индекса:** Hash.

### Решение
 
   Выполняется `EXPLAIN ANALYZE` для исходного запроса. Планировщик использует **Seq Scan** (полное сканирование таблицы), так как индекс отсутствует.

   ```sql
   EXPLAIN ANALYZE
   SELECT * FROM products WHERE product_type = 'automobile';
   ```
 Скриншот выполнения EXPLAIN ANALYZE (Seq Scan)
 
   <img width="802" height="302" alt="image" src="https://github.com/user-attachments/assets/907c6132-eddb-4dc0-b082-b70d362a3433" />

## Задание 2
**Условие:** оптимизировать поиск клиентов с широтой `latitude > 40`.  
**Тип индекса:** B-Tree (подходит для неравенств и диапазонов).

### Решение

1. **Анализ без индекса**

   ```sql
   EXPLAIN ANALYZE
   SELECT * FROM customers WHERE latitude > 40;
   ```
Скриншот выполнения EXPLAIN ANALYZE (Seq Scan)

<img width="899" height="301" alt="image" src="https://github.com/user-attachments/assets/fb984294-1c58-4ba8-8dc1-3903ec2235b9" />

## Создание B-Tree индекса

```sql
CREATE INDEX idx_customers_latitude ON customers USING BTREE (latitude);
```

## Анализ с индексом

```sql
EXPLAIN ANALYZE
SELECT * FROM customers WHERE latitude > 40;
```

<img width="1049" height="435" alt="image" src="https://github.com/user-attachments/assets/513781f0-d533-4334-a618-717fe5b9f6da" />

## Вывод

В ходе выполнения лабораторной работы для варианта 19:

- Для поиска по равенству (`product_type = 'automobile'`) применение **хеш-индекса** позволило заменить полное сканирование таблицы на индексный поиск, что ускорило выполнение запроса.
- Для диапазонного условия (`latitude > 40`) использование **B-Tree индекса** также дало выигрыш в производительности по сравнению с последовательным сканированием.
- Команда `EXPLAIN ANALYZE` наглядно показала разницу в планах выполнения и времени до и после оптимизации.

Таким образом, правильный выбор типа индекса (Hash для равенства, B-Tree для диапазонов) и анализ плана запроса являются ключевыми навыками оптимизации работы с базами данных.
