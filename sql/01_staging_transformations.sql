-- ============================================================
-- Meridian Retail Group — Staging Transformations
-- Target: Snowflake (syntax is Snowflake-compatible)
-- Purpose: Clean and standardize raw order-level data landed by
--          Fivetran into RAW schema, before it's used in Tableau.
-- ============================================================

CREATE OR REPLACE TABLE staging.stg_retail_orders AS
SELECT
    order_id,
    TRY_TO_DATE(order_date)                        AS order_date,
    TRY_TO_DATE(ship_date)                          AS ship_date,
    DATEDIFF('day', order_date, ship_date)          AS fulfillment_days,
    INITCAP(region)                                 AS region,
    INITCAP(country)                                AS country,
    INITCAP(customer_segment)                       AS customer_segment,
    INITCAP(product_category)                       AS product_category,
    INITCAP(product_subcategory)                    AS product_subcategory,
    quantity,
    unit_price,
    discount,
    sales,
    profit,
    ROUND(profit / NULLIF(sales, 0), 4)             AS profit_margin,
    shipping_cost,
    order_priority,
    -- Flag rows where the numbers don't reconcile — a check that would
    -- catch upstream pipeline issues before they hit the dashboard.
    CASE
        WHEN sales <= 0 THEN TRUE
        WHEN quantity <= 0 THEN TRUE
        WHEN fulfillment_days < 0 THEN TRUE
        ELSE FALSE
    END                                              AS is_data_quality_flag
FROM raw.retail_sales_data
WHERE order_date IS NOT NULL;

-- Quick data quality check — run after every load
SELECT
    COUNT(*)                                        AS total_rows,
    SUM(IFF(is_data_quality_flag, 1, 0))            AS flagged_rows,
    ROUND(SUM(IFF(is_data_quality_flag, 1, 0)) / COUNT(*) * 100, 2) AS flagged_pct
FROM staging.stg_retail_orders;
