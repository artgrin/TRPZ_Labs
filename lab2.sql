use UNIVERSITY_DB

--1
select * from DcDiscipline

select * from DcDuties

select * from StudyGroup

--2
select Surname,Name,Patronymic,Oklad from Employee
group by Surname,Name,Patronymic,Oklad

--3
select DateExam,Mark,StudentId,EmployeeId from Exam

--4
select Surname,Name,Patronymic,Stipendiya,StudentId from Student
where Stipendiya<'300'

--5
select Surname,Name,Patronymic,Stipendiya,StudentId,BirthdayCity from Student
where Stipendiya>'500'and BirthdayCity='Киев'

--6
select Surname,Name,Patronymic,StudentId,BirthdayCity from Student
where BirthdayCity!='Киев'

--7
select Surname,Name,Patronymic,StudentId,BirthdayCity from Student
where (BirthdayCity='Киев') or (BirthdayCity like 'Тер%')

--8
select Surname,Name,Patronymic,Stipendiya,StudentId,BirthdayCity from Student
where (Stipendiya='300'and BirthdayCity='Киев') or (BirthdayCity='Черкассы')

--9
select Surname,Name,Patronymic,Birthday,StudentId from Student
where Birthday>'19890101' and Birthday<'19901231'

--10
select Surname,Name,Patronymic,Birthday,StudentId,Stipendiya from Student
where Birthday>'19890101' and Birthday<'19901231' and Stipendiya>='600'

--11
select Surname,Name,Patronymic,Birthday,StudentId from Student
where Birthday<'19890101' or Birthday>'19901231'

--12
select EmployeeId, DcDisciplineId from Exam
group by EmployeeId, DcDisciplineId

--13
select * from Employee
join DcDuties on Employee.DcDutiesId = DcDuties.DcDutiesId
join DcSubdivision on DcDuties.DcSubdivisionID = DcSubdivision.DcSubdivisionID
where Surname like'Пет%'

--14
select * from Employee
join DcDuties on Employee.DcDutiesId = DcDuties.DcDutiesId
join DcSubdivision on DcDuties.DcSubdivisionID = DcSubdivision.DcSubdivisionID
where Birthday like '1966%'

--15
select * from Employee
join DcDuties on Employee.DcDutiesId = DcDuties.DcDutiesId
join DcSubdivision on DcDuties.DcSubdivisionID = DcSubdivision.DcSubdivisionID
where MONTH(Birthday) = '05'

--16
select * from Employee
join DcDuties on Employee.DcDutiesId = DcDuties.DcDutiesId
join DcSubdivision on DcDuties.DcSubdivisionID = DcSubdivision.DcSubdivisionID
where Birthday like '%05%'

--17
select * from Employee
join DcDuties on Employee.DcDutiesId = DcDuties.DcDutiesId
join DcSubdivision on DcDuties.DcSubdivisionID = DcSubdivision.DcSubdivisionID
where MONTH(Birthday) = '05' and Nadbavka>='500'

--18
select * from Student
join StudyGroup on Student.StudyGroupId = StudyGroup.StudyGroupId
join DcSubdivision on StudyGroup.DcSubdivisionID = DcSubdivision.DcSubdivisionID
where Stipendiya != '500'

--19
select * from Student
join StudyGroup on Student.StudyGroupId = StudyGroup.StudyGroupId
join DcSubdivision on StudyGroup.DcSubdivisionID = DcSubdivision.DcSubdivisionID
where Patronymic is null

--20
select Surname,Employee.Name,Patronymic,EmployeeId from Employee
join DcDuties on Employee.DcDutiesId = DcDuties.DcDutiesId
where DcDuties.Name = 'Професор' and Patronymic is not null

--23
select Surname,Name,Patronymic from Employee
group by Surname, Name, Patronymic
order by Surname, Name, Patronymic

--24
select Stipendiya from Student
group by Stipendiya
order by Stipendiya desc

--25
select COUNT(StudentId) from Student

--26
select COUNT(Surname) from Student
select COUNT(Name) from Student
select COUNT(Patronymic) from Student

--27
select COUNT(Stipendiya) from Student
where Stipendiya='300'

--28
select COUNT(EmployeeId), MAX(Oklad), MIN(Oklad), AVG(Oklad) from Employee

