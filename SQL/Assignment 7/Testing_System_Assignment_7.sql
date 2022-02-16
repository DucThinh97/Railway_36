-- Question 1: Tạo trigger không cho phép người dùng nhập vào Group có ngày tạo trước 1 năm trước
DROP TRIGGER IF EXISTS trig_Qs1;
DELIMITER $$
	CREATE TRIGGER trig_Qs1
    BEFORE INSERT ON `Group`
    FOR EACH ROW
    BEGIN
		IF (NEW.CreateDate< DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR)) THEN
			SIGNAL SQLSTATE '12345'
            SET MESSAGE_TEXT = 'Ko add được';
		END IF;
    END$$
DELIMITER ;
INSERT INTO `Group`	(  GroupName		, CreatorID		, CreateDate)
VALUE 				(N'Testing System'	,   12			,'2019-03-05');
SELECT * FROM `Group`;
-- Question 2: Tạo trigger Không cho phép người dùng thêm bất kỳ user nào vào
-- department "Sale" nữa, khi thêm thì hiện ra thông báo "Department "Sale" cannot add
-- more user"
DROP TRIGGER IF EXISTS trig_Qs2;
DELIMITER $$
	CREATE TRIGGER trig_Qs2
    BEFORE INSERT ON `Department`
    FOR EACH ROW
    BEGIN
			IF (NEW.DepartmentName = 'Sale') THEN
				SIGNAL SQLSTATE '12345'
				SET MESSAGE_TEXT = 'Department "Sale" cannot add more user';
			END IF;
    END$$
DELIMITER ;
INSERT INTO Department	(DepartmentName)  
VALUE					(N'Sale'	);

-- Question 3: Cấu hình 1 group có nhiều nhất là 5 user.
DROP TRIGGER IF EXISTS trig_Qs3;
DELIMITER $$
CREATE TRIGGER trig_Qs3
BEFORE INSERT ON `ExamQuestion`
FOR EACH ROW
BEGIN
		IF (SELECT 	GroupID FROM GroupAccount GROUP BY GroupID HAVING Count(AccountID) >= 5) THEN
			SIGNAL SQLSTATE '12345'
			SET MESSAGE_TEXT = 'Một group có nhiều nhất 5 User';
        END IF;
END $$
DELIMITER ;

INSERT INTO `GroupAccount`	(  GroupID	, AccountID	, JoinDate	 )
VALUE 						(	1		,    1		,'2019-03-05');
-- Question 4: Cấu hình 1 bài thi có nhiều nhất là 10 Question
 -- Số lượng câu hỏi trong 1 đề thi
 
DROP TRIGGER IF EXISTS trig_Qs4;
DELIMITER $$
CREATE TRIGGER trig_Qs4
BEFORE INSERT ON `examquestion`
FOR EACH ROW
BEGIN
			DECLARE var_CountQuesInExam TINYINT;
			SELECT count(EQ.ExamID) INTO var_CountQuesInExam 
			FROM 	examquestion EQ
			WHERE EQ.ExamID = NEW.ExamID;
		IF (var_CountQuesInExam >10) THEN
			SIGNAL SQLSTATE '12345'
			SET MESSAGE_TEXT = 'Num Question in this Exam is limited 10';
		END IF;
END$$
DELIMITER ;
INSERT INTO `examquestion`(`ExamID`, `QuestionID`) VALUES (5, 3);

-- Question 5: Tạo trigger không cho phép người dùng xóa tài khoản có email là
-- admin@gmail.com (đây là tài khoản admin, không cho phép user xóa), còn lại các tài
-- khoản khác thì sẽ cho phép xóa và sẽ xóa tất cả các thông tin liên quan tới user đó
DROP TRIGGER IF EXISTS trig_Qs5;
DELIMITER $$
CREATE TRIGGER trig_Qs5
BEFORE DELETE ON `Account`
FOR EACH ROW
BEGIN
	IF OLD.Email = 'admin@gmail.com' THEN 
		SIGNAL SQLSTATE '12345'
        SET MESSAGE_TEXT = 'Cannot delete data';
	END IF;
END $$
DELIMITER ; 
	
INSERT INTO `Account`(Email				, Username			, FullName		, DepartmentID	, PositionID, CreateDate)
VALUE 				('admin@gmail.com'	, 'tiendo'		,'Do Van Tien'		,   '5'			,   '1'		,'2021-02-02');

DELETE
FROM `Account`
WHERE Email = 'admin@gmail.com';

-- Question 6: Không sử dụng cấu hình default cho field DepartmentID của table
-- Account, hãy tạo trigger cho phép người dùng khi tạo account không điền vào
-- departmentID thì sẽ được phân vào phòng ban "Phòng chờ"
DROP TRIGGER IF EXISTS trig_Qs6;
DELIMITER $$
	CREATE TRIGGER trig_Qs6
    BEFORE INSERT ON `Account`
    FOR EACH ROW
    BEGIN
			DECLARE WaitingDepartment_ID TINYINT UNSIGNED;
			SELECT DepartmentID INTO WaitingDepartment_ID
            FROM Department
            WHERE DepartmentName = 'Phòng chờ';
		IF 	
			NEW.DepartmentID IS NULL THEN 
			SET NEW.DepartmentID = WaitingDepartment_ID;
		END IF;
	END $$
    DELIMITER ;
