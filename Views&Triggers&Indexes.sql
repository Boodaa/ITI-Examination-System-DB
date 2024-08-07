----------------------------------------------Views------------------------------------------------------------
-----------------View to Show detailed information about students' exam results-------------------------------------------
CREATE VIEW ExamResults
AS
SELECT S.St_Id,
	   S.Fname,
	   S.Lname,
	   C.Crs_Name,
	   E.Exam_Type,
	   E.Exam_start,
	   E.Exam_End,
	   E.Number_ofQestion,
	   E.Total_Dagree,
       SE.Result
FROM Student S
Join [dbo].[Student_Exam_Qestion_Composit] SE on S.St_Id= SE.Stu_id
Join Exam E ON  SE.Stu_id=E.Exa_Id
Join Course C ON E.Crs_id = C.Crs_Id

Select * from ExamResults
Go
------------------------------------------------------------------------------------------------------------------------------------
------View to Show which Instructor is responsible for each Course---------------------------------------------------------
Create VIEW CoursesWithInstructors
AS
SELECT C.Crs_Id,
	   C.Crs_Name,
	   C.Crds_Desc,
	   C.Min_Dagree,
	   C.Max_Dagree,
	   I.Fname +' '+ I.Lname as Fullname,
	   I.Email
FROM Course C
Join Instructor I on C.Crs_Id= I.Id


Select * from CoursesWithInstructors
go
--------------------------------------------------------------------------------------------------------------------------------
-----Create a view to Show the relationship between tracks and their associated branches----------------------------------------------------------------------------------------
CREATE VIEW TrackwithBranches 
AS
SELECT T.Tra_Id,
	   T.Track_Name,
	   B.Bra_Id,
	   B.Branch_Location 
FROM Track T
Join Track_Branch_Composit TB On T.Tra_Id = TB.Track_id
Join Branch B ON TB.Branch_id = B.Bra_Id

go
----------------------------------------------------------------------------------------------------------------------------------
-----create a view Show which Training Manager is responsible for each branch.-------------------------------------------------------------------------
Create VIEW BranchesWithTrainingManagers
AS
SELECT B.Bra_Id,
	   B.Branch_Location,
	   TM.Mang_Id,
	   TM.Fname +' '+ TM.Lname as Fullname,
	   TM.Email
FROM Branch B 
Join Trainning_Manager TM ON B.Manager_id = TM.Mang_Id

go
---------------------------------------------------------------------------------------------------------------------------------
------Create a view to show which branch each student belongs to and the specifics of their intake.-----------------------------------------------------------------
CREATE VIEW StudentIntakeInfo
AS 
SELECT S.St_Id,
	   S.Fname +' '+ S.Lname as Fullname,
	   I.Int_Id,
	   I.Intake_Name,
	   I.Int_Year,
	   B.Branch_Location
FROM Student S 
JOIN Intake I ON S.intak_id = I.Int_Id
JOIN Branch B ON S.Brach_id = B.Bra_Id

go
--------------------------------------------------------------------------------------------------------------------------------
-----create a view to Show the students located at each branch------------------------------------------------------------------------
CREATE VIEW BranchStudent 
AS
SELECT B.Bra_Id,
	   B.Branch_Location,
	   S.St_Id,
	   S.Fname +' '+ S.Lname as Fullname,
	   S.Email
FROM Branch B
JOIN Student S ON B.Bra_Id = S.Brach_id


Select * from BranchStudent
Go

----------------------------------------------------------------------------------------------------------------
---------------------------------------------- Triggers -------------------------------------------------------------------------------------
------Trigger To ensure that an exam is deleted from the Exam table then  associated questions are also deleted----------------------------------------------------------------------------------------
CREATE TRIGGER DeleteExam
ON Exam
AFTER DELETE
AS
BEGIN
    DELETE Qestions
    FROM Qestion Q
    INNER JOIN deleted d ON Q.Qes_id = d.Exa_ID;
END;
END


--This trigger ensures the total degree of an exam does not exceed the course's max degree.


CREATE or alter TRIGGER CheckExamDegree
ON Exam
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @CourseID INT;
    DECLARE @TotalDegree INT;
    DECLARE @MaxDegree INT;

    SELECT @CourseID = INSERTED.crs_id, @TotalDegree = INSERTED.Total_Dagree
    FROM INSERTED;

    SELECT @MaxDegree = Max_Dagree
    FROM Course
    WHERE Crs_ID = @CourseID;

    IF @TotalDegree > @MaxDegree
    BEGIN
        select ('Total degree of the exam exceeds the course''s max degree');
        ROLLBACK;
    END
END;

-----------------------------------------------------------------------------------------------------------------------------------
------create a trigger to Trigger To ensure that when an exam is deleted from the Exam table, all associated questions in the Qestion table are also deleted----------------------------------------------------------------------------------------
CREATE TRIGGER DeleteExam
ON Exam
AFTER DELETE
AS
BEGIN
    DELETE Qestions
    FROM Qestion Q
    INNER JOIN deleted d ON Q.Qes_id = d.Exa_ID;
END;

-------------------------------------------------------------------------------------------------------------
-------------------------------------------Index------------------------------------------------------------
--index in Course table

CREATE nonclustered INDEX In_Course_Name ON Course (Crs_Name ASC);

Select Crs_Name from Course

--index in Student table

CREATE nonclustered INDEX In_Student_FullName ON Student (FName ASC, LName ASC);
select FName,LName from Student
select FName+' '+LName as FullName from Student

----index in Instructor table


CREATE   nonclustered INDEX In_instructor_FullName ON Instructor (FName ASC, LName ASC);


----index in Branch table

CREATE nonclustered INDEX In_Branch_Name ON Branch (Branch_Location );

----index in Student_Cours_Composit table
CREATE nonclustered INDEX in_degree ON Student_Cours_Composit (st_degree );

----index in track table
CREATE nonclustered INDEX in_track  ON track (Track_Name );












