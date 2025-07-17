CREATE DATABASE WasteManagement ;
USE WasteManagement;
/* 1. Admin*/
CREATE TABLE Admin (
    Admin_ID INT PRIMARY KEY ,
    Admin_First_Name VARCHAR(30),
    Admin_Last_Name VARCHAR(30),
    Password VARCHAR(255) NOT NULL,
    Role VARCHAR(50),
    Email_ID VARCHAR(100) UNIQUE,
    Last_Active DATETIME,
    Permission_Level INT
);


/* 2. Admin_Contact*/
CREATE TABLE Admin_Contact (
    Admin_ID INT,
    Contact VARCHAR(15),
    PRIMARY KEY (Admin_ID, Contact),
    FOREIGN KEY (Admin_ID) REFERENCES Admin(Admin_ID) ON DELETE CASCADE
);


/* 3. Users*/
CREATE TABLE Users (
    User_ID INT PRIMARY KEY ,
    User_First_Name VARCHAR(30),
    User_Last_Name VARCHAR(30),
    Address TEXT
);


/* 4. Users_Contact*/
CREATE TABLE Users_Contact (
    User_ID INT,
    Contact VARCHAR(15),
    PRIMARY KEY (User_ID, Contact),
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID) ON DELETE CASCADE
);


/* 5. Recycling_Plants*/
CREATE TABLE Recycling_Plants (
    Plant_ID INT PRIMARY KEY ,
    Location VARCHAR(100),
    Name VARCHAR(100),
    Recycling_Capacity INT,
    Supervised_By INT,
    FOREIGN KEY (Supervised_By) REFERENCES Admin(Admin_ID)
);


/* 6. Truck_Allotment*/
CREATE TABLE Truck_Allotment (
    Zone_ID INT,
    Truck_ID INT,
    PRIMARY KEY (Zone_ID, Truck_ID),
    FOREIGN KEY (Zone_ID) REFERENCES Zone(Zone_ID),
    FOREIGN KEY (Truck_ID) REFERENCES Trucks(Truck_ID)
);


/* 7. Waste_Collection*/
CREATE TABLE Waste_Collection (
    Collection_ID INT PRIMARY KEY ,
    User_ID INT,
    Collection_Date DATE,
    Verified_By INT,
    Bin_ID INT,
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID),
    FOREIGN KEY (Verified_By) REFERENCES Admin(Admin_ID),
    FOREIGN KEY (Bin_ID) REFERENCES Smart_Bins(Bin_ID)
);


/* 8. Waste_Info*/
CREATE TABLE Waste_Info (
    Collection_ID INT,
    Type_of_Waste VARCHAR(50),
    Quantity DECIMAL(10,2),
    Truck_ID INT,
    Disposal_ID INT,
    Disposal_Date DATE,
    Plant_ID INT,
    PRIMARY KEY (Collection_ID, Truck_ID),
    FOREIGN KEY (Collection_ID) REFERENCES Waste_Collection(Collection_ID),
    FOREIGN KEY (Truck_ID) REFERENCES Trucks(Truck_ID),
    FOREIGN KEY (Disposal_ID) REFERENCES Waste_Disposal(Disposal_ID),
    FOREIGN KEY (Plant_ID) REFERENCES Recycling_Plants(Plant_ID)
);


/* 9. Trucks*/
CREATE TABLE Trucks (
    Truck_ID INT PRIMARY KEY ,
    Driver_First_Name VARCHAR(30),
    Driver_Last_Name VARCHAR(30),
    Location VARCHAR(100),
    Capacity INT,
    Managed_By INT,
    FOREIGN KEY (Managed_By) REFERENCES Admin(Admin_ID)
);


/* 10. Waste_Disposal*/
CREATE TABLE Waste_Disposal (
    Disposal_ID INT PRIMARY KEY ,
    Location VARCHAR(100),
    Collection_ID INT,
    Total_Capacity DECIMAL(10,2),
    Disposal_Method VARCHAR(50),
    Regulation_ID INT,
    Authorized_By INT,
    FOREIGN KEY (Collection_ID) REFERENCES Waste_Collection(Collection_ID),
    FOREIGN KEY (Regulation_ID) REFERENCES Environmental_Regulations(Regulation_ID),
    FOREIGN KEY (Authorized_By) REFERENCES Admin(Admin_ID)
);


