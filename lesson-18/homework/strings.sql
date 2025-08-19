--1
create view monthly_sales as(
select Sales.ProductID,
       sum(sales.quantity) as totalquantity,
	   sum(sales.quantity * products.price) as totalrevenue
from Products
join Sales
on Products.ProductID = Sales.ProductID
where month(sales.saledate) <= month(getdate())
and year(sales.saledate) <= year(getdate())
group by Sales.ProductID
)
select * from monthly_sales

--2
-- Create a view named vw_ProductSalesSummary that returns product info along with total sales quantity across all time.
--Return: ProductID, ProductName, Category, TotalQuantitySold
create view vw_ProductSalesSummary as (
select  p.ProductID,
        p.ProductName,
        p.Category, 
	ISNULL(SUM(s.Quantity), 0) AS TotalQuantitySold
from Products as p
left join Sales as s
on p.ProductID = s.ProductID
group by
       p.ProductID,
       p.ProductName,
       p.Category
)
select * from vw_ProductSalesSummary

--3
--Create a function named fn_GetTotalRevenueForProduct(@ProductID INT)
--Return: total revenue for the given product ID

go
create function fn_GetTotalRevenueForProduct(@ProductID INT)
  returns decimal(10, 2)
as
  begin
    return (select SUM(s.quantity * p.price) as totalRevenue from Products as p
      join Sales as s on s.ProductID = p.ProductID
      where p.ProductID = @ProductID)
  end
go

select dbo.fn_GetTotalRevenueForProduct(1) as revenue


--4
-- Create an function fn_GetSalesByCategory(@Category VARCHAR(50))
--Return: ProductName, TotalQuantity, TotalRevenue for all products in that category.
go
create function fn_GetSalesByCategory
(@Category VARCHAR(50)
)
returns table 
as
return
(
select 
      p.ProductName,
	  sum(s.quantity) as totalquantity,
	  sum(s.Quantity * p.price) as TotalRevenue
from Sales as s
join Products as p
on s.ProductID = p.ProductID
where p.Category = @Category
group by p.ProductName
)

go
select * from dbo.fn_GetSalesByCategory('electronics')

--5
--
--This is for those who has no idea about prime numbers: A prime number is a number greater than 1 that has only two divisors:
--1 and itself(2, 3, 5, 7 and so on).
go
CREATE FUNCTION fn_IsPrime (
    @Number INT
)
RETURNS VARCHAR(3)
AS
BEGIN
    DECLARE @i INT = 2;

    IF @Number < 2
        RETURN 'No';

    WHILE @i <= SQRT(@Number)
    BEGIN
        IF @Number % @i = 0
            RETURN 'No';
        SET @i = @i + 1;
    END

    RETURN 'Yes';
END;

go
go
SELECT dbo.fn_IsPrime(7) AS IsPrime; 
SELECT dbo.fn_IsPrime(15) AS IsPrime; 


--6
--. Create a table-valued function named fn_GetNumbersBetween that accepts two integers as input:
go
CREATE FUNCTION fn_GetNumbersBetween (
    @Start INT,
    @End INT
)
RETURNS @Numbers TABLE (
    Number INT
)
AS
BEGIN
    DECLARE @Current INT = @Start;

    WHILE @Current <= @End
    BEGIN
        INSERT INTO @Numbers(Number) VALUES (@Current);
        SET @Current = @Current + 1;
    END

    RETURN;
END;
go
SELECT * FROM dbo.fn_GetNumbersBetween(2, 7);

--9
--Create a View for Customer Order Summary.
drop table Customers
drop table Orders

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE Orderes (
    order_id INT PRIMARY KEY,
    customer_id INT FOREIGN KEY REFERENCES Customers(customer_id),
    order_date DATE,
    amount DECIMAL(10,2)
);

-- Customers
INSERT INTO Customers (customer_id, name, city)
VALUES
(1, 'Alice Smith', 'New York'),
(2, 'Bob Jones', 'Chicago'),
(3, 'Carol White', 'Los Angeles');

-- Orders
INSERT INTO Orderes (order_id, customer_id, order_date, amount)
VALUES
(101, 1, '2024-12-10', 120.00),
(102, 1, '2024-12-20', 200.00),
(103, 1, '2024-12-30', 220.00),
(104, 2, '2025-01-12', 120.00),
(105, 2, '2025-01-20', 180.00);
go
create view vw_CustomerOrderSummary as(
select 
      c.customer_id, c.name, 
	  count(distinct o.order_id) as total_orders, 
	  sum(o.amount) as totalamount
from Customers as c
join Orderes as o
on c.customer_id = o.customer_id
group by c.customer_id, c.name
)

select * from vw_CustomerOrderSummary

--10
--Write an SQL statement to fill in the missing gaps. You have to write only select statement, no need to modify the table.

DROP TABLE IF EXISTS Gaps;

CREATE TABLE Gaps
(
RowNumber   INTEGER PRIMARY KEY,
TestCase    VARCHAR(100) NULL
);

INSERT INTO Gaps (RowNumber, TestCase) VALUES
(1,'Alpha'),(2,NULL),(3,NULL),(4,NULL),
(5,'Bravo'),(6,NULL),(7,NULL),(8,NULL),(9,NULL),(10,'Charlie'), (11, NULL), (1)

select RowNumber,
case 
     when TestCase IS null then 'ALPHA'
     when TestCase IS NULL then 'BRAVO'
	 else 'CHARLIE'
	 end as status
	 from Gaps

SELECT * FROM Gaps
