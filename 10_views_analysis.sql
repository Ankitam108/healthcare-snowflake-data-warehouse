USE SCHEMA ANALYTICS_SCHEMA;


-- 1. PATIENT ANALYSIS VIEW
CREATE OR REPLACE VIEW patient_analysis AS
SELECT
    patient_id,
    name,
    age,
    age_group,
    gender,
    city,
    disease,
    disease_category
FROM dim_patients;


-- 2. GENE VARIANT ANALYSIS VIEW
CREATE OR REPLACE VIEW gene_variant_analysis AS
SELECT
    variant_id,
    patient_id,
    gene_name,
    variant_found,
    chromosome_number,
    result,
    test_date,
    is_variant_detected
FROM fact_gene_variants;


-- 3. DOCTOR ANALYSIS VIEW
CREATE OR REPLACE VIEW doctor_analysis AS
SELECT
    doctor_id,
    name,
    specialization,
    department,
    experience_years,
    experience_level
FROM dim_doctors;


-- 4. PATIENT COUNT BY DISEASE
SELECT
    disease,
    COUNT(*) AS patient_count
FROM dim_patients
GROUP BY disease
ORDER BY patient_count DESC;


-- 5. VARIANT COUNT BY GENE
SELECT
    gene_name,
    COUNT(*) AS total_tests,
    SUM(
        CASE
            WHEN is_variant_detected = TRUE THEN 1
            ELSE 0
            END
       ) AS variants_detected
FROM fact_gene_variants
GROUP BY gene_name
ORDER BY variants_detected DESC;


-- 6. PATIENTS WITH DETECTED VARIANTS
SELECT
    p.patient_id,
    p.name,
    p.disease,
    g.gene_name,
    g.variant_found,
    g.chromosome_number
FROM dim_patients p
JOIN fact_gene_variants g
    ON p.patient_id = g.patient_id
WHERE g.is_variant_detected = TRUE;


-- 7. DOCTOR EXPERIENCE ANALYSIS
SELECT
    experience_level,
    COUNT(*) AS doctor_count,
    ROUND(AVG(experience_years), 2) AS average_experience
  
FROM dim_doctors
GROUP BY experience_level
ORDER BY average_experience DESC;


-- 8. WINDOW FUNCTION ANALYSIS
SELECT
    gene_name,
    test_date,
    is_variant_detected,
    COUNT(*) OVER (
        PARTITION BY gene_name
    ) AS total_tests_for_gene
FROM fact_gene_variants
ORDER BY gene_name, test_date;
