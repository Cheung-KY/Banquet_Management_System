BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Register';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Meal';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Attendee';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Banquet';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

CREATE TABLE Banquet (
    BIN INT PRIMARY KEY,
    BanquetName VARCHAR(255) NOT NULL,
    FNameContactStaff VARCHAR(100) NOT NULL,
    LNameContactStaff VARCHAR(100) NOT NULL,
    MinAttendee INT NOT NULL,
    Quota INT NOT NULL,
    Available CHAR(1) CHECK (Available IN ('Y', 'N')),
    DateTime TIMESTAMP NOT NULL,
    Address VARCHAR(100) NOT NULL,
    Location VARCHAR(100) NOT NULL
);

CREATE TABLE Attendee (
    AttendeeID VARCHAR(255) PRIMARY KEY CHECK (AttendeeID LIKE '%@%'),
    FName VARCHAR(255) NOT NULL,
    LName VARCHAR(255) NOT NULL,
    PhoneNumber CHAR(8) NOT NULL CHECK (PhoneNumber LIKE '________'), -- 8 underscores for 8 digits
    Address VARCHAR(255) NOT NULL,
    AttendeeType VARCHAR(255) NOT NULL CHECK (AttendeeType IN ('staff', 'student', 'alumni', 'guest')),
    Password VARCHAR(20) NOT NULL,
    AffiliatedOrg VARCHAR(255) NOT NULL CHECK (AffiliatedOrg IN ('PolyU', 'SPEED', 'HKCC', 'Others'))
);

CREATE TABLE Meal (
    DishName VARCHAR(255) NOT NULL,
    Type VARCHAR(255) NOT NULL,
    Price INT NOT NULL,
    SpecialCuisine VARCHAR(255),
    BIN INT,
    FOREIGN KEY (BIN) REFERENCES Banquet(BIN)
);

CREATE TABLE Register (
    AttendeeID VARCHAR(255) NOT NULL,
    BIN INT NOT NULL, 
    DrinkChoice VARCHAR(255) NOT NULL,
    MealChoice VARCHAR(255) NOT NULL,
    Remarks VARCHAR(255) NOT NULL,
    FOREIGN KEY (AttendeeID) REFERENCES Attendee(AttendeeID),
    FOREIGN KEY (BIN) REFERENCES Banquet(BIN)
);

INSERT INTO Banquet (BIN, BanquetName, FNameContactStaff, LNameContactStaff, MinAttendee, Quota, Available, DateTime, Address, Location) VALUES
(1, 'Spring Gala', 'Alice', 'Johnson', 50, 200, 'Y', TO_TIMESTAMP('2024-05-01 19:00','YYYY-MM-DD HH24:MI'), '123 Blossom St', 'Hong Kong');

INSERT INTO Banquet (BIN, BanquetName, FNameContactStaff, LNameContactStaff, MinAttendee, Quota, Available, DateTime, Address, Location) VALUES
(2, 'Summer Feast', 'Bob', 'Smith', 60, 220, 'Y', TO_TIMESTAMP('2024-06-15 18:00','YYYY-MM-DD HH24:MI'), '456 Sunshine Rd', 'Tai Po');

INSERT INTO Banquet (BIN, BanquetName, FNameContactStaff, LNameContactStaff, MinAttendee, Quota, Available, DateTime, Address, Location) VALUES
(3, 'Autumn Banquet', 'Carol', 'Brown', 55, 250, 'N', TO_TIMESTAMP('2024-09-21 20:00','YYYY-MM-DD HH24:MI'), '789 Harvest Ave', 'Kowloon');

INSERT INTO Banquet (BIN, BanquetName, FNameContactStaff, LNameContactStaff, MinAttendee, Quota, Available, DateTime, Address, Location) VALUES
(4, 'Winter Wonderland', 'David', 'Taylor', 70, 300, 'Y', TO_TIMESTAMP('2024-12-10 17:00','YYYY-MM-DD HH24:MI'), '101 Snowfall Ln', 'Central');

INSERT INTO Banquet (BIN, BanquetName, FNameContactStaff, LNameContactStaff, MinAttendee, Quota, Available, DateTime, Address, Location) VALUES
(5, 'New Year Bash', 'Eve', 'Adams', 100, 400, 'Y', TO_TIMESTAMP('2024-12-31 21:00','YYYY-MM-DD HH24:MI'), '202 Countdown Sq', 'Mong Kok');

