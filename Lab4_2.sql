use LAB1_2DB

select distinct P.PublisherName from Publisher P join Book B on B.PublisherId = P.PublisherId where B.PublishingYear in ('2010-01-01') order by P.PublisherName

select distinct P.PublisherName from Publisher P left outer join Book B on B.PublisherId = P.PublisherId where B.BookId is NULL order by P.PublisherName

select distinct G.GenreName from Genre G left outer join Book B on B.GenreId = G.GenreId where B.BookId is NULL order by G.GenreName

select distinct Author.FullName from Book join Author on Book.AuthorId = Author.AuthorId join Orders on Book.BookId = Orders.BookId order by Author.FullName

select distinct B.BookName from Book B left outer join Orders O on B.BookId = O.BookId where O.BookId is NULL order by B.BookName

select distinct Supplier.SupplierName, Book.Price, Book.BookName from Book join Supplier on Book.SupplierId = Supplier.SupplierId where BookId in (select BookId from Orders where Quantity = 5)

select Author.FullName, Book.BookName from Book join Author on Book.AuthorId = Author.AuthorId where BookId in (select BookId from Orders join Buyer on Orders.BuyerId = Buyer.BuyerId where Phone = '06705%')

select Author.FullName, Book.BookName, Book.Price, Publisher.PublisherName, Genre.GenreName
from Book join Author on Book.AuthorId = Author.AuthorId join Publisher on Book.PublisherId = Publisher.PublisherId
join Genre on Book.GenreId = Genre.GenreId where Book.Price > (select AVG(Price) from Book) and Book.PublishingYear > '01-01-2005'

select Buyer.FullName, Buyer.DeliveryAdress, Book.BookName, Orders.Quantity 
from Orders join Buyer on Orders.BuyerId = Buyer.BuyerId join Book on Orders.BookId = Book.BookId
where Orders.Quantity >= (select AVG(Quantity) from Orders)

select Author.FullName from Author join Book on Book.AuthorId = Author.AuthorId where Book.Price > (select AVG(Price) from Book)

select * from Author where Homeland = (select Homeland from Author where AuthorId = 3)

select distinct * from Book where GenreId = (select GenreId from Book where BookName = 'Гамлет') and Price > (select AVG(Price) from Book) order by BookName desc

select Buyer.* from Buyer join Orders on Buyer.BuyerId = Orders.BuyerId where Orders.BookId = (select BookId from Orders where BuyerId = (select BuyerId from Buyer where FullName = 'Сидоров'))

select COUNT(AC.AuthorId) AuthorCount from (
	select Author.AuthorId, COUNT(BookId) BookCount from Author join Book
	on Author.AuthorId = Book.AuthorId
	group by Author.AuthorId having COUNT(BookId) > 5
	) as AC

select COUNT(G.GenreId) GenreCount from (
	select Genre.GenreId, COUNT(BookId) BookCount from Genre join Book
	on Genre.GenreId = Book.GenreId
	group by Genre.GenreId having COUNT(BookId) > 10
	) as G

select COUNT(BookId) BookCnt, BuyerId from Orders group by BuyerId having COUNT(BookId) >= 1

select Book.BookName, Genre.GenreName, Bkk.avg_cnt from Book join Genre on Book.GenreId = Genre.GenreId join (select Bk.BookId, AVG(Bk.CNT) as avg_cnt from (select BookId, COUNT(BookId) as CNT from Orders group by BookId) as Bk group by Bk.BookId) as Bkk on Bkk.BookId = Book.BookId group by BookName, GenreName,bkk.avg_cnt

select Buyer.FullName from Buyer join Orders on Orders.BuyerId = Buyer.BuyerId where Orders.Quantity = 2

select Buyer.FullName from Buyer join Orders on Orders.BuyerId = Buyer.BuyerId where BookId = (select BookId from Book where BookName = 'Гроза' or BookName = 'Чайка')