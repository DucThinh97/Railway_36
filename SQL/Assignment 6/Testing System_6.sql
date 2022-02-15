-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó

DROP PROCEDURE IF EXISTS Get_PB;
DELIMITER $$
CREATE PROCEDURE Get_PB (IN in_Departmentname VARCHAR(100),OUT Account_of_Dp TINYINT )
BEGIN
		SELECT 	A.*,D.Departmentname INTO Account_of_Dp
        FROM	`Account` A
        JOIN	Department D ON A.DepartmentID = D.DepartmentID
        WHERE	D.Departmentname = in_Departmentname;
END$$
DELIMITER ;

set @Account_of_Dp = '2';
call Get_PB('giám đốc', @Account_of_Dp );
select @Account_of_Dp;

DROP PROCEDURE IF EXISTS SP_FromDep;
DELIMITER //
CREATE PROCEDURE SP_FromDep (IN in_name VARCHAR(50))
BEGIN
			SELECT 		A.AccountID, A.FullName, D.DepartmentName 
			FROM 		`Account` A
			INNER JOIN 	Department D ON D.DepartmentID = A.DepartmentID
			WHERE 		D.DepartmentName = in_name;
END //
DELIMITER ;

Call SP_FromDep('giám đốc');

-- Question 2: Tạo store để in ra số lượng account trong mỗi group

DROP PROCEDURE IF EXISTS GET_GROUP;
DELIMITER //
CREATE PROCEDURE GET_GROUP(IN V_Group SMALLINT)
BEGIN
		SELECT  GroupID,COUNT(AccountID) AS SL
        FROM 	groupaccount 
        WHERE	GroupID = V_Group;
END //
DELIMITER ;

CALL GET_GROUP('3');

-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo trong tháng hiện tại

DROP PROCEDURE IF EXISTS GET_typequestion;
DELIMITER //
CREATE PROCEDURE GET_typequestion ()
BEGIN
		SELECT 		COUNT(B.TypeID) SL_Qs,A.Typename,B.CreateDate,A.TypeID
        FROM  		TypeQuestion A
        JOIN		Question B ON A.TypeID = B.TypeID
        WHERE		MONTH(B.CreateDate) = MONTH(NOW()) AND YEAR(B.CreateDate) = YEAR(NOW())    
		GROUP BY	B.TypeID;    	
END //
DELIMITER ;

CALL GET_typequestion ();

-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất

DROP PROCEDURE IF EXISTS GET_typequestionMAX;
DELIMITER //
CREATE PROCEDURE GET_typequestionMAX ()
BEGIN
		SELECT 		TypeID,COUNT(TypeID) AS MAX_SL_QS
		FROM		question
		GROUP BY	TypeID
		HAVING		COUNT(TypeID) = (SELECT 	MAX(SL_CAU_HOI)
										FROM   	(SELECT 	TypeID,COUNT(TypeID) AS SL_CAU_HOI
												FROM		question
												GROUP BY	TypeID) AS TEN);
END //
DELIMITER ;

CALL GET_typequestionMAX ();

-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question

DROP PROCEDURE IF EXISTS GET_typequestionnNAME;
DELIMITER //
CREATE PROCEDURE GET_typequestionnNAME (IN V_Typename VARCHAR(50))
BEGIN
		SELECT 		B.Typename,B.TypeID
		FROM		question A
        JOIN		typequestion B ON A.TypeID = B.TypeID
        WHERE		B.Typename = V_Typename;
END //
DELIMITER ;

CALL GET_typequestionnNAME('Essay');

-- Question 6: Viết 1 store (( cho phép người dùng nhập vào 1 chuỗi và trả về group có tên chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa
-- chuỗi của người dùng nhập vào ))

-- Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và ( trả về group có tên
-- chứa chuỗi của người dùng nhập vào ) hoặc ( trả về user có username chứa chuỗi của người dùng nhập vào )

DROP PROCEDURE IF EXISTS GET_cau6;
DELIMITER //
CREATE PROCEDURE GET_cau6 (IN V_Typename VARCHAR(50),IN V_TypeID INT )
BEGIN
		IF V_TypeID = 1 THEN
			SELECT 	*
			FROM		`group` A
			WHERE		A.GROUPNAME LIKE CONCAT('%',V_Typename,'%');
		ELSE
			SELECT 	*
			FROM		`ACCOUNT` B
			WHERE		Username LIKE CONCAT('%',V_Typename,'%');
		END IF;
END //
DELIMITER ;

-- Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và trong store sẽ tự động gán:
-- username sẽ giống email nhưng bỏ phần @..mail đi
-- positionID: sẽ có default là developer
-- departmentID: sẽ được cho vào 1 phòng chờ
-- Sau đó in ra kết quả tạo thành công
DELIMITER $$
CREATE PROCEDURE Ques7(in in_full_name VARCHAR(50),IN in_email VARCHAR(50))
BEGIN
	DECLARE p_username VARCHAR(50) DEFAULT ''; 
	DECLARE p_PositionID int DEFAULT 0;
	DECLARE p_DepartmentID int DEFAULT 0;
	DECLARE p_CreateDate date DEFAULT CURDATE();
	SET p_username = SUBSTRING_INDEX(in_email,'@',1);
	SET p_PositionID = 1;
	SET p_DepartmentID = 11;
	insert into account (Email,Username,Fullname,DepartmentID,PositionID,CreateDate) 
	VALUES	(in_email,p_username,in_full_name,p_DepartmentID,p_PositionID,p_CreateDate);
	
	SELECT * from account a
	WHERE a.username = username;
