DROP DATABASE IF EXISTS Testing_System_Assignment_3;
CREATE DATABASE IF NOT  EXISTS Testing_System_Assignment_3;
USE Testing_System_Assignment_3;
COMMIT;

-- table 1
DROP TABLE IF EXISTS Department;
CREATE TABLE Department(
DepartmentID     INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
DepartmentName   VARCHAR(100) NOT NULL
);
-- table 2
DROP TABLE IF EXISTS `Position`;
CREATE TABLE `Position` (
PositionID       SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
PositionName     ENUM('Dev','Test','Scrum','PM')
);

-- table 3
DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account`(
AccountID        TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Email            VARCHAR(50) NOT NULL UNIQUE KEY,
Username         VARCHAR(50) NOT NULL UNIQUE KEY,
Fullname         VARCHAR(50) NOT NULL,
DepartmentID     INT UNSIGNED,
PositionID       SMALLINT UNSIGNED,
CreateDate       DATETIME DEFAULT NOW(),
FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
FOREIGN KEY (PositionID) REFERENCES `Position` (PositionID)
);

-- table 4
DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group`(
GroupID          SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
GroupName        VARCHAR(100) NOT NULL UNIQUE KEY,
CreatorID        TINYINT UNSIGNED,
CreateDate       DATETIME,
FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);

-- table 5
DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE  GroupAccount(
GroupID          SMALLINT  UNSIGNED,
AccountID        TINYINT UNSIGNED,
JoinDATE         DATETIME DEFAULT NOW(),
PRIMARY KEY (GroupID,AccountID),
FOREIGN KEY (GroupID) REFERENCES `Group`(GroupID),
FOREIGN KEY (AccountID) REFERENCES `Account`(AccountID)
);

-- TABLE 6
DROP TABLE IF EXISTS TypeQuetion;
CREATE TABLE TypeQuetion(
TypeID            SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
TypeName          ENUM('Essay', 'Multiple-Choice')
);

