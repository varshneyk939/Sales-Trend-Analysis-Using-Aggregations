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