use LAB1_2DB

--1
select * from Genre where GenreName = 'Поезия'
--2
select * from Author where FullName = 'Пастернак'
--3
select FullName from Buyer
--4
select BookName, PublisherId from Book order by BookName
--5
select * from Book cross join Supplier
--6
select * from Publisher cross join Book
select P.PublisherName, B.BookName from Publisher P cross join Book B
--7
select A.FullName, B.BookName, B.PublishingYear from Author A join Book B on A.AuthorId = B.AuthorId
--8
select B.BookName from Book B join Publisher P on B.PublisherId = P.PublisherId where P.City = 'Киев'
--9
select B.BookName, G.GenreName, B.PublishingYear, B.CopiesNumber from Book B join Genre G on B.GenreId = G.GenreId where B.Price = 100 or B.Price = 150 order by BookName
--10
select A.FullName, B.BookName, B.PublishingYear, B.CopiesNumber from Author A join Book B on A.AuthorId = B.AuthorId where (A.DeathDate > '01-01-2001' and A.DeathDate < '31-12-2014') or DeathDate is null order by A.FullName
--11
select A.FullName, B.BookName, G.GenreName, P.PublisherName, S.SupplierName from Book B join Author A on B.AuthorId = A.AuthorId join Genre G on B.GenreId = G.GenreId join Publisher P on B.PublisherId = P.PublisherId join Supplier S on B.SupplierId = S.SupplierId order by A.FullName
--12
select Bu.FullName 'Buyer Name', B.BookName, O.OrderDate from Orders O join Book B on O.BookId = B.BookId join Buyer Bu on O.BuyerId = Bu.BuyerId where B.Price > 200 and (O.OrderDate > '2015-01-01' and O.OrderDate < '2015-04-01')
--13
select Bu.FullName 'Buyer Name', B.BookName, O.OrderDate from Orders O join Book B on O.BookId = B.BookId join Buyer Bu on O.BuyerId = Bu.BuyerId where B.PublishingYear != '1901-01-01' and B.PublishingYear != '1927-01-01' order by Bu.FullName
--14
select Buyer.FullName 'Buyer Name', Supplier.SupplierName, Publisher.PublisherName, Genre.GenreName, Author.FullName 'Author Name', Book.BookName from Orders 
join Buyer on Orders.BuyerId = Buyer.BuyerId 
join Book on Orders.BookId = Book.BookId 
join Supplier on Supplier.SupplierId = Book.SupplierId 
join Publisher on Publisher.PublisherId = Book.PublisherId
join Genre on Genre.GenreId = Book.GenreId 
join Author on Book.AuthorId = Author.AuthorId
--15
select Genre.GenreName, COUNT(Author.AuthorId) from Book join Genre on Genre.GenreId = Book.GenreId join Author on Book.AuthorId = Author.AuthorId group by Genre.GenreName
--16
select Genre.GenreName, COUNT(Book.BookId) from Book join Genre on Genre.GenreId = Book.GenreId join Publisher on Book.PublisherId = Publisher.PublisherId where Publisher.City = 'Киев' group by Genre.GenreName
--17
select Buyer.FullName, Buyer.DeliveryAdress, Buyer.Phone, Orders.Quantity from Orders join Buyer on Orders.BuyerId = Buyer.BuyerId join Book on Orders.BookId = Book.BookId join Genre on Book.GenreId = Genre.GenreId where GenreName = 'Sci-Fi'
--18
select Book.BookName, Buyer.FullName, Orders.OrderDate from Orders join Book on Orders.BookId = Book.BookId join Buyer on Orders.BuyerId = Buyer.BuyerId where Orders.OrderDate between '01-06-1900' and '07-06-2100'
--19
select Book.BookName, Orders.OrderDate from Book full outer join Orders on Orders.BookId = Book.BookId
--20
select Genre.GenreName, Book.BookName from Genre full outer join Book on Book.GenreId = Genre.GenreId