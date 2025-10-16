-- Project: FastKitchen Customer Analysis
-- Author: Daniyal Tariq Butt
-- Datasets: fastkitchen.orders, fastkitchen.users
-- (c) 2025 Daniyal Tariq Butt

-- Query 1
SELECT AVG(total) AS avg_total_per_order FROM fastkitchen.orders;

-- Query 2
SELECT order_type, AVG(subtotal) AS avg_subtotal, AVG(tip) AS avg_tip, AVG(total) AS avg_total
FROM fastkitchen.orders
GROUP BY order_type;

-- Query 3
SELECT COUNT(*) AS num_registered_orders FROM fastkitchen.orders WHERE user_id IS NOT NULL;

-- Query 4
SELECT COUNT(*) AS num_guest_orders FROM fastkitchen.orders WHERE user_id IS NULL;

-- Query 5
SELECT city, COUNT(*) AS num_users FROM fastkitchen.users GROUP BY city ORDER BY num_users DESC;

-- Query 6
SELECT city, zip, COUNT(*) AS num_users FROM fastkitchen.users GROUP BY city, zip ORDER BY city, num_users DESC;

-- Query 7
SELECT * FROM fastkitchen.orders o LEFT JOIN fastkitchen.users u ON o.user_id = u.user_id;

-- Query 8
SELECT u.zip, o.user_id, SUM(o.total) AS total_spent
FROM fastkitchen.orders o
LEFT JOIN fastkitchen.users u ON o.user_id = u.user_id
WHERE o.user_id IS NOT NULL
GROUP BY u.zip, o.user_id
ORDER BY total_spent DESC
LIMIT 1;

-- Query 9
SELECT u.zip, AVG(o.total) AS avg_total_per_order
FROM fastkitchen.orders o
LEFT JOIN fastkitchen.users u ON o.user_id = u.user_id
WHERE o.user_id IS NOT NULL
GROUP BY u.zip
ORDER BY avg_total_per_order DESC;

