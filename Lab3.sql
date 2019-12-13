use UNIVERSITY_DB
go
--1
select * from DcDuties
where Name = 'Професор'
--2
select * from DcDiscipline
where Name = 'Англійська'
--3
select Surname, Name, Patronymic from Student
--4
select Name, DcSubdivisionID from DcDuties
--5 Перекрестное соед. (декартовое)
select dd.Name, ds.Name from DcDuties dd
cross join DcSubdivision ds
--6
select sg.Name, ds.Name from StudyGroup sg
cross join DcSubdivision ds
--7
select (s.Surname + ' ' + s.Name + ' ' + s.Patronymic) ПІБ, sg.Name from Student s
join StudyGroup sg on s.StudyGroupId = sg.StudyGroupId
--8
select dd.Name from DcDuties dd
join DcSubdivision ds on dd.DcSubdivisionID = ds.DcSubdivisionID
where ds.Name = 'Кафедра 1'
--9
select s.Surname, s.Name, s.Patronymic, sg.Name, BirthdayCity, Stipendiya from Student s
join StudyGroup sg on s.StudyGroupId = sg.StudyGroupId
where BirthdayCity = 'Ялта' or BirthdayCity = 'Луцк'
--10
select s.Surname, s.Name, s.Patronymic, sg.Name, Stipendiya from Student s
join StudyGroup sg on s.StudyGroupId = sg.StudyGroupId
where (Stipendiya > '620' and Stipendiya < '800') or Stipendiya is null
order by S.Surname, Stipendiya
--11
select s.Surname, s.Name, s.Patronymic, mark, dd.Name, em.Surname, em.Name, em.Patronymic, du.Name from Exam ex
join Student s on ex.StudentId = s.StudentId
join DcDiscipline dd on ex.DcDisciplineId = dd.DcDisciplineId
join Employee em on ex.EmployeeId = em.EmployeeId
join DcDuties du on em.DcDutiesId = du.DcDutiesId
--12
select e.Surname, e.Name, e.Patronymic, dd.Name, ds.Name from Employee e
join DcDuties dd on e.DcDutiesId = dd.DcDutiesId
join DcSubdivision ds on dd.DcSubdivisionID = ds.DcSubdivisionID
where (e.Oklad + e.Nadbavka) > '3400' and e.DataVyplatu > '20130101' and e.DataVyplatu < '20130401'
--13
select e.Surname, e.Name, e.Patronymic, dd.Name, ds.Name from Employee e
join DcDuties dd on e.DcDutiesId = dd.DcDutiesId
join DcSubdivision ds on dd.DcSubdivisionID = ds.DcSubdivisionID
where ds.Name != 'Кафедра 1' and ds.Name != 'Кафедра 2'
order by e.Surname
--14
select e.Surname, e.Name, e.Patronymic, dd.Name, ds.Name, di.Name, sg.Name from Employee e
join DcDuties dd on e.DcDutiesId = dd.DcDutiesId
join DcSubdivision ds on dd.DcSubdivisionID = ds.DcSubdivisionID
join Exam ex on e.EmployeeId = ex.EmployeeId
join DcDiscipline di on ex.DcDisciplineId = di.DcDisciplineId
join Student s on s.StudentId = ex.StudentId
join StudyGroup sg on s.StudyGroupId = sg.StudyGroupId
order by e.Surname
--15
select sg.Name, COUNT(s.StudentId) from Student s
join StudyGroup sg on sg.StudyGroupId = s.StudyGroupId
group by sg.Name
--16
select sg.Name, COUNT(s.StudentId) from Student s
join StudyGroup sg on sg.StudyGroupId = s.StudyGroupId
join Exam e on s.StudentId = e.StudentId
where Mark = '5'
group by sg.Name
--17
select e.Surname, dd.Name, ds.Name, COUNT(sg.Name) from Employee e
join DcDuties dd on e.DcDutiesId = dd.DcDutiesId
join DcSubdivision ds on dd.DcSubdivisionID = ds.DcSubdivisionID
join Exam ex on e.EmployeeId = ex.EmployeeId
join Student s on s.StudentId = ex.StudentId
join StudyGroup sg on s.StudyGroupId = sg.StudyGroupId
where ds.Name = 'Кафедра 1'
group by e.Surname, dd.Name, ds.Name
--18
select dd.Name, em.Surname, em.Name, em.Patronymic, ex.DateExam from Exam ex
join DcDiscipline dd on dd.DcDisciplineId = ex.DcDisciplineId
join Employee em on em.EmployeeId = ex.EmployeeId
where MONTH(ex.DateExam) = '06' and DAY(ex.DateExam) > '01' and DAY(ex.DateExam) < '07'
order by dd.Name, em.Surname
--19 внешний
select dd.Name, ds.Name from DcSubdivision ds
right join DcDuties dd on ds.DcSubdivisionID = dd.DcSubdivisionID
--20 внешний
select sg.Name, ds.Name from DcSubdivision ds
left join StudyGroup sg on ds.DcSubdivisionID = sg.DcSubdivisionID