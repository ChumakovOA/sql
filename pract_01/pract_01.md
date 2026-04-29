
# Практическая работа №1
## Геопространственный анализ данных. Аналитика с использованием сложных типов данных

**Выполнил:** Чумаков Олег

**Группа:** ЦИБ-241

**Задания:** №1, №8, №11

---

### Цель работы
Научиться применять продвинутые возможности PostgreSQL для анализа данных, выходящих за рамки стандартных чисел и строк. Освоить работу с временными рядами, геопространственными данными, массивами, JSON/JSONB структурами и полнотекстовым поиском.

---

Полный SQL-код представлен в [файле](pract_01.sql)

## Задание №1 (Блок А. Анализ времени и дат)
**Условие:** определить, в какой день недели совершается наибольшее количество продаж. Вывести день недели и количество транзакций.

### Решение

Выполняется запрос с использованием `TO_CHAR` для преобразования даты в название дня недели и `COUNT` для подсчета количества продаж. Группировка выполняется по дню недели, результат сортируется по убыванию, берется первая строка.

```sql
SELECT 
    TO_CHAR(sales_transaction_date, 'Day') AS day_of_week,
    COUNT(*) AS number_of_sales
FROM sales
GROUP BY TO_CHAR(sales_transaction_date, 'Day'), EXTRACT(DOW FROM sales_transaction_date)
ORDER BY number_of_sales DESC
LIMIT 1;
```

**Скриншот выполнения запроса**

<img width="402" height="183" alt="image" src="https://github.com/user-attachments/assets/39e1d793-0f20-4360-943a-1386b7a34eb9" />


---

## Задание №8 (Блок Б. Геопространственный анализ)
**Условие:** найти дилерский центр, у которого наибольшее количество клиентов в радиусе 100 миль.

### Решение

Для работы с геоданными предварительно устанавливаются расширения `cube` и `earthdistance`. Затем выполняется `CROSS JOIN` между таблицами дилеров и клиентов, вычисляется расстояние с помощью оператора `<@>` (возвращает расстояние в милях между точками `point(longitude, latitude)`). Результат группируется по дилеру, считается количество уникальных клиентов в радиусе 100 миль.


**Запрос**

```sql
SELECT 
    d.dealership_id,
    COUNT(DISTINCT c.customer_id) AS customers_in_radius
FROM dealerships d
CROSS JOIN customers c
WHERE (point(d.longitude, d.latitude) <@> point(c.longitude, c.latitude)) <= 100
GROUP BY d.dealership_id
ORDER BY customers_in_radius DESC
LIMIT 1;
```

**Скриншот выполнения запроса**

<img width="436" height="192" alt="image" src="https://github.com/user-attachments/assets/841d85cb-6b50-4f5d-910f-4401072fbaaa" />

---

## Задание №11 (Блок В. Сложные типы - JSON)
**Условие:** сформировать JSON-объект для каждого клиента: `{"id": 1, "products": ["Car", "Scooter"]}` с использованием агрегации массивов.

### Решение

Выполняется соединение таблиц `customers`, `sales` и `products`. С помощью `JSONB_BUILD_OBJECT` создается JSON-объект с ключами `id` и `products`. Для формирования массива уникальных типов продуктов используется `JSONB_AGG(DISTINCT ...)`. Группировка выполняется по `customer_id`.

```sql
SELECT 
    c.customer_id,
    JSONB_BUILD_OBJECT(
        'id', c.customer_id,
        'products', JSONB_AGG(DISTINCT p.product_type)
    ) AS purchase_history
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
JOIN products p ON s.product_id = p.product_id
GROUP BY c.customer_id
ORDER BY c.customer_id;
```

**Скриншот выполнения запроса**

<img width="538" height="536" alt="image" src="https://github.com/user-attachments/assets/bb40e439-8f3a-4c56-952b-abec41988aab" />

---

## Вывод

В ходе выполнения практической работы для заданий №1, №8, №11:

- Для **анализа временных рядов** (задание №1) использованы функции `TO_CHAR` и `EXTRACT`, позволяющие группировать данные по дню недели и определять день с максимальным количеством продаж.
- Для **геопространственного анализа** (задание №8) применены расширения `cube` и `earthdistance`, оператор `<@>` для расчета расстояния между точками координат, что позволило найти дилерский центр с наибольшим охватом клиентов в радиусе 100 миль.
- Для **работы с JSON** (задание №11) использованы функции `JSONB_BUILD_OBJECT` и `JSONB_AGG`, позволяющие формировать структурированные JSON-объекты с агрегированными данными о покупках клиентов.

