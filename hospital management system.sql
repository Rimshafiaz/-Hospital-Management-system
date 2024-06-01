CREATE DATABASE HMIS;
SHOW DATABASES;
USE HMIS;
CREATE TABLE Patient (
PatientID INT(10) NOT NULL,
Name VARCHAR(20) NOT NULL,
DOB DATE,
Gender VARCHAR(1),
ContactInfo VARCHAR(11),
Address VARCHAR(100)
);

CREATE TABLE Staff (
StaffID INT(10) NOT NULL,
Name VARCHAR(20) NOT NULL,
DOB DATE,
Gender VARCHAR(1),
ContactInfo VARCHAR(11),
Address VARCHAR(100),
Position VARCHAR(50),
DepartmentID INT(10) NOT NULL
);

CREATE TABLE Doctor (
DoctorID INT(10) NOT NULL,
Name VARCHAR(20) NOT NULL,
DOB DATE,
Gender VARCHAR(1),
ContactInfo VARCHAR(11),
Address VARCHAR(100),
Specialization VARCHAR(30),
Schedule VARCHAR(50),
DepartmentID INT(10) NOT NULL
);

CREATE TABLE Nurse (
NurseID INT(10) NOT NULL,
Name VARCHAR(20) NOT NULL,
DOB DATE,
Gender VARCHAR(1),
ContactInfo VARCHAR(11),
Address VARCHAR(100),
Shifts VARCHAR(50),
DepartmentID INT(10) NOT NULL
);


CREATE TABLE Department (
DepartmentID INT(10) NOT NULL,
DepartmentName VARCHAR(50) NOT NULL,
Description VARCHAR(100)
);

CREATE TABLE Admission (
AdmissionID INT(10) NOT NULL,
PatientID INT(10) NOT NULL,
AdmissionDate DATE,
DischargeDate DATE,
AdmissionReason VARCHAR(200)
);

CREATE TABLE MedicalRecord (
RecordID INT(10) NOT NULL,
PatientID INT(10) NOT NULL,
AdmissionID INT(10) NOT NULL,
MedicalConditions VARCHAR(50),
Allergies VARCHAR(200),
Medications VARCHAR(100),
TreatmentDetails VARCHAR(200),
Results VARCHAR(100),
Timestamp TIMESTAMP
);

CREATE TABLE Appointment (
AppointmentID INT(10) NOT NULL,
PatientID INT(10) NOT NULL,
DoctorID INT(10) NOT NULL,
AppointmentDate DATE,
Status VARCHAR(100)
);

CREATE TABLE EmergencyDepartmentRecord (
EmergencyRecordID INT(10) NOT NULL,
PatientID INT(10) NOT NULL,
DoctorID INT(10) NOT NULL,
EmergencyType VARCHAR(100),
TreatmentDetails VARCHAR(200),
Timestamp TIMESTAMP
);

CREATE TABLE ICURecord (
ICURecordID INT(10) NOT NULL,
PatientID INT(10) NOT NULL,
DoctorID INT(10) NOT NULL,
ICUType VARCHAR(100),
EquipmentUsed VARCHAR(200),
Timestamp TIMESTAMP
);

CREATE TABLE SurgeryRecord (
SurgeryRecordID INT(10) NOT NULL,
PatientID INT(10) NOT NULL,
DoctorID INT(10) NOT NULL,
SurgeonID INT(10) NOT NULL,
SurgeryType VARCHAR(80),
OperationDate DATE,
Notes VARCHAR(100)
);

CREATE TABLE DiagnosticProcedure (
ProcedureID INT(10) NOT NULL,
PatientID INT(10) NOT NULL,
ProcedureType VARCHAR(20),
Results VARCHAR(100),
Timestamp TIMESTAMP
);

CREATE TABLE BillingInformation (
BillingID INT(10) NOT NULL,
PatientID INT(10) NOT NULL,
TotalAmount DECIMAL,
PaymentStatus VARCHAR(100),
InvoiceDate DATE
);
CREATE TABLE MedicalResource (
ResourceType VARCHAR(250),
ResourceID INT(10) NOT NULL,
Manufacturer VARCHAR(250),
Quantity INT(10),
Available VARCHAR(200),
ResourceCondition VARCHAR(100),
ResourceName VARCHAR(100));

