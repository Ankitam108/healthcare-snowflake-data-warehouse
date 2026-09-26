-- ANALYTICS TABLES

-- USE DATABASE AND SCHEMA
USE DATABASE HEALTHCARE_DW;
USE SCHEMA ANALYTICS_SCHEMA;

-- ANALYTICS PATIENTS TABLE
CREATE TABLE IF NOT EXISTS dim_patients (
    patient_id NUMBER PRIMARY KEY,
    name VARCHAR(100),
    age NUMBER,
    gender VARCHAR(10),
    blood_group VARCHAR(5),
    city VARCHAR(100),
    disease VARCHAR(100),

    -- Analytics columns
    age_group VARCHAR(20),
    disease_category VARCHAR(50),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);

-- ANALYTICS DOCTORS TABLE
CREATE TABLE IF NOT EXISTS dim_doctors (
    doctor_id NUMBER PRIMARY KEY,
    name VARCHAR(100),
    specialization VARCHAR(100),
    department VARCHAR(100),
    experience_years NUMBER,

    -- Analytics column
    experience_level VARCHAR(20),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);

-- ANALYTICS GENE VARIANTS TABLE
CREATE TABLE IF NOT EXISTS fact_gene_variants (
    variant_id NUMBER PRIMARY KEY,
    patient_id NUMBER,
    gene_name VARCHAR(100),
    variant_found VARCHAR(100),
    chromosome VARCHAR(10),
    result VARCHAR(200),
    test_date DATE,

    -- Analytics columns
    is_variant_detected BOOLEAN,
    chromosome_number NUMBER,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);


-- VERIFY
SHOW TABLES;
