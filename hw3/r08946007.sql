/* create and use database */
#DROP DATABASE TripDB;
CREATE DATABASE TripDB;
USE TripDB;

/* info */
CREATE TABLE self (
    StuID varchar(10) NOT NULL,
    Department varchar(10) NOT NULL,
    SchoolYear int DEFAULT 1,
    Name varchar(10) NOT NULL,
    PRIMARY KEY (StuID)
);

INSERT INTO self
VALUES ('r08946007', '資科所', 1, '蔡昀達');

SELECT DATABASE();
SELECT * FROM self;




/***** table creation and insertion *****/


CREATE TABLE Trip (
    ID int NOT NULL CHECK (ID > 0),
    Date Date NOT NULL,
    Name varchar(20) DEFAULT 'trip',
    FlightID int,
    HotelID int,
    AttractionID int,
    Attendee varchar(15),
    PRIMARY KEY (ID),
    UNIQUE (ID)
);

INSERT INTO Trip
VALUES 
('1', '2019-1-1', 'winter trip', '1', '1', '1', "Jason"),
('2', '2019-7-7', 'summer trip', '2', '2', '2', "Irene"),
('3', '2019-3-7', 'spring trip', '3', '3', '3', "Dada");





CREATE TABLE Hotel (
    ID int NOT NULL CHECK (ID > 0),
    PublicTransport bool DEFAULT false,
    Name varchar(20) NOT NULL,
    Stars ENUM("1", "2", "3", "4", "5"),
    PRIMARY KEY (ID),
    UNIQUE (ID)
);

INSERT INTO Hotel
VALUES 
('1', true , 'Citizenm hotel', '3'),
('2', true , 'Hilton hotel', '4'),
('3', true , 'Hyatt hotel', '5');





CREATE TABLE Flight (
    ID int NOT NULL CHECK (ID > 0),
    Departure TIME,
    Arrive TIME,
    Destination varchar(10),
    Airport varchar(30),
    Class ENUM ("economy", "business", "first"),
    PRIMARY KEY (ID)
);

INSERT INTO Flight
VALUES 
('1', '14:30:27', '14:40:27', 'Taiwan', 'Taoyuan International Airport', "economy"),
('2', '14:30:27', '14:40:27', 'Kyoto', 'Kansai International Airport', "business"),
('3', '14:30:29', '14:50:29', 'Finland', 'Vantaa Airport', "first");




CREATE TABLE HotelReservation (
    HotelID int NOT NULL CHECK (HotelID > 0),
    TripID int NOT NULL CHECK (TripID > 0),
    FOREIGN KEY (HotelID) REFERENCES Hotel(ID),
    FOREIGN KEY (TripID) REFERENCES Trip(ID),
    PRIMARY KEY (TripID, HotelID)
);

INSERT INTO HotelReservation
VALUES 
('1', '1'),
('2', '2'),
('3', '3');



CREATE TABLE FlightReservation (
    FlightId int NOT NULL CHECK (FlightID > 0),
    TripID int NOT NULL CHECK (TripID > 0),
    FOREIGN KEY (FlightID) REFERENCES Flight(ID),
    FOREIGN KEY (TripID) REFERENCES Trip(ID),
    PRIMARY KEY (TripID, FlightID)
);

INSERT INTO FlightReservation
VALUES 
('1', '1'),
('2', '2'),
('3', '3');





CREATE TABLE Attraction (
    ID int NOT NULL CHECK (ID > 0),
    PublicTransport bool DEFAULT false,
    Name varchar(20) NOT NULL,
    Location varchar(20),
    PRIMARY KEY (ID),
    UNIQUE (ID)
);

INSERT INTO Attraction
VALUES 
('1', true , 'sun moon lake', 'Nantou County'),
('2', true , '101', 'Taipei City'),
('3', false, 'Alishan', 'Chiayi County'),
('4', true , 'Mega City', 'Hsinchu City'),
('5', true , 'Suomenlinna', 'Helsinki');





CREATE TABLE Participant (
    Name varchar(20) NOT NULL,
    Age int CHECK (Age > 0),
    Phone varchar(10),
    company varchar(15) Not NULL,
    Weight int CHECK (Weight > 0),
    PRIMARY KEY (Name, Age)
);

INSERT INTO Participant
VALUES 
('Jason', '23', '0972169888', 'Irene', 50),
('Irene', '20', '0972169887', 'Dada', 200),
('Dada', '18', '0972169886', 'Jason', 50),
('Papa', '18', '0972169886', 'pi', 60);






