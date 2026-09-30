-- ============================================================
-- HEALTHCARE RELATIONAL DATA MODEL
-- ============================================================

-- ------------------------------------------------------------
-- Drop existing tables
-- ------------------------------------------------------------

DROP TABLE IF EXISTS MEDICAL_PROCEDURES CASCADE;
DROP TABLE IF EXISTS MEDICAL_HISTORY CASCADE;
DROP TABLE IF EXISTS PATIENTS CASCADE;
DROP TABLE IF EXISTS MEDICAL_DEPARTMENTS CASCADE;
DROP TABLE IF EXISTS MEDICAL_LOCATIONS CASCADE;


-- ------------------------------------------------------------
-- Medical Locations
-- ------------------------------------------------------------

CREATE TABLE MEDICAL_LOCATIONS (
    LOCATION_ID CHAR(9) PRIMARY KEY,
    LOCATION_NAME VARCHAR(50) NOT NULL
);


-- ------------------------------------------------------------
-- Medical Departments
-- ------------------------------------------------------------

CREATE TABLE MEDICAL_DEPARTMENTS (
    DEPT_ID CHAR(9) PRIMARY KEY,
    DEPT_NAME VARCHAR(50) NOT NULL,
    MANAGER_ID CHAR(9),
    LOCATION_ID CHAR(9) NOT NULL,

    CONSTRAINT fk_department_location
        FOREIGN KEY (LOCATION_ID)
        REFERENCES MEDICAL_LOCATIONS(LOCATION_ID)
);


-- ------------------------------------------------------------
-- Patients
-- ------------------------------------------------------------

CREATE TABLE PATIENTS (
    PATIENT_ID CHAR(9) PRIMARY KEY,
    FIRST_NAME VARCHAR(15) NOT NULL,
    LAST_NAME VARCHAR(15) NOT NULL,
    SSN CHAR(9) UNIQUE,
    BIRTH_DATE DATE,
    SEX CHAR(1),
    ADDRESS VARCHAR(100),
    DEPT_ID CHAR(9) NOT NULL,

    CONSTRAINT fk_patient_department
        FOREIGN KEY (DEPT_ID)
        REFERENCES MEDICAL_DEPARTMENTS(DEPT_ID),

    CONSTRAINT chk_patient_sex
        CHECK (SEX IN ('M', 'F', 'O'))
);


-- ------------------------------------------------------------
-- Medical History
-- ------------------------------------------------------------

CREATE TABLE MEDICAL_HISTORY (
    MEDICAL_HISTORY_ID CHAR(9) PRIMARY KEY,
    PATIENT_ID CHAR(9) NOT NULL,
    DIAGNOSIS_DATE DATE NOT NULL,
    DIAGNOSIS_CODE VARCHAR(10),
    MEDICAL_CONDITION VARCHAR(100) NOT NULL,
    DEPT_ID CHAR(9),

    CONSTRAINT fk_history_patient
        FOREIGN KEY (PATIENT_ID)
        REFERENCES PATIENTS(PATIENT_ID),

    CONSTRAINT fk_history_department
        FOREIGN KEY (DEPT_ID)
        REFERENCES MEDICAL_DEPARTMENTS(DEPT_ID)
);


-- ------------------------------------------------------------
-- Medical Procedures
-- ------------------------------------------------------------

CREATE TABLE MEDICAL_PROCEDURES (
    PROCEDURE_ID CHAR(9) PRIMARY KEY,
    PROCEDURE_NAME VARCHAR(100) NOT NULL,
    PROCEDURE_DATE DATE NOT NULL,
    PATIENT_ID CHAR(9) NOT NULL,
    DEPT_ID CHAR(9),

    CONSTRAINT fk_procedure_patient
        FOREIGN KEY (PATIENT_ID)
        REFERENCES PATIENTS(PATIENT_ID),

    CONSTRAINT fk_procedure_department
        FOREIGN KEY (DEPT_ID)
        REFERENCES MEDICAL_DEPARTMENTS(DEPT_ID)
);


-- ------------------------------------------------------------
-- Indexes
-- ------------------------------------------------------------

CREATE INDEX idx_patients_department
    ON PATIENTS(DEPT_ID);

CREATE INDEX idx_history_patient
    ON MEDICAL_HISTORY(PATIENT_ID);

CREATE INDEX idx_history_department
    ON MEDICAL_HISTORY(DEPT_ID);

