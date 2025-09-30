# Sales-Trend-Analysis-Using-Aggregations

E-Commerce Sales Data Analysis README
This document provides a comprehensive guide for setting up your database, importing the Online Sales Data.csv file, and running the advanced analytical SQL queries designed to extract key monthly performance metrics.

1. Prerequisites and Setup ⚙️
A. Environment
Database: MySQL Server (e.g., MySQL 8.0+)

Client Tool: MySQL Workbench (Recommended)

Dataset: Online Sales Data.csv

B. Analytical Requirements
The provided SQL queries fulfill all the following aggregation requirements:

✓ Date Extraction: Use EXTRACT(MONTH/YEAR FROM Date).

✓ Grouping: GROUP BY year/month.

✓ Revenue: SUM(\Total Revenue`)`.

✓ Volume: COUNT(DISTINCT \Transaction ID`)`.

✓ Sorting: Use ORDER BY.

✓ Time Limits: Use WHERE clauses for specific periods.

2. Database and Table Creation (Setup Script)
Run this entire script in a new SQL tab in MySQL Workbench. This creates the database and the table structure necessary to hold your CSV data.

SQL

-- Creates the database (schema) if it doesn't exist and selects it for use

CREATE DATABASE IF NOT EXISTS ecommerce_sales;
USE ecommerce_sales;

-- Creates the table structure matching the CSV columns
CREATE TABLE online_sales_data (
    `Transaction ID` INT PRIMARY KEY,
    `Date` DATE NOT NULL,
    `Product Category` VARCHAR(50),
    `Product Name` VARCHAR(100),
    `Units Sold` INT,
    `Unit Price` DECIMAL(10, 2),
    `Total Revenue` DECIMAL(10, 2),
    `Region` VARCHAR(50),
    `Payment Method` VARCHAR(50)
);
3. Data Import Guide (Loading the CSV) 📥
After successfully running the setup script, use the MySQL Workbench Data Import Wizard:

In the MySQL Workbench Navigator panel, right-click on the newly created online_sales_data table (under ecommerce_sales -> Tables).

Select "Table Data Import Wizard...".

Click "Browse..." and select your Online Sales Data.csv file.

In the Select Destination step, choose the "Use existing table" option and ensure it is set to ecommerce_sales.online_sales_data.

Review the Configure Import Settings step: verify the Field Separator is a comma (,) and the data preview looks correct.

Complete the wizard to load the data.

4. Analytical SQL Queries 📊
Use the following queries to analyze the imported data.

Query A: All-Time Monthly Trend
Calculates total revenue and transaction volume for every month in the dataset.

SQL

SELECT
    EXTRACT(YEAR FROM Date) AS sales_year,
    EXTRACT(MONTH FROM Date) AS sales_month,
    SUM(`Total Revenue`) AS total_revenue,          
    COUNT(DISTINCT `Transaction ID`) AS volume      
FROM
    online_sales_data
GROUP BY
    sales_year,
    sales_month
ORDER BY
    sales_year ASC,
    sales_month ASC;
Query B: Quarterly Sales Performance (Q1 2024)
Limits the analysis to a specific period (January, February, March 2024).

SQL

SELECT
    EXTRACT(YEAR FROM Date) AS sales_year,
    EXTRACT(MONTH FROM Date) AS sales_month,
    SUM(`Total Revenue`) AS total_revenue,
    COUNT(DISTINCT `Transaction ID`) AS volume
FROM
    online_sales_data
WHERE
    EXTRACT(YEAR FROM Date) = 2024
    AND EXTRACT(MONTH FROM Date) IN (1, 2, 3) 
GROUP BY
    sales_year,
    sales_month
ORDER BY
    sales_month ASC;
Query C: Top Product Categories by Revenue (Single Month)
Identifies the best-selling product categories for a specific month (e.g., March 2024).

SQL

SELECT
    `Product Category`,
    SUM(`Total Revenue`) AS total_category_revenue,
    COUNT(DISTINCT `Transaction ID`) AS volume
FROM
    online_sales_data
WHERE
    EXTRACT(YEAR FROM Date) = 2024
    AND EXTRACT(MONTH FROM Date) = 3
GROUP BY
    `Product Category`
ORDER BY
    total_category_revenue DESC;
