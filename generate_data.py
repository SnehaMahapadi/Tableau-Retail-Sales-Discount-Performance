"""
Generates a synthetic multi-region retail sales dataset for
'Meridian Retail Group' — a fictional retailer used for portfolio purposes.
Deliberately distinct from the common Superstore dataset (different
brand, categories, and business rules) so it reads as original work.
"""
import numpy as np
import pandas as pd
from datetime import date, timedelta

rng = np.random.default_rng(42)

N = 6000
start = date(2023, 1, 1)
end = date(2025, 12, 31)
date_range_days = (end - start).days

regions = {
    "North America": ["United States", "Canada", "Mexico"],
    "Europe": ["United Kingdom", "Germany", "France", "Spain"],
    "APAC": ["Australia", "Japan", "Singapore", "India"],
}
region_list = list(regions.keys())
region_weights = [0.5, 0.3, 0.2]  # NA-heavy, matches a US-anchored client base

categories = {
    "Apparel": ["Outerwear", "Footwear", "Accessories", "Activewear"],
    "Home & Living": ["Furniture", "Decor", "Kitchenware", "Bedding"],
    "Electronics": ["Audio", "Wearables", "Smart Home", "Accessories"],
}
category_list = list(categories.keys())

segments = ["Consumer", "Corporate", "Home Office"]
segment_weights = [0.6, 0.25, 0.15]

priorities = ["Low", "Medium", "High", "Critical"]
priority_weights = [0.35, 0.4, 0.2, 0.05]

rows = []
for i in range(N):
    order_date = start + timedelta(days=int(rng.integers(0, date_range_days)))
    region = rng.choice(region_list, p=region_weights)
    country = rng.choice(regions[region])
    category = rng.choice(category_list)
    subcategory = rng.choice(categories[category])
    segment = rng.choice(segments, p=segment_weights)
    priority = rng.choice(priorities, p=priority_weights)

    ship_lag = int(rng.integers(1, 9))
    ship_date = order_date + timedelta(days=ship_lag)

    quantity = int(rng.integers(1, 12))
    unit_price = round(float(rng.uniform(8, 450)), 2)
    discount = round(float(rng.choice([0, 0, 0, 0.05, 0.1, 0.15, 0.2, 0.3])), 2)

    gross_sales = round(quantity * unit_price, 2)
    sales = round(gross_sales * (1 - discount), 2)

    base_margin = rng.uniform(0.08, 0.42)
    # discount pressure lowers margin, simulating a realistic BI question
    margin = max(base_margin - discount * rng.uniform(0.5, 1.2), -0.15)
    profit = round(sales * margin, 2)

    shipping_cost = round(quantity * rng.uniform(0.8, 6.5) + rng.uniform(2, 15), 2)

    rows.append({
        "order_id": f"MRG-{2023 + order_date.year - 2023}-{i+10000}",
        "order_date": order_date.isoformat(),
        "ship_date": ship_date.isoformat(),
        "region": region,
        "country": country,
        "customer_segment": segment,
        "product_category": category,
        "product_subcategory": subcategory,
        "quantity": quantity,
        "unit_price": unit_price,
        "discount": discount,
        "sales": sales,
        "profit": profit,
        "shipping_cost": shipping_cost,
        "order_priority": priority,
    })

df = pd.DataFrame(rows).sort_values("order_date").reset_index(drop=True)
df.to_csv("/home/claude/project-tableau-retail-sales/data/retail_sales_data.csv", index=False)
print(df.shape)
print(df.head())
print("\nSummary:")
print(f"Total sales: ${df['sales'].sum():,.0f}")
print(f"Total profit: ${df['profit'].sum():,.0f}")
print(f"Date range: {df['order_date'].min()} to {df['order_date'].max()}")