/* 11. Penalties*/
CREATE TABLE Penalties (
    Penalty_ID INT PRIMARY KEY ,
    Reason TEXT,
    Penalty_Type VARCHAR(50),
    Amount DECIMAL(10,2),
    Issued_By INT,
    User_ID INT,
    Penalty_Date DATE,
    FOREIGN KEY (Issued_By) REFERENCES Admin(Admin_ID),
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID)
);


/* 12. Incentives*/
CREATE TABLE Incentives (
    Incentive_ID INT PRIMARY KEY ,
    Reason TEXT,
    Incentive_Type VARCHAR(50),
    Amount DECIMAL(10,2),
    Approved_By INT,
    User_ID INT,
    Reward_Date DATE,
    FOREIGN KEY (Approved_By) REFERENCES Admin(Admin_ID),
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID)
);


/* 13. Smart_Bins*/
CREATE TABLE Smart_Bins (
    Bin_ID INT PRIMARY KEY,
    Collection_Frequency VARCHAR(20),
    Carbon_Saved DECIMAL(10,2),
    Last_Emptied_Date DATE,
    Location VARCHAR(100),
    Type_of_Waste VARCHAR(50),
    Capacity DECIMAL(10,2)
);


/* 14. Environmental_Regulations*/
CREATE TABLE Environmental_Regulations (
    Regulation_ID INT PRIMARY KEY ,
    Regulation_Description TEXT,
    Compliance_Requirements TEXT
);


/* 15. SmartBins_Incentives*/
CREATE TABLE SmartBins_Incentives (
    Bin_ID INT,
    Incentive_ID INT,
    PRIMARY KEY (Bin_ID, Incentive_ID),
    FOREIGN KEY (Bin_ID) REFERENCES Smart_Bins(Bin_ID),
    FOREIGN KEY (Incentive_ID) REFERENCES Incentives(Incentive_ID)
);


/* 16. Hotspot_Table*/
CREATE TABLE Hotspot_Table (
    Hotspot_ID INT PRIMARY KEY ,
    Bin_ID INT,
    Alert_Reported_To INT,
    FOREIGN KEY (Bin_ID) REFERENCES Smart_Bins(Bin_ID),
    FOREIGN KEY (Alert_Reported_To) REFERENCES Admin(Admin_ID)
);


/* 17. Zone*/
CREATE TABLE Zone (
    Zone_ID INT PRIMARY KEY ,
    Zone_Name VARCHAR(100),
    State VARCHAR(100)
);


/* 18. Bin_Distribution*/
CREATE TABLE Bin_Distribution (
    Bin_ID INT,
    Zone_ID INT,
    PRIMARY KEY (Bin_ID, Zone_ID),
    FOREIGN KEY (Bin_ID) REFERENCES Smart_Bins(Bin_ID),
    FOREIGN KEY (Zone_ID) REFERENCES Zone(Zone_ID)
);


/* 19. Admin_Zone_Allocation */
CREATE TABLE Admin_Zone_Allocation (
    Admin_ID INT,
    Zone_ID INT,
    PRIMARY KEY (Admin_ID, Zone_ID) ,
    FOREIGN KEY (Admin_ID) REFERENCES Admin(Admin_ID),
    FOREIGN KEY (Zone_ID) REFERENCES Zone(Zone_ID)
);

/*Insertion*/

# 1
INSERT INTO Admin (Admin_ID, Admin_First_Name, Admin_Last_Name, Password, Role, Email_ID, Last_Active, Permission_Level)
VALUES
(1, 'Aarav', 'Mehta', 'pass123', 'System Admin', 'aarav@wm.com', '2025-07-01 10:00:00', 5),
(2, 'Diya', 'Sharma', 'diya456', 'Compliance Officer', 'diya@wm.com', '2025-07-02 09:45:00', 4),
(3, 'Kabir', 'Verma', 'kabir789', 'Plant Manager', 'kabir@wm.com', '2025-07-03 11:15:00', 3),
(4, 'Rhea', 'Kapoor', 'rhea321', 'Truck Coordinator', 'rhea@wm.com', '2025-07-03 15:00:00', 2),
(5, 'Aryan', 'Jain', 'aryan999', 'Zonal Head', 'aryan@wm.com', '2025-07-04 13:30:00', 4),
(6, 'Simran', 'Gill', 'simran888', 'Supervisor', 'simran@wm.com', '2025-07-05 08:20:00', 2),
(7, 'Yash', 'Patel', 'yash777', 'Data Analyst', 'yash@wm.com', '2025-07-01 16:45:00', 3),
(8, 'Tanya', 'Singh', 'tanya000', 'Zone Manager', 'tanya@wm.com', '2025-07-02 17:30:00', 4),
(9, 'Neil', 'Chopra', 'neil111', 'Environment Officer', 'neil@wm.com', '2025-07-01 12:00:00', 4),
(10, 'Meera', 'Rao', 'meera999', 'Tech Lead', 'meera@wm.com', '2025-07-03 14:25:00', 5);

