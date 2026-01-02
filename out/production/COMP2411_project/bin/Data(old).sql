DROP TABLE Register;
DROP TABLE Meal;
DROP TABLE Banquet;
DROP TABLE Attendee;


CREATE TABLE Banquet (
    BIN INT PRIMARY KEY,
    BanquetName VARCHAR(255) NOT NULL,
    FNameContactStaff VARCHAR(100) NOT NULL,
    LNameContactStaff VARCHAR(100) NOT NULL,
    MinAttendee INT NOT NULL,
    Quota INT NOT NULL,
    Available CHAR(1) CHECK (Available in ('Y', 'N')),
    DateTime TIMESTAMP NOT NULL,
    Address VARCHAR(100) NOT NULL,
    Location VARCHAR(100) NOT NULL
);

CREATE TABLE Meal (
	DishName VARCHAR(255),
	Type VARCHAR(255) NOT NULL,
    Price INT NOT NULL,
    SpecialCuisine VARCHAR(255),
    BIN INT,
   	FOREIGN KEY (BIN) REFERENCES Banquet(BIN)
);

CREATE TABLE Attendee (
    AttendeeID VARCHAR(255) PRIMARY KEY CHECK (AttendeeID LIKE '%@%'),
   	FName VARCHAR(255) NOT NULL,
   	LName VARCHAR(255) NOT NULL,
	PhoneNumber VARCHAR(8),
    Address VARCHAR(255),
    AttendeeType VARCHAR(255) NOT NULL CHECK (AttendeeType IN ('staff', 'student', 'alumni', 'guest')),
    Password VARCHAR(10) NOT NULL,
    AffiliatedOrg VARCHAR(255) NOT NULL CHECK (AffiliatedOrg IN ('PolyU', 'SPEED', 'HKCC', 'Others'))
);


CREATE TABLE Register (
    AttendeeID VARCHAR(255),
    BIN INT, 
 	DrinkChoice VARCHAR(255),
	MealChoice VARCHAR(255),
	Remarks VARCHAR(255),
  	FOREIGN KEY (AttendeeID) REFERENCES Attendee(AttendeeID),
	FOREIGN KEY (BIN) REFERENCES Banquet(BIN)
);

INSERT INTO Banquet VALUES
(1, 'Spring Gala', 'Alice', 'Johnson', 50, 200, 'Y', TO_TIMESTAMP('2024-05-01 19:00'), '123 Blossom St', 'Hong Kong');

INSERT INTO Banquet VALUES
(2, 'Summer Feast', 'Bob', 'Smith', 60, 220, 'Y', TO_TIMESTAMP('2024-06-15 18:00'), '456 Sunshine Rd', 'Tai Po');

INSERT INTO Banquet VALUES
(3, 'Autumn Banquet', 'Carol', 'Brown', 55, 250, 'N', TO_TIMESTAMP('2024-09-21 20:00'), '789 Harvest Ave', 'Kowloon');

INSERT INTO Banquet VALUES
(4, 'Winter Wonderland', 'David', 'Taylor', 70, 300, 'Y', TO_TIMESTAMP('2024-12-10 17:00'), '101 Snowfall Ln', 'Central');

INSERT INTO Banquet VALUES
(5, 'New Year Bash', 'Eve', 'Adams', 100, 400, 'Y', TO_TIMESTAMP('2024-12-31 21:00'), '202 Countdown Sq', 'Mong Kok');

INSERT INTO Banquet VALUES
(6, 'Charity Gala', 'Frank', 'Anderson', 80, 350, 'N', TO_TIMESTAMP('2024-11-22 19:30'), '303 Giving Blvd', 'Wan Chai');

INSERT INTO Banquet VALUES
(7, 'Tech Conference', 'Grace', 'Williams', 40, 150, 'Y', TO_TIMESTAMP('2024-08-18 13:00'), '404 Innovation Rd', 'Cyberport');

INSERT INTO Banquet VALUES
(8, 'Art Festival', 'Hank', 'Thompson', 30, 120, 'Y', TO_TIMESTAMP('2024-07-09 14:00'), '505 Creative Dr', 'Tsim Sha Tsui');

INSERT INTO Banquet VALUES
(9, 'Music Fest', 'Ivy', 'Davis', 90, 500, 'N', TO_TIMESTAMP('2024-10-05 15:00'), '606 Melody Ln', 'Sai Kung');

INSERT INTO Banquet VALUES
(10, 'Food Expo', 'Jack', 'Martinez', 200, 600, 'Y', TO_TIMESTAMP('2024-11-30 12:00'), '707 Gourmet St', 'Sham Shui Po');

