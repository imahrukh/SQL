create database FAST
use FAST
Go

create table Students(
	RollNo varchar(7) primary key,
	Name varchar(25) not null,
	Gender varchar(6),
	Phone varchar (12)
	)

create table Teacher(
	teacherID int primary key,
	Name varchar(20),
	Designation varchar(10),
	Department varchar(10)
	)

create table classVenue(
	ID int primary key,
	Building varchar(10),
	RoomNo int,
	teacherID int,
	FOREIGN KEY (teacherID) REFERENCES Teacher(teacherID) on delete no action on update cascade
	)

create table Attendance(
	RollNo varchar(7) FOREIGN KEY  REFERENCES Students(RollNo) on delete no action on update cascade,
	aDate varchar(10),
	astatus varchar(2) not NULL,
	classVenue int FOREIGN KEY REFERENCES classVenue (ID) on delete no action on update cascade
	)

INSERT INTO Students
VALUES
	('L164123', 'Ali Ahmad', 'Male', '0333-3333333'),
	('L164124', 'Rafia Ahmed' ,  'Female', '0333-3456789'),
	('L164125', ' Basit Junaid', 'Male', '0345-3243567')
	
INSERT INTO Attendance
VALUES
	('L164123', '02-22-2016','P', 2),
	('L164124', '02-23-2016' ,  'A', 1),
	('L164125', '03-04-2016', 'P', 2)

INSERT INTO classVenue
VALUES
	(1, 'CS',2, 1),
	(2, 'Civil',7, 2)

INSERT INTO Teacher
VALUES
	(1, 'Sarim Baig', 'Assistant Pof.', 'Computer Science'),
	(2,'Bismillah Jan','Lecturer', 'Civil Eng'),
	(3,'Kashif Zafar', 'Professor', 'Electrical Eng.')

alter table Students  add warningCount int 

--Add new row into Student table, values <L162334, Fozan Shahid, Male, 3.2 >

--INSERT INTO Students VALUES ('L162334', 'Fozan shahid', 'Male', 3.2)
--data type of phone no is varchar but it is given in float values, won't execute

--Add new row into ClassVenue table, values <3, CS, 5, Ali>

--INSERT INTO ClassVenue VALUES (3, 'CS', 5, 'Ali')
--teacherName is int but 'ali' is varchar, so it won't work

--Update Teacher table Change “Kashif zafar” name to “Dr. Kashif Zafar”.

UPDATE TEACHER SET Name = 'Dr Kashif zafar' where Name = 'Kashif zafar'
--will be excecuted

--Delete Students  with rollNo='L162334'
DELETE FROM Students  WHERE rollNo = 'L162334'
--will execute as student has no attendance record

--Delete Student with rollnum L164123
DELETE FROM Students  WHERE rollNo = 'L164123'
--will give error as student has attenfance record

--Delete Attendance with rollnum“L164124”, if his status is absent.
DELETE FROM Attendance WHERE astatus = 'A'
--will exceute

--Alter table and Add CNIC in student table.
alter table Students  add CNIC varchar(17)
Select * FROM Students

--Alter table and drop phone column from student table.
delete from Students where Phone = '0%'

-- Alter table and add unique constraint on teacher name
Alter Table Teacher add constraint UC_Teacher Unique(Name)
-- Alter Student table and allow values only Female and Male for gender.
alter table Students add Constraint CHK_Students check (gender ='Male' OR gender = 'Female')

-- Alter Attendance table and allow A and P as status values only.
alter table Attendance add constraint CHK_Attendance check (astatus = 'A' OR astatus = 'P')
