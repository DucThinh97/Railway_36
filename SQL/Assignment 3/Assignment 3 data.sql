DROP DATABASE IF EXISTS Testing_System_Assignment_3;
CREATE DATABASE IF NOT  EXISTS Testing_System_Assignment_3;
USE Testing_System_Assignment_3;

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
 VALUES               (             N'Sale'         ),
                      (             N'Bảo vệ'       ),
                      (             N'nhân viên'    ),
                      (             N'thư ký'       ),
					  (             N'nhân sự'      ),    
                      (             N'lao công'     ),
					  (             N'kế toán'      ), 
					  (             N'trưởng phòng' ),
				      (             N'phó phòng'    ),
					  (             N'marketing'    ); 



   -- TABLE 2                   
 INSERT INTO    Positions(PositionName)
 VALUES               (             'DEV'          ),
					  (             'TEST'         ),
                      (             'Scrum'        ),
                      (             'PM'           ),
                      (             'PM'           ),
                      (             'TEST'         ),
					  (             'DEV'          ),
                      (             'DEV'          ),
                      (             'Scrum'        ),
                      (             'Scrum'        );
					

    -- TABLE 3                  
 INSERT INTO `Account`     (Email,            Username,           fullname,       DepartmentID,       PositionID,     CreateDate)
 VALUES               ( 'NMQ@gmail.com',   'Nguyen Manh Quan',     'NMQ',             1,                  1,             now()       ),
				      ( 'TVH@gmail.com',   'Tran Van Hanh',         'B',             1,                  2,             now()       ),
                      ( 'DMT@gmail.com',   'Dong Manh Tien',        'DMT',             3,                  3,             now()       ),
				      ( 'NTM@gmail.com',   'Nguyen Tien Manh',      'D',             4,                  4,             now()       ),
                      ( 'TRM@gmail.com',   'Tran Van Nam',          'TVN',             4,                  4,             now()       ),
					  ( 'TPN@gmail.com',   'Tran Phuong Nam',       'TPN',             3,                  4,             now()       ),
                      ( 'DT@gmail.com',   'Dong Duc Thinh',         'T',             3,                  3,             now()       ),
                      ( 'Duc@gmail.com',   'Tran Van Duc',          'D',             3,                  4,             now()       ),
                      ( 'Thao@gmail.com',   'Ngo Phuong Thao',      'T',             3,                  4,             now()       ),
                      ( 'TPD@gmail.com',   'Tran Phuong Dong',      'D',             2,                  4,             now()       );
                    
                      
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
							( 1,                   3,                   NOW() ),
							( 2,                   1,                   NOW() ),
							( 1,                   1,                   NOW() ),
							( 2,                   2,                   NOW() ),
							( 3,                   3,                   NOW() ),
							( 4,                   4,                   NOW() );
						
    -- TABLE 6                        
 INSERT INTO TypeQuetion (   TypeID,        TypeName)
 VALUES                    (    1,            'Essay' ),
						   (    2,             'Essay' ),
						   (    3,             'Multiple-Choice' ),
                           (    4,             'Multiple-Choice' ),
                           (    5,            'Essay' ),
                           (    6,            'Multiple-Choice' ),
                           (    7,            'Multiple-Choice' ),
                           (    8,            'Essay' ),
                           (    9,            'Essay' ),
                           (   10,            'Multiple-Choice' );
                           
  -- TABLE 7                         
 INSERT INTO  CategoryQuestion(   CategoryID,              CategoryName )
 VALUES                        (       1,                   'Java'      ),
                               (       2,                   '.NET'      ),
							   (       3,                   ' SQL'      ),
							   (       4,                   'Postman'   ),
                               (       5,                   'Ruby'      ),
                               (       6,                   'MEN'       ),
                               (       7,                   'DONG'      ),
                               (       8,                   'KIM CUONG' ),
                               (       9,                   'VANG'      ),
                               (      10,                   'SAT'       );
-- TABLE 8
INSERT INTO    Question     (  QuestionID,         Content,          CategoryID,      TypeID,      CreatorID,      CreateDate)
VALUES                      (     1,            'Đang làm gì',           2,              1,            1,         '2021/01/30' ),
							(     2,            'Đi chơi ko',            2,              2,            2,         '2021/02/11' ),
							(     3,            'Chơi game ko',          4,              2,            3,         '2021/03/28' ),
							(     4,            'Đi ăn đi',              1,              4,            4,         '2021/04/27' ),
							(     5,            'Còn sống ko',           3,              4,            4,         '2021/05/26' ),
							(     6,            'Ổn chứ',                3,              4,            4,         '2021/06/25' ),
							(     7,            'Đá bóng ko',            1,              4,            4,         '2021/07/24' ),
							(     8,            'Cầu lông ko',           1,              4,            4,         '2021/08/23' ),
							(     9,            'Bóng bàn ko',           4,              4,            4,         '2021/09/21' ),
							(    10,            'Chạy bộ ko',            4,              4,            4,         '2021/10/30' );
-- TABLE 9
INSERT INTO Answer          (     AnswerID,            Content,       QuestionID,      isCorrect)
VALUES                      (          1,          'Tôi xong rồi',         1,             TRUE  ),
                            (          2,          'Tôi đang chơi',        1,             FALSE ),
							(          3,          'Tôi ăn rồi',           2,             TRUE  ),
                            (          4,          'Tôi đang xuống',       3,             FALSE ),
                            (          5,          'Tôi đang bơi',         4,             TRUE  ),
                            (          6,          'Tôi đang bay',         4,             FALSE ),
                            (          7,          'Tôi đang làm',         5,             TRUE  ),
                            (          8,          'Tôi đang đi',          6,             FALSE ),
                            (          9,          'Tôi đang làm việc',    7,             TRUE  ),
                            (         10,          'Tôi đang chạy',        9,             FALSE );
                            
 -- TABLE 10 
INSERT INTO		Exam(  ExamID,       `code` ,       Title,      CategoryID,	   Duration,     CreatorID,       CreateDate   )
VALUES              (   1,           'SQL1',      'Title',          1,             90,            3,          '2021/12/01' ),
					(   2,           'MYsql',     'Title',          1,             90,            2,          '2021/11/22' ),
					(   3,           'java',      'string',         3,            180,            1,          '2021/12/22' ),
                    (   4,           'javar',     'string2',        4,            180,            2,          '2021/11/23' ),
                    (   5,           'javas',     'string3',        5,            180,            3,          '2021/03/29' ),
                    (   6,           'Mysql1',    'string4',        3,            180,            4,          '2021/03/21' ),
                    (   7,           'Mysql2',    'string5',        7,            180,            6,          '2021/05/30' ),
                    (   8,           'Mysql3',    'string6',        9,            180,            2,          '2021/06/30' ),
                    (   9,           'Mysql4',    'string7',        1,            180,            3,          '2021/07/21' ),
                    (  10,           'Mysql5',    'string8',        2,            180,            3,          '2021/08/11' );
					
                    
-- TABLE 11
INSERT INTO ExamQuestion( ExamID,       QuestionID)
VALUES                  (   1,              1),
						(   2,              1),
						(   3,              1),
						(   2,              2),
                        (   3,              4),
                        (   3,              2),
                        (   2,              3),
                        (   3,              3),
                        (   1,              3),
                        (   4,              3);