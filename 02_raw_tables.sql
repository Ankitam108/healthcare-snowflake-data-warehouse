-- RAW TABLES

-- USE DATABASE AND SCHEMA
USE DATABASE HEALTHCARE_DW;
USE SCHEMA RAW_SCHEMA;

-- RAW PATIENTS TABLE

CREATE TABLE IF NOT EXISTS raw_patients (
    patient_id NUMBER,
    name VARCHAR(100),
    age NUMBER,
    gender VARCHAR(10),
    blood_group VARCHAR(5),
    city VARCHAR(100),
    disease VARCHAR(100),
    load_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);


-- RAW DOCTORS TABLE
CREATE TABLE IF NOT EXISTS raw_doctors (
    doctor_id NUMBER,
    name VARCHAR(100),
    specialization VARCHAR(100),
    department VARCHAR(100),
    experience_years NUMBER,
    load_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);

-- RAW GENE TESTS TABLE

CREATE TABLE IF NOT EXISTS raw_gene_tests (
    gene_test_id NUMBER,
    patient_id NUMBER,
    gene_name VARCHAR(100),
    variant_found VARCHAR(100),
    chromosome VARCHAR(10),
    result VARCHAR(200),
    test_date DATE,
    load_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);


-- VERIFY
SHOW TABLES;
