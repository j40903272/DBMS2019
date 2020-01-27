/* create and use database */
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






/* create table */
CREATE TABLE Trip (
    ID int NOT NULL CHECK (ID > 0),
    Date Date NOT NULL,
    Name varchar(20) DEFAULT 'trip',
    FlightID int,
    HotelID int,
    AttractionID int,
    ParticipantName varchar(15),
    PRIMARY KEY (ID),
    UNIQUE (ID)
);
/* insert */
INSERT INTO Trip
VALUES 
('1', '2019-1-1', 'winter trip', '1', '1', '1', "Jason"),
('2', '2019-7-7', 'summer trip', '2', '2', '2', "Irene"),
('3', '2019-3-7', 'spring trip', '3', '3', '3', "Dada");
SELECT * FROM Trip;



/* create table */
CREATE TABLE Hotel (
    ID int NOT NULL CHECK (ID > 0),
    PublicTransport bool DEFAULT false,
    Name varchar(20) NOT NULL,
    Stars ENUM("1", "2", "3", "4", "5"),
    PRIMARY KEY (ID),
    UNIQUE (ID)
);
/* insert */
INSERT INTO Hotel
VALUES 
('1', true , 'Citizenm hotel', '3'),
('2', true , 'Hilton hotel', '4'),
('3', true , 'Hyatt hotel', '5');
SELECT * FROM Hotel;



/* create table */
CREATE TABLE Flight (
    ID int NOT NULL CHECK (ID > 0),
    Departure TIME,
    Arrive TIME,
    Destination varchar(10),
    Airport varchar(30),
    Class ENUM ("economy", "business", "first"),
    PRIMARY KEY (ID)
);
/* insert */
INSERT INTO Flight
VALUES 
('1', '14:30:27', '14:40:27', 'Taiwan', 'Taoyuan International Airport', "economy"),
('2', '14:30:27', '14:40:27', 'Kyoto', 'Kansai International Airport', "business"),
('3', '14:30:29', '14:50:29', 'Finland', 'Vantaa Airport', "first");
SELECT * FROM Flight;



/* create table */
CREATE TABLE HotelReservation (
    HotelID int NOT NULL CHECK (HotelID > 0),
    TripID int NOT NULL CHECK (TripID > 0),
    FOREIGN KEY (HotelID) REFERENCES Hotel(ID),
    FOREIGN KEY (TripID) REFERENCES Trip(ID),
    PRIMARY KEY (TripID, HotelID)
);
/* insert */
INSERT INTO HotelReservation
VALUES 
('1', '1'),
('2', '2'),
('3', '3');
SELECT * FROM HotelReservation;

/* create table */
CREATE TABLE FlightReservation (
    FlightId int NOT NULL CHECK (FlightID > 0),
    TripID int NOT NULL CHECK (TripID > 0),
    FOREIGN KEY (FlightID) REFERENCES Flight(ID),
    FOREIGN KEY (TripID) REFERENCES Trip(ID),
    PRIMARY KEY (TripID, FlightID)
);
/* insert */
INSERT INTO FlightReservation
VALUES 
('1', '1'),
('2', '2'),
('3', '3');
SELECT * FROM FlightReservation;




/* create table */
CREATE TABLE Attraction (
    ID int NOT NULL CHECK (ID > 0),
    PublicTransport bool DEFAULT false,
    Name varchar(20) NOT NULL,
    Location varchar(20),
    PRIMARY KEY (ID),
    UNIQUE (ID)
);
/* insert */
INSERT INTO Attraction
VALUES 
('1', true , 'sun moon lake', 'Nantou County'),
('2', true , '101', 'Taipei City'),
('3', false, 'Alishan', 'Chiayi County'),
('4', true , 'Mega City', 'Hsinchu City'),
('5', true , 'Suomenlinna', 'Helsinki');
SELECT * FROM Attraction;



/* create table */
CREATE TABLE Participant (
    Name varchar(20) NOT NULL,
    Age int CHECK (Age > 0),
    Phone varchar(10),
    company varchar(15) Not NULL,
    PRIMARY KEY (Name, age)
);
/* insert */
INSERT INTO Participant
VALUES 
('Jason', '23', '0972169888', 'Irene'),
('Irene', '20', '0972169887', 'Dada'),
('Dada', '18', '0972169886', 'Jason');
SELECT * FROM Participant;




/* create table */
CREATE TABLE Paricipate (
    ParticipantName varchar(15) NOT NULL,
    Age int NOT NULL CHECK (Age > 0),
    TripID int NOT NULL CHECK (TripID > 0),
    FOREIGN KEY (ParticipantName, Age) REFERENCES Participant(Name, Age),
    FOREIGN KEY (TripID) REFERENCES Trip(ID)
);
/* insert */
INSERT INTO Paricipate
VALUES 
('Jason', '23', '1'),
('Irene', '20', '2'),
('Dada', '18', '3');
SELECT * FROM Paricipate;


/* create table */
CREATE TABLE Visit (
    AttractionID int NOT NULL CHECK (AttractionID > 0),
    TripID int NOT NULL CHECK (TripID > 0),
    FOREIGN KEY (AttractionID) REFERENCES Attraction(ID),
    FOREIGN KEY (TripID) REFERENCES Trip(ID),
    PRIMARY KEY (TripID, AttractionID)
);
/* insert */
INSERT INTO Visit
VALUES 
('1', '1'),
('2', '2'),
('3', '3');
SELECT * FROM Visit;


/* create table */
CREATE TABLE Company (
    ParticipantName1 varchar(15) NOT NULL,
    ParticipantName2 varchar(15) NOT NULL,
    Relation ENUM ("friend", "parent", "child", "family", "colleague"),
    FOREIGN KEY (ParticipantName1) REFERENCES Participant(Name),
    FOREIGN KEY (ParticipantName2) REFERENCES Participant(Name)
);
/* insert */
INSERT INTO Company
VALUES 
('Jason', 'Irene', "friend"),
('Irene', 'Dada', "friend"),
('Dada', 'Jason', "friend");
SELECT * FROM Company;





/* drop database */
DROP DATABASE TripDB;

