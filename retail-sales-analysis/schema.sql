DROP TABLE IF EXISTS superstore_sales;

CREATE TABLE superstore_sales (
    row_id INTEGER PRIMARY KEY,
    order_id VARCHAR(30) NOT NULL,
    order_date DATE NOT NULL,
    ship_date DATE NOT NULL,
    ship_mode VARCHAR(30) NOT NULL,
    customer_id VARCHAR(20) NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    segment VARCHAR(30) NOT NULL,
    country VARCHAR(50) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20),
    region VARCHAR(20) NOT NULL,
    product_id VARCHAR(30) NOT NULL,
    category VARCHAR(30) NOT NULL,
    sub_category VARCHAR(30) NOT NULL,
    product_name TEXT NOT NULL,
    sales NUMERIC(12, 4) NOT NULL,
    quantity INTEGER NOT NULL,
    discount NUMERIC(5, 2) NOT NULL,
    profit NUMERIC(12, 4) NOT NULL
);

-- Run this command from psql after creating the table:
-- \copy superstore_sales FROM 'data/superstore.csv' WITH (FORMAT csv, HEADER true);