INSERT INTO Admin_Contact (Admin_ID, Contact)
VALUES
(1, '9876543210'),
(2, '9988776655'),
(3, '9123456780'),
(4, '9345678901'),
(5, '9234567810'),
(6, '9012345678'),
(7, '9367890123'),
(8, '9456123789'),
(9, '9345098761'),
(10, '9098765432');
INSERT INTO Users (User_ID, User_First_Name, User_Last_Name, Address)
VALUES
(101, 'Sahil', 'Agarwal', 'Sector 22, Chandigarh'),
(102, 'Isha', 'Khurana', 'Patel Nagar, Delhi'),
(103, 'Naman', 'Gupta', 'Salt Lake, Kolkata'),
(104, 'Kritika', 'Desai', 'Hinjewadi, Pune'),
(105, 'Ritik', 'Bansal', 'Rajouri Garden, Delhi'),
(106, 'Pooja', 'Yadav', 'Indiranagar, Bangalore'),
(107, 'Vikram', 'Sen', 'Civil Lines, Lucknow'),
(108, 'Anjali', 'Kapoor', 'Sector 14, Gurgaon'),
(109, 'Rohan', 'Singla', 'Model Town, Ludhiana'),
(110, 'Neha', 'Mishra', 'Aliganj, Lucknow');
INSERT INTO Users_Contact (User_ID, Contact)
VALUES
(101, '9876100011'),
(102, '9876100012'),
(103, '9876100013'),
(104, '9876100014'),
(105, '9876100015'),
(106, '9876100016'),
(107, '9876100017'),
(108, '9876100018'),
(109, '9876100019'),
(110, '9876100020');
INSERT INTO Recycling_Plants (Plant_ID, Location, Name, Recycling_Capacity, Supervised_By)
VALUES
(201, 'Manimajra, Chandigarh', 'GreenCycle North', 5000, 3),
(202, 'Bawana, Delhi', 'EcoPlant East', 7500, 3),
(203, 'MIDC, Pune', 'Reclaim South', 6800, 6),
(204, 'Kengeri, Bangalore', 'Waste2Worth', 7200, 6),
(205, 'Kolkata Port Area', 'KleanKolkata', 6000, 3),
(206, 'Industrial Area, Ludhiana', 'ReGreen Ludhiana', 6500, 3),
(207, 'Sector 34, Chandigarh', 'EcoLife Central', 7000, 3),
(208, 'GIDC, Ahmedabad', 'Renew Ahmedabad', 8200, 3),
(209, 'Greater Noida', 'NCR Recycler', 9000, 6),
(210, 'Thane West, Mumbai', 'CycleThane', 7900, 6);
INSERT INTO Zone (Zone_ID, Zone_Name, State)
VALUES
(301, 'North Zone', 'Punjab'),
(302, 'South Zone', 'Tamil Nadu'),
(303, 'East Zone', 'West Bengal'),
(304, 'West Zone', 'Rajasthan'),
(305, 'Central Zone', 'Madhya Pradesh'),
(306, 'North-East Zone', 'Assam'),
(307, 'North-West Zone', 'Haryana'),
(308, 'South-West Zone', 'Goa'),
(309, 'South-Central Zone', 'Telangana'),
(310, 'North-Central Zone', 'Uttar Pradesh');

INSERT INTO Smart_Bins (Bin_ID, Collection_Frequency, Carbon_Saved, Last_Emptied_Date, Location, Type_of_Waste, Capacity)
VALUES
(401, 'Daily', 10.5, '2025-07-03', 'Sector 17, Chandigarh', 'Plastic', 120.5),
(402, 'Weekly', 5.2, '2025-07-01', 'DLF Phase 2, Gurgaon', 'Organic', 90.0),
(403, 'Daily', 12.3, '2025-07-02', 'Salt Lake, Kolkata', 'Plastic', 150.0),
(404, 'Biweekly', 3.5, '2025-06-30', 'Hitech City, Hyderabad', 'Metal', 110.0),
(405, 'Daily', 7.8, '2025-07-03', 'Maninagar, Ahmedabad', 'E-Waste', 80.0),
(406, 'Weekly', 4.1, '2025-07-01', 'Rajaji Nagar, Bangalore', 'Organic', 95.0),
(407, 'Daily', 6.2, '2025-07-04', 'T. Nagar, Chennai', 'Glass', 70.5),
(408, 'Weekly', 9.0, '2025-07-02', 'Churchgate, Mumbai', 'Plastic', 85.0),
(409, 'Biweekly', 2.8, '2025-06-29', 'Sector 9, Panchkula', 'Organic', 65.0),
(410, 'Daily', 8.5, '2025-07-03', 'Sector 10, Chandigarh', 'Metal', 100.0);

