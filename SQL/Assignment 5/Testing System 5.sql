DROP DATABASE IF EXISTS Testing_System_Assignment5;
CREATE DATABASE Testing_System_Assignment5;
USE Testing_System_Assignment5;
COMMIT;
-- 1
CREATE TABLE Department(
             DepartmentID    INT UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
             DepartmentName  VARCHAR(50) NOT NULL); -- VD SALE,MARKETING  );
    -- 2         
CREATE TABLE `Position`(
             PositionID      INT UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
             PositionName    ENUM ('Dev','Test','Scrum Master','PM') );
-- 3
CREATE TABLE `Account` (
             AccountID       INT UNSIGNED AUTO_INCREMENT PRIMARY KEY , 
             Email           VARCHAR(100) NOT NULL UNIQUE KEY ,
             Username        VARCHAR(100) NOT NULL ,
             FullName        VARCHAR(100) NOT NULL ,
             DepartmentID    INT UNSIGNED ,
             PositionID      INT UNSIGNED DEFAULT (1) ,
             CreateDate      DATETIME DEFAULT NOW() ,
             FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID) ,
             FOREIGN KEY (PositionID) REFERENCES `Position`(PositionID) );
     -- 4        
CREATE TABLE `Group` (
			 GroupID         SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
             GroupName       VARCHAR(50) NOT NULL ,
             CreatorID       INT UNSIGNED NOT NULL ,
             CreateDate      DATETIME DEFAULT NOW() ,
             FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID) );
			
  -- 5           
CREATE TABLE GroupAccount (
             GroupID         SMALLINT UNSIGNED ,
             AccountID       INT UNSIGNED ,
             JoinDate        DATETIME DEFAULT NOW() ,
             PRIMARY KEY (GroupID,AccountID) ,
             FOREIGN KEY (GroupID) REFERENCES `Group`(GroupID) ,
             FOREIGN KEY (AccountID) REFERENCES `Account`(AccountID) );
			
   -- 6          
CREATE TABLE TypeQuestion (
			 TypeID          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
             TypeName        ENUM('Essay','Multiple-Choice') NOT NULL );
             
             -- 7
CREATE TABLE CategoryQuestion (  
             CategoryID      MIDDLEINT UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
             CategoryName    VARCHAR(100) NOT NULL ); -- (Java, .NET, SQL, Postman, Ruby,...)
  -- 8
CREATE TABLE Question (
             QuestionID      INT UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
             Content         VARCHAR(50) NOT NULL ,
             CategoryID      MIDDLEINT UNSIGNED ,
             TypeID          INT UNSIGNED ,
             CreatorID       INT UNSIGNED ,
             CreateDate      DATETIME DEFAULT NOW() ,
             FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID) ,
             FOREIGN KEY (TypeID) REFERENCES TypeQuestion(TypeID) ,
             FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID) );
             
       -- 9
CREATE TABLE Answer (
             AnswerID        INT UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
             Content         VARCHAR(50) NOT NULL ,
             QuestionID      INT UNSIGNED ,
             isCorrect       BIT ,
             FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)  );
           -- 10  
CREATE TABLE Exam (
             ExamID          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
             `Code`          VARCHAR(50) NOT NULL UNIQUE KEY ,
             Title           VARCHAR(50) NOT NULL ,
             CategoryID      MIDDLEINT UNSIGNED ,
             Duration        INT UNSIGNED NOT NULL ,
             CreatorID       INT UNSIGNED NOT NULL ,
             CreateDate      DATETIME DEFAULT NOW() ,
             FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID) ,
             FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID) );
             
             -- 11
CREATE TABLE ExamQuestion (
			 ExamID          INT UNSIGNED ,
             QuestionID      INT UNSIGNED ,
             PRIMARY KEY (ExamID,QuestionID) );
             
 -- CHÈN DỮ LIỆU VÀO DATABASE VỚI CÁI TABLE
INSERT INTO  Department (Departmentid, DepartmentName )
VALUES                 (  1,              'SALE' ) ,
                        (  2,             'MARKETING' ) ,
                        (  3,            'TỔ TRƯỞNG' ) ,
                        (  4,              'GIÁM ĐỐC' ) ,
                        (  5,                'THƯ KÝ' ) ,
                        (   6,               'PHÓ PHÒNG' ) ,
                        (    7,          'TRƯỞNG BAN' ) ,
                        (   8,             'BẢO VỆ' ) ,
                        (   9,             'KẾ TOÁN' ) ,
                        (   10,              'ĐIỀU PHỐI' ) ;
                        -- 2
