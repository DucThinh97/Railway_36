DROP DATABASE IF EXISTS Testing_System_Assignment_5;
CREATE DATABASE IF NOT  EXISTS Testing_System_Assignment_5;
USE Testing_System_Assignment_5;
COMMIT;

-- table 1
DROP TABLE IF EXISTS Department;
CREATE TABLE Department(
	DepartmentID    	 INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	DepartmentName  	 VARCHAR(100) NOT NULL
);
-- table 2
DROP TABLE IF EXISTS `Position`;
CREATE TABLE `Position` (
	PositionID      	 SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	PositionName    	 ENUM('Dev','Test','Scrum','PM')
);

-- table 3
DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account`(
	AccountID        	TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Email            	VARCHAR(50) NOT NULL UNIQUE KEY,
	Username         	VARCHAR(50) NOT NULL UNIQUE KEY,
	Fullname         	VARCHAR(50) NOT NULL,
	DepartmentID     	INT UNSIGNED,
	PositionID       	SMALLINT UNSIGNED,
	CreateDate       	DATETIME DEFAULT NOW(),
	FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
	FOREIGN KEY (PositionID) REFERENCES `Position` (PositionID)
);

-- table 4
DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group`(
	GroupID          	SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	GroupName        	VARCHAR(100) NOT NULL UNIQUE KEY,
	CreatorID        	TINYINT UNSIGNED,
	CreateDate       	DATETIME,
	FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);

-- table 5
DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE  GroupAccount(
	GroupID          	SMALLINT  UNSIGNED,
	AccountID        	TINYINT UNSIGNED,
	JoinDATE         	DATETIME DEFAULT NOW(),
	PRIMARY KEY (GroupID,AccountID),
	FOREIGN KEY (GroupID) REFERENCES `Group`(GroupID),
	FOREIGN KEY (AccountID) REFERENCES `Account`(AccountID)
);

-- TABLE 6
DROP TABLE IF EXISTS TypeQuestion;
CREATE TABLE TypeQuestion(
	TypeID            	SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	TypeName          	ENUM('Essay', 'Multiple-Choice')
);

-- TABLE 7
DROP TABLE IF EXISTS CategoryQuestion;
CREATE TABLE CategoryQuestion(
	CategoryID        	TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	CategoryName      	VARCHAR(100)  -- cac gia tri ('Java', '.NET', 'SQL', 'Postman', 'Ruby',...')
	);

-- TABLE 8
DROP TABLE IF EXISTS Question;
CREATE TABLE Question(
	QuestionID        	SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
	Content           	VARCHAR(350) NOT NULL,
	CategoryID        	TINYINT UNSIGNED,
	TypeID            	SMALLINT UNSIGNED,
	CreatorID         	TINYINT UNSIGNED,
	CreateDate        	DATETIME DEFAULT NOW(),
FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion (CategoryID),
FOREIGN KEY(TypeID)  REFERENCES TypeQuestion(TypeID),
FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)
);