-- Question 7: Cấu hình 1 bài thi chỉ cho phép user tạo tối đa 4 answers cho mỗi
-- question, trong đó có tối đa 2 đáp án đúng.
DROP TRIGGER IF EXISTS trig_Qs7;
DELIMITER $$
	CREATE TRIGGER trig_Qs7
    BEFORE INSERT ON Answer
    FOR EACH ROW
    BEGIN
		DECLARE NumberAnswer TINYINT UNSIGNED;
        DECLARE NumberCorrectAnswer TINYINT UNSIGNED;
			SELECT COUNT(AnswerID) INTO NumberAnswer
            FROM Answer
            WHERE QuestionID = New.QuestionID;
            
			SELECT COUNT(AnswerID) INTO NumberCorrectAnswer
            FROM Answer
            WHERE QuestionID = New.QuestionID AND isCorrect = 'Yes';
            
		IF NumberAnswer >=4 OR NumberCorrectAnswer>=2 THEN 
        SIGNAL SQLSTATE '12345'
		SET MESSAGE_TEXT = 'Cannot insert data';
		END IF;
       
	END $$
    DELIMITER ;
-- Question 8: Viết trigger sửa lại dữ liệu cho đúng: nếu người dùng nhập vào gender
-- của account là nam, nữ, chưa xác định thì sẽ đổi lại thành M, F, U cho giống với cấu
-- hình ở database
DROP TRIGGER IF EXISTS trig_Qs8;
DELIMITER $$
CREATE TRIGGER trig_Qs8
BEFORE INSERT ON `Account`
FOR EACH ROW
BEGIN
      IF NEW.Gender = 'Nam' THEN
         SET NEW.Gender = 'M';
	  ELSEIF NEW.Gender = 'Nu' THEN
         SET NEW.Gender = 'F';
	  ELSEIF NEW.Gender = 'Chưa xác định' THEN
         SET NEW.Gender = 'U';
	  END IF ;
END $$
DELIMITER ;
-- Question 9: Viết trigger không cho phép người dùng xóa bài thi mới tạo được 2 ngày
DROP TRIGGER IF EXISTS trig_Qs9;
DELIMITER $$
CREATE TRIGGER trig_Qs9
BEFORE DELETE ON Exam
FOR EACH ROW
BEGIN
      IF (NEW.CreateDate = DATE_SUB(NOW(),INTERVAL 2 DAY)) THEN
         SIGNAL SQLSTATE '12345'
         SET MESSAGE_TEXT = 'Không được xóa Exam vừa tạo 2 ngày trước';
	  END IF ;
END $$
DELIMITER ;
-- Question 10: Viết trigger chỉ cho phép người dùng chỉ được update, delete các
-- question khi question đó chưa nằm trong exam nào
DROP TRIGGER IF EXISTS trig_Qs10;
DELIMITER $$
CREATE TRIGGER trig_Qs10
BEFORE UPDATE  ON Question
FOR EACH ROW
BEGIN
		DECLARE Not_On_Exam TINYINT;   
		SELECT q.QuestionID INTO Not_On_Exam
		FROM Question q
		LEFT JOIN ExamQuestion eq ON q.QuestionID = eq.QuestionID
		WHERE eq.ExamID IS NULL;
	IF 	
		NEW.QuestionID != Not_On_Exam THEN
		SIGNAL SQLSTATE '12345'
		SET MESSAGE_TEXT = 'Không thể INSERT'; 
	END IF ;
END $$
DELIMITER ;
-- Question 12: Lấy ra thông tin exam trong đó
-- Duration <= 30 thì sẽ đổi thành giá trị "Short time"
-- 30 < duration <= 60 thì sẽ đổi thành giá trị "Medium time"
-- duration >60 thì sẽ đổi thành giá trị "Long time"
SELECT ExamID,
		CASE 
			WHEN Duration <= 30 THEN 'Short time'
            WHEN Duration <= 60 AND Duration >30 THEN 'Medium time'
            ELSE 'Longtime'
		END AS ExamDuration
FROM Exam;
-- Question 13: Thống kê số account trong mỗi group và in ra thêm 1 column nữa có tên
-- là the_number_user_amount và mang giá trị được quy định như sau:
-- Nếu số lượng user trong group =< 5 thì sẽ có giá trị là few
-- Nếu số lượng user trong group <= 20 và > 5 thì sẽ có giá trị là normal
-- Nếu số lượng user trong group > 20 thì sẽ có giá trị là higher
SELECT GroupID, 
		CASE
			WHEN COUNT(AccountID) <=5 THEN 'Few'
            WHEN COUNT(AccountID) <=20 AND COUNT(AccountID)>5 THEN 'Normal'
            ELSE 'Higher'
		END AS the_number_user_amount
FROM GroupAccount
GROUP BY GroupID;

-- Question 14: Thống kê số mỗi phòng ban có bao nhiêu user, nếu phòng ban nào
-- không có user thì sẽ thay đổi giá trị 0 thành "Không có User"

SELECT d.DepartmentName,
		CASE
			WHEN COUNT(a.AccountID) = 0 THEN 'Khong co User'
            ELSE COUNT(a.AccountID)
		END AS Number_of_Account
FROM Department d
JOIN `Account` a ON d.DepartmentID = a.DepartmentID
GROUP BY d.DepartmentName;