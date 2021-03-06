DROP DATABASE IF EXISTS Testing_System_Assignment_2;
CREATE DATABASE IF NOT  EXISTS Testing_System_Assignment_2;
USE Testing_System_Assignment_2;

-- table 1
CREATE TABLE Department(
DepartmentID     INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
DepartmentName   VARCHAR(100) NOT NULL
);
-- table 2
CREATE TABLE PositionS (
PositionID       SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
PositionName     ENUM('Dev','Test','Scrum','PM')
);
-- table 3
CREATE TABLE `Account`(
AccountID        TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Email            VARCHAR(50) NOT NULL UNIQUE KEY,
Username         VARCHAR(50) NOT NULL UNIQUE KEY,
Fullname         VARCHAR(50) NOT NULL,
DepartmentID     INT UNSIGNED,
PositionID       SMALLINT UNSIGNED,
CreateDate       DATETIME DEFAULT NOW(),
FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
FOREIGN KEY (PositionID) REFERENCES PositionS (PositionID)
);
-- table 4
CREATE TABLE `Group`(
GroupID          SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
GroupName        VARCHAR(100) NOT NULL UNIQUE KEY,
CreatorID        TINYINT UNSIGNED,
CreateDate       DATETIME,
FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);
-- table 5
CREATE TABLE  GroupAccount(
GroupID          SMALLINT  UNSIGNED,
AccountID        TINYINT UNSIGNED,
JoinDATE         DATETIME DEFAULT NOW(),
PRIMARY KEY (GroupID,AccountID),
FOREIGN KEY (GroupID) REFERENCES `Group`(GroupID),
FOREIGN KEY (AccountID) REFERENCES `Account`(AccountID)
);
-- TABLE 6
CREATE TABLE TypeQuetion(
TypeID            SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
TypeName          ENUM('Essay', 'Multiple-Choice')
);
-- TABLE 7
CREATE TABLE CategoryQuestion(
CategoryID        TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
CategoryName      VARCHAR(100)  -- cac gia tri ('Java', '.NET', 'SQL', 'Postman', 'Ruby',...')
);
-- TABLE 8
CREATE TABLE Question(
QuestionID        SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Content           VARCHAR(50) NOT NULL,
CategoryID        TINYINT UNSIGNED,
TypeID            SMALLINT UNSIGNED,
CreatorID         TINYINT UNSIGNED,
CreateDate        DATETIME DEFAULT NOW(),
FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion (CategoryID),
FOREIGN KEY(TypeID)  REFERENCES TypeQuetion(TypeID),
FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)
);
-- TABLE 9
CREATE TABLE Answer(
 AnswerID         SMALLINT,
 Content          VARCHAR(50) NOT NULL,
 QuestionID       SMALLINT UNSIGNED,
 FOREIGN KEY (QuestionID) REFERENCES Question (QuestionID),
 isCorrect        BIT
 );
 -- TABLE 10
 CREATE TABLE Exam(
 ExamID            SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 `code`            VARCHAR(50) NOT NULL UNIQUE KEY,
 Title             VARCHAR(50),
 CategoryID        TINYINT UNSIGNED,
 Duration          INT NOT NULL,
 CreatorID         TINYINT UNSIGNED,
 CreateDate        DATETIME DEFAULT NOW(),
 FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID),
 FOREIGN KEY (CreatorID) REFERENCES `account` (AccountID)
 );
 -- TABLE 11
 CREATE TABLE ExamQuestion(
 ExamID           SMALLINT UNSIGNED,
 QuestionID       SMALLINT UNSIGNED,
 PRIMARY KEY(ExamID,QuestionID),
 FOREIGN KEY(ExamID) REFERENCES Exam(ExamID),
 FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID)
 );
  -- TABLE 1
 INSERT INTO Department(Departmentname)
 VALUES               (             N'gi??m ?????c'     ),
                      (             N'B???o v???'       ),
                      (             N'nh??n vi??n'    ),
                      (             N'th?? k??'       ),
					  (             N'nh??n s???'      );
                      

   -- TABLE 2                   
 INSERT INTO    Positions(PositionName)
 VALUES               (             'DEV'          ),
					  (             'TEST'         ),
                      (             'Scrum'        ),
                      (             'PM'           ),
                      (             'PM'           );
                      
    -- TABLE 3                  
 INSERT INTO `Account`     (Email,            Username,           fullname,       DepartmentID,       PositionID,     CreateDate)
 VALUES               ( 'NMQ@gmail.com',   'Nguyen Manh Quan',      'A',             1,                  1,             now()       ),
				      ( 'TVH@gmail.com',   'Tran Van Hanh',         'B',             1,                  2,             now()       ),
                      ( 'DMT@gmail.com',   'Dong Manh Tien',        'C',             3,                  3,             now()       ),
				      ( 'NTM@gmail.com',   'Nguyen Tien Manh',      'D',             4,                  4,             now()       ),
                      ( 'TRM@gmail.com',   'Tran Van Nam',          'N',             4,                  4,             now()       );
					  
                    
                      
    -- TABLE 4                  
 INSERT INTO `Group`    (  GroupName,              CreatorID,            CreateDate )
 VALUES                 (  'railway1',                   1,            '2019/12/01' ),
                        (  'railway2',                   2,            '2022/01/01' ),
                        (  'railway3',                   3,            '2012/12/22' ),
						(  'railway4',                   4,            '2021/12/28' ),
						(  'railway5',                   3,            '2022/01/10' ),
                        (  'railway6',                   1,            '2021/01/11' ),
                        (  'railway7',                   1,            '2021/12/08' ),
                        (  'railway8',                   3,            '2021/11/11' ),
                        (  'railway9',                   2,            '2021/03/10' ),
                        (  'railway10',                  3,            '2021/01/10' );
                        
    -- TABLE 5                    
 INSERT INTO   GroupAccount (GroupID,          AccountID,            JoinDATE )
 VALUES                     ( 1,                   2,                   NOW() ),
                            ( 3,                   1,                   NOW() ),
                            ( 1,                   4,                   NOW() ),
                            ( 4,                   1,                   NOW() ),
							( 1,                   3,                   NOW() );
							
						
    -- TABLE 6                        
 INSERT INTO TypeQuetion (   TypeID,        TypeName)
 VALUES                    (    1,            'Essay' ),
						   (    2,             'Essay' ),
						   (    3,             'Multiple-Choice' ),
                           (    4,             'Multiple-Choice' ),
                           (    5,            'Essay' );
                           
  -- TABLE 7                         
 INSERT INTO  CategoryQuestion(   CategoryID,              CategoryName )
 VALUES                        (       1,                   'Java'      ),
                               (       2,                   '.NET'      ),
							   (       3,                   ' SQL'      ),
							   (       4,                   'Postman'   ),
                               (       5,                   'Ruby'      );
                               
