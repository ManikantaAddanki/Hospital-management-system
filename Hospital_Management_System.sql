
-- =====================================================
-- HOSPITAL MANAGEMENT SYSTEM
-- Database: HospitalDB
-- Technology: MySQL
-- =====================================================


-- TASK 1: DATABASE CREATION

CREATE DATABASE IF NOT EXISTS HospitalDB;

USE HospitalDB;


-- TASK 2: CREATE TABLES

-- 1. Patients Table

CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    age INT,
    gender VARCHAR(10),
    phone VARCHAR(15),
    address VARCHAR(255),
    registration_date DATE
);

-- 2. Doctors Table

CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    specialization VARCHAR(100),
    phone VARCHAR(15),
    joining_date DATE
);

-- 3. Appointments Table

CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- 4. Rooms Table

CREATE TABLE Rooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_type VARCHAR(50),
    availability_status VARCHAR(20)
);

-- 5. Admissions Table

CREATE TABLE Admissions (
    admission_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    room_id INT,
    admission_date DATE,
    discharge_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);

-- 6. Bills Table

CREATE TABLE Bills (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    total_amount DECIMAL(10,2),
    payment_status VARCHAR(20),
    bill_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);


-- TASK 3: INSERT SAMPLE DATA

-- Patients

INSERT INTO Patients
(name, age, gender, phone, address, registration_date)
VALUES
('Manikanta',23,'Male','9876543210','Hyderabad','2026-01-10'),
('Rahul',55,'Male','9876543211','Vijayawada','2026-01-12'),
('Priya',30,'Female','9876543212','Guntur','2026-02-05'),
('Suresh',65,'Male','9876543213','Hyderabad','2026-02-10'),
('Anjali',45,'Female','9876543214','Chennai','2026-03-01'),
('Kiran',60,'Male','9876543215','Bengaluru','2026-03-05'),
('Sneha',25,'Female','9876543216','Hyderabad','2026-03-10'),
('Arjun',52,'Male','9876543217','Warangal','2026-03-15'),
('Divya',35,'Female','9876543218','Guntur','2026-04-01'),
('Vamsi',40,'Male','9876543219','Hyderabad','2026-04-05');

-- Doctors

INSERT INTO Doctors
(name, specialization, phone, joining_date)
VALUES
('Dr. Ravi','Cardiology','9000000001','2020-01-10'),
('Dr. Priya','Neurology','9000000002','2021-03-15'),
('Dr. Kumar','Orthopedics','9000000003','2019-06-20'),
('Dr. Sneha','Cardiology','9000000004','2022-07-12'),
('Dr. Arjun','Dermatology','9000000005','2023-02-18'),
('Dr. Divya','Pediatrics','9000000006','2021-09-10');

-- Appointments

INSERT INTO Appointments
(patient_id, doctor_id, appointment_date, status)
VALUES
(1,1,CURDATE(),'Scheduled'),
(2,1,CURDATE(),'Completed'),
(3,2,CURDATE(),'Scheduled'),
(4,3,'2026-03-10','Completed'),
(5,4,'2026-03-15','Cancelled'),
(1,2,'2026-03-20','Completed'),
(2,3,'2026-04-01','Completed'),
(3,1,'2026-04-05','Scheduled'),
(6,4,'2026-04-10','Completed'),
(7,5,'2026-04-15','Scheduled'),
(8,1,'2026-04-20','Completed'),
(1,1,'2026-04-25','Completed'),
(9,6,'2026-05-01','Scheduled'),
(10,3,'2026-05-05','Completed'),
(2,1,'2026-05-10','Completed');

-- Rooms

INSERT INTO Rooms
(room_type, availability_status)
VALUES
('General','Available'),
('Private','Occupied'),
('ICU','Available'),
('General','Occupied'),
('Private','Available'),
('ICU','Occupied'),
('General','Available');

-- Admissions

INSERT INTO Admissions
(patient_id, room_id, admission_date, discharge_date)
VALUES
(1,2,'2026-03-01','2026-03-05'),
(2,4,'2026-03-10','2026-03-15'),
(3,3,'2026-04-01',NULL),
(1,5,'2026-05-01','2026-05-05'),
(4,6,'2026-05-10',NULL),
(5,1,'2026-05-15','2026-05-20');

-- Bills