CREATE TABLE PatientFinancialInformation (
PatientID INT(10) NOT NULL,
InsuranceProvider VARCHAR(100),
PolicyNumber VARCHAR(10),
ExpiryDate DATE,
TotalAmount DECIMAL(10,2),
PaymentStatus VARCHAR(15),
InvoiceDate DATE
);

CREATE TABLE DoctorICURecord (
DoctorID INT(10) NOT NULL,
ICURecordID INT(10) NOT NULL
);

CREATE TABLE DoctorSurgeryRecord (
DoctorID INT(10) NOT NULL,
SurgeryRecordID INT(10) NOT NULL
);

CREATE TABLE DoctorEmergencyRecord (
DoctorID INT(10) NOT NULL,
EmergencyRecordID INT(10) NOT NULL
);

CREATE TABLE ResourceBilling (
MedicalResourceID INT(10) NOT NULL,
BillingID INT(10) NOT NULL
);


ALTER TABLE Patient ADD PRIMARY KEY (PatientID);

ALTER TABLE Staff ADD PRIMARY KEY (StaffID);

ALTER TABLE Doctor ADD PRIMARY KEY (DoctorID);

ALTER TABLE Nurse ADD PRIMARY KEY (NurseID);

ALTER TABLE Department ADD PRIMARY KEY (DepartmentID);

ALTER TABLE Admission ADD PRIMARY KEY (AdmissionID);

ALTER TABLE MedicalRecord ADD PRIMARY KEY (RecordID);

ALTER TABLE Appointment ADD PRIMARY KEY (AppointmentID);

ALTER TABLE EmergencyDepartmentRecord ADD PRIMARY KEY (EmergencyRecordID);

ALTER TABLE ICURecord ADD PRIMARY KEY (ICURecordID);

ALTER TABLE SurgeryRecord ADD PRIMARY KEY (SurgeryRecordID);

ALTER TABLE DiagnosticProcedure ADD PRIMARY KEY (ProcedureID);

ALTER TABLE BillingInformation ADD PRIMARY KEY (BillingID);

ALTER TABLE PatientFinancialInformation ADD PRIMARY KEY (PatientID);

ALTER TABLE MedicalResource ADD PRIMARY KEY (ResourceID);
    
ALTER TABLE DoctorICURecord ADD PRIMARY KEY (DoctorID, ICURecordID);

ALTER TABLE DoctorSurgeryRecord ADD PRIMARY KEY (DoctorID, SurgeryRecordID);

ALTER TABLE DoctorEmergencyRecord ADD PRIMARY KEY (DoctorID, EmergencyRecordID);

ALTER TABLE ResourceBilling ADD PRIMARY KEY (MedicalResourceID, BillingID);


ALTER TABLE Staff ADD FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID);

ALTER TABLE Doctor ADD FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID);

ALTER TABLE Nurse ADD FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID);

ALTER TABLE Admission ADD FOREIGN KEY (PatientID) REFERENCES Patient(PatientID);

ALTER TABLE MedicalRecord ADD FOREIGN KEY (PatientID) REFERENCES Patient(PatientID);
ALTER TABLE MedicalRecord ADD FOREIGN KEY (AdmissionID) REFERENCES Admission(AdmissionID);

ALTER TABLE Appointment ADD FOREIGN KEY (PatientID) REFERENCES Patient(PatientID);
ALTER TABLE Appointment ADD FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID);

ALTER TABLE EmergencyDepartmentRecord ADD FOREIGN KEY (PatientID) REFERENCES Patient(PatientID);
ALTER TABLE EmergencyDepartmentRecord ADD FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID);

ALTER TABLE ICURecord ADD FOREIGN KEY (PatientID) REFERENCES Patient(PatientID);
ALTER TABLE ICURecord ADD FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID);

