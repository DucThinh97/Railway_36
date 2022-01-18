DROP DATABASE IF EXISTS Testing_System_Assignment_1;
CREATE DATABASE Testing_System_Assignment_1;
USE Testing_System_Assignment_1;

create table Department(
         DepartmentID int ,
         DepartmentName VARCHAR(50) 
	);
create table Position (
	PositionID int ,
	PositionName VARCHAR(50)
    );
create table Account(
    AccountID int ,
    Email VARCHAR(50) ,
    Usename VARCHAR(50) ,
    Fullname VARCHAR(50) ,
    DepartmentID int ,
    positionID int ,
    CreateDate DATE
    );
create table `Group`(
    GroupID int,
    GroupName varchar(50),
    CreatorID int,
    CreateDate date
    );
create table GroupAccount(
	GroupID int,
    AccountID int,
    JoinDATE date
    );
create table TypeQuetion(
    TypeID int,
    TypeName varchar(50)
    );
create table CategoryQuestion(
	CategoryID int,
    CategoryName varchar(50)
    );
create table Question(
    QuestionID int,
    Content int,
    Categoryid int,
    TypeID int,
    CreatorID int,
    CreateDate date
    );
create table Answer(
    AnswerID int,
    Content varchar(50),
    QuestionID varchar(50),
    isCorrect varchar(50)
    );
create table Exam(
    ExamID int,
    Code int,
    Tetle varchar(50),
    CategoryID int,
    Duration int,
    CreatorID int,
    CreateDate date
    );
create table ExamQuestion(
    ExamID int,
    QuestionID int
    );
    
    
    