END $$
DELIMITER;

-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất
DROP PROCEDURE IF EXISTS Ques8;
DELIMITER $$
CREATE PROCEDURE Ques8(in in_TYPE_name VARCHAR(50))
BEGIN
		IF in_TYPE_name = 'Essay' THEN
			SELECT 	*,MAX(LENGTH(Content))
			FROM		question
			WHERE		TypeID = 2;
		ELSEIF  in_TYPE_name ='Multiple-Choice' THEN
			SELECT 	*,MAX(LENGTH(Content))
			FROM		question
			WHERE		TypeID = 1;
		END IF;
END $$
DELIMITER;

call Ques8('Multiple-Choice');

-- Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID

DROP PROCEDURE IF EXISTS Ques9;
DELIMITER $$
CREATE PROCEDURE Ques9(in v_examID INT)
BEGIN
		DELETE FROM examquestion eq WHERE eq.ExamID = v_examID;
		DELETE FROM	exam WHERE	examid = v_examID;
END $$
DELIMITER;

call Ques9(10);

-- Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử dụng store ở câu 9 để xóa)
-- Sau đó in số lượng record đã remove từ các table liên quan trong khi removing

DROP PROCEDURE IF EXISTS Ques10;
DELIMITER $$
CREATE PROCEDURE Ques10()
BEGIN
		WITH  ExamID3Year AS(
			SELECT 	*
			FROM 	Exam
			WHERE	(YEAR(NOW()) - YEAR(CreateDate)) >= 3
    )
		
-- 		select * from ExamID3Year;
		DELETE
    FROM 	examquestion 
    WHERE ExamID IN (SELECT ExamID
										 FROM 	ExamID3Year);	
		
		WITH ExamID3Year AS(
			SELECT 	*
			FROM 	Exam
			WHERE	(YEAR(NOW()) - YEAR(CreateDate)) >= 3
    )
		DELETE
    FROM 	Exam 
    WHERE ExamID IN (SELECT ExamID
											 FROM 	ExamID3Year);
-- 		DELETE
--     FROM 	Exam e
--     WHERE e.ExamID IN ( SELECT B.ExamID FROM (SELECT *
-- 			FROM 	Exam
-- 			WHERE	(YEAR(NOW()) - YEAR(CreateDate)) >= 3) as B);
END $$
DELIMITER;

call Ques10();

-- Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được chuhyển về phòng ban default là phòng ban chờ việc

DROP PROCEDURE IF EXISTS Ques11;
DELIMITER $$
CREATE PROCEDURE Ques11(in in_Departmentname VARCHAR(50))
BEGIN
		UPDATE 	`Account`
		SET		 	departmentid = 11	
		where 	DepartmentID = (select DepartmentID from department WHERE DepartmentName = in_Departmentname);
		delete 	from department WHERE DepartmentName = in_Departmentname;
END $$
DELIMITER;

call Ques11('Marketing');

-- Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay
DELIMITER $$
CREATE PROCEDURE Ques12()
BEGIN
	SELECT statics.month, COUNT(q.QuestionID) sl
	FROM
	( 
			 SELECT 1 AS MONTH
			 UNION SELECT 2 AS MONTH
			 UNION SELECT 3 AS MONTH
			 UNION SELECT 4 AS MONTH
			 UNION SELECT 5 AS MONTH
			 UNION SELECT 6 AS MONTH
			 UNION SELECT 7 AS MONTH
			 UNION SELECT 8 AS MONTH
			 UNION SELECT 9 AS MONTH
			 UNION SELECT 10 AS MONTH
			 UNION SELECT 11 AS MONTH
			 UNION SELECT 12 AS MONTH
	) as statics
	LEFT JOIN question q ON statics.month = MONTH(q.CreateDate)
	GROUP BY statics.month;
END $$
DELIMITER;

-- Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6 tháng gần đây nhất
-- (Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong tháng")
DELIMITER $$
CREATE PROCEDURE Ques13()
BEGIN
	SELECT *,IF(COUNT(q.QuestionID)>0, COUNT(q.QuestionID), "NO")
	FROM
	( 
			SELECT MONTH(NOW() - INTERVAL 5 MONTH) AS MONTH
			UNION
			SELECT MONTH(NOW() - INTERVAL 4 MONTH) AS MONTH
			UNION
			SELECT MONTH(NOW() - INTERVAL 3 MONTH) AS MONTH
			UNION
			SELECT MONTH(NOW() - INTERVAL 2 MONTH) AS MONTH
			UNION
			SELECT MONTH(NOW() - INTERVAL 1 MONTH) AS MONTH
			UNION
			SELECT MONTH(NOW() - INTERVAL 0 MONTH) AS MONTH
	) as ten
	LEFT JOIN question q ON ten.MONTH = MONTH(q.CreateDate)
	GROUP BY ten.MONTH;
END $$
DELIMITER ;
 





























