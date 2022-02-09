DROP DATABASE IF EXISTS Extra_assignment_4;
CREATE DATABASE IF NOT  EXISTS Extra_assignment_4;
USE Extra_assignment_4;

-- Question 1: Tạo table với các ràng buộc và kiểu dữ liệu
CREATE TABLE 	Department (
				Department_Number  	INT UNSIGNED AUTO_INCREMENT PRIMARY KEY ,		
				Department_Name   	VARCHAR(50) NOT NULL 
                );
CREATE TABLE 	Employee_Table (
				Employee_Number		INT UNSIGNED AUTO_INCREMENT PRIMARY KEY ,  
				Employee_Name 		VARCHAR(50) NOT NULL ,
				Department_Number 	INT UNSIGNED  ,
                FOREIGN KEY (Department_Number) REFERENCES Department(Department_Number)
                );
CREATE TABLE    Employee_Skill_Table (
				Employee_Number 	INT UNSIGNED ,
                Skill_Code 			VARCHAR(100) NOT NULL UNIQUE KEY ,
                Date_Registered 	DATETIME ,
                FOREIGN KEY (Employee_Number) REFERENCES Employee_Table(Employee_Number)
                );
        -- Question 2: Thêm ít nhất 10 bản ghi vào table        
  
INSERT INTO  	Department 				( Department_Number, Department_Name) 
VALUES  				   				(   1 		,       'sale' 			),
										( 	2 		,		'marketing' 	),
										(	3 		,		'bảo vệ'		),
										(	4 		,		'nhân sự'		),
										(	5 		, 		'giám đốc'		),
										(	6 		, 		'phóng sự'		),
										(	7 		, 		'cơ trưởng'		),
										(	8 		, 		'thủ kho'		),
										(	9 		, 		'lao công'		),
										(   10 		, 		'tổ trưởng'		);
INSERT INTO 	Employee_Table 			( Employee_Number, 	Employee_Name,	  Department_Number ) 
VALUES      							( 1  ,          'CHIẾN THẮNG'    ,       4 				),
										( 2  ,          'ĐỨC THUẬN'    	 ,       5 				),
										( 3  ,          'VĂN NAM'    	 ,       4 				),
										( 4  ,          'ĐẠI TỪ'   		 ,       4 				),
										( 5  ,          'VĂN HẢI'     	 ,       7				),
										( 6  ,          'THÀNH TÂN'    	 ,       1 				),
										( 7  ,          'ĐỨC TÀI'    	 ,       2 				),
										( 8  ,          'TẤN ĐẠT'    	 ,       3 				),
										( 9  ,          'HẢI HẬU'     	 ,       3 				),
										( 10  ,         'QUẾ LINH'    	 ,       10 			);
INSERT INTO 	Employee_Skill_Table    ( Employee_Number, Skill_Code, Date_Registered	)
VALUES								    ( 1  ,              'N1' ,       '2019/12/01' 	),
										( 3  ,            'Java' ,       '2022/01/01' 	),
										( 3  ,          	'N3' ,       '2012/12/22' 	),
										( 5  ,         	    'N4' ,       '2021/12/28' 	),
										( 1  ,           	'N5' ,       '2022/01/10' 	),
										( 8  ,            	'N6' ,       '2021/01/11' 	),
										( 8  ,          	'N7' ,       '2021/12/08' 	),
										( 6  ,          	'N8' ,       '2021/11/11' 	),
										( 9  ,           	'N9' ,       '2021/03/10' 	),
										( 4  ,          	'N10',       '2021/01/10' 	);
     -- QUESTION 3: VIẾT LỆNH ĐỂ LẤY RA DANH SÁCH NHÂN VIÊN (NAME) CÓ SKILL JAVA
     -- HƯỚNG DẪN: SỬ DỤNG UNION
     
SELECT 			Employee_Name,Skill_Code,COUNT(Skill_Code = 'java') AS SL
FROM 			Employee_Skill_Table A
JOIN			Employee_Table B ON A.Employee_Number = B.Employee_Number 
WHERE			Skill_Code = 'java' ;			

-- QUESTION 4: VIẾT LỆNH ĐỂ LẤY RA DANH SÁCH CÁC PHÒNG BAN CÓ >3 NHÂN VIÊN

SELECT 			COUNT(D.Department_Number) AS ID ,Department_Name
FROM  			Department D
JOIN			Employee_Table E ON D.Department_Number = E.Department_Number
GROUP BY		D.Department_Number
HAVING			COUNT(D.Department_Number) > 2;

-- QUESTION 5: VIẾT LỆNH ĐỂ LẤY RA DANH SÁCH NHÂN VIÊN CỦA MỖI VĂN PHÒNG BAN.
-- Hướng dẫn: sử dụng GROUP BY

SELECT 			Employee_Name,Department_Name-- ,GROUP_CONCAT(Department_Number) 
FROM			Employee_Table s
JOIN			Department c ON s.Department_Number = c.Department_Number;

-- QUESTION 6: VIẾT LỆNH ĐỂ LẤY RA DANH SÁCH NHÂN VIÊN CÓ > 1 SKILLS.
-- Hướng dẫn: sử dụng DISTINCT

SELECT 			Employee_Name,COUNT(2)
FROM			Employee_Skill_Table A
JOIN			Employee_Table  B ON A.Employee_Number = B.Employee_Number
GROUP BY		A.Employee_Number 
HAVING			COUNT(A.Employee_Number) > 1   
                                        
						                                                 
                                                                         
                           
                           
 