INSERT INTO Banquet (BIN, BanquetName, FNameContactStaff, LNameContactStaff, MinAttendee, Quota, Available, DateTime, Address, Location) VALUES
(6, 'Charity Gala', 'Frank', 'Anderson', 80, 350, 'N', TO_TIMESTAMP('2024-11-22 19:30','YYYY-MM-DD HH24:MI'), '303 Giving Blvd', 'Wan Chai');

INSERT INTO Banquet (BIN, BanquetName, FNameContactStaff, LNameContactStaff, MinAttendee, Quota, Available, DateTime, Address, Location) VALUES
(7, 'Tech Conference', 'Grace', 'Williams', 40, 150, 'Y', TO_TIMESTAMP('2024-08-18 13:00','YYYY-MM-DD HH24:MI'), '404 Innovation Rd', 'Cyberport');

INSERT INTO Banquet (BIN, BanquetName, FNameContactStaff, LNameContactStaff, MinAttendee, Quota, Available, DateTime, Address, Location) VALUES
(8, 'Art Festival', 'Hank', 'Thompson', 30, 120, 'Y', TO_TIMESTAMP('2024-07-09 14:00','YYYY-MM-DD HH24:MI'), '505 Creative Dr', 'Tsim Sha Tsui');

INSERT INTO Banquet (BIN, BanquetName, FNameContactStaff, LNameContactStaff, MinAttendee, Quota, Available, DateTime, Address, Location) VALUES
(9, 'Music Fest', 'Ivy', 'Davis', 90, 500, 'N', TO_TIMESTAMP('2024-10-05 15:00','YYYY-MM-DD HH24:MI'), '606 Melody Ln', 'Sai Kung');

INSERT INTO Banquet (BIN, BanquetName, FNameContactStaff, LNameContactStaff, MinAttendee, Quota, Available, DateTime, Address, Location) VALUES
(10, 'Food Expo', 'Jack', 'Martinez', 200, 600, 'Y', TO_TIMESTAMP('2024-11-30 12:00','YYYY-MM-DD HH24:MI'), '707 Gourmet St', 'Sham Shui Po');

INSERT INTO Attendee (AttendeeID, FName, LName, PhoneNumber, Address, AttendeeType, Password, AffiliatedOrg) VALUES 
('john.doe@example.com', 'John', 'Doe', '12345678', '123 Main St, Kowloon', 'student', 'pass1234', 'PolyU');

INSERT INTO Attendee (AttendeeID, FName, LName, PhoneNumber, Address, AttendeeType, Password, AffiliatedOrg) VALUES 
('jane.smith@example.com', 'Jane', 'Smith', '87654321', '456 Elm St, Hong Kong', 'staff', 'pass5678', 'SPEED');

INSERT INTO Attendee (AttendeeID, FName, LName, PhoneNumber, Address, AttendeeType, Password, AffiliatedOrg) VALUES 
('alice.jones@example.com', 'Alice', 'Jones', '23456789', '789 Pine St, Tsim Sha Tsui', 'alumni', 'passabcd', 'HKCC');

INSERT INTO Attendee (AttendeeID, FName, LName, PhoneNumber, Address, AttendeeType, Password, AffiliatedOrg) VALUES 
('bob.brown@example.com', 'Bob', 'Brown', '34567890', '321 Oak St, Mong Kok', 'guest', 'passefgh', 'Others');

INSERT INTO Attendee (AttendeeID, FName, LName, PhoneNumber, Address, AttendeeType, Password, AffiliatedOrg) VALUES 
('charlie.white@example.com', 'Charlie', 'White', '45678901', '654 Maple St, Wan Chai', 'student', 'passijkl', 'PolyU');

INSERT INTO Attendee (AttendeeID, FName, LName, PhoneNumber, Address, AttendeeType, Password, AffiliatedOrg) VALUES 
('emma.green@example.com', 'Emma', 'Green', '56789012', '987 Cedar St, Central', 'staff', 'passmnop', 'SPEED');

INSERT INTO Attendee (AttendeeID, FName, LName, PhoneNumber, Address, AttendeeType, Password, AffiliatedOrg) VALUES 
('david.black@example.com', 'David', 'Black', '67890123', '135 Birch St, Causeway Bay', 'alumni', 'passqrst', 'HKCC');