-- TABLE 9
DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer(
	AnswerID         	SMALLINT,
	Content          	VARCHAR(50) NOT NULL,
	QuestionID       	SMALLINT UNSIGNED,
	FOREIGN KEY (QuestionID) REFERENCES Question (QuestionID)ON DELETE CASCADE,
	isCorrect       	BIT
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
	FOREIGN KEY(ExamID) REFERENCES Exam(ExamID)ON DELETE CASCADE,
	FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID) ON DELETE CASCADE
 );
  -- TABLE 1
 INSERT INTO Department		(DepartmentID ,	Departmentname)
 VALUES               		(  	 1,         'Sale'        ),
							(  	 2,         'Bảo vệ'      ),
							(  	 3,         'nhân viên'   ),
							(  	 4,         'thư ký'      ),
							(  	 5,         'nhân sự'     ),    
							(  	 6,         'lao công'    ),
							(  	 7,         'kế toán'     ), 
							(  	 8,         'trưởng phòng'),
							(  	 9,         'phó phòng'   ),
							(  	10,         'marketing'   ),
							(	11,			'kỹ thuật'	  ),	
							(  	12,         'No person'   ),
							(  	13,         'Bán hàng'    ),
							(  	14,         'phó giám đốc'),
							(  	15,         'tổ trưởng'	  );
                      
                      
   -- TABLE 2                   
 INSERT INTO    `Position`	(PositionID,	 PositionName)
 VALUES               		(   1,         'DEV'          ),
							(   2,         'TEST'         ),
							(   3,         'Scrum'        ),
							(   4,         'PM'           ),
							(   5,         'PM'           ),
							(   6,         'TEST'         ),
							(   7,         'DEV'          ),
							(   8,         'DEV'          ),
							(   9,         'Scrum'        ),
							(  10,         'Scrum'        ),
							(  11,         'DEV'       	  ),
                            (  12,         'DEV'          ),
					        (  13,         'Scrum'        ),
                            (  14,         'Scrum'        ),
			                (  15,         'DEV'       	  );
                            
    -- TABLE 3                   ,
 INSERT INTO `Account`		(	AccountID,		Email,          	 Fullname,          Username,       DepartmentID,     PositionID,  CreateDate		)
 VALUES               		(		 1,		 'VTI1@Gmail.com',   'NGUYEN MANH QUAN',      'QUAN',           1,                2,          now()       	),
							(		 2,		 'VTI2@Gmail.com',   'TRAN VAN HANH'	,     'HANH',           2,                2,          now()       	),
							(		 3,		 'VTI3@Gmail.com',   'DONG MANH TIEN',        'TIEN',           1,               13,        '2010-12-20'  	),
							(		 4,		 'VTI4@Gmail.com',   'NGUYEN TIEN MANH',      'MANH',           4,                4,          now()       	),
							(		 5,		 'VTI5@Gmail.com',   'TRAN VAN ĐO'	,         'ĐO',             1,                5,       	 now()      	),
							(		 6,		 'VTI6@Gmail.com',   'TRAN PHUONG NAM',       'NAM',            6,                1,          now()      	),
							(		 7,		 'VTI7gMail.com',    'DONG DUC THINH',        'THINH',          2,                8,        '2018-11-22' 	),
							(		 8,		 'VTI8@Gmail.com',   'TRAN VAN DUC'	,         'DUC',            3,                8,          now()      	),
							(		 9,		 'VTI9@Gmail.com',   'NGO PHUONG THAO',       'THAO',           3,                9,          now()      	),
							(		10,		 'VTI10@Gmail.com',  'TRAN PHUONG DONG',      'DONG',          10,               10,        '2022-01-20' 	),
							(		11,		 'VTI11@Gmail.com',   'NGUYEN BA CUONG',      'CUONG',         10,                9,          now()      	),
							(		12,		 'VTI12gMail.com',    'NGUYEN VAN AN',        'AN',            5,                 9,        '2019-10-10' 	),
							(		13,		 'VTI13@Gmail.com',   'TRAN VAN THAI',        'THAI',          10,               10,          now()     	), 
							(		14,		 'VTI14@Gmail.com',   'NGO NHU QUYNH',        'QUYNH',         14,                1,        '2015-05-16' 	),
							(		15,		 'VTI15@Gmail.com',  'TRAN PHUONG TAY',       'TAY',           10,                3,        '1996-12-20' 	);
                      
                      
                    
    -- TABLE 4                  
 INSERT INTO `Group`    	( GroupID, 		 GroupName,              CreatorID,            CreateDate )
 VALUES                 	(  	 1,			'railway1',                   1,            '2019/12/01' ),
							(  	 2,			'railway2',                   2,            '2022/01/01' ),
							(  	 3,			'railway3',                  13,            '2012/12/22' ),
							(  	 4,			'railway4',                   4,            '2017/12/28' ),
							(  	 5,			'railway5',                  13,            '2022/01/10' ),
							(  	 6,			'railway6',                   3,            '2021/01/11' ),
							(  	 7,			'railway7',                   3,           	 	NOW() 	 ),
							(  	 8,			'railway8',                   3,            '2021/11/11' ),
							(  	 9,			'railway9',                   1,            '2021/03/10' ),
							(  	10,			'railway10',                  3,            '2021/01/10' ),
							(  	11,			'railway11',                 11,            	NOW()  	 ),
							(  	12,			'railway12',                  9,            '2010/12/08' ),
							(  	13,			'railway13',                  7,            '2015/01/21' ),
							(  	14,			'railway15',                  2,            	NOW()	 ),
							(  	15,			'railway20',                  8,            '2019/02/11' );
                        
                        
    -- TABLE 5                    
 INSERT INTO   GroupAccount (GroupID,          AccountID,            JoinDATE )
 VALUES                     ( 2,                   2,                  NOW() 		),
							( 2,                  11,                  NOW() 		),
							( 1,                   1,                  NOW() 		),
							(10,                   2,                  NOW() 		),
							(11,                   5,                  NOW() 		),
							(13,                  10,                  NOW() 		),
							( 9,                  11,                  NOW() 		),
							( 7,                   6,                  NOW() 		),
							( 9,                   9,                  NOW() 		),
							(10,                   5,                  NOW() 		),
							( 8,                   5,                  NOW() 		),
							( 1,                   9,                  NOW() 		),
							( 2,                   1,                  NOW() 		),
							(10,                   9,                  NOW() 		),
							( 4,                   9,                  NOW() 		);
                            
    -- TABLE 6                        
 INSERT INTO TypeQuestion  	(   TypeID,      TypeName		)
 VALUES                    	(    1,         'Essay' 		  ),
							(    2,         'Essay' 		  ),
							(    3,         'Multiple-Choice' ),
							(    4,         'Multiple-Choice' ),
							(    5,         'Essay' 		  ),
							(    6,         'Multiple-Choice' ),
							(    7,         'Multiple-Choice' ),
							(    8,         'Essay' 		  ),
							(    9,         'Essay' 		  ),
							(    10,         'Multiple-Choice'),
							(  	11,         'Multiple-Choice' ),
							(  	12,         'Multiple-Choice' ),
							(  	13,         'Essay'			  ),
							(  	14,         'Essay' 		  ),
							(  	15,         'Multiple-Choice' );
    
  -- TABLE 7                         
 INSERT INTO  CategoryQuestion (   CategoryID,   CategoryName )
 VALUES                        (     1,        'Java'      ),
                               (     2,        'A.NET'     ),
							   (     3,        ' SQL'      ),
							   (     4,        'Postman'   ),
                               (     5,        'Ruby'      ),
                               (     6,        'MEN'       ),
                               (     7,        'COPPER'    ),
                               (     8,        'ASP.NET'   ),
                               (     9,        'C++'       ),
                               (    10,        'C Sharp'   ),
                               (    11,        'MEN'       ),
                               (    12,        'PHP'       ),
                               (    13,        'JAVAS'     ),
                               (    14,        'WEB'       ),
                               (    15,        'GAME'      );
                               
