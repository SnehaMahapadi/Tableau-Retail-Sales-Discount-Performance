# Meridian Retail Group — Sales & Discount Performance Dashboard

**Live dashboard:** _add your Tableau Public link here after publishing_

## Overview
A retail sales analytics project built to answer a real business question:
*where is a multi-region retailer growing profitably, and where is discounting
quietly eating into margin?* Built end-to-end — from a warehouse-style data
model through to an interactive Tableau dashboard — to reflect how this kind
of work actually gets done for a client, not just a chart built on a raw CSV.

## What's in this repo
- `data/retail_sales_data.csv` — synthetic order-level dataset, 6,000 rows,
  2023-2025, three regions, three product categories (see `docs/data_dictionary.md`)
- `sql/01_staging_transformations.sql` — Snowflake-style staging: cleaning,
  standardization, and data quality flags
- `sql/02_kpi_aggregations.sql` — pre-aggregated views that back the dashboard
- `docs/dashboard_spec.md` — full dashboard design: layout, KPIs, and the
  specific analytical finding the dashboard is built to surface
- `docs/data_dictionary.md` — column-level definitions

## Tech stack
Tableau (visualization) · SQL / Snowflake syntax (staging & aggregation) ·
Python/pandas (synthetic data generation)

## Key finding
Discount levels above 20% turn profitable orders unprofitable in some
categories but not others — a pattern only visible once discount rate and
margin are plotted together, not from looking at total sales alone. See
`docs/dashboard_spec.md` for the full breakdown.

## Why this project is structured this way
Most portfolio dashboards start from a flat file and skip straight to
charts. This one is built the way a client engagement actually runs: raw
data → staging/cleaning → aggregated views → dashboard — which is closer to
the BI Assessment and Data Architecture work this portfolio is meant to
represent, not just dashboard styling.

## Reproducing this project
1. `python3 generate_data.py` to regenerate the dataset (optional — the CSV
   is already included in `data/`)
2. Open `data/retail_sales_data.csv` in Tableau Desktop
3. Build the dashboard per `docs/dashboard_spec.md`
4. Publish to Tableau Public and add the link at the top of this README
