# Dashboard Spec — Meridian Retail Group: Sales & Discount Performance

## Business question
"Where are we growing profitably, and where is discounting quietly eating our margin?"
This is a realistic question a mid-market retail client's finance or merchandising
lead would actually ask a BI consultant — not just "show me total sales."

## Audience
VP of Merchandising / Regional Sales Directors at a multi-region retailer.

## Data source
`data/retail_sales_data.csv` — 6,000 orders, 2023-2025, three regions
(North America, Europe, APAC), three product categories.

## Layout — 3 tabs (or 1 tab with 3 sections if using a single dashboard)

### Tab 1: Executive Overview
- KPI cards: Total Sales, Total Profit, Profit Margin %, Total Orders (with
  YoY % change on each)
- Line chart: Monthly sales trend, colored by region
- Map or bar chart: Sales by country
- Filter: Year, Region (top of dashboard, applies to all tabs)

### Tab 2: Category & Segment Mix
- Treemap or bar chart: Sales by product category → subcategory
- Stacked bar: Sales by customer segment (Consumer / Corporate / Home Office)
  across categories
- Table: Top 10 subcategory × segment combinations by profit

### Tab 3: Discount Impact (the "insight" tab — this is what to lead with
in a portfolio writeup, since it shows analysis, not just reporting)
- Scatter plot: Discount % vs. Profit Margin, one dot per order, colored by category
- Bar chart: Average profit margin by discount band (No Discount / 1-10% / 11-20% / 21%+)
- Callout text box: the one-sentence finding (e.g. "Discounts above 20% turn
  profitable orders unprofitable in Electronics, but not in Apparel")

## Interactivity
- Global filters: Year, Region, Customer Segment
- Tooltip on the scatter plot showing order_id, category, discount %, margin
- Highlight action: clicking a category in Tab 2 filters Tab 3 to that category

## What this project is meant to demonstrate
- Ability to go from a warehouse-style data model (see `sql/`) to a dashboard,
  not just connect Tableau to a flat file
- An actual analytical finding (discount/margin relationship), not just KPIs
- Clean, business-relevant filtering and layout decisions

## Publishing checklist
- [ ] Build in Tableau Desktop using `data/retail_sales_data.csv`
- [ ] Publish to Tableau Public
- [ ] Add the live dashboard link to `README.md` and to this repo's About section
- [ ] Take a screenshot for the README and for LinkedIn
