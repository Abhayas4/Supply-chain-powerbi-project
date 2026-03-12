# Supply Chain Data Analysis & Power BI Dashboard

## Project Overview

This project analyzes supply chain order data to understand shipping performance, delivery delays, and risk of late deliveries. Using SQL for data preparation and Power BI for visualization, the project transforms raw operational data into an interactive dashboard that highlights key logistics insights.

## Objectives

* Analyze shipping performance across different shipping modes
* Compare scheduled vs actual shipping times
* Identify patterns in late deliveries
* Build a professional dashboard to visualize supply chain performance

## Data Preparation

The dataset contains **180,519 records** of order and shipping data.

Steps performed:

* Cleaned and structured the dataset
* Removed duplicate records
* Created a **dim_shipping** dimension table from the fact table
* Inserted shipping attributes such as shipping date, shipping mode, delivery status, and late delivery risk
* Built SQL queries to populate and manage the dimension table

## Data Modeling

A dimensional model was created including:

* **Fact Table:** `fact_orders`
* **Dimension Table:** `dim_shipping`

This structure enables efficient analysis of shipping and delivery metrics.

## Power BI Dashboard

A Power BI dashboard was created to visualize key metrics including:

* Total Orders
* Average Shipping Days
* Average Delivery Delay
* Late Delivery Risk
* Shipping Mode Distribution
* Delivery Status Breakdown
* Comparison of Real vs Scheduled Shipping Days

## Key Insights

* Certain shipping modes show higher late delivery risk.
* Actual shipping time sometimes exceeds scheduled delivery time, creating delays.
* Delivery status distribution highlights operational performance trends.

## Tools & Technologies

* SQL (MySQL)
* Power BI
* Data Modeling (Star Schema)
* Data Visualization

## Dashboard Preview

![Dashboard](images/dashboard_preview.png)

## Project Outcome

This project demonstrates the complete workflow of a data analyst:
data preparation, SQL transformation, dimensional modeling, and business-focused visualization using Power BI.
