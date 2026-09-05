# Meridian Retail Group — Sales \& Discount Performance Dashboard

**Live dashboard:** *https://public.tableau.com/app/profile/sneha.mahapadi/viz/SalesDiscountPerformance/ExecutiveOverview#1*



## Overview

A retail sales analytics project built to answer a real business question:
*where is a multi-region retailer growing profitably, and where is discounting
quietly eating into margin?* Built end-to-end — from a warehouse-style data
model through to an interactive Tableau dashboard — to reflect how this kind
of work actually gets done for a client, not just a chart built on a raw CSV.

## What's in this repo

* `data/retail\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\_sales\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\_data.csv` — synthetic order-level dataset, 6,000 rows,
2023-2025, three regions, three product categories (see `docs/data\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\_dictionary.md`)
* `sql/01\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\_staging\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\_transformations.sql` — Snowflake-style staging: cleaning,
standardization, and data quality flags
* `sql/02\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\_kpi\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\_aggregations.sql` — pre-aggregated views that back the dashboard
* `docs/dashboard\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\_spec.md` — full dashboard design: layout, KPIs, and the
specific analytical finding the dashboard is built to surface
* `docs/data\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\_dictionary.md` — column-level definitions

## Tech stack

Tableau (visualization) · SQL / Snowflake syntax (staging \& aggregation) ·
Python/pandas (synthetic data generation)

## Key finding

Average profit margin falls from 25% on full-price orders to effectively 0%
on orders discounted 21% or more — heavy discounting isn't just cutting into
margin, it's erasing it entirely. This pattern is only visible once discount
rate and margin are plotted together, not from looking at total sales alone.
See `docs/dashboard\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\_spec.md` for the full breakdown.

## Why this project is structured this way

Most portfolio dashboards start from a flat file and skip straight to
charts. This one is built the way a client engagement actually runs: raw
data → staging/cleaning → aggregated views → dashboard — which is closer to
the BI Assessment and Data Architecture work this portfolio is meant to
represent, not just dashboard styling.

## Reproducing this project

1. `python3 generate\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\_data.py` to regenerate the dataset (optional — the CSV
is already included in `data/`)
2. Open `data/retail\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\_sales\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\_data.csv` in Tableau Desktop
3. Build the dashboard per `docs/dashboard\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\_spec.md`
4. Publish to Tableau Public and add the link at the top of this README