CREATE INDEX idx_history_diagnosis_date
    ON MEDICAL_HISTORY(DIAGNOSIS_DATE);

CREATE INDEX idx_procedures_patient
    ON MEDICAL_PROCEDURES(PATIENT_ID);

CREATE INDEX idx_procedures_department
    ON MEDICAL_PROCEDURES(DEPT_ID);

CREATE INDEX idx_procedures_date
    ON MEDICAL_PROCEDURES(PROCEDURE_DATE);

-- ============================================================
-- SAMPLE DATA
-- ============================================================

-- ------------------------------------------------------------
-- Locations
-- ------------------------------------------------------------

INSERT INTO MEDICAL_LOCATIONS
    (LOCATION_ID, LOCATION_NAME)
VALUES
    ('LOC000001', 'Main Hospital'),
    ('LOC000002', 'Specialist Centre'),
    ('LOC000003', 'Outpatient Centre'),
    ('LOC000004', 'Diagnostic Centre');


-- ------------------------------------------------------------
-- Departments
-- ------------------------------------------------------------

INSERT INTO MEDICAL_DEPARTMENTS
    (DEPT_ID, DEPT_NAME, MANAGER_ID, LOCATION_ID)
VALUES
    ('DEP000001', 'Cardiology', 'DOC000001', 'LOC000001'),
    ('DEP000002', 'Neurology', 'DOC000002', 'LOC000001'),
    ('DEP000003', 'Orthopedics', 'DOC000003', 'LOC000002'),
    ('DEP000004', 'Pediatrics', 'DOC000004', 'LOC000003'),
    ('DEP000005', 'General Medicine', 'DOC000005', 'LOC000003'),
    ('DEP000006', 'Radiology', 'DOC000006', 'LOC000004');


-- ------------------------------------------------------------
-- Patients
-- ------------------------------------------------------------

INSERT INTO PATIENTS
    (PATIENT_ID, FIRST_NAME, LAST_NAME, SSN, BIRTH_DATE, SEX, ADDRESS, DEPT_ID)
VALUES
    ('PAT000001', 'James', 'Wilson', '111111111', '1978-03-15', 'M', '12 Oak Street', 'DEP000001'),
    ('PAT000002', 'Sarah', 'Johnson', '222222222', '1985-07-21', 'F', '45 Pine Road', 'DEP000005'),
    ('PAT000003', 'Michael', 'Brown', '333333333', '1969-11-04', 'M', '18 King Street', 'DEP000002'),
    ('PAT000004', 'Emily', 'Davis', '444444444', '2012-02-17', 'F', '22 Lake Avenue', 'DEP000004'),
    ('PAT000005', 'Daniel', 'Miller', '555555555', '1990-09-30', 'M', '31 Market Road', 'DEP000003'),
    ('PAT000006', 'Olivia', 'Taylor', '666666666', '1975-12-08', 'F', '9 Garden Street', 'DEP000001'),
    ('PAT000007', 'Robert', 'Anderson', '777777777', '1958-05-26', 'M', '67 Church Road', 'DEP000002'),
    ('PAT000008', 'Sophia', 'Thomas', '888888888', '2001-01-13', 'F', '14 Park Avenue', 'DEP000005'),
    ('PAT000009', 'William', 'Jackson', '999999999', '1982-06-19', 'M', '28 Hill Street', 'DEP000003'),
    ('PAT000010', 'Grace', 'White', '101010101', '2015-10-11', 'F', '52 River Road', 'DEP000004'),
    ('PAT000011', 'David', 'Harris', '121212121', '1971-08-23', 'M', '73 Forest Lane', 'DEP000001'),
    ('PAT000012', 'Emma', 'Martin', '131313131', '1995-04-02', 'F', '6 Victoria Street', 'DEP000005');


-- ------------------------------------------------------------
-- Medical History
-- ------------------------------------------------------------

INSERT INTO MEDICAL_HISTORY
    (MEDICAL_HISTORY_ID, PATIENT_ID, DIAGNOSIS_DATE, DIAGNOSIS_CODE, MEDICAL_CONDITION, DEPT_ID)