INSERT INTO Trucks (Truck_ID, Driver_First_Name, Driver_Last_Name, Location, Capacity, Managed_By)
VALUES
(501, 'Raj', 'Kumar', 'Sector 25, Chandigarh', 3000, 4),
(502, 'Amit', 'Verma', 'Pitampura, Delhi', 2800, 4),
(503, 'Suresh', 'Patil', 'Baner, Pune', 3200, 4),
(504, 'Vijay', 'Reddy', 'Madhapur, Hyderabad', 2900, 4),
(505, 'Arun', 'Mishra', 'Garia, Kolkata', 3100, 4),
(506, 'Sunil', 'Sharma', 'Thane East, Mumbai', 3300, 4),
(507, 'Dev', 'Singh', 'Sector 15, Noida', 3000, 4),
(508, 'Ravi', 'Joshi', 'Gandhinagar, Ahmedabad', 3400, 4),
(509, 'Nitin', 'Mehta', 'Indiranagar, Bangalore', 3000, 4),
(510, 'Karan', 'Chawla', 'Gomti Nagar, Lucknow', 3100, 4);

INSERT INTO Waste_Collection (Collection_ID, User_ID, Collection_Date, Verified_By, Bin_ID)
VALUES
(601, 101, '2025-07-02', 1, 401),
(602, 102, '2025-07-03', 2, 402),
(603, 103, '2025-07-02', 3, 403),
(604, 104, '2025-07-01', 1, 404),
(605, 105, '2025-07-03', 4, 405),
(606, 106, '2025-07-02', 5, 406),
(607, 107, '2025-07-01', 6, 407),
(608, 108, '2025-07-03', 7, 408),
(609, 109, '2025-07-02', 8, 409),
(610, 110, '2025-07-03', 9, 410);

INSERT INTO Waste_Disposal (Disposal_ID, Location, Collection_ID, Total_Capacity, Disposal_Method, Regulation_ID, Authorized_By)
VALUES
(701, 'Dumping Ground, Chandigarh', 601, 500.0, 'Landfill', 801, 1),
(702, 'Plant B, Delhi', 602, 450.0, 'Incineration', 802, 2),
(703, 'Kolkata Sector A', 603, 400.0, 'Recycling', 803, 3),
(704, 'Pune Site C', 604, 550.0, 'Recycling', 804, 4),
(705, 'Hyd Zone 5', 605, 520.0, 'Composting', 805, 5),
(706, 'Ahmedabad Plant 2', 606, 510.0, 'Landfill', 806, 6),
(707, 'Bangalore East Yard', 607, 480.0, 'Incineration', 807, 7),
(708, 'Chennai Zone 9', 608, 470.0, 'Recycling', 808, 8),
(709, 'Ludhiana Sector 12', 609, 460.0, 'Landfill', 809, 9),
(710, 'Lucknow North Site', 610, 490.0, 'Composting', 810, 10);

INSERT INTO Environmental_Regulations (Regulation_ID, Regulation_Description, Compliance_Requirements)
VALUES
(801, 'Limit landfill use', 'Reduce landfill by 30% annually'),
(802, 'Plastic ban', 'No non-biodegradable plastic usage'),
(803, 'Recycling quota', 'Minimum 50% recyclable waste'),
(804, 'Hazardous waste rules', 'Follow safe disposal protocols'),
(805, 'Composting mandate', 'Compost all organic waste'),
(806, 'Truck emissions', 'Trucks must meet BS-VI standards'),
(807, 'E-waste compliance', 'Follow electronic waste recycling rules'),
(808, 'Water usage norms', 'Limit water in recycling to 200L/ton'),
(809, 'Noise pollution', 'Equipment < 60dB'),
(810, 'Bio-medical waste', 'Use yellow-coded disposal bins');

