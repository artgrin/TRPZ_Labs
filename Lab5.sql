use UNIVERSITY_DB
go

--1
select Surname, Name, Patronymic
from Student
union
select Surname, Name, Patronymic
from Employee
--2
select Surname, Name, Patronymic, BirthdayCity, Birthday
from Student
union
select Surname, Name, Patronymic, BirthdayCity, Birthday
from Employee
group by Surname, Name, Patronymic, BirthdayCity, Birthday
--3
select BirthdayCity
from Employee
except
select BirthdayCity
from Student
--4
select BirthdayCity
from Employee
intersect
select BirthdayCity
from Student
--5
select EmployeeId
from Employee
intersect 
select EmployeeId
from Exam e
join DcDiscipline dd on e.DcDisciplineId = dd.DcDisciplineId
where Name = 'Математика' or Name = 'Физика'

drop database if exists zkVnzCopy 
create database zkVnzCopy
go
use zkVnzCopy
go
create table DcSubdivisionCopyA (
	DcSubdivisionID int Not null,
	Name varchar(250) Not null,
	Constraint PK_DcSubdivisionCopyA_DcSubdivisionId primary key clustered(DcSubdivisionId)
)
go
create table DcSubdivisionCopyB (
	DcSubdivisionID int Not null,
	Name varchar(250) Not null,
	Abraviature Varchar(5) null,
	Constraint PK_DcSubdivisionCopyB_DcSubdivisionId primary key clustered(DcSubdivisionId)
)
go
create table DcSubdivisionCopyC (
	DcSubdivisionID int Not null,
	Name varchar(250) Not null,
	Constraint PK_DcSubdivisionCopyC_DcSubdivisionId primary key clustered(DcSubdivisionId)
)
go 
insert into DcSubdivisionCopyA 
	select DcSubdivisionID, Name
	from UNIVERSITY_DB..DcSubdivision
go 
insert into DcSubdivisionCopyB (DcSubdivisionID,Name)
	select DcSubdivisionID, Name
	from UNIVERSITY_DB..DcSubdivision
go
--2 
insert into DcSubdivisionCopyC 
	select DcSubdivisionID, Name
	from UNIVERSITY_DB..DcSubdivision
	where DcSubdivisionID > '5'
go
--3
create table DcDisciplineCopy(
	DcDisciplineId int Not null,
	Name varchar(250) Not null,
	Constraint PK_DcDiscipline_DcDisciplineId primary key clustered(DcDisciplineId)
)
go
insert into DcDisciplineCopy
	select *
	from UNIVERSITY_DB..DcDiscipline
	where DcDisciplineId > '6' or DcDisciplineId < '3'
go
--4
create table ExamCopy(
	ExamId int not null,
	Mark int not null,
	DateExam date not null,
	StudentId int not null,
	DcDisciplineId int not null,
	EmployeeId int not null
)
go
insert into ExamCopy
	select *
	from UNIVERSITY_DB..Exam
	where Mark = '5'
go
--5
create table DcDisciplineCopyNew(
	DcDisciplineId int Not null,
	Name varchar(250) Not null,
	Constraint PK_DcDisciplineCopyNew_DcDisciplineId primary key clustered(DcDisciplineId)
)
go
insert into DcDisciplineCopyNew
	select *
	from UNIVERSITY_DB..DcDiscipline
go
--6
use UNIVERSITY_DB
go
update Student
set RecordBook = 'ІК24-03-01'
where Surname = 'Персиков'
--7
update Student
set BirthdayCity = 'Прага'
where StudentId >= '5' and StudentId <= '10'
--8
update Employee
set Oklad = Oklad * 1.25
where DcDutiesId in (
	select DcDutiesId
	from DcDuties
	where Name = 'Професор' or Name = 'Доцент')
--9
update Employee
set Oklad = Oklad * 1.7
where Oklad in (
	select MIN(Oklad)
	from Employee)
--10
update Employee
set Oklad = Oklad * 2
where Oklad in (
	select MAX(Oklad)
	from Employee)
--11
Alter table Student
add DataZachislennya date null
go

update Student
set DataZachislennya = '20050901'
where StudyGroupId = (
	select StudyGroupId
	from StudyGroup
	where Name = 'ІК-11');
--12
delete Exam
where StudentId > '5' or StudentId < '3'
--13
delete Exam
where StudentId in (
	select StudentId
	from Student 
	where BirthdayCity = 'Одессы')
--14
delete Student
where StudentId > '4' and StudentId < '8'