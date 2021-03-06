DROP DATABASE IF EXISTS Testing_System_Assignment_1;
CREATE DATABASE IF NOT  EXISTS Testing_System_Assignment_1;
USE Testing_System_Assignment_1;

create table Department(
         Department_ID int primary key,
         DepartmentName varchar(50)
	);
create table Position (
	PositionID smallint primary key,
	PositionName enum('Dev','Test','Scrum','PM')
    );
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
create table `Group`(
    GroupID smallint unsigned primary key,
    GroupName varchar(255),
    CreatorID INT unsigned,
    foreign key (CreatorID) references `account` (AccountID),
    CreateDate date
    );
create table GroupAccount(
	GroupID smallint unsigned ,
    foreign key (GroupID) references `Group` (GroupID),
    AccountID int unsigned,
    foreign key (AccountID) references `account` (AccountID),
    JoinDATE date
    );
create table TypeQuetion(
    TypeID bigint primary KEY ,
    TypeName enum('Essay, Multiple-Choice')
    );
create table CategoryQuestion(
	CategoryID tinyint primary key ,
    CategoryName enum('Java, .NET, SQL, Postman, Ruby,...')
    );
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
create table Answer(
    AnswerID smallint,
    Content varchar(50),
    QuestionID smallint,
    foreign key (QuestionID) references Question (QuestionID),
    isCorrect varchar(50)
    );
create table Exam(
    ExamID smallint,
    Code int,
    Tetle varchar(50),
    CategoryID int,
    foreign key (CategoryID) references Categogy (CategoryID),
    Duration int,
    CreatorID int,
    foreign key (CreatorID) references Creator (CreatorID),
    CreateDate date
    );
create table ExamQuestion(
    ExamID bigint,
    QuestionID int,
    foreign key (QuestionID) references Question (QuestionID)
    );
    
    
    
