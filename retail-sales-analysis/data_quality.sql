SELECT COUNT(*) AS transaction_rows,
       COUNT(DISTINCT order_id) AS unique_orders,
       COUNT(DISTINCT customer_id) AS unique_customers,
       COUNT(DISTINCT product_id) AS unique_products
FROM superstore_sales;

SELECT
    COUNT(*) FILTER (WHERE order_id IS NULL) AS missing_order_id,
    COUNT(*) FILTER (WHERE order_date IS NULL) AS missing_order_date,
    COUNT(*) FILTER (WHERE sales IS NULL) AS missing_sales,
    COUNT(*) FILTER (WHERE profit IS NULL) AS missing_profit
FROM superstore_sales;

SELECT
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    MIN(sales) AS min_sales,
    MAX(sales) AS max_sales,
    MIN(discount) AS min_discount,
    MAX(discount) AS max_discount
FROM superstore_sales;

