create database assignment1
use assignment1

create table Departments(
	ID int,
	Name varchar(25) 
)

Select * FROM Departments

Insert into Departments
VALUES (2767543, 'Electrical Engineering'),
		(5427892, 'Civil Engineering'),
		(2476257, 'Mechanical Engineering'),
		(8717635, 'Computer Science'),
		(3876215, 'Mathematics')
Select * FROM Departments

create Table Employee(
	ID_Number int,
	Last_Name varchar(25),
	First_Name varchar(25),
	Dept_ID int
)
Select * FROM Employee

create Table my_Employee(
	ID int NOT NULL,
	Last_Name varchar(25),
	First_Name varchar(25),
	UserID varchar(8),
	Salary decimal(9,2)
)
Select * FROM my_Employee

INSERT INTO my_Employee 
VALUES (1, 'Patel','Ralph','rpatel',795)
Select * FROM my_Employee

INSERT INTO my_Employee (ID, Last_Name, First_Name, UserID, Salary)
VALUES (2, 'Dancs','Betty','bdancs', 860)
SELECT * FROM my_Employee

SELECT * FROM my_Employee

UPDATE my_Employee 
SET Last_Name ='Hammad' WHERE Last_Name='Dancs'

SELECT * FROM my_Employee

UPDATE my_Employee 
SET Salary = 3000 
WHERE Salary Between 500 AND 2000 AND (First_Name LIKE '%t%' OR Last_Name LIKE'%t%')
SELECT * FROM my_Employee

--inserting an employee with salary >5000 to make sure if it works
INSERT INTO my_Employee (ID, Last_Name, First_Name, UserID, Salary)
VALUES (3, 'Raza','Hassan','Hraza', 5200)
SELECT * FROM my_Employee
DELETE FROM my_Employee 
WHERE Salary > 5000
SELECT * FROM my_Employee

--adding constraints for primary key
ALTER Table Departments
ALTER Column ID int not NULL
ALTER Table Departments
ADD UNIQUE(ID)
ALTER Table Departments
ADD Primary Key (ID)

create table myDept1_22L6702(
	Department_ID int Primary key,
	Name varchar(25),
	Location varchar(15)
)
SELECT * FROM myDept1_22L6702

create table myEmp1_L226702(
	ID int Primary key,
	Name varchar(25),
	Dept_ID int FOREIGN KEY REFERENCES myDept1_22L6702 (Department_ID)
)

SELECT * FROM myEmp1_L226702

--applying checks for data types numbers:
ALTER Table Departments add check (ID<10000000)
ALTER Table Employee add check (Dept_ID<10000000)
ALTER Table My_Employee add check (ID<10000)
ALTER Table myEmp1_L226702 add check (Dept_ID<1000)
ALTER Table myDept1_22L6702 add check (Department_ID<1000)

ALTER Table myEmp1_L226702
ALTER Column Name varchar(50)

INSERT INTO myEmp1_L226702 (ID, NAME)
VALUES (2275, 'Muhammad Ahmad Hashim Qureshi')
SELECT * FROM myEmp1_L226702

--getting constraint name from system
SELECT name
FROM sys.key_constraints
WHERE parent_object_id = OBJECT_ID('myEmp1_L226702') AND type = 'PK'

--dropping constraint as cannot modify datatype alongside
ALTER TABLE myEmp1_L226702 
DROP CONSTRAINT PK__myEmp1_L__3214EC27C303455A
ALTER Table myEmp1_L226702
ALTER Column ID bigint

ALTER Table myEmp1_L226702 
ALTER COLUMN ID bigint NOT NULL
ALTER Table myEmp1_L226702 
ADD UNIQUE (ID)
ALTER TABLE myEmp1_L226702 
ADD PRIMARY KEY (ID)

--adding check to bigint
Alter table myEmp1_L226702
ADD check(ID<1000000000000)

UPDATE myEmp1_L226702 
SET ID= 123456789121 
WHERE ID = 2275
SELECT * FROM myEmp1_L226702

INSERT INTO myDept1_22L6702 (Department_ID, Name)
SELECT ID/10000, Name FROM Departments
SELECT * FROM  myDept1_22L6702
--department has id of 7 digits so converting it to 3 digits for myDept1


INSERT INTO myEmp1_L226702
VALUES (226702, 'Mah Rukh',100)
Select* FROM myEmp1_L226702
--not inserted as dept_id is a foreign key and 100 doesnot has a reference of dept_Id in myDept1_22L6702
INSERT INTO myEmp1_L226702
VALUES (226702, 'Mah Rukh',247)
Select* FROM myEmp1_L226702
--inserted as dept_id is refernced as from table myDept and found in dept_id

EXEC sp_rename 'myEmp1_L226702','Emp1_L226702'
EXEC sp_rename 'myDept1_22L6702','Dept1_22L6702'

ALTER TABLE Dept1_22L6702
DROP COLUMN Name;
SELECT* FROM Dept1_22L6702

DROP TABLE Emp1_L226702
SELECT * FROM Emp1_L226702