INSERT INTO `Position` (  PositionName )
VALUES                 (  'Dev' ) ,  
                       (  'Test' ) ,  
                       (  'Test' ) ,  
                       (  'PM' ) ,  
                       (  'PM' ) ,  
                       (  'Scrum Master' ) ,  
                       (  'Scrum Master' ) ,  
                       (  'Dev' ) ,  
                       (  'Test' ) ,  
                       (  'Scrum Master' ) ;  
                       -- 3
INSERT INTO  `Account` ( Email,             Username,     FullName,     DepartmentID,  PositionID,   CreateDate )
VALUES			       ( 'VTI1@Gmail.com',     'A',    'Nguyễn Văn Anh',        10,          10,          now() ),
					   ( 'VTI2@Gmail.com',     'B',    'Nguyễn Văn Bá',          8,          10,           now() ),
					   ( 'VTI3@Gmail.com',     'C',    'Nguyễn Văn Cầu',         1,           1,           now() ),
                       ( 'VTI5@Gmail.com',     'p',    'Nguyễn Văn Phùng',       3,          1,           now() ),
                       ( 'VTI6@Gmail.com',     'T',    'NGUYỄN DO DO',         10,          10,          now() ),
                       ( 'VTI7@Gmail.com',     'Q',    'DO Văn Quang',          2,          10,          now() ),
                       ( 'VTI8@Gmail.com',     'H',    'Nguyễn Văn Hường',       10,          10,          now() ),
                       ( 'VTI9@Gmail.com',     'K',    'Nguyễn Văn Khương',      3,          10,          now() ),
                       ( 'VTI10@Gmail.com',    'N',    'Nguyễn Văn Nam',         10,          10,          now() );
                       -- 4
INSERT INTO `Group` (  GroupName,   CreatorID,    CreateDate )                     
VALUES              ( 'NHÓM 1' ,      1   ,   '2021-12-30'),
					( 'NHÓM 2' ,      3   ,   '2018-01-03' ),
                    ( 'NHÓM 3' ,      3   ,   now() ),
                    ( 'NHÓM 4' ,      2   ,   now() ),
                    ( 'NHÓM 5' ,      4   ,   now() ),
                    ( 'NHÓM 6' ,      5   ,   now() ),
                    ( 'NHÓM 7' ,      4   ,   now() ),
                    ( 'NHÓM 8' ,      2   ,   now() ),
                    ( 'NHÓM 9' ,      5   ,   now() ),
                    ( 'NHÓM 10' ,     1   ,   now() );
                    -- 5
INSERT INTO GroupAccount ( GroupID,  AccountID,  JoinDate )
VALUES					 (   1,    2,   NOW() ),
                         (   1,    3,   NOW() ),
                         (   1,    4,   NOW() ),
                         (   1,    5,   NOW() ),
                         (   1,    6,   NOW() ),
                         (   1,    7,   NOW() ),
                         (   1,    8,   NOW() ),
                         (   8,    2,   NOW() ),
                         (   1,    9,   NOW() ),
                         (   9,    2,   NOW() );
                         -- 6
INSERT INTO TypeQuestion ( TypeName )
VALUES                 ( 'Essay' ),
                       ( 'Essay' ), 
                       ( 'Essay' ), 
                       ( 'Multiple-Choice' ), 
                       ( 'Multiple-Choice' ), 
                       ( 'Multiple-Choice' ), 
                       ( 'Essay' ), 
                       ( 'Essay' ), 
                       ( 'Multiple-Choice' ), 
                       ( 'Multiple-Choice' );
                       -- 7
INSERT INTO CategoryQuestion ( CategoryName )
VALUES                       ( ' Java ' ) ,
                             ( ' Java ' ) ,
                             ( ' Java ' ) ,
                             ( ' Java ' ) ,
                             ( ' Java ' ) ,
                             ( ' Java ' ) ,
                             ( ' Java ' ) ,
                             ( ' Java ' ) ,
                             ( ' Java ' ) ,
                             ( ' Java ' ) ;
					-- 8
