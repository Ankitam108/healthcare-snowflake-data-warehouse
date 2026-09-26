-- STAGING TABLES

-- US DATABASE AND SCHEMA
USE DATABASE HEALTHCARE_DW;
USE SCHEMA STAGING_SCHEMA;


-- STAGING PATIENTS TABLE
CREATE TABLE IF NOT EXISTS stg_patients (
    patient_id NUMBER,
    name VARCHAR(100),
    age NUMBER,
    gender VARCHAR(10),
    blood_group VARCHAR(5),
    city VARCHAR(100),
    disease VARCHAR(100),
  
    -- Derived columns
    name_upper VARCHAR(100),
    city_upper VARCHAR(100),
    is_valid BOOLEAN,

    staged_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);


-- STAGING DOCTORS TABLE
CREATE TABLE IF NOT EXISTS stg_doctors (
    doctor_id NUMBER,
    name VARCHAR(100),
    specialization VARCHAR(100),
    department VARCHAR(100),
    experience_years NUMBER,

    -- Derived / validation columns
    experience_level VARCHAR(20),
    is_valid BOOLEAN,

    staged_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);

-- STAGING GENE TESTS TABLE
CREATE TABLE IF NOT EXISTS stg_gene_tests (
    gene_test_id NUMBER,
    patient_id NUMBER,
    gene_name VARCHAR(100),
    variant_found VARCHAR(100),
    chromosome VARCHAR(10),
    result VARCHAR(200),
    test_date DATE,

    -- Derived / validation columns
    is_variant_detected BOOLEAN,
    is_valid BOOLEAN,

    staged_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);


-- VERIFY
SHOW TABLES;