-- TABLE 8
INSERT INTO    Question     (  QuestionID,       Content,   CategoryID,   TypeID,   CreatorID,     CreateDate		)
VALUES                      (     1,            'câu hỏi1',        1,     	  2,    	   1,      	'2021/01/30'	),
							(     2,            'câu hỏi2',        3,     	 11,    	  10,       '2021/02/11' 	),
							(     3,            'câu hỏi3',        3,     	  1,    	   3,    	'2021/03/28' 	),
							(     4,            'câu hỏi4',        4,     	  2,    	  15,      	'2021/04/27'	),
							(     5,            'câu hỏi5',        4,     	  5,    	   5,      	'2021/05/26' 	),
							(     6,            'câu hỏi6',        6,     	 10,    	  15,       '2021/06/25' 	),
							(     7,            'câu hỏi7',        4,     	 11,    	   7,       '2021/07/24' 	),
							(     8,            'câu hỏi10',       8,     	  6,    	  11,       '2021/08/23' 	),
							(     9,            'câu hỏi100',      9,     	  9,    	   9,       '2021/09/21' 	),
							(    10,            'câu hỏi20',      10,     	  5,    	  11,       	NOW()		),
                            (    11,            'câu hỏi6',       10,     	  5,    	  11,       '2021/06/25' 	),
                            (    12,            'câu hỏi7',       10,     	  9,    	   6,       	NOW()		),
                            (    13,            'câu hỏi10',       5,     	  1,    	   3,       	NOW() 		),
                            (    14,            'câu hỏi100',      9,     	 15,    	   4,     	'2015/09/17'	),
                            (    15,            'câu hỏi20',      11,     	  9,    	   9,           NOW() 		);
                            					
