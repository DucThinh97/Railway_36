DROP DATABASE IF EXISTS Testing_System_Assignment_4;
CREATE DATABASE IF NOT  EXISTS Testing_System_Assignment_4;
USE Testing_System_Assignment_4;
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
TypeName          ENUM('Essay', 'Multiple-Choice') NOT NULL
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
 INSERT INTO Department(  Departmentname   )
 VALUES                (    'Sale'         ),
                       (    'B???o v???'       ),
                       (    'nh??n vi??n'    ),
                       (    'th?? k??'       ),
					   (    'nh??n s???'      ),    
                       (    'lao c??ng'     ),
					   (    'k??? to??n'      ), 
					   (    'tr?????ng ph??ng' ),
				       (    'ph?? ph??ng'    ),
					   (    'marketing'    ); 


   -- TABLE 2                   
 INSERT INTO    `Position`(PositionName)
 VALUES               (   'DEV'   ),
					  (   'TEST'  ),
                      (   'Scrum' ),
                      (   'PM'    ),
                      (   'PM'    ),
                      (   'TEST'  ),
					  (   'DEV'   ),
                      (   'DEV'   ),
                      (   'Scrum' ),
                      (   'Scrum' );
					
			
    -- TABLE 3                  
 INSERT INTO `Account`     (Email,           Fullname,            Username,       DepartmentID,     PositionID,     CreateDate  )
 VALUES               ( 'NMQ@gmail.com',   'Nguyen Manh Quan',      'A',              1,                 1,            '2019-12-20'  ),
				      ( 'TVH@gmail.com',   'Tran Van Hanh',         'B',              1,                 2,             now()   ),
                      ( 'DMT@gmail.com',   'Dong Manh Tien',        'C',              3,                 3,             now()   ),
				      ( 'NTM@gmail.com',   'Nguyen Tien Manh',      'D',              4,                 4,             now()   ),
                      ( 'TVD@gmail.com',   'Tran Van ??o',           'E',              4,                 4,             now()   ),
					  ( 'TPN@gmail.com',   'Tran Phuong Nam',       'F',              3,                 4,             now()   ),
                      ( 'DT@gmail.com',   'Dong Duc Thinh',         'T',              5,                 3,             now()   ),
                      ( 'Duc@gmail.com',   'Tran Van Duc',          'P',              3,                 4,             now()   ),
                      ( 'Thao@gmail.com',   'Ngo Phuong Thao',      'O',              3,                 4,             now()   ),
                      ( 'TPD@gmail.com',   'Tran Phuong Dong',      'S',              2,                 4,             now()   );
                    
                      
    -- TABLE 4                  
 INSERT INTO `Group`    (  GroupName,       CreatorID,     CreateDate )
 VALUES                 (  'railway1',          1,       '2019/12/01' ),
                        (  'railway2',          2,       '2022/01/01' ),
                        (  'railway3',          3,       '2012/12/22' ),
						(  'railway4',          4,       '2021/12/28' ),
						(  'railway5',          3,       '2022/01/10' ),
                        (  'railway6',          1,       '2021/01/11' ),
                        (  'railway7',          1,       '2021/12/08' ),
                        (  'railway8',          3,       '2021/11/11' ),
                        (  'railway9',          2,       '2021/03/10' ),
                        (  'railway10',         3,       '2021/01/10' );
                        
    -- TABLE 5                    
 INSERT INTO   GroupAccount (GroupID,     AccountID,     JoinDATE )
 VALUES                     ( 1,              2,            NOW() ),
                            ( 3,              1,            NOW() ),
                            ( 1,              4,            NOW() ),
                            ( 3,              4,            NOW() ),
							( 1,              3,            NOW() ),
							( 2,              1,            NOW() ),
							( 1,              1,            NOW() ),
							( 2,              2,            NOW() ),
							( 3,              3,            NOW() ),
							( 4,              4,            NOW() );
                            

				
    -- TABLE 6                        
 INSERT INTO TypeQuetion ( TypeID,   TypeName    )
 VALUES                  (   1, 'Essay'     ),
						 ( 2,'Multiple-Choice' );
-- Ng???n g???n
  -- TABLE 7                         
INSERT INTO  CategoryQuestion( CategoryName )
VALUES                       (    'Java'    ),
                             (   'ASP.NET'  ),
                             (   'ADO.NET'  ),
							 (     'SQL'    ),
                             (   'Postman'  ),
                             (    'Ruby'    ),
                             (   'Python'   ),
							 (     'C++'    ),
                             (   'C Sharp'  ),
							 (     'PHP'    );
