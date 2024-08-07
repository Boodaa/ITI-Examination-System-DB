-----------------------------------------------------Insertion------------------------------------------------
--Done
INSERT INTO Student (FName,LName,Email,Pass_Word ,Brach_id,Track_id,intak_id)
VALUES('Mostafa','Abdullah','Mostafa@gmail.com','AZ3456SS',4,7,1),
      ('Abanoub','Raafat','Abanoub@gmail.com','ZX5744SS',5,8,2),
      ('Gehad','Mohamed','Gehad@yahoo.com','VC6812SS',6,9,3),
	  ('Mai','Bahaa','Mai@yahoo.com','VC6812SS',7,10,4),
	  ('ahmed','Mohamed','ahmed@yahoo.com','7889asA2SS',5,9,2),
	  ('mostafa','ali','mostafa@yahoo.com','VC6812SS',6,8,3)
	  go

---------------------insert table 2  Instractor------Done--------------------------


INSERT INTO Instructor (FName,LName,Email,Pass_Word)

VALUES ('Sara','Mohamed','Sara@gmail.com','as0569SS'),
       ('Mrihan','Mohamed','mrihan@gmail.com','Nb9876SS'),
       ('Ahmed','mohamed','ahmed@yahoo.com','fG5325SS'),
	   ('ali','ali','ali@yahoo.com','Fg5325SS'),
	   ('loay','hatem','loay@yahoo.com','fg5325SS')
go
----------------insert table 3 TrainingManager ------Done-----------------------------

INSERT INTO Trainning_Manager (FName,LName,Email,Pass_Word)

VALUES ('Ahmed','Othman','Ahmed@gmail.com','abc00SSS'),
       ('Mohamed','Tony','Mohamed@gmail.com','456ASSSS'),
       ('Mohamed','Ahmed','Ahmed@yahoo.com','ERD123SS')
go
----------------create table 4 Course------------------Done-----------------

INSERT INTO Course (Crs_Name ,Crds_Desc,Min_Dagree,Max_Dagree,Inst_Id,Trac_id)

VALUES ('HTML','Learn about web page structure','30','60',1,7),
       ('CSS','Learn about web page Style','30','60',3,9),
       ('Javascript','Learn about web page interactive','30', '60',2,8),
       ('OOP','programming paradigm','30','60',4,10),
	   ('SQL','Learn about structure Query lan','30','60',5,7),
       ('Python','Learn about code Analsis','30','60',2,9),
       ('Power bi','Learn about Dashboards','30','60',1,8 )
       
	go
-------------------- insert table 5 branch ------Done--------------


INSERT INTO Branch (Branch_Location)
VALUES ('Minia'),('Asyut'),
       ('Alexanderia'),('Cairo')
	   go



-------------------- insert table 6  intake ----Done----------------

INSERT INTO Intake (Intake_Name , Intake_Year)
VALUES ('intake 41',GETDATE()),('intake 42',GETDATE()),
       ('intake 43',GETDATE()),('intake 44',GETDATE())
go
--------------------  insert table 7 track ------Done--------------

INSERT INTO Track (Track_Name)
VALUES ('Power BI'),
       ('Full stack MEARN'),
       ('Mobile App'),
       ('Social Media')
 go
-------------------- insert table 8 exam ------dONE--------------


INSERT INTO Exam(Exam_Type,Exam_Start,Exam_End,Number_ofQestion,Total_Dagree,Crs_id)
VALUES ('Normal','2024-8-7 14:30:00','2024-8-7 15:00:00',2,60,1),
      ('Normal','2024-8-8 10:00:00','2024-8-8 11:00:00',2,60,2),
      ('Normal','2024-8-9 11:30:00','2024-8-9 12:00:00',2,60,3),
      ('Corrective','2024-8-10 15:30:00','2024-8-10 16:00:00',2,60,4),
	  ('Normal','2024-8-12 14:30:00','2024-8-7 15:00:00',2,60,5),
      ('Normal','2024-8-15 10:00:00','2024-8-8 11:00:00',2,60,6),
      ('Normal','2024-8-18 11:30:00','2024-8-9 12:00:00',2,60,7)
	  
	  
	  go
-------------------- insert table 9 Question ----dONE----------------
INSERT Qestion (Qestio__Type,Boolen_Qestion,Boolen_Qestion_Answer, Crs_id)
values
 ('Boolen',N'C# purly OOP', 0, 1),
 ('Boolen',N'A relation might have multiple foreign keys?', 1, 2),
 ('Boolen',N'A relation might have multiple foreign keys?', 1, 3),
 ('Boolen',N'Is alter a DDL command?', 1, 4),
 ('Boolen',N'Each column can have more than one data type?', 0, 5),
 ('Boolen',N'The condition in a where clause can refer to only one value?', 0, 6),
 ('Boolen',N'Powerbi Online code ide', 0, 7)
 go

 INSERT Qestion (Qestio__Type, Multichoice_Qestion, Multichoice_Qestion_Answer, Crs_id)
values
 ('Multichoice', N'The first true object oriented language is: a) C++. b) SmallTalk. c) C#.', N'b', 1),
 ('Multichoice', N'The first true object oriented language is: a) C++. b) SmallTalk. c) C#.', N'b', 2),
 ('Multichoice',N'Which of the following is not an SQL command: a) forget. b) select. c) where', N'a', 3),
 ('Multichoice',N'The primary key can be: a) null. b) not null. c) both null and not null.', N'b', 4),
 ('Multichoice',N'The primary key can be: a) null. b) not null. c) both null and not null.', N'b', 5),
 ('Multichoice',N'What is a table joined with itself called: a) Join. b) Outer Join. c) self-join.', N'c', 6),
 ('Multichoice',N'M language in : a) Python. b) Power Query . c) Tablue.', N'b', 7)
 go


 ----------------------------------------------------------------------------------------------------


 Insert into Student_Cours_Composit (Stu_id ,Crs_id )
 Values (3,2),
        (4,3),
		(5,4),
		(6,5),
		(7,6),
		(2,7)
		
-----------------------------------

Insert into Track_Branch_Composit (Branch_id,Track_id)
Values (4,7),(5,8),(6,9),(7,10)
	
-----------------------------


Insert into Instructor_Branch_Composit (Inst_id ,Bra_id) 
Values (1,4),(2,6),(3,5),(4,7),(5,5)





























