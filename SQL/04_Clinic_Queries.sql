-- ============================================
-- CLINIC MANAGEMENT SYSTEM - ADVANCED QUERIES
-- ============================================


-- ============================================
-- Q1: Total REVENUE by Sales Channel
-- ============================================

-- Logic:
-- Group revenue based on channel

SELECT 
    sales_channel,
    SUM(amount) AS total_revenue
FROM clinic_sales
GROUP BY sales_channel
ORDER BY total_revenue DESC;



-- ============================================
-- Q2: Monthly REVENUE
-- ============================================

-- Logic:
-- Extract month and sum revenue

SELECT 
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    SUM(amount) AS monthly_revenue
FROM clinic_sales
GROUP BY year, month
ORDER BY year, month;



-- ============================================
-- Q3: Monthly PROFIT / LOSS
-- ============================================

-- Logic:
-- Profit = Revenue - Expenses

WITH revenue_data AS (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        SUM(amount) AS revenue
    FROM clinic_sales
    GROUP BY year, month
),

expense_data AS (
    SELECT 
        YEAR(expense_date) AS year,
        MONTH(expense_date) AS month,
        SUM(amount) AS expenses
    FROM expenses
    GROUP BY year, month
)

SELECT 
    r.year,
    r.month,
    r.revenue,
    e.expenses,
    (r.revenue - e.expenses) AS profit_or_loss
FROM revenue_data r
JOIN expense_data e 
    ON r.year = e.year AND r.month = e.month
ORDER BY r.year, r.month;



-- ============================================
-- Q4: Top Performing Channel per Month
-- ============================================

-- Logic:
-- Rank channels by revenue per month

WITH channel_revenue AS (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        sales_channel,
        SUM(amount) AS revenue
    FROM clinic_sales
    GROUP BY year, month, sales_channel
),

ranked_channels AS (
    SELECT *,
        RANK() OVER (
            PARTITION BY year, month 
            ORDER BY revenue DESC
        ) AS rank_position
    FROM channel_revenue
)

SELECT *
FROM ranked_channels
WHERE rank_position = 1
ORDER BY year, month;



-- ============================================
-- Q5: Highest Revenue Month
-- ============================================

-- Logic:
-- Find month with maximum revenue

WITH monthly_revenue AS (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        SUM(amount) AS revenue
    FROM clinic_sales
    GROUP BY year, month
)

SELECT *
FROM monthly_revenue
ORDER BY revenue DESC
LIMIT 1;