ALTER TABLE SurgeryRecord ADD FOREIGN KEY (PatientID) REFERENCES Patient(PatientID);
ALTER TABLE SurgeryRecord ADD FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID);
ALTER TABLE SurgeryRecord ADD FOREIGN KEY (SurgeonID) REFERENCES Doctor(DoctorID);

ALTER TABLE DiagnosticProcedure ADD FOREIGN KEY (PatientID) REFERENCES Patient(PatientID);

ALTER TABLE BillingInformation ADD FOREIGN KEY (PatientID) REFERENCES Patient(PatientID);

ALTER TABLE PatientFinancialInformation ADD FOREIGN KEY (PatientID) REFERENCES Patient(PatientID);

ALTER TABLE DoctorICURecord  ADD FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID);
ALTER TABLE DoctorICURecord  ADD FOREIGN KEY (ICURecordID) REFERENCES ICURecord(ICURecordID);

ALTER TABLE DoctorSurgeryRecord ADD FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID);
ALTER TABLE DoctorSurgeryRecord ADD FOREIGN KEY (SurgeryRecordID) REFERENCES SurgeryRecord(SurgeryRecordID);

ALTER TABLE DoctorEmergencyRecord  ADD FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID);
ALTER TABLE DoctorEmergencyRecord  ADD FOREIGN KEY (EmergencyRecordID) REFERENCES EmergencyDepartmentRecord(EmergencyRecordID);

ALTER TABLE ResourceBilling ADD FOREIGN KEY (MedicalResourceID) REFERENCES MedicalResource(ResourceID);
ALTER TABLE ResourceBilling ADD FOREIGN KEY (BillingID) REFERENCES BillingInformation(BillingID);


-- Sample entries for the Patient table
INSERT INTO Patient VALUES
(1, 'Ahmed Mustaffa', '1990-01-01', 'M', '03030304021', '123 Model Town'),
(2, 'Fiza Ashraf', '1985-05-15', 'F', '03102030405', '456 Wapda Town'),
(3, 'ALi', '1978-08-20', 'M', '03040505567', '789 Model Town'),
(4, 'Aliya Ahmed', '1995-03-10', 'F', '03007956789', '567 Valenecia'),
(5, 'Hassan', '1982-12-05', 'M', '03055687768', '197 Wapda Town');

INSERT INTO Department VALUES
(1, 'Cardiology', 'Heart-related issues'),
(2, 'Orthopedics', 'Musculoskeletal system'),
(3, 'Neurology', 'Brain related issue'),
(4, 'Internal Medicine', 'General healthcare'),
(5, 'Dermatology', 'Skin-related issues');

INSERT INTO Staff VALUES
(1, 'Faiza Hussein', '1980-03-12', 'F', '03078875890', '190 Valencia', 'Administrator', 1),
(2, 'Fahad Hussein', '1975-07-20', 'M', '03045768797', '321 Johar Town', 'Admin', 2),
(3, 'Sarzaraf', '1988-11-05', 'M', '03456745460', '456 Iqbal Town', 'Admin', 1),
(4, 'Ayesha Ahmed', '1992-04-30', 'F', '03098989767', '654 Wapda Town', 'Receptionist', 2),
(5, 'Fawad Ch', '1972-09-15', 'M', '03090658890', '789 Johar Town', 'Ward Boy', 3);


INSERT INTO Doctor VALUES
(1, 'Dr. Ahmed', '1970-04-15', 'M', '03071175890', '111 Wapda Town', 'Cardiology', 'Mon-Fri', 1),
(2, 'Dr. Aleeza', '1980-03-20', 'F', '03098989790', '209 Johar Town', 'Cardiology', 'Tue-Sat', 1),
(3, 'Dr. Mustaffa', '1988-05-12', 'M', '03006745460', '233 Paragon City', 'General physician', 'Mon-Wed', 4),
(4, 'Dr. Fatima', '1972-09-15', 'F', '03090089767', '144 Johar Town', 'neurology', 'Thu-Sat', 3),
(5, 'Dr. Zaid', '1984-11-18', 'M', '03090957790', '195 Valencia ', 'General physician', 'Mon-Thu', 4);

