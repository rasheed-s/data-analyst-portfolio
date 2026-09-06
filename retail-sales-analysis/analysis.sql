-- 1. Executive KPIs.
SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(100.0 * SUM(profit) / NULLIF(SUM(sales), 0), 2) AS profit_margin_pct
FROM superstore_sales;

-- 2. Category performance.
SELECT
    category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(100.0 * SUM(profit) / NULLIF(SUM(sales), 0), 2) AS profit_margin_pct
FROM superstore_sales
GROUP BY category
ORDER BY total_sales DESC;

-- 3. Regional performance with ranking.
WITH regional AS (
    SELECT region, SUM(sales) AS sales, SUM(profit) AS profit
    FROM superstore_sales
    GROUP BY region
)
SELECT
    region,
    ROUND(sales, 2) AS total_sales,
    ROUND(profit, 2) AS total_profit,
    RANK() OVER (ORDER BY sales DESC) AS sales_rank,
    RANK() OVER (ORDER BY profit DESC) AS profit_rank
FROM regional
ORDER BY sales_rank;

-- 4. Monthly sales, profit, and running totals.
WITH monthly AS (
    SELECT
        DATE_TRUNC('month', order_date)::date AS month,
        SUM(sales) AS sales,
        SUM(profit) AS profit
    FROM superstore_sales
    GROUP BY DATE_TRUNC('month', order_date)
)
SELECT
    month,
    ROUND(sales, 2) AS monthly_sales,
    ROUND(profit, 2) AS monthly_profit,
    ROUND(SUM(sales) OVER (ORDER BY month), 2) AS running_sales,
    ROUND(SUM(profit) OVER (ORDER BY month), 2) AS running_profit
FROM monthly
ORDER BY month;

-- 5. Top 10 products by sales with profitability context.
SELECT
    product_name,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS units_sold
FROM superstore_sales
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;

-- 6. Bottom 10 products by profit.
SELECT
    product_name,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(discount) * 100, 2) AS avg_discount_pct
FROM superstore_sales
GROUP BY product_name
HAVING SUM(profit) < 0
ORDER BY total_profit
LIMIT 10;

-- 7. Discount bands and profitability.
SELECT
    CASE
        WHEN discount = 0 THEN 'No discount'
        WHEN discount <= 0.20 THEN '1-20%'
        WHEN discount <= 0.40 THEN '21-40%'
        ELSE 'Above 40%'
    END AS discount_band,
    COUNT(*) AS transaction_rows,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(100.0 * SUM(profit) / NULLIF(SUM(sales), 0), 2) AS profit_margin_pct
FROM superstore_sales
GROUP BY discount_band
ORDER BY MIN(discount);

-- 8. Sub-category contribution and rank within category.
WITH subcategory AS (
    SELECT category, sub_category, SUM(sales) AS sales, SUM(profit) AS profit
    FROM superstore_sales
    GROUP BY category, sub_category
)
SELECT
    category,
    sub_category,
    ROUND(sales, 2) AS total_sales,
    ROUND(profit, 2) AS total_profit,
    DENSE_RANK() OVER (PARTITION BY category ORDER BY sales DESC) AS category_sales_rank
FROM subcategory
ORDER BY category, category_sales_rank;

-- 9. Customer value ranking.
SELECT
    customer_id,
    customer_name,
    COUNT(DISTINCT order_id) AS order_count,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    DENSE_RANK() OVER (ORDER BY SUM(sales) DESC) AS customer_sales_rank
FROM superstore_sales
GROUP BY customer_id, customer_name
ORDER BY customer_sales_rank
LIMIT 25;

-- 10. Year-over-year sales and growth.
WITH yearly AS (
    SELECT EXTRACT(YEAR FROM order_date)::int AS year, SUM(sales) AS sales
    FROM superstore_sales
    GROUP BY EXTRACT(YEAR FROM order_date)
), compared AS (
    SELECT year, sales, LAG(sales) OVER (ORDER BY year) AS prior_year_sales
    FROM yearly
)
SELECT
    year,
    ROUND(sales, 2) AS total_sales,
    ROUND(100.0 * (sales - prior_year_sales) / NULLIF(prior_year_sales, 0), 2) AS yoy_growth_pct
FROM compared
ORDER BY year;