-- TABLE 8
INSERT INTO    Question     (  QuestionID,         Content,          CategoryID,      TypeID,      CreatorID,      CreateDate)
VALUES                      (     1,            '??ang l??m g??',           2,              1,            1,         '2021/01/30' ),
							(     2,            '??i ch??i ko',            2,              2,            2,         '2021/02/11' ),
							(     3,            'Ch??i game ko',          4,              2,            3,         '2021/03/28' ),
							(     4,            '??i ??n ??i',              1,              4,            4,         '2021/04/27' ),
							(     5,            'C??n s???ng ko',           3,              4,            4,         '2021/05/26' );
							
-- TABLE 9
INSERT INTO Answer          (     AnswerID,            Content,       QuestionID,      isCorrect)
VALUES                      (          1,          'T??i xong r???i',         1,             TRUE  ),
                            (          2,          'T??i ??ang ch??i',        1,             FALSE ),
							(          3,          'T??i ??n r???i',           2,             TRUE  ),
                            (          4,          'T??i ??ang xu???ng',       3,             FALSE ),
                            (          5,          'T??i ??ang b??i',         4,             TRUE  );
                           
                            
 -- TABLE 10 
INSERT INTO		Exam(  ExamID,       `code` ,       Title,      CategoryID,	   Duration,     CreatorID,       CreateDate   )
VALUES              (   1,           'SQL1',      'Title',          1,             90,            3,          '2021/12/01' ),
					(   2,           'MYsql',     'Title',          1,             90,            2,          '2021/11/22' ),
					(   3,           'java',      'string',         3,            180,            1,          '2021/12/22' ),
                    (   4,           'javar',     'string2',        4,            180,            2,          '2021/11/23' ),
                    (   5,           'javas',     'string3',        5,            180,            3,          '2021/03/29' );
                    
					
-- TABLE 11
INSERT INTO ExamQuestion( ExamID,       QuestionID)
VALUES                  (   1,              1),
						(   2,              1),
						(   3,              1),
						(   2,              2),
                        (   3,              4);
