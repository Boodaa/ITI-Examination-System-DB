-----------------------------------------------------Creation------------------------------------------------

Use master
Go
--- Createing the Database on the primary and identify the md and log file with name , location ,size and grouth
Create Database Examination_System on Primary 
(	Name = N'Examination_System' , FileName = N'G:\SQL Project\Database\Examination_System.mdf' , Size = 12288KB ,
	MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )

Log on 
(	Name = N'Examination_System_log' , FileName = N'G:\SQL Project\Database\Examination_System_log.ldf' , SIZE = 12288KB ,	
	MAXSIZE = UNLIMITED, FILEGROWTH = 10% )
go

---------------------------------------------------------------------------------------------------
-------------Creating Tables

Create table Instructor 
( Id int identity(1,1) , Fname nvarchar(20) Not Null , Lname nvarchar(20) Not Null
	,Email nvarchar(30) Not Null , Pass_Word nvarchar(20) Not Null , 
	CONSTRAINT Id PRIMARY KEY CLUSTERED (Id )WITH (IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON))

Go
Create table Student 
( St_Id int identity(1,1) , Fname nvarchar(20) Not Null , Lname nvarchar(20) Not Null
	, Email nvarchar(30) Not Null , Pass_Word nvarchar(20) Not Null , Brach_id int Null 
	, Track_id int Null , intak_id int Null 
	CONSTRAINT St_Id PRIMARY KEY CLUSTERED (St_Id )WITH (IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON))

Go
Create table Trainning_Manager 
(Mang_Id int identity(1,1) , Fname nvarchar(20) Not Null , Lname nvarchar(20) Not Null
	, Email nvarchar(30) Not Null , Pass_Word nvarchar(20) Not Null 
	CONSTRAINT Mang_Id PRIMARY KEY CLUSTERED (Mang_Id )WITH (IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON))

Go
Create table Course 
( Crs_Id int identity(1,1) , Crs_Name nvarchar(20)  Not Null , Crds_Desc text , 
	Min_Dagree float Not null ,Max_Dagree float Not null , Inst_Id int Null , Trac_id int Null
	CONSTRAINT Crs_Id PRIMARY KEY CLUSTERED (Crs_Id )WITH (IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON))

Go
Create table Exam 
( Exa_Id int identity(1,1) , Exam_Type nvarchar(20) Not Null , Exam_Start DateTime Not Null
	, Exam_End DateTime Not Null , Number_ofQestion int Not Null , Total_Dagree float ,
	Total_Time As Datediff( Minute , Exam_Start , Exam_End ) , Crs_id int Null 
	CONSTRAINT Exa_Id PRIMARY KEY CLUSTERED (Exa_Id )WITH (IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON))
	
Go
Create table Qestion 
( Qes_Id int identity(1,1) , Qestio__Type nvarchar(20) Not Null , Boolen_Qestion nvarchar(Max) Null
	,Boolen_Qestion_Answer nvarchar(max) Null ,Multichoice_Qestion nvarchar(max) Null
	,Multichoice_Qestion_Answer nvarchar(max) Null , Crs_id int Null 
	CONSTRAINT Qes_Id PRIMARY KEY CLUSTERED (Qes_Id )WITH (IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON))

Go
Create table Intake 
( Int_Id int identity(1,1) , Intake_Name nvarchar(10) Not Null ,Intake_Year Date 
	CONSTRAINT Int_Id PRIMARY KEY CLUSTERED (Int_Id )WITH (IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON))

Go
Create table Branch 
( 
	Bra_Id int identity(1,1) , Branch_Location nvarchar(10) Not Null , Manager_id int Null
	CONSTRAINT Bra_Id PRIMARY KEY CLUSTERED (Bra_Id )WITH (IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON))

Go
Create table Department  
( 
	Dep_Id int identity(1,1) , Dep_Name nvarchar(10) Not Null , Bra_id int Null
	CONSTRAINT Dep_Id PRIMARY KEY CLUSTERED (Dep_Id)WITH (IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON))

	Alter Table Track 
	Alter Column  Track_Name nvarchar(20)
