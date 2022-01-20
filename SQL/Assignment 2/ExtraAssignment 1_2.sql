DROP DATABASE IF EXISTS ExtraAssignment1_2;
CREATE DATABASE IF NOT EXISTS ExtraAssignment1_2;
USE ExtraAssignment1_2;

-- Exercise 1:Design a table
Create table exe1(
    TraineeID        tinyint auto_increment primary key,
	Full_Name        varchar(50) not null,
	Birth_Date       date not null,
	Gender 		     enum('male','female','unknown'),
	ET_IQ 		     tinyint not null CHECK(ET_IQ >= 0 AND ET_IQ <= 20),
	ET_Gmath 	     tinyint not null CHECK(ET_Gmath BETWEEN 0 AND 20),
	ET_English 	     tinyint  null CHECK(ET_English BETWEEN 0 AND 50),
	Training_Class   varchar(50),
	Evaluation_Notes text
);
-- Exercise 2: Data Types
Create table exe2(
    ID               mediumint auto_increment primary key,
   `Name`            varchar(50),
   `Code`            varchar(5),
    ModifedDate      datetime not null
);
-- Exercise 3: Data Types (2)
Create table exe3(
    ID               mediumint auto_increment primary key
);