VALUES
    ('HIS000001', 'PAT000001', '2023-01-15', 'I10', 'Hypertension', 'DEP000001'),
    ('HIS000002', 'PAT000001', '2023-05-20', 'E78', 'Hyperlipidemia', 'DEP000001'),
    ('HIS000003', 'PAT000002', '2023-02-11', 'E11', 'Type 2 Diabetes', 'DEP000005'),
    ('HIS000004', 'PAT000003', '2023-03-07', 'G40', 'Epilepsy', 'DEP000002'),
    ('HIS000005', 'PAT000004', '2023-04-18', 'J45', 'Asthma', 'DEP000004'),
    ('HIS000006', 'PAT000005', '2023-06-23', 'M54', 'Back Pain', 'DEP000003'),
    ('HIS000007', 'PAT000006', '2023-07-09', 'I10', 'Hypertension', 'DEP000001'),
    ('HIS000008', 'PAT000007', '2023-08-14', 'G30', 'Alzheimer Disease', 'DEP000002'),
    ('HIS000009', 'PAT000008', '2023-09-05', 'E11', 'Type 2 Diabetes', 'DEP000005'),
    ('HIS000010', 'PAT000009', '2023-10-12', 'M17', 'Osteoarthritis', 'DEP000003'),
    ('HIS000011', 'PAT000010', '2023-11-03', 'J45', 'Asthma', 'DEP000004'),
    ('HIS000012', 'PAT000011', '2023-11-21', 'I25', 'Coronary Heart Disease', 'DEP000001'),
    ('HIS000013', 'PAT000012', '2023-12-02', 'E78', 'Hyperlipidemia', 'DEP000005'),
    ('HIS000014', 'PAT000003', '2024-01-19', 'I10', 'Hypertension', 'DEP000002'),
    ('HIS000015', 'PAT000006', '2024-02-07', 'I25', 'Coronary Heart Disease', 'DEP000001');


-- ------------------------------------------------------------
-- Medical Procedures
-- ------------------------------------------------------------

INSERT INTO MEDICAL_PROCEDURES
    (PROCEDURE_ID, PROCEDURE_NAME, PROCEDURE_DATE, PATIENT_ID, DEPT_ID)
VALUES
    ('PRO000001', 'Echocardiogram', '2023-01-22', 'PAT000001', 'DEP000001'),
    ('PRO000002', 'Blood Test', '2023-02-18', 'PAT000002', 'DEP000005'),
    ('PRO000003', 'Brain MRI', '2023-03-15', 'PAT000003', 'DEP000002'),
    ('PRO000004', 'Chest X-Ray', '2023-04-25', 'PAT000004', 'DEP000004'),
    ('PRO000005', 'Knee X-Ray', '2023-06-30', 'PAT000005', 'DEP000003'),
    ('PRO000006', 'ECG', '2023-07-15', 'PAT000006', 'DEP000001'),
    ('PRO000007', 'Brain MRI', '2023-08-21', 'PAT000007', 'DEP000002'),
    ('PRO000008', 'Blood Test', '2023-09-12', 'PAT000008', 'DEP000005'),
    ('PRO000009', 'Knee MRI', '2023-10-20', 'PAT000009', 'DEP000003'),
    ('PRO000010', 'Chest X-Ray', '2023-11-10', 'PAT000010', 'DEP000004'),
    ('PRO000011', 'Echocardiogram', '2023-12-01', 'PAT000011', 'DEP000001'),
    ('PRO000012', 'Blood Test', '2023-12-10', 'PAT000012', 'DEP000005'),
    ('PRO000013', 'Brain MRI', '2024-01-27', 'PAT000003', 'DEP000002'),
    ('PRO000014', 'ECG', '2024-02-15', 'PAT000006', 'DEP000001'),
    ('PRO000015', 'Echocardiogram', '2024-03-02', 'PAT000001', 'DEP000001');

-- ============================================================
-- DATA QUALITY CHECKS
-- ============================================================


-- Check for duplicate patient IDs
SELECT
    PATIENT_ID,
    COUNT(*) AS RECORD_COUNT
FROM PATIENTS
GROUP BY PATIENT_ID
HAVING COUNT(*) > 1;


-- Check for duplicate SSNs
SELECT
    SSN,
    COUNT(*) AS RECORD_COUNT
FROM PATIENTS
WHERE SSN IS NOT NULL
GROUP BY SSN
HAVING COUNT(*) > 1;


-- Check for patients with missing departments
SELECT
    PATIENT_ID,
    FIRST_NAME,
    LAST_NAME
FROM PATIENTS
WHERE DEPT_ID IS NULL;


-- Check for diagnoses without valid patients
SELECT
    h.MEDICAL_HISTORY_ID,
    h.PATIENT_ID
