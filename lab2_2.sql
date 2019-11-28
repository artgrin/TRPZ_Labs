USE LAB1_2DB

select COUNT(PublisherId) PublisherCount from Publisher

select COUNT(FullName) AuthorNameCnt from Author

select COUNT(BookId) BookCount, MIN(Price) minPrice, MAX(Price) maxPrice, AVG(Price) avgPrice from Book

select pub.PublisherName, COUNT(bk.BookId) BookCount, MIN(bk.Price) minPrice, MAX(bk.Price) maxPrice, AVG(bk.Price) avgPrice from Publisher pub 
join Book bk on pub.PublisherId = bk.PublisherId group by pub.PublisherName

select COUNT(distinct FullName) UniqueQty from Author

select COUNT(case when FullName like 'M%' then 1 end) Qty from Author