INSERT INTO Nurse VALUES
(1, 'Nurse Aqsa', '1986-02-25', 'F', '03090985782', '109 Valencia', 'Day Shift', 1),
(2, 'Nurse Zaid', '1990-06-15', 'M', '03047586951', '212 Johar Town', 'Night Shift', 2),
(3, 'Nurse Amna', '1983-09-05', 'F', '03044506060', '197 PCSIR', 'Rotating Shifts', 3),
(4, 'Nurse Faraz', '1992-03-12', 'M', '03445678901', '190 Wapda Town', 'Day Shift', 1),
(5, 'Nurse Anooshay', '1980-12-20', 'F', '03079485858', '120 PCSIR', 'Night Shift', 2);


INSERT INTO Admission VALUES
(1, 1, '2023-01-01', '2023-01-10', 'Routine Checkup'),
(2, 2, '2023-02-15', '2023-02-20', 'Injury Treatment'),
(3, 3, '2023-03-10', '2023-03-15', 'Viral Infection'),
(4, 4, '2023-04-05', '2023-04-12', 'Allergy Diagnosis'),
(5, 5, '2023-05-20', '2023-05-25', 'Surgery Recovery');

INSERT INTO MedicalRecord VALUES
(1, 1, 1, 'Hypertension', 'None', 'Medication A', 'Regular checkups', 'Normal', '2023-01-05 10:30:00'),
(2, 2, 2, 'Fractured Arm', 'None', 'Painkiller B', 'Cast applied', 'Good recovery', '2023-02-18 15:45:00'),
(3, 3, 3, 'Flu', 'None', 'Antiviral medication', 'Bed rest', 'Recovered', '2023-03-12 08:00:00'),
(4, 4, 4, 'Allergic reaction', 'Pollen', 'Antihistamine C', 'Avoid allergen', 'Improved', '2023-04-08 12:20:00'),
(5, 5, 5, 'Appendix removal', 'None', 'Painkiller D', 'Post-surgery care', 'Excellent', '2023-05-22 11:10:00');

INSERT INTO Appointment VALUES
(1, 1, 2, '2023-01-15', 'Scheduled'),
(2, 2, 3, '2023-02-25', 'Scheduled'),
(3, 3, 4, '2023-03-20', 'Scheduled'),
(4, 4, 5, '2023-04-10', 'Scheduled'),
(5, 5, 1, '2023-05-30', 'Scheduled');

INSERT INTO EmergencyDepartmentRecord VALUES
(1, 1, 3, 'Accident', 'X-ray and first aid', '2023-01-08 18:30:00'),
(2, 2, 2, 'Heart attack', 'Emergency angioplasty', '2023-02-18 09:15:00'),
(3, 3, 5, 'Severe fever', 'IV fluids and antipyretics', '2023-03-15 14:45:00'),
(4, 4, 5, 'Respiratory distress', 'Oxygen therapy', '2023-04-10 21:00:00'),
(5, 5, 3, 'Trauma', 'Stitching and wound dressing', '2023-05-25 16:20:00');

INSERT INTO ICURecord VALUES
(1, 1, 1, 'Cardiac ICU', 'ECG, ventilator', '2023-01-12 08:00:00'),
(2, 2, 2, 'Surgical ICU', 'Life support, monitoring', '2023-02-22 14:30:00'),
(3, 3, 3, 'Medical ICU', 'Oxygen, ventilator', '2023-03-18 11:45:00'),
(4, 4, 2, 'Cardiac ICU', 'ECG, ventilator', '2023-04-15 20:10:00'),
(5, 5, 4, 'Surgical ICU', 'Life support, monitoring', '2023-05-28 17:30:00');

INSERT INTO SurgeryRecord VALUES
(1, 1, 2, 1, 'Angioplasty', '2023-01-20', 'Successful procedure'),
(2, 2, 5, 4, 'Neurosurgery', '2023-02-28', 'Good recovery'),
(3, 3, 2, 1, 'Angioplasty', '2023-03-25', 'Stable condition'),
(4, 4, 2, 1, 'Cardiac Bypass', '2023-04-15', 'Recovering well'),
(5, 5, 5, 4, 'Neurosurgery', '2023-06-01', 'Post-op care in progress');

