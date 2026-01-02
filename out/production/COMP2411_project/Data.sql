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
EXECUTE IMMEDIATE 'DROP TABLE BanquetMeal';
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

-- Insert into Banquet
INSERT INTO Banquet (BIN, BanquetName, FNameContactStaff, LNameContactStaff, MinAttendee, Quota, Available, DateTime, Address, Location) VALUES
    (1, 'Spring Gala', 'Alice', 'Johnson', 5, 10, 'Y', TO_TIMESTAMP('2024-05-01 19:00', 'YYYY-MM-DD HH24:MI'), '123 Blossom St', 'Hong Kong');
INSERT INTO Banquet (BIN, BanquetName, FNameContactStaff, LNameContactStaff, MinAttendee, Quota, Available, DateTime, Address, Location) VALUES
    (2, 'Summer Feast', 'Bob', 'Smith', 6, 11, 'Y', TO_TIMESTAMP('2024-06-15 18:00', 'YYYY-MM-DD HH24:MI'), '456 Sunshine Rd', 'Tai Po');
INSERT INTO Banquet (BIN, BanquetName, FNameContactStaff, LNameContactStaff, MinAttendee, Quota, Available, DateTime, Address, Location) VALUES
    (3, 'Autumn Banquet', 'Carol', 'Brown', 3, 5, 'N', TO_TIMESTAMP('2024-09-21 20:00', 'YYYY-MM-DD HH24:MI'), '789 Harvest Ave', 'Kowloon');
INSERT INTO Banquet (BIN, BanquetName, FNameContactStaff, LNameContactStaff, MinAttendee, Quota, Available, DateTime, Address, Location) VALUES
    (4, 'Winter Wonderland', 'David', 'Taylor', 2, 4, 'Y', TO_TIMESTAMP('2024-12-10 17:00', 'YYYY-MM-DD HH24:MI'), '101 Snowfall Ln', 'Central');
INSERT INTO Banquet (BIN, BanquetName, FNameContactStaff, LNameContactStaff, MinAttendee, Quota, Available, DateTime, Address, Location) VALUES
    (5, 'New Year Bash', 'Eve', 'Adams', 1, 5, 'Y', TO_TIMESTAMP('2024-12-31 21:00', 'YYYY-MM-DD HH24:MI'), '202 Countdown Sq', 'Mong Kok');
INSERT INTO Banquet (BIN, BanquetName, FNameContactStaff, LNameContactStaff, MinAttendee, Quota, Available, DateTime, Address, Location) VALUES
    (6, 'Charity Gala', 'Frank', 'Anderson', 2, 10, 'N', TO_TIMESTAMP('2024-11-22 19:30', 'YYYY-MM-DD HH24:MI'), '303 Giving Blvd', 'Wan Chai');
INSERT INTO Banquet (BIN, BanquetName, FNameContactStaff, LNameContactStaff, MinAttendee, Quota, Available, DateTime, Address, Location) VALUES
    (7, 'Tech Conference', 'Grace', 'Williams', 7, 8, 'Y', TO_TIMESTAMP('2024-08-18 13:00', 'YYYY-MM-DD HH24:MI'), '404 Innovation Rd', 'Cyberport');
INSERT INTO Banquet (BIN, BanquetName, FNameContactStaff, LNameContactStaff, MinAttendee, Quota, Available, DateTime, Address, Location) VALUES
    (8, 'Art Festival', 'Hank', 'Thompson', 1, 2, 'Y', TO_TIMESTAMP('2024-07-09 14:00', 'YYYY-MM-DD HH24:MI'), '505 Creative Dr', 'Tsim Sha Tsui');
INSERT INTO Banquet (BIN, BanquetName, FNameContactStaff, LNameContactStaff, MinAttendee, Quota, Available, DateTime, Address, Location) VALUES
    (9, 'Music Fest', 'Ivy', 'Davis', 2, 3, 'N', TO_TIMESTAMP('2024-10-05 15:00', 'YYYY-MM-DD HH24:MI'), '606 Melody Ln', 'Sai Kung');
