
DESCRIBE TABLE ANALYTICS_SCHEMA.dim_patients;

ALTER TABLE ANALYTICS_SCHEMA.dim_patients
ADD COLUMN disease_category VARCHAR;


INSERT INTO ANALYTICS_SCHEMA.dim_patients
(
    patient_id,
    name,
    age,
    gender,
    blood_group,
    city,
    disease,
    age_group,
    disease_category
)
SELECT
    patient_id,
    name_upper AS name,
    age,
    gender,
    blood_group,
    city_upper AS city,
    disease,

    CASE
        WHEN age < 30 THEN 'Young'
        WHEN age BETWEEN 30 AND 50 THEN 'Middle'
        ELSE 'Senior'
    END AS age_group,

    CASE
        WHEN disease IN ('COPD', 'asthma') THEN 'Respiratory'
        WHEN disease IN ('diabetes', 'hypertension') THEN 'Chronic'
        WHEN disease = 'cancer' THEN 'Oncology'
        ELSE 'Other'
    END AS disease_category

FROM STAGING_SCHEMA.stg_patients
WHERE is_valid = TRUE;



INSERT INTO ANALYTICS_SCHEMA.dim_doctors
(
    doctor_id,
    name,
    specialization,
    department,
    experience_years,
    experience_level
)
SELECT
    doctor_id,
    UPPER(name) AS name,
    specialization,
    department,
    experience_years,
    experience_level

FROM STAGING_SCHEMA.stg_doctors
WHERE is_valid = TRUE;


INSERT INTO ANALYTICS_SCHEMA.fact_gene_variants
(
    variant_id,
    patient_id,
    gene_name,
    variant_found,
    chromosome,
    result,
    test_date,
    is_variant_detected,
    chromosome_number
)
SELECT
    gene_test_id AS variant_id,
    patient_id,
    gene_name,
    variant_found,
    chromosome,
    result,
    test_date,
    is_variant_detected,

-- try to convert this value into a number
    TRY_TO_NUMBER(
        REPLACE(chromosome, 'Chr', '')
    ) AS chromosome_number

FROM STAGING_SCHEMA.stg_gene_tests
WHERE is_valid = TRUE;



SELECT * FROM ANALYTICS_SCHEMA.dim_patients;

SELECT * FROM ANALYTICS_SCHEMA.dim_doctors;

SELECT * FROM ANALYTICS_SCHEMA.fact_gene_variants;
