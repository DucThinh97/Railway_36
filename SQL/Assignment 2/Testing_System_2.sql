DROP DATABASE IF EXISTS Testing_System_Assignment_2;
CREATE DATABASE IF NOT  EXISTS Testing_System_Assignment_2;
USE Testing_System_Assignment_2;

-- Table 1
create table Department(
         Department_ID int primary key,
         DepartmentName enum('sale','marketing')
	);
-- Table 2
create table Position (
	PositionID smallint primary key,
	PositionName enum('Dev','Test','Scrum','PM')
    );
 -- Table 3   
create table `Account`(
    AccountID int unsigned primary key,
    Email varchar(50) unique key,
    Usename tinyint unsigned,
    Fullnametiny tinyint unsigned,
    Department_ID int,
	Foreign Key (Department_ID) references Department (Department_ID),
    positionID smallint,
    Foreign Key (positionID) references position (positionID),
    CreateDate DATE
    );
-- Table 4
create table `Group`(
    GroupID smallint unsigned primary key,
    GroupName enum('nhom_1','nhom_2','nhom_3'),
    CreatorID INT unsigned,
    foreign key (CreatorID) references `account` (AccountID),
    CreateDate date
    );
-- Table 5
create table GroupAccount(
	GroupID smallint unsigned ,
    foreign key (GroupID) references `Group` (GroupID),
    AccountID int unsigned,
    foreign key (AccountID) references `account` (AccountID),
    JoinDATE date
    );
-- Table 6
create table TypeQuetion(
    TypeID bigint primary KEY ,
    TypeName enum('Essay, Multiple-Choice')
    );
-- Table 7
create table CategoryQuestion(
	CategoryID tinyint primary key,
    CategoryName enum('Java, .NET, SQL, Postman, Ruby,...')
    );
-- Table 8
create table Question(
    QuestionID smallint primary key,
    Content int,
    Categoryid tinyint,
    foreign key (Categoryid) references CategoryQuestion (Categoryid),
    TypeID bigint,
    foreign key (TypeID) references TypeQuetion (TypeID),
    CreatorID int unsigned,
    foreign key (CreatorID) references `account` (AccountID),
    CreateDate date
    );
-- Table 9
create table Answer(
    AnswerID smallint,
    Content varchar(50),
    QuestionID smallint,
    foreign key (QuestionID) references Question (QuestionID),
    isCorrect varchar(50)
    );
-- Table 10
create table Exam(
    ExamID smallint primary key,
    Code int,
    Tetle varchar(50),
    CategoryID tinyint,
    foreign key (CategoryID) references CategoryQuestion (CategoryID),
    Duration int,
    CreatorID int unsigned,
    foreign key (CreatorID) references `account` (AccountID),
    CreateDate date
    );
-- Table 11
create table ExamQuestion(
    ExamID smallint,
    foreign key (ExamID) references Exam (ExamID),
    QuestionID smallint,
    foreign key (QuestionID) references Question (QuestionID)
    );






    
    



     

    











     
     
	
     

  