INSERT INTO Banquet (BIN, BanquetName, FNameContactStaff, LNameContactStaff, MinAttendee, Quota, Available, DateTime, Address, Location) VALUES
    (10, 'Food Expo', 'Jack', 'Martinez', 3, 4, 'Y', TO_TIMESTAMP('2024-11-30 12:00', 'YYYY-MM-DD HH24:MI'), '707 Gourmet St', 'Sham Shui Po');

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

-- Insert into Attendee
INSERT INTO Attendee (AttendeeID, FName, LName, PhoneNumber, Address, AttendeeType, Password, AffiliatedOrg) VALUES
    ('admin@csdoor.comp.polyu.edu.hk', 'admin', 'admin', '12345678', 'Mars', 'staff', '1234', 'PolyU');
INSERT INTO Attendee (AttendeeID, FName, LName, PhoneNumber, Address, AttendeeType, Password, AffiliatedOrg) VALUES
    ('john.doe@csdoor.comp.polyu.edu.hk', 'John', 'Doe', '12345678', '123 Main St, Kowloon', 'student', 'pass1234', 'PolyU');
INSERT INTO Attendee (AttendeeID, FName, LName, PhoneNumber, Address, AttendeeType, Password, AffiliatedOrg) VALUES
    ('jane.smith@csdoor.comp.polyu.edu.hk', 'Jane', 'Smith', '87654321', '456 Elm St, Hong Kong', 'staff', 'pass5678', 'SPEED');
INSERT INTO Attendee (AttendeeID, FName, LName, PhoneNumber, Address, AttendeeType, Password, AffiliatedOrg) VALUES
    ('alice.jones@csdoor.comp.polyu.edu.hk', 'Alice', 'Jones', '23456789', '789 Pine St, Tsim Sha Tsui', 'alumni', 'passabcd', 'HKCC');
INSERT INTO Attendee (AttendeeID, FName, LName, PhoneNumber, Address, AttendeeType, Password, AffiliatedOrg) VALUES
    ('bob.brown@csdoor.comp.polyu.edu.hk', 'Bob', 'Brown', '34567890', '321 Oak St, Mong Kok', 'guest', 'passefgh', 'Others');
INSERT INTO Attendee (AttendeeID, FName, LName, PhoneNumber, Address, AttendeeType, Password, AffiliatedOrg) VALUES
    ('charlie.white@csdoor.comp.polyu.edu.hk', 'Charlie', 'White', '45678901', '654 Maple St, Wan Chai', 'student', 'passijkl', 'PolyU');
INSERT INTO Attendee (AttendeeID, FName, LName, PhoneNumber, Address, AttendeeType, Password, AffiliatedOrg) VALUES
    ('emma.green@csdoor.comp.polyu.edu.hk', 'Emma', 'Green', '56789012', '987 Cedar St, Central', 'staff', 'passmnop', 'SPEED');
INSERT INTO Attendee (AttendeeID, FName, LName, PhoneNumber, Address, AttendeeType, Password, AffiliatedOrg) VALUES
    ('david.black@csdoor.comp.polyu.edu.hk', 'David', 'Black', '67890123', '135 Birch St, Causeway Bay', 'alumni', 'passqrst', 'HKCC');
INSERT INTO Attendee (AttendeeID, FName, LName, PhoneNumber, Address, AttendeeType, Password, AffiliatedOrg) VALUES
    ('sophia.miller@csdoor.comp.polyu.edu.hk', 'Sophia', 'Miller', '78901234', '246 Spruce St, Sham Shui Po', 'guest', 'passuvwx', 'Others');
INSERT INTO Attendee (AttendeeID, FName, LName, PhoneNumber, Address, AttendeeType, Password, AffiliatedOrg) VALUES
    ('mia.davis@csdoor.comp.polyu.edu.hk', 'Mia', 'Davis', '89012345', '357 Willow St, Yau Ma Tei', 'student', 'passyz12', 'PolyU');