-- TABLE 9
INSERT INTO Answer          (     AnswerID,        Content,      	 QuestionID,      isCorrect)
VALUES                      (          1,         'Tôi xong rồi',         1,             TRUE  ),
                            (          2,         'Tôi đang chơi',        1,             FALSE ),
							(          3,         'Tôi ăn rồi',           2,             TRUE  ),
                            (          4,         'Tôi đang xuống',       4,             FALSE ),
                            (          5,         'Tôi đang bơi',         4,             TRUE  ),
                            (          6,         'Tôi đang bay',         4,             1 	   ),
                            (          7,         'Tôi đang làm',         5,             TRUE  ),
                            (          8,         'Tôi đang đi',          4,             FALSE ),
                            (          9,         'Tôi đang làm việc',    7,             TRUE  ),
                            (         10,         'Tôi đang chạy',        9,             FALSE ),
                            (         11,         'Tôi đang học',         4,             1 	   ),
                            (         12,         'Tôi đang game',        5,             0     ),
                            (         13,         'Tôi đang nhảy',        4,             1     ),
                            (         14,         'Tôi đang uông nc',     7,             1     ),
                            (         15,         'Tôi đang tán gái',     9,             0	   );
                            
                            
 -- TABLE 10 
INSERT INTO		Exam		(  ExamID,     `code` ,       Title,      CategoryID,	   Duration,     CreatorID,     CreateDate   )
VALUES              		(   1,         'SQL1',      'Title',          1,             90,            1,          '2019/12/10' ),
							(   2,         'MYsql',     'Title',          1,             90,            2,          	NULL     ),
							(   3,         'java',      'string',         3,            180,           10,          	NULL  	 ),
							(   4,         'javar',     'string2',        4,            180,            2,          '2021/11/23' ),
							(   5,         'javas',     'string3',        5,             60,           15,          	NOW() 	 ),
							(   6,         'Mysql1',    'string4',        3,            180,            4,          '2019/03/21' ),
							(   7,         'Mysql2',    'string5',        7,           	 90,            6,          	NOW()	 ),
							(   8,         'Mysql3',    'string6',        9,            180,           14,          '2021/06/30' ),
							(   9,         'Mysql4',    'string7',        1,            180,            3,          	NULL 	 ),
							(  10,         'Mysql5',    'string8',        2,             90,           10,         		 NOW() 	 ),
							(  11,         'Mysql6',    'string9',        3,            180,            4,          '2019/03/21' ),
							(  12,         'Mysql7',    'string10',       7,         	 60,           14,        		NULL 	 ),
							(  13,         'Mysql8',    'string17',       9,           	180,            2,         		NOW()	 ),
							(  14,         'Mysql9',    'string13',       1,          	 60,           11,          '2021/07/21' ),
							(  15,         'Mysql11',    'string20',      2,          	180,           10,         		NOW()	 );
                    
                    
-- TABLE 11
INSERT INTO ExamQuestion	( ExamID,       QuestionID)
VALUES                  	(   1,              1	),
							(   2,              3	),
							(   3,              2	),
							(  12,              2	),
							(   3,             14	),
							(   3,              4	),
							(   2,              6	),
							(  13,              3	),
							(   1,              3	),
							(   4,              3	),
							(  13,             11	),
							(   2,             11	),
							(   9,              3	),
							(   8,             11	),
							(  15,              3	);