-- ============================================
-- HOTEL MANAGEMENT SYSTEM - SCHEMA SETUP
-- ============================================


-- ============================================
-- TABLE: users
-- Stores customer details
-- ============================================

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);



-- ============================================
-- TABLE: bookings
-- Stores booking information
-- ============================================

CREATE TABLE bookings (
    booking_id INT PRIMARY KEY,
    user_id INT,
    booking_date DATE NOT NULL,
    room_number INT NOT NULL,

    -- Foreign Key
    CONSTRAINT fk_user
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);



-- ============================================
-- TABLE: items
-- Stores chargeable services/items
-- ============================================

CREATE TABLE items (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL,
    rate DECIMAL(10,2) NOT NULL CHECK (rate > 0)
);



-- ============================================
-- TABLE: booking_commercials
-- Stores item usage per booking
-- ============================================

CREATE TABLE booking_commercials (
    booking_id INT,
    item_id INT,
    quantity INT NOT NULL CHECK (quantity > 0),

    -- Composite Primary Key
    PRIMARY KEY (booking_id, item_id),

    -- Foreign Keys
    CONSTRAINT fk_booking
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),

    CONSTRAINT fk_item
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

-- ============================================
-- INSERT SAMPLE DATA
-- ============================================

INSERT INTO users (user_id, name) VALUES
(1, 'Amit'),
(2, 'Sara'),
(3, 'Rahul');


INSERT INTO bookings (booking_id, user_id, booking_date, room_number) VALUES
(101, 1, '2021-11-10', 201),
(102, 2, '2021-11-15', 202),
(103, 1, '2021-12-01', 203),
(104, 3, '2021-11-20', 204);


INSERT INTO items (item_id, item_name, rate) VALUES
(1, 'Food', 200.00),
(2, 'Laundry', 100.00),
(3, 'Spa', 500.00);


INSERT INTO booking_commercials (booking_id, item_id, quantity) VALUES
(101, 1, 3),
(101, 2, 2),
(102, 1, 5),
(103, 2, 4),
(104, 3, 2);