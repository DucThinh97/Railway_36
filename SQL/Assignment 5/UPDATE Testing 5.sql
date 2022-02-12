
-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
CREATE OR REPLACE VIEW phong_ban_Sale AS -- SD VIEW
SELECT 			A.*, D.DepartmentName
FROM 			`Account` A
INNER JOIN 		Department D ON A.DepartmentID = D.DepartmentID
WHERE		 	D.DepartmentName = 'Sale';

SELECT 			* 
FROM 			phong_ban_Sale ;

-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất

CREATE OR REPLACE VIEW vw_GetAccount AS
WITH 		CTE_GetListCountAccount AS ( SELECT COUNT(GA1.AccountID) AS countGA1 FROM groupaccount GA1
GROUP BY 	GA1.AccountID )

SELECT 		A.AccountID, A.Username, count(GA.AccountID) AS SL FROM groupaccount GA
INNER JOIN 	`Account` A ON GA.AccountID = A.AccountID
GROUP BY 	GA.AccountID
HAVING 		COUNT(GA.AccountID) = (
SELECT 		MAX(countGA1) AS maxCount FROM CTE_GetListCountAccount
);
SELECT 		* 
FROM 		vw_GetAccount ;

-- QUESTION 3: TẠO VIEW CÓ CHỨA CÂU HỎI CÓ NHỮNG CONTENT QUÁ DÀI (CONTENT QUÁ 300 TỪ ĐƯỢC COI LÀ QUÁ DÀI) VÀ XÓA NÓ ĐI
CREATE OR REPLACE VIEW Content_18 AS
SELECT			 *
FROM 			Question
WHERE 			LENGTH(Content) > 18 ;
SELECT 			*
FROM 			Content_18 ;
-- xóa nó đi
DELETE FROM 	Content_18 ;

-- QUESTION 4: TẠO VIEW CÓ CHỨA DANH SÁCH CÁC PHÒNG BAN CÓ NHIỀU NHÂN VIÊN NHẤT
CREATE OR REPLACE VIEW PB_MAX_NV AS
SELECT 			D.DepartmentName, count(A.DepartmentID) AS SL
FROM 			account A
INNER JOIN 		Department D ON D.DepartmentID = A.DepartmentID
GROUP BY 		A.DepartmentID
HAVING 			count(A.DepartmentID) = (SELECT MAX(so_nv) AS max_NV FROM
(SELECT 		count(AC.DepartmentID) AS so_nv FROM account AC
GROUP BY 		AC.DepartmentID) AS TB );

SELECT 			* 
FROM 			PB_MAX_NV;


-- QUESTION 5: TẠO VIEW CÓ CHỨA TẤT CÁC CÁC CÂU HỎI DO USER HỌ NGUYỄN TẠO

CREATE OR REPLACE VIEW QS_5 AS
SELECT	 	Q.CategoryID, Q.Content, A.FullName AS Creator 
FROM 		question Q
INNER JOIN 	`account` A ON A.AccountID = Q.CreatorID
WHERE 		SUBSTRING_INDEX( A.FullName, ' ', 1 ) = 'Nguyễn';

SELECT 		* 
FROM 		QS_5;
