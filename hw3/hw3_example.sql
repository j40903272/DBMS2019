/***** create and use database *****/
CREATE DATABASE MovieDB;
USE MovieDB;

/***** info *****/
CREATE TABLE self (
    StuID varchar(10) NOT NULL,
    Department varchar(10) NOT NULL,
    SchoolYear int DEFAULT 1,
    Name varchar(10) NOT NULL,
    PRIMARY KEY (StuID)
);

INSERT INTO self
VALUES ('r07000000', '電機所', 1, '大中天');

SELECT DATABASE();
SELECT * FROM self;



/***** table creation and insertion *****/
CREATE TABLE Users (
    UserID int,
    UserName varchar(40),
    FirstName varchar(40),
    PRIMARY KEY (UserID)
);

INSERT INTO Users
VALUES 
('1', 'Snoopy', 'Dog'),
('2', 'Sumikko', 'Gurashi');

/***** homework 3 commands *****/

/* basic select */
/* basic projection */
/* basic rename */
/* union */
/* equijoin */
/* natural join */
/* theta join */
/* three table join */
/* aggregate */
/* aggregate 2 */
/* in */
/* in 2 */
/* correlated nested query */
/* correlated nested query 2 */
/* bonus 1 */
/* bonus 2 */
/* bonus 3 */
/* bonus 4 */

/***** drop database *****/
DROP DATABASE MovieDB;