INSERT INTO DiagnosticProcedure VALUES
(1, 1, 'X-ray', 'Normal', '2023-01-10 11:30:00'),
(2, 2, 'MRI', 'Fracture detected', '2023-02-20 14:45:00'),
(3, 3, 'Blood test', 'Viral infection', '2023-03-15 10:00:00'),
(4, 4, 'Allergy test', 'Positive for pollen allergy', '2023-04-12 13:20:00'),
(5, 5, 'CT scan', 'Normal', '2023-05-28 09:45:00');

INSERT INTO BillingInformation VALUES
(1, 1, 5000.00, 'Paid', '2023-01-15'),
(2, 2, 7500.00, 'Pending', '2023-02-28'),
(3, 3, 3000.00, 'Paid', '2023-03-22'),
(4, 4, 10000.00, 'Pending', '2023-04-18'),
(5, 5, 6000.00, 'Paid', '2023-06-05');

INSERT INTO MedicalResource VALUES
('Medicine', 1, 'ABC Pharma', 100, 'Yes', 'Good', 'Painkiller A'),
('Equipment', 2, 'XYZ Devices', 5, 'Yes', 'Excellent', 'Ventilator B'),
('Medicine', 3, 'DEF Pharmaceuticals', 50, 'No', 'Fair', 'Antiviral C'),
('Equipment', 4, 'LMN Devices', 2, 'Yes', 'Good', 'X-ray Machine D'),
('Medicine', 5, 'PQR Pharma', 75, 'Yes', 'Excellent', 'Antibiotic E');

INSERT INTO PatientFinancialInformation VALUES
(1, 'Health Insurance Inc.', 'HI12345', '2025-01-01', 5000.00, 'Paid', '2022-01-18'),
(2, 'Medical Coverage Ltd.', 'MC67890', '2025-02-15', 7500.00, 'Pending', '2022-03-02'),
(3, 'Secure Health Insurance', 'SHI34567', '2025-03-10', 3000.00, 'Paid', '2022-04-02'),
(4, 'Wellness Assurance', 'WA98765', '2025-04-05', 10000.00, 'Pending', '2022-05-18'),
(5, 'CareGuard Insurance', 'CG54321', '2025-05-20', 6000.00, 'Paid', '2022-06-10');

INSERT INTO DoctorICURecord VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO DoctorSurgeryRecord VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO DoctorEmergencyRecord VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO ResourceBilling VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);


-- Queries
-- information of staff working in cardiology department

SELECT * FROM Staff WHERE DepartmentID = (SELECT DepartmentID FROM Department WHERE DepartmentName = 'Cardiology');


-- Retrieve all resources with 'Yes' availability status

SELECT * FROM MedicalResource WHERE Available = 'Yes';

-- List all ICU records handled by a specific doctor 

SELECT * FROM ICURecord WHERE ICURecordID IN (SELECT ICURecordID FROM DoctorICURecord WHERE DoctorID = 2);


-- Retrieve the names and contact information of patients along with their assigned doctor's name

SELECT 
    P.Name AS PatientName, 
    P.ContactInfo AS PatientContact,
    D.Name AS DoctorName  FROM Patient P
JOIN 
    Appointment A ON P.PatientID = A.PatientID
JOIN 
    Doctor  D ON A.DoctorID = D.DoctorID;

-- List all staff members along with the department they work in

SELECT 
    S.Name AS StaffName,
    D.DepartmentName AS Department
FROM 
    Staff S
JOIN 
    Department D ON S.DepartmentID = D.DepartmentID;


-- List all diagnostic procedures along with patient names and the results

SELECT  DP.ProcedureID,P.Name AS PatientName,DP.ProcedureType,DP.Results FROM  DiagnosticProcedure DP
JOIN 
    Patient P ON DP.PatientID = P.PatientID;

-- Find the name and contact information of nurses who work the night shift
SELECT Name, ContactInfo FROM Nurse WHERE Shifts = 'Night Shift';