FROM MEDICAL_HISTORY h
LEFT JOIN PATIENTS p
    ON h.PATIENT_ID = p.PATIENT_ID
WHERE p.PATIENT_ID IS NULL;


-- Check for procedures without valid patients
SELECT
    mp.PROCEDURE_ID,
    mp.PATIENT_ID
FROM MEDICAL_PROCEDURES mp
LEFT JOIN PATIENTS p
    ON mp.PATIENT_ID = p.PATIENT_ID
WHERE p.PATIENT_ID IS NULL;


-- Check for procedures occurring before the patient's birth
SELECT
    mp.PROCEDURE_ID,
    mp.PATIENT_ID,
    mp.PROCEDURE_DATE,
    p.BIRTH_DATE
FROM MEDICAL_PROCEDURES mp
JOIN PATIENTS p
    ON mp.PATIENT_ID = p.PATIENT_ID
WHERE mp.PROCEDURE_DATE < p.BIRTH_DATE;


-- Check for diagnoses occurring before the patient's birth
SELECT
    h.MEDICAL_HISTORY_ID,
    h.PATIENT_ID,
    h.DIAGNOSIS_DATE,
    p.BIRTH_DATE
FROM MEDICAL_HISTORY h
JOIN PATIENTS p
    ON h.PATIENT_ID = p.PATIENT_ID
WHERE h.DIAGNOSIS_DATE < p.BIRTH_DATE;

-- Patient master analytical view --
CREATE OR REPLACE VIEW vw_patient_profile AS
SELECT
    p.PATIENT_ID,
    p.FIRST_NAME,
    p.LAST_NAME,
    p.SEX,
    p.BIRTH_DATE,
    d.DEPT_NAME,
    l.LOCATION_NAME,
    COUNT(DISTINCT h.MEDICAL_HISTORY_ID) AS DIAGNOSIS_COUNT,
    COUNT(DISTINCT mp.PROCEDURE_ID) AS PROCEDURE_COUNT
FROM PATIENTS p
LEFT JOIN MEDICAL_DEPARTMENTS d
    ON p.DEPT_ID = d.DEPT_ID
LEFT JOIN MEDICAL_LOCATIONS l
    ON d.LOCATION_ID = l.LOCATION_ID
LEFT JOIN MEDICAL_HISTORY h
    ON p.PATIENT_ID = h.PATIENT_ID
LEFT JOIN MEDICAL_PROCEDURES mp
    ON p.PATIENT_ID = mp.PATIENT_ID
GROUP BY
    p.PATIENT_ID,
    p.FIRST_NAME,
    p.LAST_NAME,
    p.SEX,
    p.BIRTH_DATE,
    d.DEPT_NAME,
    l.LOCATION_NAME;

SELECT *
FROM vw_patient_profile;

-- Department KPI view --
CREATE OR REPLACE VIEW vw_department_kpis AS
SELECT
    d.DEPT_ID,
    d.DEPT_NAME,
    l.LOCATION_NAME,
    COUNT(DISTINCT p.PATIENT_ID) AS PATIENT_COUNT,
    COUNT(DISTINCT h.MEDICAL_HISTORY_ID) AS DIAGNOSIS_COUNT,
    COUNT(DISTINCT mp.PROCEDURE_ID) AS PROCEDURE_COUNT
FROM MEDICAL_DEPARTMENTS d
LEFT JOIN MEDICAL_LOCATIONS l
    ON d.LOCATION_ID = l.LOCATION_ID
LEFT JOIN PATIENTS p
    ON d.DEPT_ID = p.DEPT_ID
LEFT JOIN MEDICAL_HISTORY h
    ON d.DEPT_ID = h.DEPT_ID
LEFT JOIN MEDICAL_PROCEDURES mp
    ON d.DEPT_ID = mp.DEPT_ID
GROUP BY
    d.DEPT_ID,
    d.DEPT_NAME,
    l.LOCATION_NAME;

SELECT *
FROM vw_department_kpis
ORDER BY PATIENT_COUNT DESC;

-- Monthly activity view --
CREATE OR REPLACE VIEW vw_monthly_activity AS

WITH diagnosis_activity AS (
    SELECT
        DATE_TRUNC('month', DIAGNOSIS_DATE) AS MONTH,
        COUNT(*) AS DIAGNOSIS_COUNT
    FROM MEDICAL_HISTORY
    GROUP BY DATE_TRUNC('month', DIAGNOSIS_DATE)
),

