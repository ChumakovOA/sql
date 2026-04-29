-- Лабораторная №5

-- Задание №1

EXPLAIN ANALYZE
SELECT * FROM products WHERE product_type = 'automobile';

CREATE INDEX idx_products_type_hash ON products USING HASH (product_type);

EXPLAIN ANALYZE
SELECT * FROM products WHERE product_type = 'automobile';

-- Задание №2

EXPLAIN ANALYZE
SELECT * FROM customers WHERE latitude > 40;

CREATE INDEX idx_customers_latitude ON customers USING BTREE (latitude);

EXPLAIN ANALYZE
SELECT * FROM customers WHERE latitude > 40;