INSERT INTO Bills
(patient_id, doctor_id, total_amount, payment_status, bill_date)
VALUES
(1,1,15000,'Paid','2026-03-05'),
(2,1,25000,'Paid','2026-03-15'),
(3,2,18000,'Pending','2026-04-01'),
(4,3,30000,'Paid','2026-04-10'),
(5,4,12000,'Pending','2026-04-15'),
(1,1,10000,'Paid','2026-05-05'),
(2,1,20000,'Paid','2026-05-10'),
(6,4,35000,'Pending','2026-05-15'),
(7,5,8000,'Paid','2026-05-20'),
(8,1,22000,'Paid','2026-06-01');


-- TASK 4: BASIC QUERIES

-- 1. Display patients above age 50

SELECT * FROM Patients
WHERE age > 50;

-- 2. Show doctors with Cardiology specialization

SELECT * FROM Doctors
WHERE specialization = 'Cardiology';

-- 3. Appointments scheduled for today

SELECT * FROM Appointments
WHERE appointment_date = CURDATE();

-- 4. Display available rooms

SELECT * FROM Rooms
WHERE availability_status = 'Available';

-- 5. Patients in ascending order of age

SELECT * FROM Patients
ORDER BY age ASC;


-- TASK 5: JOINS

-- 1. Patient name with doctor name

SELECT p.name AS patient_name,
       d.name AS doctor_name,
       d.specialization,
       a.appointment_date
FROM Patients p
INNER JOIN Appointments a
ON p.patient_id = a.patient_id
INNER JOIN Doctors d
ON a.doctor_id = d.doctor_id;

-- 2. Appointment details with patient information

SELECT a.appointment_id,
       p.name,
       p.age,
       p.phone,
       a.appointment_date,
       a.status
FROM Appointments a
INNER JOIN Patients p
ON a.patient_id = p.patient_id;

-- 3. Admission details with room type

SELECT ad.admission_id,
       p.name,
       r.room_type,
       ad.admission_date,
       ad.discharge_date
FROM Admissions ad
INNER JOIN Patients p
ON ad.patient_id = p.patient_id
INNER JOIN Rooms r
ON ad.room_id = r.room_id;

-- 4. Bills with patient name

SELECT b.bill_id,
       p.name,
       b.total_amount,
       b.payment_status,
       b.bill_date
FROM Bills b
INNER JOIN Patients p
ON b.patient_id = p.patient_id;

-- 5. Doctors with their patients

SELECT DISTINCT d.name AS doctor_name,
       p.name AS patient_name
FROM Doctors d
INNER JOIN Appointments a
ON d.doctor_id = a.doctor_id
INNER JOIN Patients p
ON a.patient_id = p.patient_id;

-- 6. All doctors including doctors without appointments

SELECT d.name,
       p.name AS patient_name
FROM Doctors d
LEFT JOIN Appointments a
ON d.doctor_id = a.doctor_id
LEFT JOIN Patients p
ON a.patient_id = p.patient_id;


-- TASK 6: AGGREGATE FUNCTIONS

-- 1. Total patients

SELECT COUNT(*) AS total_patients
FROM Patients;

-- 2. Average patient age

SELECT AVG(age) AS average_age
FROM Patients;

-- 3. Total revenue

SELECT SUM(total_amount) AS total_revenue
FROM Bills;

-- 4. Total appointments

SELECT COUNT(*) AS total_appointments
FROM Appointments;

-- 5. Highest bill

SELECT MAX(total_amount) AS highest_bill
FROM Bills;

-- 6. Appointments for each doctor

SELECT d.name,
       COUNT(a.appointment_id) AS total_appointments
FROM Doctors d
LEFT JOIN Appointments a
ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.name;

-- 7. Doctors with more than two appointments

SELECT doctor_id,
       COUNT(*) AS total
FROM Appointments
GROUP BY doctor_id
HAVING COUNT(*) > 2;


-- TASK 7: SUBQUERIES

-- 1. Patients who never booked appointments

SELECT *
FROM Patients
WHERE patient_id NOT IN (
    SELECT patient_id
    FROM Appointments
);

-- 2. Doctors who have no patients

SELECT *
FROM Doctors
WHERE doctor_id NOT IN (
    SELECT doctor_id
    FROM Appointments
);

-- 3. Patients with bills greater than average

SELECT *
FROM Patients
WHERE patient_id IN (
    SELECT patient_id
    FROM Bills
    WHERE total_amount > (
        SELECT AVG(total_amount)
        FROM Bills
    )
);