INSERT INTO Attendee (AttendeeID, FName, LName, PhoneNumber, Address, AttendeeType, Password, AffiliatedOrg) VALUES 
('sophia.miller@example.com', 'Sophia', 'Miller', '78901234', '246 Spruce St, Sham Shui Po', 'guest', 'passuvwx', 'Others');

INSERT INTO Attendee (AttendeeID, FName, LName, PhoneNumber, Address, AttendeeType, Password, AffiliatedOrg) VALUES 
('mia.davis@example.com', 'Mia', 'Davis', '89012345', '357 Willow St, Yau Ma Tei', 'student', 'passyz12', 'PolyU');

INSERT INTO Attendee (AttendeeID, FName, LName, PhoneNumber, Address, AttendeeType, Password, AffiliatedOrg) VALUES 
('liam.thompson@example.com', 'Liam', 'Thompson', '90123456', '468 Fir St, Wong Tai Sin', 'staff', 'pass3456', 'SPEED');

INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, BIN) VALUES
('Vegetable Samosas', 'Vegetarian', 120, 'Mint Chutney', 1);

INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, BIN) VALUES
('Pork Belly Bao', 'Pork', 150, 'Hoisin Sauce', 2);

INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, BIN) VALUES
('Lamb Chops', 'Lamb', 280, 'Mint Sauce', 3);

INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, BIN) VALUES
('Seafood Paella', 'Seafood', 230, 'Saffron', 4);

INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, BIN) VALUES
('Stuffed Bell Peppers', 'Vegetarian', 140, 'Rice and Beans', 5);

INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, BIN) VALUES
('Duck Confit', 'Poultry', 300, 'Garlic Mashed Potatoes', 6);

INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, BIN) VALUES
('Grilled Octopus', 'Seafood', 220, 'Chili Oil', 7);

INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, BIN) VALUES
('Spinach and Ricotta Ravioli', 'Vegetarian', 160, 'Tomato Sauce', 8);

INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, BIN) VALUES
('Lobster Roll', 'Seafood', 250, 'Lemon Butter', 9);

INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, BIN) VALUES
('Chili Lime Shrimp Tacos', 'Seafood', 190, 'Avocado Sauce', 10);


INSERT INTO Register (AttendeeID, BIN, DrinkChoice, MealChoice, Remarks) VALUES
('john.doe@example.com', 1, 'Wine', 'Grilled Salmon', 'Gluten-free');

INSERT INTO Register (AttendeeID, BIN, DrinkChoice, MealChoice, Remarks) VALUES
('jane.smith@example.com', 2, 'Beer', 'Baked Cod', 'Lactose-free');

INSERT INTO Register (AttendeeID, BIN, DrinkChoice, MealChoice, Remarks) VALUES
('alice.jones@example.com', 3, 'Juice', 'Seared Tuna', 'Low-sodium');

INSERT INTO Register (AttendeeID, BIN, DrinkChoice, MealChoice, Remarks) VALUES
('bob.brown@example.com', 4, 'Water', 'Pan-Seared Halibut', 'No fried');

INSERT INTO Register (AttendeeID, BIN, DrinkChoice, MealChoice, Remarks) VALUES
('charlie.white@example.com', 5, 'Cocktail', 'Blackened Catfish', 'Spicy');

INSERT INTO Register (AttendeeID, BIN, DrinkChoice, MealChoice, Remarks) VALUES
('emma.green@example.com', 6, 'Soda', 'Sushi Platter', 'Soy-free');

INSERT INTO Register (AttendeeID, BIN, DrinkChoice, MealChoice, Remarks) VALUES
('david.black@example.com', 7, 'Tea', 'Fish Tacos', 'Dairy-free');

INSERT INTO Register (AttendeeID, BIN, DrinkChoice, MealChoice, Remarks) VALUES
('sophia.miller@example.com', 8, 'Wine', 'Grilled Swordfish', 'Gluten-free');

INSERT INTO Register (AttendeeID, BIN, DrinkChoice, MealChoice, Remarks) VALUES
('mia.davis@example.com', 9, 'Coffee', 'Tuna Poke Bowl', 'Low-fat');

INSERT INTO Register (AttendeeID, BIN, DrinkChoice, MealChoice, Remarks) VALUES
('liam.thompson@example.com', 10, 'Water', 'Smoked Trout', 'No dairy');


COMMIT;