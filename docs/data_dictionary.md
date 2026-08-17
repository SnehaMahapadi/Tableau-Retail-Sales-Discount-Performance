# Data Dictionary — retail_sales_data.csv

| Column | Type | Description |
|---|---|---|
| order_id | string | Unique order identifier (format: MRG-YYYY-#####) |
| order_date | date | Date the order was placed |
| ship_date | date | Date the order was shipped |
| region | string | North America / Europe / APAC |
| country | string | Country within the region |
| customer_segment | string | Consumer / Corporate / Home Office |
| product_category | string | Apparel / Home & Living / Electronics |
| product_subcategory | string | Subcategory within the product category |
| quantity | integer | Units ordered |
| unit_price | decimal | Price per unit before discount |
| discount | decimal | Discount applied, as a fraction (0.1 = 10%) |
| sales | decimal | Net sales after discount (quantity × unit_price × (1 - discount)) |
| profit | decimal | Profit on the order (can be negative on heavily discounted orders) |
| shipping_cost | decimal | Cost to ship the order |
| order_priority | string | Low / Medium / High / Critical |

Note: this is a synthetic dataset generated for portfolio purposes
(see `generate_data.py`) — it is not real client data.
