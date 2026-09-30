# Healthcare Relational Data Modeling & Analytics

## Overview

A PostgreSQL project demonstrating relational database design,
SQL data transformation, analytical views, aggregation tables,
data-quality validation, and business intelligence queries using
a synthetic healthcare dataset.

## Objectives

- Design a normalized relational database schema
- Define primary and foreign-key relationships
- Enforce data integrity using constraints
- Transform data from multiple relational tables
- Build reusable SQL views for reporting
- Create aggregated analytical datasets
- Develop KPI queries for business intelligence
- Implement data-quality checks
- Analyze patient, department, diagnosis, and procedure activity

## Data Model

The database contains five core entities:

- Patients
- Medical History
- Medical Procedures
- Medical Departments
- Medical Locations

## Technical Skills

- PostgreSQL
- SQL
- Relational database design
- Data modeling
- SQL joins
- CTEs
- Aggregations
- SQL views
- Data validation
- KPI development
- Analytical datasets
- Indexing

## Key Outputs

### Reusable analytical views

- `vw_patient_profile`
- `vw_department_kpis`
- `vw_monthly_activity`

### Analytical aggregation table

- `patient_activity_summary`

## Key Analytical Questions

1. Which departments have the highest patient volumes?
2. Which medical conditions occur most frequently?
3. Which procedures are performed most frequently?
4. How does activity change over time?
5. Which departments have the highest procedures per patient?
6. How can transactional data be transformed into reusable analytical datasets?

## Data Disclaimer

All healthcare records in this project are synthetic and created
for educational and portfolio purposes. No real patient information
is used.
