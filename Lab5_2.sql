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