--29
select DD.DcDutiesId ID, COUNT(Em.EmployeeId) N, MAX(Em.Oklad) Max, Min(Em.Oklad) Min, AVG(Em.Oklad) sered from DcDuties DD
join Employee Em on DD.DcDutiesId = Em.DcDutiesId
group by DD.DcDutiesId

--30
select DD.DcDutiesId ID, COUNT(Em.EmployeeId) N, MAX(Em.Oklad) Max, Min(Em.Oklad) Min, AVG(Em.Oklad) sered, MIN(Em.DataVyplatu) from DcDuties DD
join Employee Em on DD.DcDutiesId = Em.DcDutiesId
group by DD.DcDutiesId

--31
select DD.DcDutiesId ID, COUNT(Em.EmployeeId) N, MAX(Em.Oklad) Max, Min(Em.Oklad) Min, AVG(Em.Oklad) sered, MIN(Em.DataVyplatu) from DcDuties DD
join Employee Em on DD.DcDutiesId = Em.DcDutiesId
where DD.Name != 'профессор'
group by DD.DcDutiesId

--32
select COUNT(DISTINCT Surname) from Student

--33
select COUNT(Student.Name) from Student
where Student.Name like 'К%'

--34
select EmployeeId EI from Employee
where Oklad + Nadbavka > '5000'

--35
select BirthdayCity, COUNT(BirthdayCity) N from Employee
group by BirthdayCity
order by BirthdayCity

--36
select Mark, COUNT(s.StudentId) Stud, COUNT(m.EmployeeId) Empl from Exam E
join Student s on E.StudentId = s.StudentId
join Employee m on E.StudentId = m.EmployeeId
group by Mark
--псевдонимы

--37
select DcDiscipline.Name, COUNT(Exam.StudentId) N from DcDiscipline
join Exam on DcDiscipline.DcDisciplineId = Exam.DcDisciplineId
where mark > '2'
group by DcDiscipline.Name

--38
select DcDiscipline.Name, COUNT(Exam.StudentId) N from DcDiscipline
join Exam on DcDiscipline.DcDisciplineId = Exam.DcDisciplineId
where mark = '5'
group by DcDiscipline.Name

--39
select DateExam Дата, COUNT(DateExam) 'Кількість екзаменів' from Exam
group by DateExam

--40
select DateExam Дата, COUNT(DateExam) 'Кількість екзаменів' from Exam
group by DateExam
having COUNT(DateExam) > '5'
order by DateExam
--Если предложение WHERE определяет предикат для фильтрации строк, 
--то предложение HAVING применяется после группировки для определения аналогичного предиката, 
--фильтрующего группы по значениям агрегатных функций.

--41
select * from Student
where BirthdayCity = 'Киев' and Stipendiya <= '500'

--42
select e.Surname, e.Name, e.Patronymic, e.Birthday, e.Oklad, e.Nadbavka, dd.Name from Employee e
join DcDuties dd on e.DcDutiesId = dd.DcDutiesId
where e.Birthday > '19450101' and e.Birthday < '19651231' and (Oklad + Nadbavka) >= '5000'

--43
select BirthdayCity, AVG(Oklad) from Employee
where Birthday > '19450101' and Birthday < '19651231'
group by BirthdayCity

--44
select COUNT(Patronymic) from Employee
--bez povtora
select COUNT(DISTINCT Patronymic) from Employee
select COUNT(Patronymic) from Employee
where Patronymic is null

--45
select AVG(Oklad) from Employee
select SUM(Oklad) / COUNT(Oklad) from Employee
 
--46
select MAX(Oklad), MIN(Oklad), MAX(Oklad) + '100', Min(Oklad) + '100' from Employee

--47
select StudentId, AVG(Mark) from Exam
group by StudentId
having AVG(Mark) > '3'

--48
select Oklad + Nadbavka Viplata from Employee
where Oklad+Nadbavka > '4300'

--49
select dd.Name, AVG(E.Oklad+ e.Nadbavka) from DcDuties DD
join Employee e on dd.DcDutiesId = e.DcDutiesId
group by dd.Name
having AVG(E.Oklad+ e.Nadbavka) > '4500'

--50
select Surname, Name, Patronymic, BirthdayCity from Employee
where (Oklad + Nadbavka) = Oklad
