-- ============================================
-- HOTEL MANAGEMENT SYSTEM - ADVANCED QUERIES
-- ============================================


-- ============================================
-- Q1: Find the LAST booked room
-- ============================================

-- Logic:
-- Get the most recent booking using latest date

SELECT 
    booking_id,
    room_number,
    booking_date
FROM bookings
ORDER BY booking_date DESC
LIMIT 1;



-- ============================================
-- Q2: Total BILLING in November 2021
-- ============================================

-- Logic:
-- Join bookings + commercials + items
-- Calculate total = quantity * rate

SELECT 
    b.booking_id,
    b.booking_date,
    SUM(bc.quantity * i.rate) AS total_bill
FROM bookings b
JOIN booking_commercials bc 
    ON b.booking_id = bc.booking_id
JOIN items i 
    ON bc.item_id = i.item_id
WHERE MONTH(b.booking_date) = 11
  AND YEAR(b.booking_date) = 2021
GROUP BY b.booking_id, b.booking_date
ORDER BY total_bill DESC;



-- ============================================
-- Q3: Find BOOKINGS where bill > 1000
-- ============================================

-- Logic:
-- Use HAVING after aggregation

SELECT 
    b.booking_id,
    SUM(bc.quantity * i.rate) AS total_bill
FROM bookings b
JOIN booking_commercials bc 
    ON b.booking_id = bc.booking_id
JOIN items i 
    ON bc.item_id = i.item_id
GROUP BY b.booking_id
HAVING total_bill > 1000
ORDER BY total_bill DESC;



-- ============================================
-- Q4: MOST & LEAST ordered items per MONTH
-- ============================================

-- Logic:
-- 1. Calculate total quantity per item per month
-- 2. Use RANK() to find highest and lowest

WITH item_summary AS (
    SELECT 
        MONTH(b.booking_date) AS month,
        i.item_name,
        SUM(bc.quantity) AS total_quantity
    FROM bookings b
    JOIN booking_commercials bc 
        ON b.booking_id = bc.booking_id
    JOIN items i 
        ON bc.item_id = i.item_id
    GROUP BY month, i.item_name
),

ranked_items AS (
    SELECT *,
        RANK() OVER (
            PARTITION BY month 
            ORDER BY total_quantity DESC
        ) AS highest_rank,

        RANK() OVER (
            PARTITION BY month 
            ORDER BY total_quantity ASC
        ) AS lowest_rank
    FROM item_summary
)

SELECT *
FROM ranked_items
WHERE highest_rank = 1 
   OR lowest_rank = 1
ORDER BY month;



-- ============================================
-- Q5: Find 2nd HIGHEST bill
-- ============================================

-- Logic:
-- Rank all bookings by total bill

WITH bill_summary AS (
    SELECT 
        b.booking_id,
        SUM(bc.quantity * i.rate) AS total_bill
    FROM bookings b
    JOIN booking_commercials bc 
        ON b.booking_id = bc.booking_id
    JOIN items i 
        ON bc.item_id = i.item_id
    GROUP BY b.booking_id
),

ranked_bills AS (
    SELECT *,
        RANK() OVER (ORDER BY total_bill DESC) AS bill_rank
    FROM bill_summary
)

SELECT *
FROM ranked_bills
WHERE bill_rank = 2;