CREATE TABLE Participate (
    ParticipantName varchar(15) NOT NULL,
    Age int NOT NULL CHECK (Age > 0),
    TripID int NOT NULL CHECK (TripID > 0),
    FOREIGN KEY (ParticipantName, Age) REFERENCES Participant(Name, Age),
    FOREIGN KEY (TripID) REFERENCES Trip(ID)
);

INSERT INTO Participate
VALUES 
('Jason', '23', '1'),
('Irene', '20', '2'),
('Dada', '18', '3');




CREATE TABLE Visit (
    AttractionID int NOT NULL CHECK (AttractionID > 0),
    TripID int NOT NULL CHECK (TripID > 0),
    FOREIGN KEY (AttractionID) REFERENCES Attraction(ID),
    FOREIGN KEY (TripID) REFERENCES Trip(ID),
    PRIMARY KEY (TripID, AttractionID)
);

INSERT INTO Visit
VALUES 
('1', '1'),
('2', '2'),
('3', '3');



CREATE TABLE Company (
    ParticipantName1 varchar(15) NOT NULL,
    ParticipantName2 varchar(15) NOT NULL,
    Relation ENUM ("friend", "parent", "child", "family", "colleague"),
    FOREIGN KEY (ParticipantName1) REFERENCES Participant(Name),
    FOREIGN KEY (ParticipantName2) REFERENCES Participant(Name)
);

INSERT INTO Company
VALUES 
('Jason', 'Irene', "friend"),
('Irene', 'Dada', "friend"),
('Dada', 'Jason', "family");






/***** homework 3 commands *****/

/* basic select */
SELECT * FROM Participant WHERE Name='Jason' AND Age='23' AND Phone='0972169888';
SELECT * FROM Company WHERE ParticipantName1='Jason' OR ParticipantName1='Dada';
SELECT * FROM Attraction WHERE NOT PublicTransport=true;


/* basic projection */
SELECT Departure,Arrive from Flight;
SELECT DISTINCT Departure,Arrive FROM Flight;

/* basic rename */
SELECT C.ParticipantName1 AS P1, C.ParticipantName2 AS P2, C.Relation As R 
FROM Company As C 
WHERE C.Relation="Family";

/* union */
SELECT ParticipantName1 FROM Company
UNION
SELECT TripID FROM Visit;


/* equijoin */
SELECT * FROM Participate 
JOIN Company
ON Participate.ParticipantName=Company.ParticipantName1;

/* natural join */
SELECT * FROM Visit
NATURAL JOIN Attraction;

/* theta join */
SELECT * FROM Participate 
JOIN Company
ON Participate.ParticipantName < Company.ParticipantName1;

/* three table join */
SELECT DISTINCT Name, Attendee, ParticipantName2
FROM Trip, Participate, Company
WHERE Attendee=ParticipantName1 AND Relation="Family";


/* aggregate */
SELECT COUNT(*), MAX(Weight), Min(Weight)
FROM Participant GROUP BY Age;

/* aggregate 2 */
SELECT COUNT(*), AVG(Weight), SUM(Weight)
FROM Participant GROUP BY Age;

/* in */
SELECT *
From Participant
WHERE Weight IN (50, 60);

/* in 2 */
SELECT *
From Participant
WHERE Weight IN
(SELECT Weight FROM Participant WHERE Age=18);

/* correlated nested query */
SELECT P.Name, P.Age, P.Weight
FROM Participant AS P
WHERE P.Name IN (
    SELECT ParticipantName1
    FROM Company AS C
    WHERE C.ParticipantName1=P.Name
);

/* correlated nested query 2 */
SELECT P.Name, P.Age, P.Weight
FROM Participant AS P
WHERE EXISTS (
    SELECT *
    FROM Company AS C
    WHERE C.ParticipantName1=P.Name
);

/* bonus 1 */
SELECT * FROM Participate 
LEFT JOIN Company
ON Participate.ParticipantName=Company.ParticipantName1;

/* bonus 2 */
SELECT COUNT(*), AVG(Weight), SUM(Weight)
FROM Participant GROUP BY Age
HAVING COUNT(*)>=2;

/* bonus 3 */
SELECT P.Name, P.Age, P.Weight
FROM Participant AS P
WHERE NOT EXISTS (
    SELECT *
    FROM Company AS C
    WHERE C.ParticipantName1=P.Name
);

/* bonus 4 */







/* drop database */
DROP DATABASE TripDB;