INSERT INTO Meal VALUES
('Sushi Platter', 'Fish', 195, 'Miso Soup');
INSERT INTO Meal VALUES
('Roast Chicken', 'Chicken', 170, 'Stuffing');
INSERT INTO Meal VALUES
('Beef Bourguignon', 'Beef', 240, 'French Onion Soup');
INSERT INTO Meal VALUES
('Veggie Burger', 'Vegetarian', 150, 'Sweet Potato Fries');
INSERT INTO Meal VALUES
('Fish Tacos', 'Fish', 180, 'Pico de Gallo');
INSERT INTO Meal VALUES
('Chicken Caesar Salad', 'Chicken', 150, 'Croutons');
INSERT INTO Meal VALUES
('Beef and Broccoli', 'Beef', 225, 'Egg Rolls');
INSERT INTO Meal VALUES
('Vegetable Soup', 'Vegetarian', 135, 'Garlic Bread');
INSERT INTO Meal VALUES
('Grilled Swordfish', 'Fish', 165, 'Artichoke Dip');
INSERT INTO Meal VALUES
('Chicken Quesadilla', 'Chicken', 145, 'Salsa');
INSERT INTO Meal VALUES
('Steak Frites', 'Beef', 215, 'Béarnaise Sauce');
INSERT INTO Meal VALUES
('Caprese Salad', 'Vegetarian', 120, 'Garlic Bread');
INSERT INTO Meal VALUES
('Tuna Poke Bowl', 'Fish', 200, 'Seaweed Salad');
INSERT INTO Meal VALUES
('Chicken Marsala', 'Chicken', 170, 'Minestrone Soup');
INSERT INTO Meal VALUES
('Beef Gyros', 'Beef', 235, 'Tzatziki');
INSERT INTO Meal VALUES
('Vegetable Paella', 'Vegetarian', 145, 'Patatas Bravas');
INSERT INTO Meal VALUES
('Smoked Trout', 'Fish', 190, 'Borscht');
INSERT INTO Meal VALUES
('Fried Chicken', 'Chicken', 160, 'Mashed Potatoes');
INSERT INTO Meal VALUES
('Beef Fajitas', 'Beef', 220, 'Refried Beans');
INSERT INTO Meal VALUES
('Tofu Stir Fry', 'Vegetarian', 140, 'Vegetable Spring Rolls');

INSERT INTO Attendee VALUES 
('john.doe@example.com', 'John', 'Doe', 12345678, '123 Main St, Kowloon', 'student', 'pass1234', 'PolyU');

INSERT INTO Attendee VALUES 
('jane.smith@example.com', 'Jane', 'Smith', 87654321, '456 Elm St, Hong Kong', 'staff', 'pass5678', 'SPEED');

INSERT INTO Attendee VALUES 
('alice.jones@example.com', 'Alice', 'Jones', 23456789, '789 Pine St, Tsim Sha Tsui', 'alumni', 'passabcd', 'HKCC');

INSERT INTO Attendee VALUES 
('bob.brown@example.com', 'Bob', 'Brown', 34567890, '321 Oak St, Mong Kok', 'guest', 'passefgh', 'Others');

INSERT INTO Attendee VALUES 
('charlie.white@example.com', 'Charlie', 'White', 45678901, '654 Maple St, Wan Chai', 'student', 'passijkl', 'PolyU');

INSERT INTO Attendee VALUES 
('emma.green@example.com', 'Emma', 'Green', 56789012, '987 Cedar St, Central', 'staff', 'passmnop', 'SPEED');

INSERT INTO Attendee VALUES 
('david.black@example.com', 'David', 'Black', 67890123, '135 Birch St, Causeway Bay', 'alumni', 'passqrst', 'HKCC');

INSERT INTO Attendee VALUES 
('sophia.miller@example.com', 'Sophia', 'Miller', 78901234, '246 Spruce St, Sham Shui Po', 'guest', 'passuvwx', 'Others');

INSERT INTO Attendee VALUES 
('mia.davis@example.com', 'Mia', 'Davis', 89012345, '357 Willow St, Yau Ma Tei', 'student', 'passyz12', 'PolyU');

INSERT INTO Attendee VALUES 
('liam.thompson@example.com', 'Liam', 'Thompson', 90123456, '468 Fir St, Wong Tai Sin', 'staff', 'pass3456', 'SPEED');

INSERT INTO Register VALUES
('john.doe@example.com', 1, 'Wine', 'Grilled Salmon', 'Gluten-free');

INSERT INTO Register VALUES
('jane.smith@example.com', 2, 'Beer', 'Baked Cod', 'Lactose-free');

INSERT INTO Register VALUES
('alice.jones@example.com', 3, 'Juice', 'Seared Tuna', 'Low-sodium');

INSERT INTO Register VALUES
('bob.brown@example.com', 4, 'Water', 'Pan-Seared Halibut', 'No fried');

INSERT INTO Register VALUES
('charlie.white@example.com', 5, 'Cocktail', 'Blackened Catfish', 'Spicy');

INSERT INTO Register VALUES
('emma.green@example.com', 6, 'Soda', 'Sushi Platter', 'Soy-free');

INSERT INTO Register VALUES
('david.black@example.com', 7, 'Tea', 'Fish Tacos', 'Dairy-free');

INSERT INTO Register VALUES
('sophia.miller@example.com', 8, 'Wine', 'Grilled Swordfish', 'Gluten-free');

INSERT INTO Register VALUES
('mia.davis@example.com', 9, 'Coffee', 'Tuna Poke Bowl', 'Low-fat');

INSERT INTO Register VALUES
('liam.thompson@example.com', 10, 'Water', 'Smoked Trout');

COMMIT;