INSERT INTO  Question ( Content,   CategoryID,  TypeID, CreatorID,   CreateDate )                            
VALUES                ( 'CÂU HỎI',    1,      	   1,        1,        	NULL ),                              
                      ( 'CÂU HỎI',    1,      	   1,        1,        	NULL ),                              
                      ( 'CÂU HỎI',    1,      	   1,        1,        	NULL ),                              
                      ( 'CÂU HỎI',    1,      	   1,        1,        	NULL ),                              
                      ( 'CÂU HỎI',    1,      	   1,        1,        	NULL ),                              
                      ( 'CÂU HỎI',    1,      	   1,        1,        	NULL ),                              
                      ( 'CÂU HỎI',    1,      	   1,        1,        	NULL),                              
                      ( 'CÂU HỎI',    1,      	   1,        1,        	NULL ),                              
                      ( 'CÂU HỎI',    1,      	   1,        1,        	NULL ),                              
                      ( 'CÂU H',    1,      	   1,        1,        	NULL );                              
                      -- 9
INSERT INTO  Answer ( Content,  QuestionID, isCorrect )
VALUES              ( 'CÂU TL',    1,          0 ),
				    ( 'CÂU TL',    1,          1 ),  
                    ( 'CÂU TL',    2,          0 ),  
                    ( 'CÂU TL',    1,          1 ),  
                    ( 'CÂU TL',    3,          0 ),  
                    ( 'CÂU TL',    3,          0 ),  
                    ( 'CÂU TL',    3,          0 ),  
                    ( 'CÂU TL',    3,          0 ),  
                    ( 'CÂU TL',    3,          0 ),  
                    ( 'CÂU TL',    1,          0 );
                    -- 10
INSERT INTO Exam ( `Code`,  Title,   CategoryID,  Duration,  CreatorID,  CreateDate )
VALUES           ( 'N1',   'ASDA',  1,              60,      1,    NOW() ),
                 ( 'N2',   'ASDA',  1,              60,      1,    NOW() ),
                 ( 'N3',   'ASDA',  1,              60,      1,    NOW() ),
                 ( 'N4',   'ASDA',  1,              60,      1,    '2018-12-20' ),
                 ( 'N5',   'ASDA',  1,              60,      1,    NOW() ),
                 ( 'N6',   'ASDA',  1,              60,      1,    NOW() ),
                 ( 'N7',   'ASDA',  1,              60,      1,    NOW() ),
                 ( 'N8',   'ASDA',  1,              60,      1,    NOW() ),
                 ( 'N9',   'ASDA',  1,              60,      1,    NOW() ),
                 ( 'N10',   'ASDA',  1,             60,      1,    NOW() );
                 -- 11
INSERT INTO ExamQuestion (ExamID, QuestionID )
VALUES                   ( 1,1),   
                          ( 2,1),
                          ( 3,1), 
                          ( 4,1), 
                          ( 5,1), 
                          ( 6,1), 
                          ( 7,1), 
                          ( 8,1), 
                          ( 9,1), 
                          ( 1,9);            
 
-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
-- SD VIEW
CREATE OR REPLACE VIEW vw_DSNV_Sale AS
SELECT A.*, D.DepartmentName
FROM `account` A
INNER JOIN department D ON A.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Sale';
SELECT * FROM vw_DSNV_Sale ;

-- CTE
WITH DSNV_Sale AS(
SELECT A.*, D.DepartmentName
FROM account A
INNER JOIN department D ON A.DepartmentID = D.DepartmentID
WHERE D.DepartmentName LIKE 'Sale'
)
SELECT *
FROM DSNV_Sale ;

-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất

CREATE OR REPLACE VIEW vw_GetAccount AS
WITH CTE_GetListCountAccount AS ( SELECT COUNT(GA1.AccountID) AS countGA1 FROM groupaccount GA1
GROUP BY GA1.AccountID )

SELECT A.AccountID, A.Username, count(GA.AccountID) AS SL FROM groupaccount GA
INNER JOIN `Account` A ON GA.AccountID = A.AccountID
GROUP BY GA.AccountID
HAVING COUNT(GA.AccountID) = (
SELECT MAX(countGA1) AS maxCount FROM CTE_GetListCountAccount
);
SELECT * FROM vw_GetAccount ;            

             
             
             
			
             
             
             
		