-- STREAM AND TASKS FROM RAW TABLE TO STAGING TABLE
-- CREATE STREAM
CREATE STREAM IF NOT EXISTS RAW_SCHEMA.gene_tests_stream
ON TABLE RAW_SCHEMA.raw_gene_tests;


SELECT *
FROM RAW_SCHEMA.gene_tests_stream;


--CREATE TASK
CREATE TASK IF NOT EXISTS STAGING_SCHEMA.load_gene_tests_task
    WAREHOUSE = COMPUTE_WH
    SCHEDULE = 'USING CRON 0 * * * * UTC'
AS
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

FROM RAW_SCHEMA.gene_tests_stream
WHERE METADATA$ACTION = 'INSERT';

--  TO RESUME THE TASK (scheduled Task ON)
ALTER TASK STAGING_SCHEMA.load_gene_tests_task RESUME;

-- SUSPEND THE TASK (scheduled Task OFF)
ALTER TASK STAGING_SCHEMA.load_gene_tests_task SUSPEND;

-- TO LOOK METADATA
SHOW TASKS;
