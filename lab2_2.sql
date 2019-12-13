USE LAB1_2DB

--1
select * from Author
select * from Buyer
select * from Publisher
--2
select distinct BookName, PublishingYear, Price from Book
--3
select FullName, AuthorId, Homeland from Author where Homeland != 'Kyiv'
--4
select FullName, AuthorId, Homeland from Author where Homeland = 'Kyiv' or Homeland = 'Cher%'
--5
select FullName, AuthorId, Homeland from Author where (Homeland = 'Kyiv' and FullName = 'Oleg%')  or Homeland = 'Odessa'
--6
USE UNIVERSITY_DB
select Name, Surname, Patronymic, Stipendiya, StudentId, BirthdayCity from Student where Name = 'Назар'/*'Олег'*/ and (BirthdayCity = 'Киев' or BirthdayCity = 'Одесса') 
USE LAB1_2DB
--7
select FullName, BirthDate, AuthorId from Author where BirthDate > '1801-01-01' and BirthDate < '1901-12-31'
--8
select * from Orders where (BookId = 1 or BookId = 2 or BookId = 3 or BookId = 5) and (BuyerId = 1 or BuyerId = 8)
--9
select * from Buyer where FullName = 'Пет%'
--10
select * from Author where BirthDate >= '1966-01-01' and BirthDate <= '1966-12-31'
--11.12
select * from Buyer where Phone != '050%'
--13
select distinct B.BookName, B.Price from Book B group by B.BookName, B.Price order by B.BookName desc, B.Price desc
--14
select COUNT(PublisherId) PublisherCount from Publisher
--15,16
select COUNT(FullName) AuthorNameCnt from Author
--17
select COUNT(BookId) BookCount, MIN(Price) minPrice, MAX(Price) maxPrice, AVG(Price) avgPrice from Book
--18
select pub.PublisherName, COUNT(bk.BookId) BookCount, MIN(bk.Price) minPrice, MAX(bk.Price) maxPrice, AVG(bk.Price) avgPrice from Publisher pub 
join Book bk on pub.PublisherId = bk.PublisherId group by pub.PublisherName
--19
select COUNT(distinct FullName) UniqueQty from Author
--20
select COUNT(case when FullName like 'M%' then 1 end) Qty from Author
--21
select COUNT(AuthorId) 'Author Count', Homeland from Author group by Homeland order by Homeland
--22
select OrderDate, COUNT(BuyerId) 'Buyers Count', COUNT(BookId) 'Books Count' from Orders group by OrderDate
--23
select B.BookName, COUNT(O.BuyerId) 'Buyers Count' from Book B join Orders O on B.BookId = O.BookId where O.Quantity = 5 group by B.BookName
--24
select OrderDate, COUNT(OrderId) 'Orders Count' from Orders group by OrderDate order by OrderDate
--25
select OrderDate, COUNT(OrderId) 'Orders Count' from Orders group by OrderDate having COUNT(OrderId) > 5 order by OrderDate
--26
select PublishingYear, AVG(Price) 'AVG Price' from Book where SupplyDate > '2012-01-01' and SupplyDate < '2014-12-31' group by PublishingYear
--27
select COUNT(FullName) from Author
select distinct COUNT(FullName) from Author
--28
select B.FullName from Buyer B join Orders O on B.BuyerId = O.BuyerId group by B.FullName having AVG(O.BookId * O.Quantity) > 3 
--29
select G.GenreName, AVG(B.Price) 'AVG Price' from Book B join Genre G on B.GenreId = G.GenreId group by G.GenreName having AVG(B.Price) >= 150
