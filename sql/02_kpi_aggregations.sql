-- ============================================================
-- Meridian Retail Group — KPI Aggregations
-- Purpose: Pre-aggregated views that back the Tableau dashboard.
-- Building these in the warehouse (not in Tableau calculated
-- fields) keeps the extract small and the dashboard fast —
-- this is the kind of decision a BI Assessment would flag.
-- ============================================================

-- Monthly performance by region, for the trend + regional views
CREATE OR REPLACE VIEW analytics.vw_monthly_region_performance AS
SELECT
    DATE_TRUNC('month', order_date)   AS order_month,
    region,
    country,
    COUNT(DISTINCT order_id)          AS total_orders,
    SUM(sales)                        AS total_sales,
    SUM(profit)                       AS total_profit,
    ROUND(SUM(profit) / NULLIF(SUM(sales), 0), 4) AS profit_margin,
    SUM(shipping_cost)                AS total_shipping_cost,
    AVG(fulfillment_days)             AS avg_fulfillment_days
FROM staging.stg_retail_orders
WHERE NOT is_data_quality_flag
GROUP BY 1, 2, 3;

-- Category performance, for the product mix view
CREATE OR REPLACE VIEW analytics.vw_category_performance AS
SELECT
    product_category,
    product_subcategory,
    customer_segment,
    COUNT(DISTINCT order_id)          AS total_orders,
    SUM(quantity)                     AS units_sold,
    SUM(sales)                        AS total_sales,
    SUM(profit)                       AS total_profit,
    ROUND(AVG(discount), 4)           AS avg_discount
FROM staging.stg_retail_orders
WHERE NOT is_data_quality_flag
GROUP BY 1, 2, 3;

-- Discount-vs-margin relationship, for the discount impact view
-- (this is the "so what" insight the dashboard is built around)
CREATE OR REPLACE VIEW analytics.vw_discount_margin_impact AS
SELECT
    CASE
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount <= 0.1 THEN '1-10%'
        WHEN discount <= 0.2 THEN '11-20%'
        ELSE '21%+'
    END                                AS discount_band,
    COUNT(DISTINCT order_id)          AS total_orders,
    SUM(sales)                        AS total_sales,
    ROUND(AVG(profit_margin), 4)      AS avg_profit_margin
FROM staging.stg_retail_orders
WHERE NOT is_data_quality_flag
GROUP BY 1
ORDER BY 1;
