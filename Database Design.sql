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
    PRIMARY KEY (Admin_ID, Zone_ID),
    FOREIGN KEY (Admin_ID) REFERENCES Admin(Admin_ID),
    FOREIGN KEY (Zone_ID) REFERENCES Zone(Zone_ID)
);
