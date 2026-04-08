-- ============================================
-- CLINIC MANAGEMENT SYSTEM - SCHEMA SETUP
-- ============================================


-- ============================================
-- TABLE: patients
-- Stores patient information
-- ============================================

CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(15)
);



-- ============================================
-- TABLE: clinic_sales
-- Stores revenue transactions
-- ============================================

CREATE TABLE clinic_sales (
    sale_id INT PRIMARY KEY,
    patient_id INT,
    sale_date DATE NOT NULL,
    sales_channel VARCHAR(50) NOT NULL,
    amount DECIMAL(10,2) NOT NULL CHECK (amount > 0),

    -- Foreign Key
    CONSTRAINT fk_patient
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);



-- ============================================
-- TABLE: expenses
-- Stores clinic expenses
-- ============================================

CREATE TABLE expenses (
    expense_id INT PRIMARY KEY,
    expense_date DATE NOT NULL,
    category VARCHAR(50),
    amount DECIMAL(10,2) NOT NULL CHECK (amount > 0)
);

-- ============================================
-- INSERT SAMPLE DATA
-- ============================================

INSERT INTO patients (patient_id, patient_name, contact_number) VALUES
(1, 'Ravi Kumar', '9876543210'),
(2, 'Anjali Mehta', '9123456780'),
(3, 'Karan Shah', '9988776655');


INSERT INTO clinic_sales (sale_id, patient_id, sale_date, sales_channel, amount) VALUES
(101, 1, '2021-11-05', 'Online', 1500.00),
(102, 2, '2021-11-10', 'Walk-in', 2000.00),
(103, 3, '2021-12-01', 'Online', 1800.00),
(104, 1, '2021-12-15', 'Referral', 2200.00);


INSERT INTO expenses (expense_id, expense_date, category, amount) VALUES
(201, '2021-11-01', 'Rent', 3000.00),
(202, '2021-11-15', 'Salary', 4000.00),
(203, '2021-12-01', 'Supplies', 1500.00),
(204, '2021-12-10', 'Maintenance', 1200.00);