-- TABLE 7
DROP TABLE IF EXISTS CategoryQuestion;
CREATE TABLE CategoryQuestion(
CategoryID        TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
CategoryName      VARCHAR(100)  -- cac gia tri ('Java', '.NET', 'SQL', 'Postman', 'Ruby',...')
);

-- TABLE 8
DROP TABLE IF EXISTS Question;
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
DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer(
 AnswerID         SMALLINT,
 Content          VARCHAR(50) NOT NULL,
 QuestionID       SMALLINT UNSIGNED,
 FOREIGN KEY (QuestionID) REFERENCES Question (QuestionID),
 isCorrect        BIT
 );
 
 -- TABLE 10
 DROP TABLE IF EXISTS Exam;
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
 DROP TABLE IF EXISTS ExamQuestion;
 CREATE TABLE ExamQuestion(
 ExamID           SMALLINT UNSIGNED,
 QuestionID       SMALLINT UNSIGNED,
 PRIMARY KEY(ExamID,QuestionID),
 FOREIGN KEY(ExamID) REFERENCES Exam(ExamID) ON DELETE CASCADE,
 FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID)
 );
  -- TABLE 1
 INSERT INTO Department(Departmentname)
 VALUES               (             N'Sale'         ),
                      (             N'B???o v???'       ),
                      (             N'nh??n vi??n'    ),
                      (             N'th?? k??'       ),
					  (             N'nh??n s???'      ),    
                      (             N'lao c??ng'     ),
					  (             N'k??? to??n'      ), 
					  (             N'tr?????ng ph??ng' ),
				      (             N'ph?? ph??ng'    ),
					  (             N'marketing'    ); 



   -- TABLE 2                   
 INSERT INTO    `Position`(PositionName)
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
 INSERT INTO `Account`     (Email,           Fullname,            Username,       DepartmentID,       PositionID,     CreateDate)
 VALUES               ( 'NMQ@gmail.com',   'Nguyen Manh Quan',      'A',             1,                  1,             now()       ),
				      ( 'TVH@gmail.com',   'Tran Van Hanh',         'B',              1,                 2,             now()       ),
                      ( 'DMT@gmail.com',   'Dong Manh Tien',        'C',            3,                   3,             now()       ),
				      ( 'NTM@gmail.com',   'Nguyen Tien Manh',      'D',              4,                 4,             now()       ),
                      ( 'TVD@gmail.com',   'Tran Van ??o',           'E',             4,                  4,             now()       ),
					  ( 'TPN@gmail.com',   'Tran Phuong Nam',       'F',            3,                   4,             now()       ),
                      ( 'DT@gmail.com',   'Dong Duc Thinh',         'T',              5,                  3,             now()       ),
                      ( 'Duc@gmail.com',   'Tran Van Duc',          'P',              3,                  4,             now()       ),
                      ( 'Thao@gmail.com',   'Ngo Phuong Thao',      'O',              3,                  4,             now()       ),
                      ( 'TPD@gmail.com',   'Tran Phuong Dong',      'S',              2,                  4,             now()       );
                    
                      
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
                            ( 3,                   4,                   NOW() ),
							( 1,                   3,                   NOW() ),
							( 2,                   1,                   NOW() ),
							( 1,                   1,                   NOW() ),
							( 2,                   2,                   NOW() ),
							( 3,                   3,                   NOW() ),
							( 4,                   4,                   NOW() );
                            


				
    -- TABLE 6                        
 INSERT INTO TypeQuetion (   TypeID,       TypeName)
 VALUES                    (    1,         'Essay' ),
						   (    2,         'Essay' ),
						   (    3,         'Multiple-Choice' ),
                           (    4,         'Multiple-Choice' ),
                           (    5,         'Essay' ),
                           (    6,         'Multiple-Choice' ),
                           (    7,         'Multiple-Choice' ),
                           (    8,         'Essay' ),
                           (    9,         'Essay' ),
                           (   10,         'Multiple-Choice' );
                           
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
VALUES                      (     1,            '??ang l??m g??',           2,              1,            1,         '2021/01/30' ),
							(     2,            '??i ch??i ko',            2,              2,            2,         '2021/02/11' ),
							(     3,            'Ch??i game ko',          4,              2,            3,         '2021/03/28' ),
							(     4,            '??i ??n ??i',              1,              4,            4,         '2021/04/27' ),
							(     5,            'C??n s???ng ko',           3,              4,            4,         '2021/05/26' ),
							(     6,            '???n ch???',                3,              4,            4,         '2021/06/25' ),
							(     7,            '???? b??ng ko',            1,              4,            4,         '2021/07/24' ),
							(     8,            'C???u l??ng ko',           1,              4,            4,         '2021/08/23' ),
							(     9,            'B??ng b??n ko',           4,              4,            4,         '2021/09/21' ),
							(    10,            'Ch???y b??? ko',            4,              4,            4,         '2021/10/30' );
-- TABLE 9
INSERT INTO Answer          (     AnswerID,            Content,       QuestionID,      isCorrect)
VALUES                      (          1,          'T??i xong r???i',         1,             TRUE  ),
                            (          2,          'T??i ??ang ch??i',        1,             FALSE ),
							(          3,          'T??i ??n r???i',           2,             TRUE  ),
                            (          4,          'T??i ??ang xu???ng',       4,             FALSE ),
                            (          5,          'T??i ??ang b??i',         4,             TRUE  ),
                            (          6,          'T??i ??ang bay',         4,             FALSE ),
                            (          7,          'T??i ??ang l??m',         5,             TRUE  ),
                            (          8,          'T??i ??ang ??i',          4,             FALSE ),
                            (          9,          'T??i ??ang l??m vi???c',    7,             TRUE  ),
                            (         10,          'T??i ??ang ch???y',        9,             FALSE );
                            
 -- TABLE 10 
INSERT INTO		Exam(  ExamID,       `code` ,       Title,      CategoryID,	   Duration,     CreatorID,       CreateDate   )
VALUES              (   1,           'SQL1',      'Title',          1,             90,            3,          '2019/12/10' ),
					(   2,           'MYsql',     'Title',          1,             90,            2,          '2018/11/22' ),
					(   3,           'java',      'string',         3,            180,            1,          '2021/12/22' ),
                    (   4,           'javar',     'string2',        4,            180,            2,          '2021/11/23' ),
                    (   5,           'javas',     'string3',        5,            180,            3,          '2021/03/29' ),
                    (   6,           'Mysql1',    'string4',        3,            180,            4,          '2019/03/21' ),
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
                        
 -- "Testing_System_Assignment_3"