-- TABLE 8
INSERT INTO    Question     (  QuestionID,        Content,          CategoryID,      TypeID,      CreatorID,      CreateDate)
VALUES                      (     1,         'C??u H???i v??? PHP',          2,             1,            1,         '2021/01/30' ),
							(     2,         'H???i v??? C#' ,              2,             2,            2,         '2021/02/11' ),
							(     3,         'H???i v??? Ruby' ,            4,             2,            3,         '2021/03/28' ),
							(     4,         'H???i v??? Postman',          1,             2,            4,         '2021/04/27' ),
							(     5,         'H???i v??? ADO.NET',          3,             2,            4,         '2021/05/26' ),
							(     6,         'H???i v??? ASP.NET',          3,             2,            4,         '2021/06/25' ),
							(     7,         'H???i v??? C++' ,             1,             2,            4,         '2021/07/24' ),
							(     8,         'H???i v??? SQL' ,             1,             2,            4,         '2021/08/23' ),
							(     9,         'H???i v??? Python' ,          4,             2,            4,         '2021/09/21' ),
							(    10,         'C??u h???i v??? Java',         4,             2,            4,         '2021/10/30' );
-- TABLE 9
INSERT INTO Answer          (     AnswerID,    Content,     QuestionID,  isCorrect)
VALUES                      (       1,        'Tr??? l???i 01',      1 ,           0),
							(		2,		  'Tr??? l???i 02' ,     1 ,           1),
							(       3,        'Tr??? l???i 03',      1 ,           0),
							(       4,        'Tr??? l???i 04',      1 ,           1),
				         	(       5,        'Tr??? l???i 05',      2 ,           1 ),
                            (       6,        'Tr??? l???i 06',      3 ,           1 ),
							(		7,		  'Tr??? l???i 07',      4 ,           0 ),
                            (       8,        'Tr??? l???i 08',      8 ,           0 ),
                            (       9,        'Tr??? l???i 09',      9 ,           1 ),
                            (      10,        'Tr??? l???i 10',      10 ,          1 );
						
 -- TABLE 10 
INSERT INTO		Exam(  ExamID,    `code` ,      Title,     CategoryID,  Duration,  CreatorID,     CreateDate )
VALUES              (     1,        'VTI1',   '????? thi C#',      1 ,       90,         '5',       '2011-04-04'),
                    (     2,        'VTI2',   '????? thi PHP',     2 ,       60,         '2',       '2019-08-05'),
                    (     3,        'VTI3',   '????? thi C++',     3 ,       90, '        2',       '2018-08-07'),
                    (     4,        'VTI4',   '????? thi Java',    4 ,       60,         '3',       '2022-01-01'),
                    (     5,        'VTI5',   '????? thi Ruby',    5 ,      120,         '4',       '2021-03-15'),
                    (     6,        'VTI6',   '????? thi Postman', 6 ,       60,         '6',       '2021-04-05'),
                    (     7,        'VTI7',   '????? thi SQL',     7 ,       60,         '7',       '2021-10-05'),
                    (     8,        'VTI8',   '????? thi Python',  8 ,      120,         '8',       '2020-05-07'),
                    (     9,        'VTI9',   '????? thi ADO.NET', 9 ,       90,         '9',       '2021-06-06'),
                    (    10,       'VTI10',   '????? thi ASP.NET', 10,       90,        '10',       '2018-08-08');
					
                    
-- TABLE 11
INSERT INTO ExamQuestion( ExamID,   QuestionID)
VALUES                  (   1,          1),
						(   2,          1),
						(   3,          1),
						(   2,          2),
                        (   3,          4),
                        (   3,          2),
                        (   2,          3),
                        (   3,          3),
                        (   1,          3),
                        (   4,          3);

-- Question 1: Vi???t l???nh ????? l???y ra danh s??ch nh??n vi??n v?? th??ng tin ph??ng ban c???a h???
SELECT A.Email, A.Username , A.FullName, D.DepartmentName
FROM `Account` A
INNER JOIN Department D ON A.DepartmentID = D.DepartmentID;

-- Question 2: Vi???t l???nh ????? l???y ra th??ng tin c??c account ???????c t???o sau ng??y 20/12/2010
SELECT *
FROM `Account`
WHERE CreateDate > '2020-12-20';

-- Question 3: Vi???t l???nh ????? l???y ra t???t c??? c??c developer
SELECT A.FullName, A.Email, P.PositionName
FROM `Account` A
INNER JOIN Position P ON A.PositionID = P.PositionID
WHERE P.PositionName = 'Dev';

