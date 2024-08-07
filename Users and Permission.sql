-- Create roles
CREATE ROLE admin_role
CREATE ROLE manager_role
CREATE ROLE instructor_role
CREATE ROLE student_role


CREATE LOGIN admin WITH PASSWORD = 'admin', DEFAULT_DATABASE = [Examination_System]
GO
CREATE LOGIN manager WITH PASSWORD = 'manager', DEFAULT_DATABASE = [Examination_System]
GO
CREATE LOGIN instructor WITH PASSWORD = 'instructor' ,DEFAULT_DATABASE = [Examination_System]
GO
CREATE LOGIN student WITH PASSWORD = 'student' ,DEFAULT_DATABASE = [Examination_System]
GO

-- Create users and assign roles
CREATE USER admin FOR LOGIN admin WITH DEFAULT_SCHEMA = dbo
ALTER ROLE admin_role ADD MEMBER admin


CREATE USER manager FOR LOGIN manager WITH DEFAULT_SCHEMA = dbo
ALTER ROLE manager_role ADD MEMBER manager

CREATE USER instructor FOR LOGIN instructor WITH DEFAULT_SCHEMA = dbo
ALTER ROLE instructor_role ADD MEMBER instructor

CREATE USER student FOR LOGIN student WITH DEFAULT_SCHEMA = dbo
ALTER ROLE student_role ADD MEMBER student

--Admin Permissions--

GRANT ALTER ON DATABASE :: Examination_System TO admin_role
GRANT SELECT, INSERT, UPDATE, DELETE, Execute ON DATABASE :: Examination_System TO admin_role

--Training Manager Permissions--

GRANT EXECUTE ON OBJECT::Adjust_Course_By_Manager TO manager_role
GRANT EXECUTE ON OBJECT::Adjust_Track_By_Manager TO manager_role
GRANT EXECUTE ON OBJECT::Adjust_Intake_By_Manager TO manager_role

GRANT EXECUTE ON OBJECT::Adjust_Branch_By_Manager TO manager_role
GRANT EXECUTE ON OBJECT::Adjust_Instructor_By_Manager TO manager_role
GRANT EXECUTE ON OBJECT::Adjust_Student_By_Manager TO manager_role
GRANT EXECUTE ON OBJECT::AddIntake TO manager_role
GRANT EXECUTE ON OBJECT::UpdateIntakeNames TO manager_role
GRANT EXECUTE ON OBJECT::DeleteIntake TO manager_role

GRANT EXECUTE ON OBJECT::ChechandstoreAnswer TO manager_role, instructor_role
GRANT EXECUTE ON OBJECT::UpdateCourseResults TO manager_role, instructor_role
--Instructor Permissions--

GRANT EXECUTE ON OBJECT::UpdateQes TO instructor_role
GRANT EXECUTE ON OBJECT::CreateExam TO instructor_role
GRANT EXECUTE ON OBJECT::AddQes TO instructor_role
GRANT EXECUTE ON OBJECT::DeleteQes TO instructor_role
GRANT EXECUTE ON OBJECT::Check_login TO instructor_role

GRANT EXECUTE ON OBJECT::Display_Own_Qestion TO instructor_role
GRANT EXECUTE ON OBJECT::Update_Qestion TO instructor_role



--Student Permissions--

GRANT EXECUTE ON OBJECT::GetExamQueationForStudent TO student_role
GRANT EXECUTE ON OBJECT::Getdegreeofcores TO student_role

--Views--

GRANT SELECT ON OBJECT::ExamResults TO manager_role , student_role 
GRANT SELECT ON OBJECT::CoursesWithInstructors TO manager_role
GRANT SELECT ON OBJECT::TrackwithBranches TO manager_role , student_role
GRANT SELECT ON OBJECT::BranchesWithTrainingMangers TO manager_role
GRANT SELECT ON OBJECT::StudentIntakeInfo TO manager_role , student_role
GRANT SELECT ON OBJECT::BranchStudent TO manager_role , student_role


