-- 1. Create a Database (Schema) if it doesn't already exist
CREATE DATABASE IF NOT EXISTS ecommerce_sales;

-- 2. Select this new database for use
USE ecommerce_sales;

-- 3. Create the table structure matching the CSV columns
CREATE TABLE online_sales_data (
    `Transaction ID` INT PRIMARY KEY, -- Unique Identifier
    `Date` DATE NOT NULL,             -- Date type for date functionsonline_sales_data
    `Product Category` VARCHAR(50),
    `Product Name` VARCHAR(100),
    `Units Sold` INT,
    `Unit Price` DECIMAL(10, 2),      -- Decimal type for currency
    `Total Revenue` DECIMAL(10, 2),
    `Region` VARCHAR(50),
    `Payment Method` VARCHAR(50)
);




USE ecommerce_sales;

SELECT
    EXTRACT(YEAR FROM Date) AS sales_year,
    EXTRACT(MONTH FROM Date) AS sales_month,
    SUM(`Total Revenue`) AS total_revenue,
    COUNT(DISTINCT `Transaction ID`) AS transaction_volume
FROM
    online_sales_data  -- The table exists now!
GROUP BY
    sales_year,
    sales_month
ORDER BY
    sales_year ASC,
    sales_month ASC;
    
    
   --  Monthly Trend for a Specific Time Period
   
   SELECT
    EXTRACT(YEAR FROM Date) AS sales_year,
    EXTRACT(MONTH FROM Date) AS sales_month,
    SUM(`Total Revenue`) AS total_revenue,
    COUNT(DISTINCT `Transaction ID`) AS volume
FROM
    online_sales_data
WHERE                                               -- f. Limit results for specific time periods
    EXTRACT(YEAR FROM Date) = 2024
    AND EXTRACT(MONTH FROM Date) IN (1, 2, 3)       -- Q1: January, February, March
GROUP BY
    sales_year,
    sales_month
ORDER BY
    sales_month ASC;  
    
    -- Top-Performing Product Categories in a Single Month (March 2024)
    
    SELECT
    `Product Category`,
    SUM(`Total Revenue`) AS total_category_revenue,
    COUNT(DISTINCT `Transaction ID`) AS volume
FROM
    online_sales_data
WHERE                                               -- f. Limit results for a specific time period (March 2024)
    EXTRACT(YEAR FROM Date) = 2024
    AND EXTRACT(MONTH FROM Date) = 3
GROUP BY
    `Product Category`
ORDER BY                                            -- e. ORDER BY for sorting (Highest revenue first)
    total_category_revenue DESC;  
    
    -- Average Monthly Revenue Per Region (2024 Only)
    
    SELECT
    EXTRACT(MONTH FROM Date) AS sales_month,
    Region,
    SUM(`Total Revenue`) AS total_revenue,
    AVG(SUM(`Total Revenue`)) OVER (PARTITION BY Region) AS avg_monthly_revenue_per_region
FROM
    online_sales_data
WHERE
    EXTRACT(YEAR FROM Date) = 2024
GROUP BY                                            -- b. GROUP BY month and Region
    sales_month,
    Region
ORDER BY
    Region,
    sales_month;  


