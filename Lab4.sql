use UNIVERSITY_DB
go
--1
select Surname, Name, Patronymic
from Employee
where EmployeeId in ('1','2','3','4','6','8','20','22','23')
group by Surname, Name, Patronymic
order by Surname, Name, Patronymic
--2
select Surname, Name, Patronymic
from Employee
where EmployeeId not in ('1','2','3','4','6','8','20','22','23')
group by Surname, Name, Patronymic
order by Surname, Name, Patronymic
--3
select Surname, Name, Patronymic
from Student
where StudentId in ('1','2','3','4','6','7','8','9','10')
group by Surname, Name, Patronymic
order by Surname, Name, Patronymic
--4
select Name
from DcDuties
where DcDutiesId not in ('7')
group by Name
order by Name
--5
select Name
from DcSubdivision
where DcSubdivisionID not in ('1','2')
group by Name
order by Name
--6
select s.Surname, s.Name, s.Patronymic, s.RecordBook, g.Name 
from Student s
join StudyGroup g on s.StudyGroupId = g.StudyGroupId
where StudentId in 
	(select StudentId
	from Exam
	where Mark = '5'
	group by StudentId)
order by s.Surname, s.Name, s.Patronymic, s.RecordBook, g.Name
--7
--1
select Em.Surname, Em.Name, Em.Patronymic 
from Employee Em
--2
select Em.Surname, Em.Name, Em.Patronymic, DD.Name
from Exam Ex
join Employee Em on Ex.EmployeeId = Em.EmployeeId
join DcDuties DD on Em.DcDutiesId = DD.DcDutiesId
where Ex.DcDisciplineId = '1'
--8
select Em.Surname, Em.Name, Em.Patronymic, Em.Oklad, Em.Nadbavka, dd.Name, DS.Name
from Employee Em
join DcDuties DD on Em.DcDutiesId = DD.DcDutiesId
join DcSubdivision DS on DD.DcSubdivisionID = DS.DcSubdivisionID
where Em.Nadbavka >= '450' and Em.Oklad > 
	(select AVG(Oklad)
	from Employee)
--9
select s.Surname, s.Name, s.Patronymic, s.RecordBook, g.Name, e.Mark
from Exam e
join Student s on e.StudentId = s.StudentId
join StudyGroup g on s.StudyGroupId = g.StudyGroupId
where Mark >= 
	(select AVG(Mark)
	from Exam)
--10
select s.Name, AVG(Mark)
from Exam e
join Student s on e.StudentId = s.StudentId
group by s.Name
having AVG(Mark) >
	(select AVG(Mark)
	from Exam)
--11
select *
from Employee
where BirthdayCity in
	(select BirthdayCity
	from Employee
	where EmployeeId = '1')
--12
select *
from Employee
where Oklad >
	(select AVG(Oklad)
	from Employee) and DcDutiesId in
	(select DcDutiesId
	from Employee
	where Surname = 'Мацуки')
order by Surname desc
--13
select *
from Student
where StudyGroupId in 
	(select StudyGroupId
	from Student
	where Surname = 'Масливець')
--14
select COUNT(tt.t)
from 
	(select COUNT(DcDutiesId) t
	from Employee
	group by DcDutiesId) as tt
where tt.t > '2'
--15
select COUNT(tt.t)
from
	(select COUNT(StudyGroupId) t
	from Student
	group by StudyGroupId) tt
where tt.t > '5'
--16
select COUNT(tt.t)
from 
	(select COUNT(ExamId) t
	from Exam
	group by DcDisciplineId, StudentId) tt
where tt.t > '1'
--17
select s.Surname, s.Name, S.Patronymic, tt.t, g.Name, tt2.t2, d.Name
from Student s
join 
	(select studentId, AVG(Mark) t
	from Exam
	group by StudentId) tt on s.StudentId = tt.StudentId
join StudyGroup g on s.StudyGroupId = g.StudyGroupId
join DcSubdivision d on g.DcSubdivisionID = d.DcSubdivisionID
join 
	(select StudyGroupId, AVG(Mark) t2
	from Exam
	join Student st on Exam.StudentId = st.StudentId
	group by StudyGroupId) tt2 on g.StudyGroupId = tt2.t2
where tt.t > tt2.t2
--18
select s.StudentId, s.Surname, s.Name, S.Patronymic, tt.t
from Student s
join 
	(select studentId, AVG(tt2.t2) t
	from 
		(select studentId, MAX(Mark) t2
		from Exam
		group by StudentId,DcDisciplineId) tt2
	group by StudentId) tt on s.StudentId = tt.StudentId
--19
select s.StudentId, s.Surname, s.Name, S.Patronymic,tt.t
from Student s
join 
	(select StudentId, AVG(Mark) t
	from Exam
	group by StudentId) tt on s.StudentId = tt.StudentId
where tt.t = '5'
--20
select * 
from Employee
join 
	(select EmployeeId
	from Exam e
	join DcDiscipline dd on e.DcDisciplineId = dd.DcDisciplineId
	where Name in ('Математика','Физика')
	group by EmployeeId) tt on Employee.EmployeeId = tt.EmployeeId