-- Question 2: l???y ra t???t c??? c??c ph??ng ban
SELECT *
FROM Testing_System_Assignment_3.Department;


-- Question 3: l???y ra id c???a ph??ng ban "Sale"
SELECT DepartmentID
FROM Testing_System_Assignment_3.Department
WHERE Departmentname = "sale";


-- Question 4: l???y ra th??ng tin account c?? full name d??i nh???t
SELECT *,Char_length(fullname)
FROM   `account` 
WHERE Char_length(fullname) = (SELECT Max(Char_length(fullname))
                                FROM   `account`) ;
                                
                                
-- Question 5: L???y ra th??ng tin account c?? full name d??i nh???t v?? thu???c ph??ng ban c?? id= 3
SELECT *,Char_length(fullname)
FROM   `account` 
WHERE  DepartmentID = 3 AND Char_length(fullname) = (SELECT Max(Char_length(fullname))
                                FROM   `account`) ;
                                
                                
-- Question 6: L???y ra t??n group ???? t???o tr?????c ng??y 20/12/2019
SELECT *
FROM `Group`
WHERE CreateDate < '2019-12-20 00:00:00';


-- Question 7: L???y ra ID c???a question c?? >= 4 c??u tr??? l???i
SELECT *
FROM answer;
SELECT QuestionID, GROUP_CONCAT(answerID SEPARATOR ' ' ) , count(QuestionID) AS SL 
FROM answer 
GROUP BY QuestionID
HAVING count(answerID) >=4;

-- Question 8: L???y ra c??c m?? ????? thi c?? th???i gian thi >= 60 ph??t v?? ???????c t???o tr?????c ng??y 20/12/2019
SELECT `Code` 
FROM Exam
WHERE Duration >= 60 AND CreateDate < '2019-12-20';


-- Question 9: L???y ra 5 group ???????c t???o g???n ????y nh???t
SELECT * 
FROM `Group`
ORDER BY CreateDate DESC 
LIMIT 5;


-- Question 10: ?????m s??? nh??n vi??n thu???c department c?? id = 2
SELECT departmentID, COUNT(AccountID) AS SL
FROM `Account`
WHERE DepartmentID = 2;


-- Question 11: L???y ra nh??n vi??n c?? t??n b???t ?????u b???ng ch??? "D" v?? k???t th??c b???ng ch??? "o"
SELECT  SUBSTRING_INDEX(FullName, ' ', -1)
FROM `Account`
WHERE (SUBSTRING_INDEX(FullName, ' ', -1)) LIKE 'D%o';


-- Question 12: X??a t???t c??? c??c exam ???????c t???o tr?????c ng??y 20/12/2019
DELETE 
FROM Exam
WHERE CreateDate < '2019-12-20';


-- Question 13: X??a t???t c??? c??c question c?? n???i dung b???t ?????u b???ng t??? "c??u h???i"                       
DELETE
FROM Answer
WHERE QuestionID IN ( SELECT QuestionID
                        FROM Question
                       WHERE Content LIKE 'c??u h???i' ) ;   
DELETE 
FROM Question
WHERE Content like 'c??u h???i' ;


-- Question 14: update th??ng tin c???a account c?? id = 5 th??nh t??n "Nguy???n B?? L???c" v?? email th??nh loc.nguyenba@vti.com.vn
UPDATE `Account`
SET    Fullname 	= 	'Nguy???n Quang Chi???n', 
	   Email 		= 	'chienquang.nguyen@adcstudio.info'
WHERE  AccountID = 5;

-- Question 15: update account c?? id = 5 s??? thu???c group c?? id = 4
UPDATE 		`GroupAccount` 
SET 		AccountID = 5 
WHERE 		GroupID = 4;                       
                        