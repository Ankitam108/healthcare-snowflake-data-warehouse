USE DATABASE HEALTHCARE_DW;
USE SCHEMA RAW_SCHEMA;

-- PATIENTS TABLE
INSERT INTO raw_patients
(patient_id, name, age, gender, blood_group, city, disease)
VALUES
(1, 'ankita sharma', 25, 'female', 'B+', 'chandigarh', 'COPD'),
(2, 'rahul verma', 35, 'male', 'O+', 'delhi', 'diabetes'),
(3, 'priya singh', 28, 'female', 'A+', 'mohali', 'hypertension'),
(4, 'amit kumar', 45, 'male', 'AB+', 'gurugram', 'cancer'),
(5, 'sunita devi', 32, 'female', 'O-', 'shimla', 'COPD'),
(6, 'neha kapoor', 29, 'female', 'B+', 'amritsar', 'asthma'),
(7, 'rohit sharma', 41, 'male', 'A+', 'chandigarh', 'diabetes'),
(8, 'meena thakur', 36, 'female', 'O+', 'shimla', 'hypertension'),
(9, 'karan singh', 36, 'male', 'AB+', 'mohali', 'COPD'),
(10, 'pooja mehta', 27, 'female', 'O-', 'delhi', 'cancer'),
(11, 'vikas kumar', 48, 'male', 'B-', 'gurugram', 'asthma'),
(12, 'simran kaur', 33, 'female', 'A-', 'amritsar', 'diabetes'),
(13, 'manish verma', 39, 'male', 'O+', 'chandigarh', 'COPD'),
(14, 'richa sharma', 31, 'female', 'AB-', 'mohali', 'hypertension'),
(15, 'deepak rana', 55, 'male', 'B+', 'shimla', 'cancer');

-- DOCTORS TABLE
INSERT INTO raw_doctors
(doctor_id, name, specialization, department, experience_years)
VALUES
(1, 'dr. rajesh kumar', 'genetics', 'molecular biology', 15),
(2, 'dr. sunita sharma', 'cardiology', 'heart care', 10),
(3, 'dr. amit gupta', 'endocrinology', 'diabetes care', 8),
(4, 'dr. priya nair', 'oncology', 'cancer care', 12),
(5, 'dr. vikram singh', 'pulmonology', 'lung care', 7),
(6, 'dr. anita mehta', 'neurology', 'brain care', 9),
(7, 'dr. suresh patel', 'general', 'general medicine', 5);


-- GENE TEST DATA
INSERT INTO raw_gene_tests
(gene_test_id, patient_id, gene_name, variant_found, chromosome, result, test_date)
VALUES
(1, 1, 'Galectin-3', 'rs4644', 'Chr19', 'Variant detected', '2026-01-20'),
(2, 2, 'BRCA1', 'rs1799950', 'Chr17', 'No variant found', '2026-02-25'),
(3, 4, 'TP53', 'Mutation', 'Chr17', 'Variant detected', '2026-03-15'),
(4, 5, 'CFTR', 'rs75961395', 'Chr7', 'No variant found', '2026-03-25'),
(5, 7, 'EGFR', 'Deletion', 'Chr7', 'Variant detected', '2026-04-01'),
(6, 9, 'Galectin-3', 'rs4644', 'Chr19', 'Variant detected', '2026-04-05'),
(7, 10, 'BRCA2', 'rs80359550', 'Chr13', 'Variant detected', '2026-04-10'),
(8, 12, 'HBA1', 'rs33950507', 'Chr16', 'No variant found', '2026-04-15'),
(9, 13, 'Galectin-3', 'rs4644', 'Chr19', 'Variant detected', '2026-04-20'),
(10, 15, 'TP53', 'Mutation', 'Chr17', 'Variant detected', '2026-04-25');



SELECT * FROM raw_patients;
SELECT * FROM raw_doctors;
SELECT * FROM raw_gene_tests;
