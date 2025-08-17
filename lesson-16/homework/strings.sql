--1
--Create a numbers table using a recursive query from 1 to 1000.
;with cte AS (
    SELECT 1 AS number
    UNION ALL
    SELECT number + 1
    FROM cte
    WHERE number < 100
)
SELECT * FROM cte;


--2
--Write a query to find the total sales per employee using a derived table.(Sales, Employees)
select * from Employees

select Employees.EmployeeID, Employees.firstname, aggregated_.total from 
(
select EmployeeID, sum(salesamount) as total
from Sales
group by EmployeeID
) as aggregated_
join Employees
on aggregated_.EmployeeID=Employees.EmployeeID

;with cte as (
select EmployeeID, sum(salesamount) as total
from Sales
group by EmployeeID
) 
select  * from cte
join Employees on cte.EmployeeID=Employees.DepartmentID

--3
--Create a CTE to find the average salary of employees.(Employees)
select * from
(
select avg(salary) as avg_salary 
from Employees
) as avg_salary

;with cte as (
select avg(salary) as avg_salary 
from Employees
) 
select * from cte

--4
--Write a query using a derived table to find the highest sales for each product.(Sales, Products)
 select ppp.ProductID, ppp.ProductName, ppp.Price, maxx.max_amount from
 (
 select ProductID, max(salesamount) as max_amount
 from Sales
 group by ProductID
 ) as maxx
 join Products as ppp
 on maxx.ProductID = ppp.ProductID

;with cte as  (
 select ProductID, max(salesamount) as max_amount
 from Sales
 group by ProductID
 )
 select ppp.ProductID, ppp.ProductName, ppp.Price, cte.max_amount from cte
 join Products as ppp
 on cte.ProductID = ppp.ProductID

 --5
 --Beginning at 1, write a statement to double the number for each record, the max value you get should be less than 1000000.

 ;WITH cte AS (
    SELECT 1 AS number
    UNION ALL
    SELECT number * 2
    FROM cte
    WHERE number * 2 < 1000000
)
SELECT * FROM cte;

 --6
 --Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)
 select ee.EmployeeID, ee.FirstName, sale_count.sale_caount from 
 (
 select EmployeeID, count(*) as sale_caount
 from Sales
 group by EmployeeID
 having COUNT(*) > 5
 ) as sale_count
join Employees as ee
on sale_count.EmployeeID = ee.EmployeeID

;with cte as
 (
 select EmployeeID, count(*) as sale_caount
 from Sales
 group by EmployeeID
 having COUNT(*) > 5
 ) 
 select em.EmployeeID, em.FirstName, em.Salary, cte.sale_caount from Employees as em
 join cte
 on em.EmployeeID = cte.EmployeeID


--7
--Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)
select pr.ProductID, pr.ProductName, pr.Price, sss.s_amount from
(
select ProductID, sum(salesamount) as s_amount
from Sales as ss
group by ProductID
) as sss
join Products as pr
on sss.ProductID = pr.ProductID
where sss.s_amount >500 

;with cte as
(
select ProductID, sum(salesamount) as s_amount
from Sales as ss
group by ProductID
)
select prr.ProductID, prr.ProductName, prr.Price, cte.s_amount  from cte
join Products as prr
on cte.ProductID = prr.ProductID


--8
--Create a CTE to find employees with salaries above the average salary.(Employees)

select emp2.EmployeeID, emp2.FirstName, emp2.Salary from 
(
select avg(salary) as avg_sal
from Employees as emp1
) as avgg
join Employees as emp2
on emp2.Salary > avgg.avg_sal

;with cte as
(
select avg(salary) as avg_sal
from Employees as emp1
)
select emp.EmployeeID, emp.FirstName, emp.Salary from cte
join Employees as emp
on emp.Salary > cte.avg_sal

--9
--Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)
;with total as
(
select top 5 EmployeeID, count(*) as total_orders
from Sales
group by EmployeeID
order by COUNT(*) desc
)
select emm.EmployeeID, emm.FirstName, total.total_orders from total
join Employees as emm
on emm.EmployeeID = total.EmployeeID

--10
--Write a query using a derived table to find the sales per product category.(Sales, Products)
select pr.CategoryID, totall.total_amount from products as pr
join
(
select ProductID, sum(salesamount) as total_amount
from Sales
group by ProductID
) as totall on pr.ProductID = totall.ProductID

--11
--Write a script to return the factorial of each value next to it.(Numbers1)
select * from Numbers1
;with cte AS (
    -- Boshlanish nuqtasi: har bir raqam uchun faktorial hisoblashni boshlaymiz
    SELECT 
        n.Number,
        1 AS step,
        1 AS factorial
    FROM Numbers1 AS n
    WHERE n.Number >= 0

    UNION ALL

    -- Har bir qadamda: factorial = factorial * step + 1
    SELECT
        cte.Number,
        cte.step + 1,
        cte.factorial * (cte.step + 1)
    FROM cte
    WHERE cte.step < cte.Number
)

-- Har bir son uchun faqat yakuniy natijani chiqaramiz
SELECT 
    Number,
    MAX(factorial) AS factorial
FROM cte
GROUP BY Number
ORDER BY Number;


--12
--Use a CTE to calculate the sales difference between the current month and the previous month.(Sales)
  ;with cte as(
select month(saledate) as sale_month, sum(salesamount) as totalsale_in_month from Sales
group by month(saledate)
)
select cte.sale_month as current_month, prev_sales.sale_month as prev_month
, cte.totalsale_in_month - isnull(prev_sales.totalsale_in_month,0) as diff_between_months from cte
LEFT JOIN
(
select month(saledate) as sale_month, sum(salesamount) as totalsale_in_month from Sales
group by month(saledate)
) as prev_sales
on cte.sale_month = prev_sales.sale_month +1
