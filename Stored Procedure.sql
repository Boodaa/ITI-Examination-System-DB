------------------------------------SP of The Dynamic Exam System---------------------------------------------
--check The student's answer  whether it is correct or incorrect for each question

Create or alter Proc CheckandStoreAnswer
	@student_id INT,
	@Exam_id INT,
	@qesid int ,
	@student_Answer nvarchar(20)
as
BEGIN
	declare @correct_Answer nVarchar(20),@result int
    select @result=  [Qestion_Degree] 
	from Instruc_Qesti_Exam_Cours_Composit
    where @qesid = [Qesti_id]


	select  @correct_Answer =[Qestion_Answer]    
	from Qestion
	where  [Qes_Id]=@qesid
	IF  @student_Answer = @correct_Answer  
		BEGIN
			update [dbo].[Student_Exam_Qestion_Composit]
			SET [Result]=@result
			where @student_id=stu_id and @Exam_id=Exam_id and @qesid=Qes_id
		END
	ELSE
		BEGIN
			update [dbo].[Student_Exam_Qestion_Composit]
			SET [Result]=0
			where @student_id=stu_id and @Exam_id=Exam_id and @qesid=Qes_id
		END
END
Go
---------------------------------------------------------------------------------------------
--Collect the correct answers degree questions and store it Using CTE 

CREATE or Alter PROCEDURE dbo.UpdateCourseResults
AS
BEGIN
    -- Aggregate results from Student_Exam_Qestion_Composit
    WITH AggregatedResults AS (
        SELECT 
            Stu_id, 
            Exam_id, 
            SUM(Result) AS TotalResult
        FROM 
            dbo.Student_Exam_Qestion_Composit
        GROUP BY 
            Stu_id, 
            Exam_id 
							)
    
    -- Update Student_Cours_Composit with aggregated results
    UPDATE sc
    SET 
        sc.St_Degree = ar.TotalResult
    FROM 
        dbo.Student_Cours_Composit sc
    JOIN 
        AggregatedResults ar
    ON 
        sc.Stu_id = ar.Stu_id
    WHERE 
        sc.Crs_id = ar.Exam_id;
END;
Go

----------------------------------------------------------------------------------------------
--The student enters his name and his course then present an exam for this course using Cursor

Create or alter  PROCEDURE GetExamQuestionsForStudent
    @FirstName NVARCHAR(20),
    @LastName NVARCHAR(20),
    @CourseName NVARCHAR(20)
AS
BEGIN
 IF EXISTS (
        SELECT 1
        FROM [dbo].[Student] S
        JOIN [dbo].[Student_Cours_Composit] SC ON S.St_Id = SC.Stu_id
        JOIN [dbo].[Course] C ON SC.Crs_id = C.Crs_Id
        WHERE S.Fname = @FirstName AND S.Lname = @LastName AND C.Crs_Name = @CourseName
    )
    BEGIN
	 DECLARE @Qestions NVARCHAR(MAX);
     

        DECLARE question_cursor CURSOR FOR
        SELECT Q.Qestions
        FROM [dbo].[Qestion] Q
        JOIN [dbo].[Course] C ON Q.Crs_id = C.Crs_Id
        WHERE C.Crs_Name = @CourseName;

        OPEN question_cursor;

        FETCH NEXT FROM question_cursor INTO @Qestions

        WHILE @@FETCH_STATUS = 0
        BEGIN
         
            select  'Question: ' + @Qestions;
            
            
            -- - Bring the next question
            FETCH NEXT FROM question_cursor INTO @Qestions
        END

        CLOSE question_cursor;
        DEALLOCATE question_cursor;
    END
    ELSE
    BEGIN
        select 'The student who is not registered in this course.';
    END
END
Go
--------------------------------------------------------------------------------------------------------
--Get student's name and his course then display his grade

Create or alter PROCEDURE Getdegreeofcorse
    @FirstName NVARCHAR(20),
    @LastName NVARCHAR(20),
    @CourseName NVARCHAR(20)
AS
BEGIN
 IF EXISTS (
        SELECT 1
        FROM [dbo].[Student] S
        JOIN [dbo].[Student_Cours_Composit] SC ON S.St_Id = SC.Stu_id
        JOIN [dbo].[Course] C ON SC.Crs_id = C.Crs_Id
        WHERE S.Fname = @FirstName AND S.Lname = @LastName AND C.Crs_Name = @CourseName
    )
	select sc.St_Degree , s.Fname+' '+s.Lname as fullname ,  c.Crs_Name from Student_Cours_Composit  sc
	join Student  s on s.St_Id = sc.Stu_id
	join Course  c on sc.Crs_id=c.Crs_Id
	where c.Crs_Name = @CourseName and s.Fname =@FirstName and s.Lname = @LastName 
end 
Go

--------------------------------------------------------------------------------------------------------
---Create New Exam

create or alter proc CreateExam 
@inst_id int  ,@Email nvarchar(20),@password varchar(20) ,@exam_id int ,@exam_type nvarchar(30) 
, @exam_start datetime ,@exam_end datetime, @num_of_question int , @total_degree float  ,@cr_id int 
as 
begin  
      if exists (select 1 from log_account where id= @inst_id and Email = @Email and  Pass_word =@password)
	   and exists (select 1 from Course where Inst_id =@inst_id and Crs_id = @cr_id )
	   begin
	         begin try 
	                  insert into Exam (Exa_Id,Exam_Type , Exam_Start,Exam_End ,Number_ofQestion,Total_Dagree,Crs_id)
					  values (@exam_id ,@exam_type ,@exam_start ,@exam_end ,@num_of_question , @total_degree ,@cr_id)
	         end try 
	         begin catch 
	                    print ('You can not have a permession to create exam for this course.')
		     end catch 
		end
end ;




--------------------------------------------------------------------------------------------------------
-----------------------------------------Test Query-----------------------------------

insert into Instruc_Qesti_Exam_Cours_Composit (Inst_id ,Qesti_id,Exam_id ,Crs_id  ,Qestion_Degree)
values (1,2,1,1,4)
select * from Instruc_Qesti_Exam_Cours_Composit
-----------------
go

insert into Student_Exam_Qestion_Composit ( [Stu_id],[Exam_id],[Qes_id]  ,[Answer])
values (2,1,2,'0')
select * from Student_Exam_Qestion_Composit
-----------------
exec CheckandStoreAnswer  2,1,2,'0'
------------------
exec UpdateCourseResults 
------------------
exec GetExamQuestionsForStudent ahmed,Mohamed,css  --Fales 
exec GetExamQuestionsForStudent ahmed,Mohamed,sql  --True
------------------
exec Getdegreeofcorse Mostafa,Abdullah,HTML
----------------
exec CreateExam 1,'abdoali@gmail','AsDf123545',1,'boolen','1/2/2024 12:30','1/2/2024 13:30',2,60,1
----------------