procedure_activity AS (
    SELECT
        DATE_TRUNC('month', PROCEDURE_DATE) AS MONTH,
        COUNT(*) AS PROCEDURE_COUNT
    FROM MEDICAL_PROCEDURES
    GROUP BY DATE_TRUNC('month', PROCEDURE_DATE)
)

SELECT
    COALESCE(d.MONTH, p.MONTH) AS MONTH,
    COALESCE(d.DIAGNOSIS_COUNT, 0) AS DIAGNOSIS_COUNT,
    COALESCE(p.PROCEDURE_COUNT, 0) AS PROCEDURE_COUNT
FROM diagnosis_activity d
FULL OUTER JOIN procedure_activity p
    ON d.MONTH = p.MONTH
ORDER BY MONTH;

-- ============================================================
-- ANALYTICAL AGGREGATION TABLE
-- ============================================================

DROP TABLE IF EXISTS patient_activity_summary;

CREATE TABLE patient_activity_summary AS

SELECT
    p.PATIENT_ID,
    p.SEX,
    p.BIRTH_DATE,
    p.DEPT_ID,
    COUNT(DISTINCT h.MEDICAL_HISTORY_ID) AS DIAGNOSIS_COUNT,
    COUNT(DISTINCT mp.PROCEDURE_ID) AS PROCEDURE_COUNT,
    MIN(h.DIAGNOSIS_DATE) AS FIRST_DIAGNOSIS_DATE,
    MAX(h.DIAGNOSIS_DATE) AS MOST_RECENT_DIAGNOSIS_DATE,
    MIN(mp.PROCEDURE_DATE) AS FIRST_PROCEDURE_DATE,
    MAX(mp.PROCEDURE_DATE) AS MOST_RECENT_PROCEDURE_DATE
FROM PATIENTS p
LEFT JOIN MEDICAL_HISTORY h
    ON p.PATIENT_ID = h.PATIENT_ID
LEFT JOIN MEDICAL_PROCEDURES mp
    ON p.PATIENT_ID = mp.PATIENT_ID
GROUP BY
    p.PATIENT_ID,
    p.SEX,
    p.BIRTH_DATE,
    p.DEPT_ID;

-- Department performance 
SELECT
    DEPT_NAME,
    PATIENT_COUNT,
    DIAGNOSIS_COUNT,
    PROCEDURE_COUNT
FROM vw_department_kpis
ORDER BY PATIENT_COUNT DESC;

-- Most common conditions 
SELECT
    MEDICAL_CONDITION,
    COUNT(*) AS DIAGNOSIS_COUNT
FROM MEDICAL_HISTORY
GROUP BY MEDICAL_CONDITION
ORDER BY DIAGNOSIS_COUNT DESC;

-- Most frequently performed procedures 
SELECT
    PROCEDURE_NAME,
    COUNT(*) AS PROCEDURE_COUNT
FROM MEDICAL_PROCEDURES
GROUP BY PROCEDURE_NAME
ORDER BY PROCEDURE_COUNT DESC;

-- Patient activity 
SELECT
    PATIENT_ID,
    DIAGNOSIS_COUNT,
    PROCEDURE_COUNT,
    FIRST_DIAGNOSIS_DATE,
    MOST_RECENT_DIAGNOSIS_DATE
FROM patient_activity_summary
ORDER BY PROCEDURE_COUNT DESC;


-- Department procedure-to-patient ratio 
SELECT
    d.DEPT_NAME,
    COUNT(DISTINCT mp.PROCEDURE_ID) AS PROCEDURE_COUNT,
    COUNT(DISTINCT p.PATIENT_ID) AS PATIENT_COUNT,
    ROUND(
        COUNT(DISTINCT mp.PROCEDURE_ID)::NUMERIC
        / NULLIF(COUNT(DISTINCT p.PATIENT_ID), 0),
        2
    ) AS PROCEDURES_PER_PATIENT
FROM MEDICAL_DEPARTMENTS d
LEFT JOIN PATIENTS p
    ON d.DEPT_ID = p.DEPT_ID
LEFT JOIN MEDICAL_PROCEDURES mp
    ON d.DEPT_ID = mp.DEPT_ID
GROUP BY d.DEPT_ID, d.DEPT_NAME
ORDER BY PROCEDURES_PER_PATIENT DESC;