Go
Create table Track 
( Tra_Id int identity(1,1) , Track_Name nvarchar(20) Not Null 
	CONSTRAINT Tra_Id PRIMARY KEY CLUSTERED (Tra_Id )WITH (IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON))

Go
Create Table  Student_Exam_Qestion_Composit 
						(Stu_id int , Exam_id int ,Qes_id int , Primary Key (Exam_id,Stu_id,Qes_id ) 
							,Answer nvarchar(20), Result float)

Go
Create Table Student_Cours_Composit
( Stu_id int , Crs_id int , Primary Key (Crs_id,Stu_id) )

Go
Create Table Track_Branch_Composit
( Branch_id int , Track_id int , Primary key (Track_id,Branch_id) )

Go
Create Table Instruc_Qesti_Exam_Cours_Composit
( Inst_id int , Qesti_id int , Exam_id int ,Crs_id int ,  Primary key (Inst_id ,Crs_id , Qesti_id , Exam_id)
 , Qestion_Degree int Not Null)
Go
 
 Create Table Instructor_Branch_Composit 
 ( Inst_id int , Bra_id int , Primary Key (Inst_id , Bra_id) )


--------------------------------------------------------------------------------------------------
------------------------Foreign Key Constraint

Go
Alter Table Student Add Constraint FK_Sbran_id Foreign Key (Brach_id)
References Branch (Bra_Id)

Go
Alter Table Student Add Constraint FK_STrac_id Foreign Key (Track_id)
References Track (Tra_Id)

Go
Alter Table Student Add Constraint FK_Sinta_id Foreign Key (intak_id)
References Intake (Int_Id)


Go
Alter Table Course Add Constraint FK_CInst_id Foreign Key (Inst_Id)
References  Instructor (Id)

Go
Alter Table Course Add Constraint FK_CTrac_id Foreign Key (Trac_id)
References  Track (Tra_Id)


Go
Alter Table Exam Add Constraint FK_ECrs_id Foreign Key (Crs_id)
References Course (Crs_Id)

Go
Alter Table Qestion Add Constraint FK_QCrs_id Foreign Key (Crs_id)
References Course (Crs_Id)


Go 
Alter Table Branch Add Constraint FK_Manag_id Foreign Key (Manager_id)
References Trainning_Manager (Mang_Id)

Go 
Alter Table Department Add Constraint FK_Dbra_id Foreign Key (Bra_id)
References Branch (Bra_Id)
----------------------------------------------------------------------------------------------
--------------------- Student_Exam_Qestion_Composit Foreign Key

Alter Table Student_Exam_Qestion_Composit Add Constraint FkStudEQ_Composit Foreign Key (Stu_id) 
References Student (St_Id)
Go
Alter Table Student_Exam_Qestion_Composit Add Constraint FkExaSQ_Composit Foreign Key (Exam_id) 
References Exam (Exa_Id)
Go
Alter Table Student_Exam_Qestion_Composit Add Constraint FkQestSE_Composit Foreign Key (Qes_id) 
References Qestion (Qes_Id)


-------------------------------- Student_Cours_Composit Foreign Key

Alter Table Student_Cours_Composit Add Constraint FK_Stud_id Foreign Key (Stu_id)
References Student (St_Id) 

Go
Alter Table Student_Cours_Composit Add Constraint FK_Inta_id Foreign Key (Crs_id)
References Course (Crs_Id)

----------------------------------Track_Branch_Composit Foreign Key

Go
Alter Table Track_Branch_Composit Add Constraint FKTrac_id Foreign Key (Track_id)
References Track (Tra_Id)

Go
Alter Table Track_Branch_Composit Add Constraint FKBran_id Foreign Key (Branch_id)
References Branch (Bra_Id)

------------------------------------Instruc_Qesti_Exam_Crs Foreign Key

Go
Alter Table Instruc_Qesti_Exam_Cours_Composit Add Constraint FKInst_id Foreign Key (Inst_id )
References Instructor (Id) 

Go
Alter Table Instruc_Qesti_Exam_Cours_Composit Add Constraint FKQes_id Foreign Key (Qesti_id)
References Qestion (Qes_Id) 

