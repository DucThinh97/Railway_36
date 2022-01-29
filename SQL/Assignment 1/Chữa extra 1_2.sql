DROP DATABASE IF EXISTS ExtraAssignment1_2;
CREATE DATABASE IF NOT EXISTS ExtraAssignment1_2;
USE ExtraAssignment1_2;

-- Exercise 1:Design a table
CREATE TABLE Trainee (
    TraineeID        TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Full_Name        VARCHAR(50) NOT NULL,
	Birth_Date       DATE NOT NULL,
	Gender 		     ENUM('male','female','unknown') NOT NULL,
	ET_IQ 		     FLOAT  CHECK(ET_IQ >= 0 AND ET_IQ <= 20),
	ET_Gmath 	     FLOAT  CHECK(ET_Gmath BETWEEN 0 AND 20),
	ET_English 	     FLOAT  CHECK(ET_English BETWEEN 0 AND 50),
	Training_Class   VARCHAR(50) NOT NULL,
	Evaluation_Notes TEXT
);
-- Question 2: thêm trường VTI_Account với điều kiện not null & unique
-- Chú ý: chú tới tới các best practice
ALTER TABLE Trainee ADD COLUMN VTI_Account INT NOT NULL UNIQUE ;
CREATE TABLE VTI_Account ( VTI_Account INT NOT NULL UNIQUE );



-- Exercise 2: Data Types
CREATE TABLE exe2(
    ID               MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
   `Name`            VARCHAR(50) NOT NULL,
   `Code`            VARCHAR(5) UNIQUE NOT NULL,
    ModifedDate      DATETIME NOT NULL
);
-- Exercise 3: Data Types (2)
CREATE TABLE exe3(
    ID               MEDIUMINT AUTO_INCREMENT PRIMARY KEY,
   `Name`            VARCHAR(50) NOT NULL,
    Birthdate        DATE NOT NULL,
    Gender           BIT NULL, -- Lưu 0,1  NULL là mặc định
    IsDeletedFlag    BIT NOT NULL
);