-- 4. Patients admitted more than once

SELECT p.name,
       COUNT(ad.admission_id) AS admission_count
FROM Patients p
INNER JOIN Admissions ad
ON p.patient_id = ad.patient_id
GROUP BY p.patient_id, p.name
HAVING COUNT(ad.admission_id) > 1;

-- 5. Doctors with appointment counts above average

SELECT d.doctor_id,
       d.name,
       COUNT(a.appointment_id) AS total_appointments
FROM Doctors d
INNER JOIN Appointments a
ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.name
HAVING COUNT(a.appointment_id) > (
    SELECT AVG(appointment_count)
    FROM (
        SELECT COUNT(*) AS appointment_count
        FROM Appointments
        GROUP BY doctor_id
    ) AS temp
);


-- TASK 8: UPDATE AND DELETE

-- 1. Update patient phone number

UPDATE Patients
SET phone = '9999999999'
WHERE patient_id = 1;

-- 2. Change doctor specialization

UPDATE Doctors
SET specialization = 'Cardiac Surgery'
WHERE doctor_id = 1;

-- 3. Update room availability

UPDATE Rooms
SET availability_status = 'Occupied'
WHERE room_id = 1;

-- 4. Delete cancelled appointments

DELETE FROM Appointments
WHERE status = 'Cancelled';

-- 5. Delete patients without any records

DELETE FROM Patients
WHERE NOT EXISTS (
    SELECT 1 FROM Appointments
    WHERE Appointments.patient_id = Patients.patient_id
)
AND NOT EXISTS (
    SELECT 1 FROM Admissions
    WHERE Admissions.patient_id = Patients.patient_id
)
AND NOT EXISTS (
    SELECT 1 FROM Bills
    WHERE Bills.patient_id = Patients.patient_id
);


-- TASK 9: VIEWS

-- 1. Patient appointments view

CREATE VIEW PatientAppointments AS
SELECT p.patient_id,
       p.name AS patient_name,
       d.name AS doctor_name,
       a.appointment_date,
       a.status
FROM Patients p
JOIN Appointments a
ON p.patient_id = a.patient_id
JOIN Doctors d
ON a.doctor_id = d.doctor_id;

SELECT * FROM PatientAppointments;

-- 2. Doctor details view

CREATE VIEW DoctorDetails AS
SELECT doctor_id,
       name,
       specialization,
       phone,
       joining_date
FROM Doctors;

SELECT * FROM DoctorDetails;

-- 3. Admission details view

CREATE VIEW AdmissionDetails AS
SELECT ad.admission_id,
       p.name AS patient_name,
       r.room_type,
       r.availability_status,
       ad.admission_date,
       ad.discharge_date
FROM Admissions ad
JOIN Patients p
ON ad.patient_id = p.patient_id
JOIN Rooms r
ON ad.room_id = r.room_id;

SELECT * FROM AdmissionDetails;

-- 4. Patient billing view

CREATE VIEW PatientBilling AS
SELECT p.patient_id,
       p.name,
       COUNT(b.bill_id) AS total_bills,
       COALESCE(SUM(b.total_amount),0) AS total_amount
FROM Patients p
LEFT JOIN Bills b
ON p.patient_id = b.patient_id
GROUP BY p.patient_id, p.name;

SELECT * FROM PatientBilling;

-- 5. Most visited doctors view

CREATE VIEW MostVisitedDoctors AS
SELECT d.doctor_id,
       d.name,
       d.specialization,
       COUNT(a.appointment_id) AS total_appointments
FROM Doctors d
JOIN Appointments a
ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.name, d.specialization;

SELECT *
FROM MostVisitedDoctors
ORDER BY total_appointments DESC;


-- TASK 10: STORED PROCEDURES

-- Change delimiter

DELIMITER //

-- 1. Insert new patient

CREATE PROCEDURE InsertPatient(
    IN p_name VARCHAR(100),
    IN p_age INT,
    IN p_gender VARCHAR(10),
    IN p_phone VARCHAR(15),
    IN p_address VARCHAR(255),
    IN p_registration_date DATE
)
BEGIN
    INSERT INTO Patients
    (name, age, gender, phone, address, registration_date)
    VALUES
    (p_name, p_age, p_gender, p_phone, p_address, p_registration_date);
END //

-- 2. Update room status

