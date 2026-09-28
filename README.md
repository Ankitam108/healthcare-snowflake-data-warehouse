# Healthcare Snowflake Data Warehouse

An end-to-end healthcare data warehouse project built using Snowflake and SQL. The project demonstrates how raw healthcare and genetic testing data can be loaded, transformed, validated, and organized into analytics-ready tables for reporting and analysis.

## Project Overview

This project follows a layered data warehouse architecture:

RAW
  ↓
STAGING
  ↓
ANALYTICS
  ↓
VIEWS & ANALYSIS

The project uses healthcare-related sample data including:

- Patient information
- Doctor information
- Genetic test information
- Gene variants
- Test results

The purpose of the project is to demonstrate practical Snowflake concepts such as data loading, SQL transformations, Streams, Tasks, Time Travel, Zero-Copy Cloning, RBAC, Views, and analytical queries.

---

##  Architecture

HEALTHCARE_DW
│
├── RAW_SCHEMA
│   ├── raw_patients
│   ├── raw_doctors
│   └── raw_gene_tests
│
├── STAGING_SCHEMA
│   ├── stg_patients
│   ├── stg_doctors
│   └── stg_gene_tests
│
└── ANALYTICS_SCHEMA
    ├── dim_patients
    ├── dim_doctors
    └── fact_gene_variants

## Data Flow

Source Data
     ↓
RAW_SCHEMA
Exact source data
     ↓
STAGING_SCHEMA
Cleaning + Validation + Derived Columns
     ↓
ANALYTICS_SCHEMA
Business-ready analytical data
     ↓
Views + SQL Analysis

---

## Technologies Used

- Snowflake
- SQL
- GitHub

---

Database Design

**RAW Layer**

The RAW layer stores the source data with minimal transformation.

"raw_patients"

Contains:

- Patient ID
- Name
- Age
- Gender
- Blood group
- City
- Disease
- Load timestamp

"raw_doctors"

Contains:

- Doctor ID
- Name
- Specialization
- Department
- Experience
- Load timestamp

"raw_gene_tests"

Contains:

- Gene test ID
- Patient ID
- Gene name
- Variant found
- Chromosome
- Result
- Test date
- Load timestamp

---

**STAGING Layer**

The STAGING layer is used for cleaning, validation, and preparing the data for analytics.

Patient Transformations

- Convert patient names to uppercase
- Convert cities to uppercase
- Validate required fields
- Create an "is_valid" flag

Example:

UPPER(name) AS name_upper

UPPER(city) AS city_upper

Doctor Transformations

Doctor experience is categorized into levels:

10+ years       → Senior
5–9 years       → Mid-Level
Below 5 years   → Junior

Gene Test Transformations

The gene test result is converted into a Boolean flag:

Variant detected → TRUE
Other result     → FALSE

An "is_valid" flag is also created to identify valid records.

---

**ANALYTICS Layer**

The ANALYTICS layer contains business-ready data designed for analysis.

"dim_patients"

Contains patient information along with derived attributes such as:

- Age group
- Disease category

Age groups:

Below 30       → Young
30–50          → Middle
Above 50       → Senior

Disease categories:

COPD / Asthma          → Respiratory
Diabetes / Hypertension → Chronic
Cancer                  → Oncology
Other                   → Other

"dim_doctors"

Contains:

- Doctor information
- Specialization
- Department
- Experience
- Experience level

"fact_gene_variants"

Contains genetic testing information including:

- Patient
- Gene
- Variant
- Chromosome
- Test result
- Test date
- Variant detection flag
- Numeric chromosome number

For example:

Chr19 → 19
Chr17 → 17
Chr7  → 7

This is achieved using:

TRY_TO_NUMBER(REPLACE(chromosome, 'Chr', ''))

"TRY_TO_NUMBER" returns "NULL" instead of an error if the value cannot be converted to a number.

---

## Project Files ##

healthcare-snowflake-data-warehouse/
│
├── 01_database_setup.sql
├── 02_raw_tables.sql
├── 03_staging_tables.sql
├── 04_analytics_tables.sql
├── 05_data_loading.sql
├── 06_staging_transform.sql
├── 07_analytics_transform.sql
├── 08_streams_tasks.sql
├── 09_snowflake_features.sql
├── 10_views_analysis.sql
└── README.md

File Description

File| Purpose
"01_database_setup.sql"| Creates database and schemas
"02_raw_tables.sql"| Creates RAW tables
"03_staging_tables.sql"| Creates STAGING tables
"04_analytics_tables.sql"| Creates ANALYTICS tables
"05_data_loading.sql"| Loads sample healthcare data
"06_staging_transform.sql"| Cleans and validates RAW data
"07_analytics_transform.sql"| Creates business-ready analytical data
"08_streams_tasks.sql"| Demonstrates Streams and Tasks
"09_snowflake_features.sql"| Demonstrates Snowflake features
"10_views_analysis.sql"| Creates views and analytical queries
"README.md"| Project documentation

---

Example Analytical Queries

Patients by Disease

SELECT
    disease,
    COUNT(*) AS patient_count
FROM ANALYTICS_SCHEMA.dim_patients
GROUP BY disease
ORDER BY patient_count DESC;

Gene Variant Analysis

SELECT
    gene_name,
    COUNT(*) AS total_tests,
    SUM(
        CASE
            WHEN is_variant_detected = TRUE THEN 1
            ELSE 0
        END
    ) AS variants_detected
FROM ANALYTICS_SCHEMA.fact_gene_variants
GROUP BY gene_name
ORDER BY variants_detected DESC;

Patients with Detected Variants

SELECT
    p.patient_id,
    p.name,
    p.disease,
    g.gene_name,
    g.variant_found,
    g.chromosome_number
FROM ANALYTICS_SCHEMA.dim_patients p
JOIN ANALYTICS_SCHEMA.fact_gene_variants g
    ON p.patient_id = g.patient_id
WHERE g.is_variant_detected = TRUE;


---

Key Learning Outcomes

Through this project, I practiced:

- Designing a layered Snowflake data warehouse
- Creating databases and schemas
- Creating RAW, STAGING, and ANALYTICS tables
- Loading and transforming data using SQL
- Data validation and derived columns
- Working with dates and timestamps
- Using "CASE", "UPPER", "REPLACE", and "TRY_TO_NUMBER"
- Understanding Snowflake virtual warehouses
- Understanding stages and data loading
- Using "COPY INTO"
- Understanding Snowpipe
- Creating and using Streams
- Creating scheduled Tasks
- Understanding Time Travel
- Understanding Zero-Copy Cloning
- Implementing basic RBAC
- Creating Views
- Using joins, aggregations, and window functions
- Performing analytical queries in Snowflake
- Managing a SQL project using Git and GitHub

---

Important Note

This project uses sample healthcare and genetic testing data for learning and demonstration purposes. It does not contain real patient records or real clinical conclusions.

The genetic testing portion demonstrates data engineering and analytical workflows, not medical or diagnostic interpretation.

---
---
