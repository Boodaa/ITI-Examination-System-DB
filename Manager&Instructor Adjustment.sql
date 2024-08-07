---------------------------------------------Manager --------------------------------------------------------
----------------Manager Adjust instructors , courses ,student ,track , intake and Branch-----------------
-----Adjust Branch in single SP

Create or Alter Proc Adjust_Branch_By_Manager (@Adjust nvarchar(10) ,@Bra_id int
										,@Bra_loc nvarchar(20), @Manager_id int )
as
Begin

		If @Adjust = 'Update'
			Begin
				Update [dbo].[Branch]
				Set [Branch_Location] = @Bra_loc ,[Manager_id] = @Manager_id 
				Where Bra_Id = @Bra_id
			End
		Else if @Adjust = 'Insert'
			Begin
				Insert Into [dbo].[Branch]
				Values (@Bra_loc,@Manager_id)
			End
	
		Else if	 @Adjust = 'Delete'
			Begin
				Delete 
				From [dbo].[Branch]
				Where Bra_Id = @Bra_id
			End

		Else 
			Print('Incorrect Adjust')

End

Go
-----------------------------------------------------------------
-----Adjust Instructor in single SP

Create or Alter Proc Adjust_Instructor_By_Manager (@Adjust nvarchar(10) ,@inst_id int ,@inst_fname nvarchar(20)
									,@inst_lname nvarchar(20),@Email nvarchar(20),@Password nvarchar(20))
as
Begin

		If @Adjust = 'Update'
			Begin
				Update [dbo].[Instructor]
				Set   [Fname] = @inst_fname , [Lname] = @inst_lname , [Email] = @Email 
				    , [Pass_Word]= @Password 
				Where [Id] = @inst_id
			End
		Else if @Adjust = 'Insert'
			Begin
				Insert Into [dbo].[Instructor]
				Values ( @inst_fname,@inst_lname,@Email,@Password )
			End
	
		Else if	 @Adjust = 'Delete'
			Begin
				Delete 
				From [dbo].[Instructor]
				Where [Id] = @inst_id
			End

		Else 
			Print('Incorrect Adjust')

End

Go

-----------------------------------------------------------------
-----Adjust Student in single SP

Create or Alter Proc Adjust_Student_By_Manager (@Adjust nvarchar(10) ,@Stu_id int ,@Stu_fname nvarchar(20)
						   ,@Stu_lname nvarchar(20),@Email nvarchar(20),@Password nvarchar(20),@Bra_id int
				    		,@Tra_id int ,@Int_id int)
as
Begin

		If @Adjust = 'Update'
			Begin
				Update [dbo].Student
				Set  [Fname] = @Stu_fname , [Lname] = @Stu_lname , [Email] = @Email  
					,[Pass_Word]= @Password 
					, Brach_id = @Bra_id , Track_id = @Tra_id , intak_id = @Int_id 
				Where [St_Id] = @Stu_id
			End
		Else if @Adjust = 'Insert'
			Begin
				Insert Into [dbo].Student
				Values ( @Stu_fname,@Stu_lname,@Email,@Password ,@Bra_id ,@Tra_id ,@Int_id)
			End
	
		Else if	 @Adjust = 'Delete'
			Begin
				Delete 
				From [dbo].Student
				Where [St_Id] = @Stu_id
			End

		Else 
			Print('Incorrect Adjust')

End

Go

-----------------------------------------------------------------
-----Adjust Course in single SP

Create or Alter Proc Adjust_Course_By_Manager (@Adjust nvarchar(10) ,@Crs_id int ,@Crs_name nvarchar(20)
			   ,@Crs_Desc nvarchar(20),@Min_degree Float ,@Max_degree Float ,@Ins_id int , @Trac_id int)
as
Begin

		If @Adjust = 'Update'
			Begin
				Update [dbo].[Course]
				Set   Crs_Name = @Crs_name , Crds_Desc = @Crs_Desc , Min_Dagree = @Min_degree 
					, Max_Dagree= @Max_degree
					, Inst_Id = @Ins_id , Trac_id = @Trac_id
				Where Crs_Id = @Crs_id
			End
		Else if @Adjust = 'Insert'
			Begin
				Insert Into [dbo].[Course]
				Values ( @Crs_name,@Crs_Desc,@Min_degree,@Max_degree ,@Ins_id ,@Trac_id)
			End
	
		Else if	 @Adjust = 'Delete'
			Begin
				Delete 
				From [dbo].[Course]
				Where Crs_Id = @Crs_id
			End

		Else 
			Print('Incorrect Adjust')

End

Go

-----------------------------------------------------------------
-----Adjust Track in single SP

Create or Alter Proc Adjust_Track_By_Manager (@Adjust nvarchar(10) ,@Tra_id int ,@Trac_name nvarchar(20))
as
Begin

		If @Adjust = 'Update'
			Begin
				Update [dbo].Track
				Set [Track_Name] = @Trac_name 
				Where Tra_Id = @Tra_id
			End
		Else if @Adjust = 'Insert'
			Begin
				Insert Into [dbo].Track
				Values ( @Trac_name)
			End
	
		Else if	 @Adjust = 'Delete'
			Begin
				Delete 
				From [dbo].Track
				Where Tra_Id = @Tra_id
			End

		Else 
			Print('Incorrect Adjust')

End

Go 


-----------------------------------------------------------------
-----Adjust Intake in single SP

Create or Alter Proc Adjust_Intake_By_Manager (@Adjust nvarchar(10) ,@Int_id int 
											  ,@Inta_name nvarchar(20) ,@Inta_Year Date )