CREATE PROCEDURE UpdateRoomStatus(
    IN p_room_id INT,
    IN p_status VARCHAR(20)
)
BEGIN
    UPDATE Rooms
    SET availability_status = p_status
    WHERE room_id = p_room_id;
END //

-- 3. Display patient appointments

CREATE PROCEDURE GetPatientAppointments(
    IN p_patient_id INT
)
BEGIN
    SELECT a.appointment_id,
           p.name AS patient_name,
           d.name AS doctor_name,
           a.appointment_date,
           a.status
    FROM Appointments a
    JOIN Patients p
    ON a.patient_id = p.patient_id
    JOIN Doctors d
    ON a.doctor_id = d.doctor_id
    WHERE a.patient_id = p_patient_id;
END //

-- 4. Calculate total revenue

CREATE PROCEDURE CalculateRevenue()
BEGIN
    SELECT SUM(total_amount) AS total_revenue
    FROM Bills;
END //

-- 5. List doctors by specialization

CREATE PROCEDURE GetDoctorsBySpecialization(
    IN p_specialization VARCHAR(100)
)
BEGIN
    SELECT *
    FROM Doctors
    WHERE specialization = p_specialization;
END //

DELIMITER ;


-- EXECUTE STORED PROCEDURES

CALL InsertPatient(
    'Ramesh',28,'Male','9123456780',
    'Hyderabad','2026-11-24'
);

CALL UpdateRoomStatus(1,'Available');

CALL GetPatientAppointments(1);

CALL CalculateRevenue();

CALL GetDoctorsBySpecialization('Cardiology');


-- TASK 11: REPORTS AND ANALYSIS

-- 1. Top 5 doctors with most appointments

SELECT d.doctor_id,
       d.name,
       d.specialization,
       COUNT(a.appointment_id) AS total_appointments
FROM Doctors d
JOIN Appointments a
ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.name, d.specialization
ORDER BY total_appointments DESC
LIMIT 5;

-- 2. Most frequent patients

SELECT p.patient_id,
       p.name,
       COUNT(a.appointment_id) AS visit_count
FROM Patients p
JOIN Appointments a
ON p.patient_id = a.patient_id
GROUP BY p.patient_id, p.name
ORDER BY visit_count DESC;

-- 3. Monthly appointment report

SELECT DATE_FORMAT(appointment_date,'%Y-%m') AS month,
       COUNT(*) AS total_appointments
FROM Appointments
GROUP BY DATE_FORMAT(appointment_date,'%Y-%m')
ORDER BY month;

-- 4. Doctor generating highest revenue

SELECT d.name,
       d.specialization,
       SUM(b.total_amount) AS total_revenue
FROM Doctors d
JOIN Bills b
ON d.doctor_id = b.doctor_id
GROUP BY d.doctor_id, d.name, d.specialization
ORDER BY total_revenue DESC
LIMIT 1;

-- 5. Patient billing analysis

SELECT p.patient_id,
       p.name,
       COUNT(b.bill_id) AS total_bills,
       COALESCE(SUM(b.total_amount),0) AS total_amount,
       COALESCE(SUM(
           CASE
               WHEN b.payment_status = 'Paid'
               THEN b.total_amount
               ELSE 0
           END
       ),0) AS paid_amount,
       COALESCE(SUM(
           CASE
               WHEN b.payment_status = 'Pending'
               THEN b.total_amount
               ELSE 0
           END
       ),0) AS pending_amount
FROM Patients p
LEFT JOIN Bills b
ON p.patient_id = b.patient_id
GROUP BY p.patient_id, p.name;

-- 6. Most demanded specialization

SELECT d.specialization,
       COUNT(a.appointment_id) AS total_appointments
FROM Doctors d
JOIN Appointments a
ON d.doctor_id = a.doctor_id
GROUP BY d.specialization
ORDER BY total_appointments DESC;


-- TASK 12: FINAL VERIFICATION

SHOW TABLES;

SELECT * FROM Patients;
SELECT * FROM Doctors;
SELECT * FROM Appointments;
SELECT * FROM Rooms;
SELECT * FROM Admissions;
SELECT * FROM Bills;

SHOW FULL TABLES
WHERE TABLE_TYPE = 'VIEW';

SHOW PROCEDURE STATUS
WHERE Db = 'HospitalDB';


-- =====================================================
-- END OF HOSPITAL MANAGEMENT SYSTEM SQL PROJECT
-- =====================================================
