
-- Подготовка расширений для геоданных
CREATE EXTENSION IF NOT EXISTS cube;
CREATE EXTENSION IF NOT EXISTS earthdistance;


-- ЗАДАНИЕ №1. Дни недели продаж (Блок А)
SELECT 
    TO_CHAR(sales_transaction_date, 'Day') AS day_of_week,
    COUNT(*) AS number_of_sales
FROM sales
GROUP BY TO_CHAR(sales_transaction_date, 'Day'), EXTRACT(DOW FROM sales_transaction_date)
ORDER BY number_of_sales DESC
LIMIT 1;


-- ЗАДАНИЕ №8. Покрытие дилеров (Блок Б)

SELECT 
    d.dealership_id,
    COUNT(DISTINCT c.customer_id) AS customers_in_radius
FROM dealerships d
CROSS JOIN customers c
WHERE (point(d.longitude, d.latitude) <@> point(c.longitude, c.latitude)) <= 100
GROUP BY d.dealership_id
ORDER BY customers_in_radius DESC
LIMIT 1;

-- ЗАДАНИЕ №11. История покупок в JSON (Блок В)
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