as
Begin

		If @Adjust = 'Update'
			Begin
				Update [dbo].Intake
				Set Intake_Name = @Inta_name , Intake_Year = @Inta_Year
				Where Int_Id = @Int_id
			End
		Else if @Adjust = 'Insert'
			Begin
				Insert Into [dbo].Intake
				Values ( @Inta_name , @Inta_Year)
			End
	
		Else if	 @Adjust = 'Delete'
			Begin
				Delete 
				From [dbo].Intake
				Where Int_Id = @Int_id	
			End

		Else 
			Print('Incorrect Adjust')

End
Go

------------------------------------------------------------------------------------------------------------
----------------------------------------- Instructor --------------------------------------------------------
-------- Instructor Update , Delete and Add Qestions after checking his credintial 

create or alter proc UpdateQes 
@Qes_id int , @Ins_id int , @Qestio_type nvarchar(100) , @Email varchar(20) , 
@password varchar(15) , @Qestions nvarchar(50) , @Qestion_Answer varchar(100)
as 
begin  
     if exists ( select 1 from log_account where Inst_id = @Ins_id and Email = @Email and  Pass_word = @password )
	             begin 
				      update Qestion set Qestio__Type = @Qestio_type , Qestion_Answer = @Qestion_Answer , Qestions = @Qestions 
					  where Qes_Id = @Qes_id 
				 end
	else 
	     begin 
		      print ('You do not have premission')
		end 
end ;
Go
---------------------------------------------------------------------------------------------------------------------------------
create or alter proc DeleteQes 
@Qes_id int , @Ins_id int , @Email Varchar(20) , @password varchar(20)
as 
begin  
     if exists ( select 1 from log_account where Inst_id = @Ins_id and Email = @Email and  Pass_word = @password )
	             begin 
				      delete from Qestion
					  where Qes_Id = @Qes_id 
					  print ('Question deleted successfully.')
				 end
	else 
	     begin 
		      print ('You do not have permession for deleting.')
		end 
end ;
Go
------------------------------------------------------------------------------------------------------------------------
CREATE OR ALTER proc addQes 
@Qes_id INT,@Ins_id INT,@Email VARCHAR(20),@password VARCHAR(20),
@Qestions NVARCHAR(50),@Qestion_Answer VARCHAR(100),@Qestio_type NVARCHAR(100),@cr_id INT
AS  
BEGIN
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM log_account WHERE Inst_id = @Ins_id AND Email = @Email AND Pass_word = @password)
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM Qestion WHERE Qes_Id = @Qes_id)
            BEGIN
                INSERT INTO Qestion (Qes_Id, Qestio__Type, Qestion_Answer, Qestions, Crs_id)
                VALUES (@Qes_id, @Qestio_type, @Qestion_Answer, @Qestions, @cr_id);
                PRINT 'Question added successfully.';
            END
            ELSE
            BEGIN
                PRINT 'Question already exists in database.';
            END;
        END

 END TRY
    BEGIN CATCH
        PRINT ('You do not hav permission for adding.');
    END CATCH;
END;

------------------------------------------------------------------------------------------------------
--Instructor Create Exam Randomly Using CTE Table and NEWID() Function

Go
Create or Alter Proc Create_Random_Exam 
 @ins_id int  ,
 @crs_id int  ,
 @q_degree int 
as

With Get_Ques_id as(Select top (1) Qes_Id From Qestion q Where q.Crs_id = @crs_id order by NEWID())

insert into [dbo].[Instruc_Qesti_Exam_Cours_Composit] 
([Inst_id] ,Crs_id ,[Qesti_id],[Exam_id],[Qestion_Degree])

Select top (1)[Inst_id] =@ins_id ,Crs_id = @crs_id ,g.Qes_Id ,e.Exa_Id , @q_degree 
From Exam e inner join  Qestion q inner join Get_Ques_id g
on  Crs_id = q.Crs_id And Crs_id = @crs_id 
on q.Qes_Id =g.Qes_Id

Go
---------------------------------------------------------------------------------------------------
--Instructor select students that can do specific exam

Create or alter Proc Slect_Stud_for_exam @Stu_id int 
as
insert into [dbo].[Student_Exam_Qestion_Composit]
(Stu_id ,Exam_id,Qes_id)
Select b.Stu_id , a.Exam_id , a.Qesti_id
From [dbo].[Instruc_Qesti_Exam_Cours_Composit] A inner join [dbo].[Student_Cours_Composit] B
on  A.Crs_id = B.Crs_id
And B.Stu_id =@Stu_id
Go


--------------------------------------------------------------------------------------------------------------------
------------------------------------Test Query-------------------------------------

Exec Create_Random_Exam 2,2,30
------------------------
Exec Slect_Stud_for_exam 1 
-------------------
Exec UpdateQes 1,1,'boolen','abdosayed@yahoo','asAS159789','',''
-------------------
Exec DeleteQes 1,1,'abdosayed@yahoo','asAS159789'
-------------------
Exec addQes 1,1,'abdosayed@yahoo','asAS159789','','',1,'boolen'
-------------------
Execute Adjust_Branch_By_Manager
--------------------
Execute Adjust_Instructor_By_Manager
-------------------
Execute Adjust_Student_By_Manager
-------------------
Execute Adjust_Course_By_Manager
--------------------
Execute Adjust_Track_By_Manager
--------------------
Execute Adjust_Intake_By_Manager
--------------------- 
Execute Check_Login
---------------------
Execute Display_Own_Qestion
----------------------
Execute Update_Qestion














