USE master;
DROP DATABASE IF EXISTS LAB1_2DB;

CREATE DATABASE USERDB1;
GO  
ALTER DATABASE USERDB1 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
ALTER DATABASE USERDB1 MODIFY NAME = LAB1_2DB;
GO  
ALTER DATABASE LAB1_2DB SET MULTI_USER;
GO
USE LAB1_2DB;
GO

EXEC sp_helpdb LAB1_2DB;

CREATE TABLE Author
(
    AuthorId INT PRIMARY KEY IDENTITY,
    FullName VARCHAR(100) NOT NULL,
	BirthDate DATE,
	Homeland VARCHAR(50),
	DeathDate DATE
);

CREATE TABLE Publisher
(
    PublisherId INT PRIMARY KEY IDENTITY,
    PublisherName VARCHAR(100) NOT NULL,
	City VARCHAR(50)
);

CREATE TABLE Genre
(
    GenreId INT PRIMARY KEY IDENTITY,
    GenreName VARCHAR(50) NOT NULL,
	GenreDesc VARCHAR(500)
);

CREATE TABLE Supplier
(
    SupplierId INT PRIMARY KEY IDENTITY,
    SupplierName VARCHAR(50) NOT NULL,
	Adress VARCHAR(100),
	Phone VARCHAR(100)
);

CREATE TABLE Buyer
(
    BuyerId INT PRIMARY KEY IDENTITY,
    FullName VARCHAR(100) NOT NULL,
	DeliveryAdress VARCHAR(100),
	Phone VARCHAR(100)
);

CREATE TABLE Book
(
    BookId INT PRIMARY KEY IDENTITY,
	PublisherId INT NOT NULL,
	AuthorId INT NOT NULL,
	GenreId INT NOT NULL,
	SupplierId INT NOT NULL,
    BookName VARCHAR(50) NOT NULL,
	PublishingYear DATE,
	CopiesNumber INT,
	Price MONEY,
	SupplyDate DATE,
	CONSTRAINT FK_Book_Publisher FOREIGN KEY (PublisherId)  REFERENCES Publisher (PublisherId),
	CONSTRAINT FK_Book_Author FOREIGN KEY (AuthorId)  REFERENCES Author (AuthorId),
	CONSTRAINT FK_Book_Genre FOREIGN KEY (GenreId)  REFERENCES Genre (GenreId),
	CONSTRAINT FK_Book_Supplier FOREIGN KEY (SupplierId)  REFERENCES Supplier (SupplierId)
);

CREATE TABLE Orders
(
    OrderId INT PRIMARY KEY IDENTITY,
	BuyerId INT NOT NULL,
	BookId INT NOT NULL,
	Quantity INT,
	OrderDate DATE,
	CONSTRAINT FK_Order_Buyer FOREIGN KEY (BuyerId)  REFERENCES Buyer (BuyerId),
	CONSTRAINT FK_Order_Book FOREIGN KEY (BookId)  REFERENCES Book (BookId)
);

ALTER TABLE Author ADD LiveYears AS DATEDIFF (year, BirthDate, DeathDate)

Insert into Author(FullName, BirthDate, Homeland, DeathDate) Values
('Isaak Asimov', '02-01-1920', 'Petrovichi, Smolensk Oblast, USSR', '06-04-1992'),
('Douglas Adams', '11-03-1952', 'Cambridge, United Kingdom', '11-05-2001'),
('Joanne Rowling', '31-07-1965', 'Killiechassie, Scotland', null)

Insert into Publisher(PublisherName, City) Values
('Macmillan Ltd.','New York'),
('Roc Books','New York'),
('Bloomsbury Publishing PLC','London')

Insert into Genre(GenreName) Values
('Fantasy'),
('Sci-Fi')

Insert into Supplier(SupplierName) Values
('Unknown Supplier')

Insert into Buyer(FullName, DeliveryAdress, Phone) Values
('Hrynko A.V.', 'Yanhelya 18/1', '0678711736')

--Select * from Publisher
--Select * from Author

Insert into Book(PublisherId, AuthorId, GenreId, SupplierId, BookName, PublishingYear, Price) Values
(1, 2, 2, 1, 'The Hitchhiker’s Guide to the Galaxy', '01-01-1979', 100.0),
(2, 1, 2, 1, 'Robot Visions', '01-01-1990', 110.0),
(3, 3, 1, 1, 'Harry Potter and the Philosophers Stone', '01-01-1997', 150.0)

Insert into Orders(BuyerId, BookId, Quantity, OrderDate) Values
(1, 2, 1, '01-11-2019')



