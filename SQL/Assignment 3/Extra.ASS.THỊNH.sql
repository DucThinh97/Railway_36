DROP DATABASE IF EXISTS ExtraAssignment3;
CREATE DATABASE IF NOT EXISTS ExtraAssignment3;
USE ExtraAssignment3;

-- Exercise 1:Design a table
CREATE TABLE Trainee(
    TraineeID        TINYINT AUTO_INCREMENT PRIMARY KEY,
	Full_Name        VARCHAR(50) NOT NULL,
	Birth_Date       DATETIME NOT NULL,
	Gender 		     ENUM('male','female','unknown'),
	ET_IQ 		     TINYINT NOT NULL CHECK (ET_IQ >= 0 AND ET_IQ <= 20),
	ET_Gmath 	     TINYINT NOT NULL CHECK (ET_Gmath BETWEEN 0 AND 20),
	ET_English 	     TINYINT NOT NULL CHECK (ET_English BETWEEN 0 AND 50),
	Training_Class   VARCHAR(100) UNIQUE KEY,
	Evaluation_Notes TEXT
);
-- Exercise 2: Data Types
CREATE TABLE exe2(
    ID               MEDIUMINT AUTO_INCREMENT PRIMARY KEY,
   `Name`            VARCHAR(50) NOT NULL,
   `Code`            VARCHAR(5) NOT NULL,
    ModifedDate      DATETIME NOT NULL
);
-- Exercise 3: Data Types (2)
CREATE TABLE exe3(
    ID               MEDIUMINT AUTO_INCREMENT PRIMARY KEY,
   `Name`            VARCHAR(50) NOT NULL,
    Gender           ENUM('male','female','unknown'),
    IsDeletedFlag    TINYINT CHECK (IsDeletedFlag IN (0,1))
);
  
INSERT INTO Trainee( TraineeID ,    Full_Name   ,  Birth_Date  ,   Gender ,    ET_IQ , ET_GmatH ,  ET_English , Training_Class ,  Evaluation_Notes )
VALUES             (    1,      'ĐỒNG ĐỨC THỊNH', '1997-12-30' ,    'male',      10,         1,       1,            '123'      ,        'TEXT'     ),
                   (    2,     'NGUYỄN CHÍ LINH', '1998-11-30' ,    'male',       2,         1,       2,            '234'      ,        'TEXT'     ),
                   (    3,      'NGUYỄN BÁ DANH', '1999-10-20' ,    'male',       3,         3,       1,            '345'      ,        'TEXT'     ),
                   (    4,      'HUỲNH TẤN TÀI' , '1987-12-30' ,  'female',       4,         4,       4,            '456'      ,        'TEXT'     ),
                   (    5,        'BÙI BÁ DANH' , '1977-12-30' ,  'female',       5,         5,       5,            '567'      ,        'TEXT'     ),
                   (    6,     'NGUYỄN THÙY THU', '1991-02-11' ,  'female',       6,         6,       6,            '678'      ,        'TEXT'     ),
                   (    7,      'ĐÀO TẤN NAM '  , '1997-11-23' , 'unknown',       7,         7,       7,            '789'      ,        'TEXT'     ),
				   (    8,      'ĐỒNG THU HƯƠNG', '1967-12-31' , 'unknown',       8,        10,       8,            '910'      ,       ' TEXT'     ),
                   (    9,      'ĐỒNG ĐỨC ĐẠI  ', '1997-12-30' , 'unknown',       9,         9,       9,            '101'      ,        'TEXT'     ),
                   (   10,      'NGUYÊN LÝ CHÍ ', '1997-12-30' , 'unknown',      10,        11,      10,            '102'      ,        'TEXT'     );
		
INSERT INTO EXE2(  ID,          `Name`,       `Code`,   ModifedDate )
VALUES          (   1,       'English',        'AB1',       NOW()   ),
                (   2,       'English',       'AB1' ,       NOW()   ),
                (   3,       'English',       'AB1' ,       NOW()   ),
                (   5,       'English',       'AB1' ,       NOW()   ),
                (   6,       'English',       'AB1' ,       NOW()   ),
                (   7,       'English',       'AB1' ,       NOW()   ),
                (   8,       'English',       'AB1' ,       NOW()   ),
                (   9,       'English',       'AB1' ,       NOW()   ),
                (  10,       'English',       'AB1' ,       NOW()   );
                
INSERT INTO EXE3(  ID,        `Name`,      Gender,     IsDeletedFlag)
VALUES          (   1,       'English',      'male',         1     ),
                (   2,       'English',      'male',         0     ),
                (   3,       'English',      'male',         0     ),
                (   4,       'English',    'female',         0     ),
                (   5,       'English',    'female',         1     ),
                (   6,       'English',    'female',         1     ),
                (   7,       'English',   'unknown',         1     ),
                (   8,       'English',   'unknown',         1     ),
                (   9,       'English',   'unknown',         0     ),
                (  10,       'English',   'unknown',         1     );
 
 -- LẤY DỮ LIỆU TỪ SQL
 -- Question 2: Viết lệnh để lấy ra tất cả các thực tập sinh đã vượt qua bài test đầu vào,nhóm chúng thành các tháng sinh khác nhau
SELECT GROUP_CONCAT(Full_Name), MONTH(Birth_Date)
FROM trainee 
GROUP BY MONTH(Birth_Date) ;


-- Question 3: Viết lệnh để lấy ra thực tập sinh có tên dài nhất, lấy ra các thông tin sau:tên, tuổi, các thông tin cơ bản (như đã được định nghĩa trong table)

SELECT  CHAR_LENGTH(full_name),
(YEAR(NOW()) - Year(birth_date)) AS tuoi, full_name FROM trainee
WHERE CHAR_LENGTH(full_name) = ( SELECT MAX(CHAR_LENGTH (Full_Name)) FROM trainee ) 
GROUP BY month(birth_date); 

-- Question 4: Viết lệnh để lấy ra tất cả các thực tập sinh là ET, 1 ET thực tập sinh là những người đã vượt qua bài test đầu vào và thỏa mãn số điểm như sau:
-- ET_IQ + ET_Gmath>=20
-- ET_IQ>=8
-- ET_Gmath>=8
-- ET_English>=18

SELECT * 
FROM trainee
WHERE ET_IQ + ET_Gmath>=20
  AND ET_IQ>=8
  AND ET_Gmath>=8 
  AND ET_English>=18;
  
  
-- Question 5: xóa thực tập sinh có TraineeID = 3

DELETE 
FROM trainee
WHERE TraineeID = 3;

-- Question 6: Thực tập sinh có TraineeID = 5 được chuyển sang lớp "2". Hãy cập nhật thông tin vào database

UPDATE trainee
SET Training_Class = '2'
WHERE TraineeID = 5 
               
                
			
                
                
                
                
                