INSERT INTO Attendee (AttendeeID, FName, LName, PhoneNumber, Address, AttendeeType, Password, AffiliatedOrg) VALUES
    ('liam.thompson@csdoor.comp.polyu.edu.hk', 'Liam', 'Thompson', '90123456', '468 Fir St, Wong Tai Sin', 'staff', 'pass3456', 'SPEED');

CREATE TABLE Meal (
                      DishName VARCHAR(255) PRIMARY KEY,
                      Type VARCHAR(255) NOT NULL,
                      Price INT NOT NULL,
                      SpecialCuisine VARCHAR(255),
                      Bin INT NOT NULL
);

-- Insert into Meal
-- Bin 1
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Vegetable Samosas', 'Vegetarian', 120, 'Mint Chutney', 1);
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Apple Pie', 'Dessert', 100, 'Cinnamon', 1);
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Mushroom Risotto', 'Vegetarian', 150, 'Parmesan', 1);
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Beef Tacos', 'Beef', 180, 'Salsa', 1);

-- Bin 2
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Chicken Tikka', 'Chicken', 150, 'Yogurt Sauce', 2);
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Roast Chicken', 'Poultry', 200, 'Herbs', 2);
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Butter Chicken', 'Chicken', 200, 'Cream', 2);
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Spinach Lasagna', 'Vegetarian', 140, 'Ricotta', 2);

-- Bin 3
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Paneer Butter Masala', 'Vegetarian', 140, 'Cream Sauce', 3);
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Seafood Paella', 'Seafood', 230, 'Saffron', 3);
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Shrimp Alfredo', 'Seafood', 220, 'Cream Sauce', 3);
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Vegetable Stir Fry', 'Vegetarian', 130, 'Soy Sauce', 3);

-- Bin 4
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Gulab Jamun', 'Dessert', 90, 'Rose Syrup', 4);
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Beef Wellington', 'Beef', 300, 'Mushroom Duxelles', 4);
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Shepherd\'s Pie', 'Lamb', 220, 'Mashed Potatoes', 4);
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Crab Cakes', 'Seafood', 190, 'Remoulade', 4);

-- Bin 5
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Pork Belly Bao', 'Pork', 150, 'Hoisin Sauce', 5);
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Yule Log', 'Dessert', 150, 'Chocolate', 5);
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Pulled Pork Tacos', 'Pork', 160, 'Salsa', 5);
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Chocolate Mousse', 'Dessert', 140, 'Whipped Cream', 5);

-- Bin 6
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Summer Salad', 'Vegetarian', 100, 'Vinaigrette', 6);
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Pepperoni Pizza', 'Pork', 150, 'Mozzarella', 6);
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Beet Salad', 'Vegetarian', 100, 'Goat Cheese', 6);
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Chicken Caesar Wrap', 'Chicken', 130, 'Caesar Dressing', 6);

-- Bin 7
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Mango Sticky Rice', 'Dessert', 120, 'Coconut Milk', 7);
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Creme Brulee', 'Dessert', 180, 'Caramel', 7);
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Pad Thai', 'Seafood', 170, 'Peanuts', 7);
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Grilled Octopus', 'Seafood', 240, 'Lemon', 7);

-- Bin 8
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Grilled Shrimp Skewers', 'Seafood', 180, 'Garlic Butter', 8);
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Salmon Nigiri', 'Seafood', 200, 'Soy Sauce', 8);
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Pulled Pork Sandwich', 'Pork', 140, 'BBQ Sauce', 8);
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('BBQ Ribs', 'Pork', 220, 'BBQ Sauce', 8);

-- Bin 9
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Lamb Chops', 'Lamb', 280, 'Mint Sauce', 9);
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Moussaka', 'Lamb', 210, 'Béchamel', 9);
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Stuffed Bell Peppers', 'Vegetarian', 150, 'Tomato Sauce', 9);
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Roast Lamb', 'Lamb', 280, 'Rosemary', 9);

