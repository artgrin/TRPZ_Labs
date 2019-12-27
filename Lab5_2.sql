use LAB1_2DB

select FullName, DeliveryAdress from Buyer
union all
select FullName, Homeland from Author

select FullName, DeliveryAdress from Buyer
union
select FullName, Homeland from Author

select Homeland as City from Author
except
select City from Publisher

select Homeland as City from Author
intersect
select distinct City from Publisher

select Buyer.FullName from Buyer join Orders on Buyer.BuyerId = Orders.BuyerId join Book on Book.BookId = Orders.BookId join Genre on Genre.GenreId = Book.GenreId where Genre.GenreName = 'Фантастика'
intersect
select Buyer.FullName from Buyer join Orders on Buyer.BuyerId = Orders.BuyerId join Book on Book.BookId = Orders.BookId join Genre on Genre.GenreId = Book.GenreId where Genre.GenreName = 'Публіцистика'

drop database if exists zkMyCopy
create database zkMyCopy
use zkMyCopy

CREATE TABLE PublisherCopyA
(
    PublisherId INT PRIMARY KEY,
    PublisherName VARCHAR(100) NOT NULL,
	City VARCHAR(50)
);

CREATE TABLE PublisherCopyB
(
    PublisherId INT PRIMARY KEY,
    PublisherName VARCHAR(100) NOT NULL,
	ShortName VARCHAR(50),
	City VARCHAR(50)
);

CREATE TABLE PublisherCopyC
(
    PublisherId INT PRIMARY KEY,
    PublisherName VARCHAR(100) NOT NULL,
	City VARCHAR(50)
);

insert into PublisherCopyA select * from LAB1_2DB..Publisher
insert into PublisherCopyB(PublisherId, PublisherName, City) select * from LAB1_2DB..Publisher

insert into PublisherCopyC select * from LAB1_2DB..Publisher where PublisherId > 3

create table GenreCopy
(
    GenreId INT PRIMARY KEY,
    GenreName VARCHAR(50) NOT NULL,
	GenreDesc VARCHAR(500)
);

insert into GenreCopy select * from LAB1_2DB..Genre where GenreId > 3 and GenreId < 6

create table BookCopy
(
	BookId INT PRIMARY KEY,
	PublisherId INT NOT NULL,
	AuthorId INT NOT NULL,
	GenreId INT NOT NULL,
	SupplierId INT NOT NULL,
    BookName VARCHAR(50) NOT NULL,
	PublishingYear DATE,
	CopiesNumber INT,
	Price MONEY,
	SupplyDate DATE,
	CONSTRAINT FK_Book_Publisher FOREIGN KEY (PublisherId)  REFERENCES PublisherCopyA (PublisherId),
	--CONSTRAINT FK_Book_Author FOREIGN KEY (AuthorId)  REFERENCES Author (AuthorId),
	CONSTRAINT FK_Book_Genre FOREIGN KEY (GenreId)  REFERENCES GenreCopy (GenreId),
	--CONSTRAINT FK_Book_Supplier FOREIGN KEY (SupplierId)  REFERENCES Supplier (SupplierId)
);

insert into BookCopy select * from LAB1_2DB..Book where YEAR(PublishingYear)='1911'

create table GenreCopyNew
(
    GenreId INT PRIMARY KEY,
    GenreName VARCHAR(50) NOT NULL,
	GenreDesc VARCHAR(500)
);

insert into GenreCopyNew select * from LAB1_2DB..Genre

use LAB1_2DB

update Buyer set Phone = '067-555-03-05' where FullName = 'Hrynko A.V.'

update Author set Homeland = 'Prague' where AuthorId between 3 and 17

update Book set Price = Price*1.25 where AuthorId = (select AuthorId from Author where FullName in ('Пастернак', 'Блок'))

update Book set Price = Price*1.7 where Price = (select MIN(Price) from Book)

update Book set Price = Price*2 where Price = (select MAX(Price) from Book)

alter table Book add Cover varchar(50)

update Book set Cover = 'Hard cover'

update Book set Cover = 'Soft cover' where PublisherId = (select PublisherId from Publisher where PublisherName = 'Знание')

delete Orders where BuyerId between 3 and 5

delete Publisher where City = 'Odessa'

delete Book where BookId between 4 and 8