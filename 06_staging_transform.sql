
INSERT INTO STAGING_SCHEMA.stg_patients
(
    patient_id,
    name,
    age,
    gender,
    blood_group,
    city,
    disease,
    name_upper,
    city_upper,
    is_valid
)
SELECT
    patient_id,
    name,
    age,
    gender,
    blood_group,
    city,
    disease,
    
    UPPER(name) AS name_upper,
    UPPER(city) AS city_upper,

    CASE
        WHEN patient_id IS NOT NULL
         AND name IS NOT NULL
         AND age IS NOT NULL
         AND age > 0
         AND gender IS NOT NULL
        THEN TRUE
        ELSE FALSE
    END AS is_valid

FROM RAW_SCHEMA.raw_patients;



INSERT INTO STAGING_SCHEMA.stg_doctors
(
    doctor_id,
    name,
    specialization,
    department,
    experience_years,
    experience_level,
    is_valid
)
SELECT
    doctor_id,
    name,
    specialization,
    department,
    experience_years,

    CASE
        WHEN experience_years >= 10 THEN 'Senior'
        WHEN experience_years >= 5 THEN 'Mid-Level'
        ELSE 'Junior'
    END AS experience_level,

    CASE
        WHEN doctor_id IS NOT NULL
         AND name IS NOT NULL
         AND experience_years >= 0
        THEN TRUE
        ELSE FALSE
    END AS is_valid

FROM RAW_SCHEMA.raw_doctors;



INSERT INTO STAGING_SCHEMA.stg_gene_tests
(
    gene_test_id,
    patient_id,
    gene_name,
    variant_found,
    chromosome,
    result,
    test_date,
    is_variant_detected,
    is_valid
)
SELECT
    gene_test_id,
    patient_id,
    gene_name,
    variant_found,
    chromosome,
    result,
    test_date,

    CASE
        WHEN result = 'Variant detected' THEN TRUE
        ELSE FALSE
    END AS is_variant_detected,

    CASE
        WHEN gene_test_id IS NOT NULL
         AND patient_id IS NOT NULL
         AND gene_name IS NOT NULL
         AND test_date IS NOT NULL
        THEN TRUE
        ELSE FALSE
    END AS is_valid

FROM RAW_SCHEMA.raw_gene_tests;

SELECT * FROM STAGING_SCHEMA.stg_patients;

SELECT * FROM STAGING_SCHEMA.stg_doctors;

SELECT * FROM STAGING_SCHEMA.stg_gene_tests;