-- Bin 10
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Butternut Squash Soup', 'Vegetarian', 110, 'Thyme', 10);
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Garlic Bread', 'Vegetarian', 80, 'Garlic', 10);
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Pancakes', 'Dessert', 120, 'Maple Syrup', 10);
INSERT INTO Meal (DishName, Type, Price, SpecialCuisine, Bin) VALUES ('Tomato Soup', 'Vegetarian', 90, 'Basil', 10);

CREATE TABLE Register (
                          AttendeeID VARCHAR(255) NOT NULL,
                          BIN INT NOT NULL,
                          DrinkChoice VARCHAR(255) NOT NULL,
                          MealChoice VARCHAR(255) NOT NULL,
                          Remarks VARCHAR(255) NOT NULL,
                          FOREIGN KEY (AttendeeID) REFERENCES Attendee(AttendeeID),
                          FOREIGN KEY (BIN) REFERENCES Banquet(BIN)
);

-- Insert into Register
INSERT INTO Register (AttendeeID, BIN, DrinkChoice, MealChoice, Remarks) VALUES
    ('john.doe@csdoor.comp.polyu.edu.hk', 1, 'Water', 'Vegetable Samosas', 'No Remarks');
INSERT INTO Register (AttendeeID, BIN, DrinkChoice, MealChoice, Remarks) VALUES
    ('jane.smith@csdoor.comp.polyu.edu.hk', 1, 'Juice', 'Chicken Tikka', 'Vegetarian');
INSERT INTO Register (AttendeeID, BIN, DrinkChoice, MealChoice, Remarks) VALUES
    ('alice.jones@csdoor.comp.polyu.edu.hk', 2, 'Soda', 'Pork Belly Bao', 'Gluten-Free');
INSERT INTO Register (AttendeeID, BIN, DrinkChoice, MealChoice, Remarks) VALUES
    ('bob.brown@csdoor.comp.polyu.edu.hk', 2, 'Tea', 'Summer Salad', 'No Remarks');
INSERT INTO Register (AttendeeID, BIN, DrinkChoice, MealChoice, Remarks) VALUES
    ('charlie.white@csdoor.comp.polyu.edu.hk', 3, 'Coffee', 'Lamb Chops', 'No Remarks');
INSERT INTO Register (AttendeeID, BIN, DrinkChoice, MealChoice, Remarks) VALUES
    ('emma.green@csdoor.comp.polyu.edu.hk', 3, 'Lemonade', 'Butternut Squash Soup', 'No Dairy');
INSERT INTO Register (AttendeeID, BIN, DrinkChoice, MealChoice, Remarks) VALUES
    ('david.black@csdoor.comp.polyu.edu.hk', 4, 'Wine', 'Seafood Paella', 'No Remarks');
INSERT INTO Register (AttendeeID, BIN, DrinkChoice, MealChoice, Remarks) VALUES
    ('sophia.miller@csdoor.comp.polyu.edu.hk', 4, 'Water', 'Beef Wellington', 'Vegetarian');
INSERT INTO Register (AttendeeID, BIN, DrinkChoice, MealChoice, Remarks) VALUES
    ('mia.davis@csdoor.comp.polyu.edu.hk', 5, 'Sparkling Water', 'Duck Confit', 'No Remarks');
INSERT INTO Register (AttendeeID, BIN, DrinkChoice, MealChoice, Remarks) VALUES
    ('liam.thompson@csdoor.comp.polyu.edu.hk', 5, 'Juice', 'Caviar Blinis', 'Gluten-Free');

SELECT
    B.BIN, B.BanquetName, B.FNameContactStaff, B.LNameContactStaff,
    B.MinAttendee, B.Quota, B.Available, B.DateTime, B.Address,
    B.Location, M.DishName, M.Type, M.Price, M.SpecialCuisine
FROM
    Banquet B
LEFT JOIN
    Meal M ON B.BIN = M.BIN
ORDER BY
    B.BIN;


COMMIT;