-- =========================
-- 1. สร้างฐานข้อมูล
-- =========================
CREATE DATABASE IF NOT EXISTS hospital_db;
USE hospital_db;

-- =========================
-- 2. สร้างตาราง
-- =========================

CREATE TABLE IF NOT EXISTS Patient_Data (
    HN INT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    DOB DATE,
    District VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Visit_Log (
    VN INT PRIMARY KEY,
    HN INT,
    VisitDate DATE,
    Clinic_Name VARCHAR(100),
    FOREIGN KEY (HN) REFERENCES Patient_Data(HN)
);

CREATE TABLE IF NOT EXISTS Diagnosis_Record (
    VN INT,
    ICD10_Code VARCHAR(10),
    Attending_Doctor VARCHAR(100),
    Med_Student VARCHAR(100),
    PRIMARY KEY (VN, ICD10_Code),
    FOREIGN KEY (VN) REFERENCES Visit_Log(VN)
);

-- =========================
-- 3. เพิ่มข้อมูลตัวอย่าง
-- =========================

INSERT INTO Patient_Data (HN, FirstName, LastName, DOB, District) VALUES
(1001, 'Somchai', 'Jaidee', '1980-05-10', 'เมือง'),
(1002, 'Suda', 'Kumdee', '1975-08-20', 'กมลาไสย'),
(1003, 'Anan', 'Rakdee', '1990-02-15', 'ยางตลาด'),
(1004, 'Malee', 'Sukjai', '1968-11-30', 'เมือง');

INSERT INTO Visit_Log (VN, HN, VisitDate, Clinic_Name) VALUES
(2001, 1001, '2026-01-10', 'คลินิกอายุรกรรม'),
(2002, 1002, '2026-02-05', 'คลินิกอายุรกรรม'),
(2003, 1003, '2026-03-15', 'คลินิกศัลยกรรม'),
(2004, 1004, '2026-01-25', 'คลินิกอายุรกรรม'),
(2005, 1001, '2026-03-01', 'คลินิกอายุรกรรม');

INSERT INTO Diagnosis_Record (VN, ICD10_Code, Attending_Doctor, Med_Student) VALUES
(2001, 'E119', 'Dr. Anucha', 'Student A'),
(2002, 'E110', 'Dr. Benja', 'Student B'),
(2003, 'K350', 'Dr. Chai', 'Student C'),
(2004, 'E119', 'Dr. Anucha', 'Student D'),
(2005, 'I10', 'Dr. Benja', 'Student A');

-- =========================
-- 4. Query สำหรับข้อสอบ
-- =========================

SELECT 
    p.FirstName,
    p.LastName,
    v.VisitDate,
    d.ICD10_Code,
    d.Attending_Doctor
FROM Patient_Data p
INNER JOIN Visit_Log v ON p.HN = v.HN
INNER JOIN Diagnosis_Record d ON v.VN = d.VN
WHERE 
    d.ICD10_Code LIKE 'E11%'
    AND v.Clinic_Name = 'คลินิกอายุรกรรม'
    AND v.VisitDate BETWEEN '2026-01-01' AND '2026-03-31'
ORDER BY v.VisitDate DESC;