-- Question 4: Vi???t l???nh ????? l???y ra danh s??ch c??c ph??ng ban c?? >3 nh??n vi??n
SELECT D.DepartmentName, count(a.DepartmentID) AS SL FROM account A
INNER JOIN department D ON a.DepartmentID = D.DepartmentID
GROUP BY A.DepartmentID
HAVING COUNT(A.DepartmentID) >3;

-- Question 5: Vi???t l???nh ????? l???y ra danh s??ch c??u h???i ???????c s??? d???ng trong ????? thi nhi???u nh???t
SELECT E.QuestionID, Q.Content FROM examquestion E
INNER JOIN question Q ON Q.QuestionID = E.QuestionID
GROUP BY E.QuestionID
HAVING count(E.QuestionID) = (SELECT MAX(countQues) as maxcountQues FROM (
SELECT COUNT(E.QuestionID) AS countQues FROM examquestion E
GROUP BY E.QuestionID) AS countTable);

-- Question 6: Th??ng k?? m???i Category Question ???????c s??? d???ng trong bao nhi??u Question ???
SELECT cq.CategoryID, cq.CategoryName, count(q.CategoryID) 
FROM categoryquestion cq
JOIN question q ON cq.CategoryID = q.CategoryID
GROUP BY q.CategoryID;

-- Question 7: Th??ng k?? m???i Question ???????c s??? d???ng trong bao nhi??u Exam
SELECT Q.Content, COUNT(EQ.QuestionID) AS SL
FROM Question Q 
LEFT JOIN ExamQuestion EQ ON EQ.QuestionID = Q.QuestionID
GROUP BY Q.QuestionID
ORDER BY EQ.ExamID ASC;

-- Question 8: L???y ra Question c?? nhi???u c??u tr??? l???i nh???t
SELECT Q.QuestionID, Q.Content, count(A.QuestionID) 
FROM answer A
INNER JOIN question Q ON Q.QuestionID = A.QuestionID
GROUP BY A.QuestionID
HAVING count(A.QuestionID) = (SELECT max(countQues) FROM (SELECT count(B.QuestionID) AS countQues FROM answer B GROUP BY B.QuestionID) AS countAnsw);

-- Question 9: Th???ng k?? s??? l?????ng account trong m???i group
SELECT G.GroupID, COUNT(GA.AccountID) AS SL
FROM GroupAccount GA
JOIN `Group` G ON GA.GroupID = G.GroupID
GROUP BY G.GroupID
ORDER BY G.GroupID ASC;

-- Question 10: T??m ch???c v??? c?? ??t ng?????i nh???t
SELECT P.PositionID, P.PositionName, count( A.PositionID) AS SL FROM account A
INNER JOIN position P ON A.PositionID = P.PositionID
GROUP BY A.PositionID
HAVING count(A.PositionID)= (SELECT MIN(minP) FROM( SELECT count(B.PositionID) AS minP FROM account B GROUP BY B.PositionID) AS minPA);

-- Question 11: Th???ng k?? m???i ph??ng ban c?? bao nhi??u dev, test, scrum master, PM
SELECT d.DepartmentID,d.DepartmentName, p.PositionName, count(p.PositionName) FROM `account` a
INNER JOIN department d ON a.DepartmentID = d.DepartmentID
INNER JOIN position p ON a.PositionID = p.PositionID
GROUP BY d.DepartmentID, p.PositionID;

-- Question 12: L???y th??ng tin chi ti???t c???a c??u h???i bao g???m: th??ng tin c?? b???n c???a question, lo???i c??u h???i, ai l?? ng?????i t???o ra c??u h???i, c??u tr??? l???i l?? g??, ...
SELECT Q.QuestionID, Q.Content, A.FullName, TQ.TypeName AS Author, ANS.Content FROM question Q
INNER JOIN categoryquestion CQ ON Q.CategoryID = CQ.CategoryID
INNER JOIN typequestion TQ ON Q.TypeID = TQ.TypeID
INNER JOIN account A ON A.AccountID = Q.CreatorID
INNER JOIN Answer AS ANS ON Q.QuestionID = ANS.QuestionID
ORDER BY Q.QuestionID ASC ;

-- Question 13: L???y ra s??? l?????ng c??u h???i c???a m???i lo???i t??? lu???n hay tr???c nghi???m
SELECT TQ.TypeID, TQ.TypeName, COUNT(Q.TypeID) AS SL FROM question Q
INNER JOIN typequestion TQ ON Q.TypeID = TQ.TypeID
GROUP BY Q.TypeID;









                       