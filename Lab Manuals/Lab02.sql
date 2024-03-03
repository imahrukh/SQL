
--creating a table
create table Students(
	Name varchar(30) not NULL,
	Age int,
	GPA float,
	DOB datetime
)

--addding new column to existing table
alter table Students add Address varchar(50)

--drop existing column from pre-exsiting table
alter table Students drop column [Address]

-- constraints
create table Student1(
	RollNo int not null primary key , --using contraints
	Name varchar (30),
	Age int,
	GPA float,
	DOB datetime
	--Primary key (RollNo): if there is one
	--Primary key ([ROllNo],[Name]):if there is composite key 
)

--add primary key in pre-existing table
alter table Students alter column Name int NOT NULL
alter table Students add constraint Primarykey Primary key (Name)

--see schema of your table
sp_help Students

--add foreign key contraint to tables
create table Staff(
	staffID int Primary key not NULL,
	staffName varchar(50) not NULL,
	staffRole varchar(50) NULL
)
create table School(
	schoolID int Primary key not NULL,
	schoolName varchar (50) NULL,
	schoolDeanId int Foreign key References Staff(staffID) ON DELETE NO ACTION ON UPDATE NO ACTION NOT NULL
--  Referencing col              Referenced table(referenced col   insertion and update specifications
                               --of referencd table)
	)

--adding foreign key to pre existing table
--alter table [name of table]
--add constraint [name of fk] foreign key [referencing col] Refernces [refernced table(refernced col)] insert and update specifications
 alter table Students
 add constraint fkStudents foreign key(Name) References Student1(Name) ON DELETE Cascade ON UPDATE NO ACTION

 --Data Modification Language DML

 --insert rows
INSERT INTO Students
values ('Demian',20, 3.0, '1/1/1990'),
		('Brian', 19, 3.21,'2/12/1999')

INSERT INTO Students(Name, Age, GPA, DOB)
Values ('Ahmed',20, 3.0, '1/1/1990'),
		('Ali', 19, 3.21,'2/12/1999')
GO

--to see the data from table
Select * from Students

--delete rows from table
delete from Students
where Age >20

--delete all data from table
delete from Students
truncate table Student1

--updating the rows
update Students 
set Name ='Ali Ahmed'
where Name ='Ahmed'

--to see all tables in your database
select* from INFORMATION_SCHEMA.TABLES
Lab02.sql
Displaying Lab02.sql.