INSERT INTO Waste_Info (Collection_ID, Type_of_Waste, Quantity, Truck_ID, Disposal_ID, Disposal_Date, Plant_ID)
VALUES
(601, 'Plastic', 120.5, 501, 701, '2025-07-03', 201),
(602, 'Organic', 90.0, 502, 702, '2025-07-03', 202),
(603, 'Plastic', 150.0, 503, 703, '2025-07-03', 203),
(604, 'Metal', 110.0, 504, 704, '2025-07-02', 204),
(605, 'E-Waste', 80.0, 505, 705, '2025-07-03', 205),
(606, 'Organic', 95.0, 506, 706, '2025-07-03', 206),
(607, 'Glass', 70.5, 507, 707, '2025-07-03', 207),
(608, 'Plastic', 85.0, 508, 708, '2025-07-03', 208),
(609, 'Organic', 65.0, 509, 709, '2025-07-03', 209),
(610, 'Metal', 100.0, 510, 710, '2025-07-03', 210);

INSERT INTO Truck_Allotment (Zone_ID, Truck_ID)
VALUES
(301, 501),
(302, 502),
(303, 503),
(304, 504),
(305, 505),
(306, 506),
(307, 507),
(308, 508),
(309, 509),
(310, 510);

INSERT INTO Bin_Distribution (Bin_ID, Zone_ID)
VALUES
(401, 301),
(402, 302),
(403, 303),
(404, 304),
(405, 305),
(406, 306),
(407, 307),
(408, 308),
(409, 309),
(410, 310);

INSERT INTO Admin_Zone_Allocation (Admin_ID, Zone_ID)
VALUES
(1, 301),
(2, 302),
(3, 303),
(4, 304),
(5, 305),
(6, 306),
(7, 307),
(8, 308),
(9, 309),
(10, 310);

INSERT INTO Penalties (Penalty_ID, Reason, Penalty_Type, Amount, Issued_By, User_ID, Penalty_Date)
VALUES
(901, 'Overflowing bin', 'Fine', 250.00, 1, 101, '2025-07-03'),
(902, 'Late segregation', 'Warning', 0.00, 2, 102, '2025-07-03'),
(903, 'Illegal dumping', 'Fine', 500.00, 3, 103, '2025-07-02'),
(904, 'Wrong bin usage', 'Warning', 0.00, 4, 104, '2025-07-03'),
(905, 'Tampering sensors', 'Ban', 1000.00, 5, 105, '2025-07-03'),
(906, 'Hazardous waste', 'Fine', 300.00, 6, 106, '2025-07-01'),
(907, 'Noise pollution', 'Warning', 0.00, 7, 107, '2025-07-02'),
(908, 'Skipping collection', 'Fine', 400.00, 8, 108, '2025-07-03'),
(909, 'Misreporting', 'Warning', 0.00, 9, 109, '2025-07-03'),
(910, 'Unauthorized disposal', 'Fine', 600.00, 10, 110, '2025-07-03');

INSERT INTO Incentives (Incentive_ID, Reason, Incentive_Type, Amount, Approved_By, User_ID, Reward_Date)
VALUES
(1001, 'Proper segregation', 'Cash', 150.00, 1, 101, '2025-07-03'),
(1002, 'Clean locality', 'Voucher', 100.00, 2, 102, '2025-07-03'),
(1003, 'Low bin usage', 'Discount', 75.00, 3, 103, '2025-07-02'),
(1004, 'High recycling', 'Cash', 200.00, 4, 104, '2025-07-03'),
(1005, 'Smart bin maintenance', 'Voucher', 125.00, 5, 105, '2025-07-03'),
(1006, 'Community initiative', 'Cash', 180.00, 6, 106, '2025-07-01'),
(1007, 'Low carbon impact', 'Discount', 90.00, 7, 107, '2025-07-02'),
(1008, 'E-waste disposal', 'Cash', 130.00, 8, 108, '2025-07-03'),
(1009, 'Awareness program', 'Voucher', 110.00, 9, 109, '2025-07-03'),
(1010, 'App usage', 'Discount', 85.00, 10, 110, '2025-07-03');

INSERT INTO SmartBins_Incentives (Bin_ID, Incentive_ID)
VALUES
(401, 1001),
(402, 1002),
(403, 1003),
(404, 1004),
(405, 1005),
(406, 1006),
(407, 1007),
(408, 1008),
(409, 1009),
(410, 1010);

INSERT INTO Hotspot_Table (Hotspot_ID, Bin_ID, Alert_Reported_To)
VALUES
(1101, 401, 1),
(1102, 402, 2),
(1103, 403, 3),
(1104, 404, 4),
(1105, 405, 5),
(1106, 406, 6),
(1107, 407, 7),
(1108, 408, 8),
(1109, 409, 9),
(1110, 410, 10);