Go
Alter Table Instruc_Qesti_Exam_Cours_Composit Add Constraint FKExa_id Foreign Key (Exam_id)
References Exam (Exa_Id)

Go
Alter Table Instruc_Qesti_Exam_Cours_Composit Add Constraint FKCrsQIE_id Foreign Key (Crs_id)
References Course (Crs_Id)

--------------------------------------------- Instructor_Cours_Composit Foreign Key

Alter Table Instructor_Cours_Composit Add Constraint FKInstC_id Foreign Key (Inst_id)
References Instructor (Id)

Go
Alter Table Instructor_Cours_Composit Add Constraint FKCrsI_id Foreign Key (Crs_id)
References Course (Crs_Id)

--------------------------------------------- Qestion_Exam_Composit Foreign Key

Go
Alter Table Qestion_Exam_Composit Add Constraint FKQesE_id Foreign Key (Qes_id)
References Qestion (Qes_Id) 

Go
Alter Table Qestion_Exam_Composit Add Constraint FKExaQ_id Foreign Key (Exa_id)
References Exam (Exa_Id)

----------------------------------------------- Instructor_Branch_Composit Foreign Key

Go
Alter Table Instructor_Branch_Composit Add Constraint FKInstB_id Foreign Key (Inst_id)
References Instructor (Id) 

Go
Alter Table Instructor_Branch_Composit Add Constraint FKBraI_id Foreign Key (Bra_id)
References Branch (Bra_Id)

--------------------------------------------------------------------------------------------
----------------------------Creat Rules For Email & Pass

Go
Create Rule Rul_Email as 
@x like '%@Gmail.com' or @x like '%@Yahoo.com' or @x like '%@Icloud.com' or
@x like '%@gmail.com' or @x like '%@yahoo.com' or @x like '%@icloud.com'
Go
sp_bindrule Rul_Email , 'Student.Email'
Go
sp_bindrule Rul_Email , 'Instructor.Email'
Go
sp_bindrule Rul_Email , 'Trainning_Manager.Email'

go
Create Rule Rul_Pass 
as @y Like '%[A-Z]%' And @y Like '%[a-z]%' And @y Like '%[0-9]%'                                                                    -- And @y Like '%[@-#-$-!-$-%-^-&-*-"-'-'-?-~-,-.-/-\-|]%' 

Go
sp_bindrule Rul_Pass ,'Student.Pass_Word'
GO

sp_bindrule Rul_Pass ,'Instructor.Pass_Word'
GO

sp_bindrule Rul_Pass ,'Trainning_Manager.Pass_Word'
GO

-------------------------------------------------------------------------
------------------------------------
--Test
Insert into Student (Fname,Lname,Email,Pass_Word)
Values ('aboq','hamdy','abdohamdy@Yahoo.com','12ab3456AB')























-------------------------------------------
/*Alter Table Exam Add Constraint Check_T_Degree 

Check (Total_Dagree <= (Select Max(Max_Dagree)From Course inner join Exam On Crs_Id =Crs_id )) 

-------------------------------------------
Go
Create Rule Rl_Email as 
@x like '%@Gmail' or @x like '%@Yahoo' or @x like '%@Icloud' or
@x like '%@gmail' or @x like '%@yahoo' or @x like '%@icloud'
Go
Go
Create Rule Rule_Pass 
as @y Like '%[A-Z]%' And @y Like '%[a-z]%' And @y Like '%[0-9]%' And @y Like '%[@-#-$-!-$-%-^-&-*-"-'-'-?-~-,-.-/-\-|]%' 

Go
sp_bindrule Rl_Email ,'Student.Email'
GO

sp_bindrule Rl_Email ,'Instructor.Email'
GO

sp_bindrule Rl_Email ,'Trainning_Manager.Email'

Go
sp_bindrule FR_Pass ,'Student.Pass_Word'
GO

sp_bindrule FR_Pass ,'Instructor.Pass_Word'
GO

sp_bindrule FR_Pass ,'Trainning_Manager.Pass_Word'
GO



*/
------------------------------------------------------------------------------------------------------








