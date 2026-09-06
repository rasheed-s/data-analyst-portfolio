# Retail Sales Performance Analysis

## Business Question

Where is the business generating sales and profit, which products or discount levels are weakening margins, and what trends should leaders act on?

## Dataset

- **Source:** Tableau's public Sample Superstore dataset, distributed through public analytics repositories
- **Rows:** 9,994 transaction line items
- **Period:** 2014–2017
- **Scope:** orders, customers, products, geography, sales, quantity, discount, and profit

## Tools and Skills

PostgreSQL, data validation, aggregate functions, CTEs, date functions, profitability analysis, ranking, running totals, `LAG`, and window functions.

## Project Files

- `data/superstore.csv` — source transaction data with SQL-friendly headers
- `schema.sql` — PostgreSQL table definition and import instructions
- `data_quality.sql` — row, entity, missing-value, date, and numeric checks
- `analysis.sql` — ten business analyses from executive KPIs to year-over-year growth

## How to Run

1. Create a PostgreSQL database.
2. Run `schema.sql`.
3. From `psql`, run the `\copy` command shown at the bottom of `schema.sql`.
4. Run `data_quality.sql`, followed by `analysis.sql`.

## Key Findings

- The dataset contains **9,994 line items**, **5,009 unique orders**, and **793 customers**.
- Total sales were **$2.30 million**, producing **$286,397.02** in profit and a **12.47% profit margin**.
- The **West** led both sales and profit, while the **Central** region produced a much lower margin despite substantial sales.
- **Technology** produced the highest category sales and profit; **Furniture** generated the weakest profit margin.
- Transactions discounted above 40% were unprofitable in aggregate, signaling a need for tighter discount controls.
- Sales increased each year from 2014 through 2017, with 2017 producing the highest annual sales.

## Recommendations

1. Review discount approval rules above 40%, especially for consistently loss-making products and sub-categories.
2. Protect high-performing Technology products while investigating Furniture pricing, fulfillment, and product mix.
3. Study practices in the West region and test whether they can improve performance in lower-margin regions.
4. Pair revenue targets with profit-margin targets so high sales do not hide unprofitable growth.

