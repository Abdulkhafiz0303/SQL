print("lesson-7")

(lesson-7)
--1
select min(price) as min_price
from Products

--2
select max(salary) as max_salary
from Employees

--3
select count(*) as total_customers
from Customers

--4
select count(distinct category) as unique_categories
from products

--5
select sum(saleamount) as total_sales
from Sales
where ProductID = 7

--6
select avg(age) as avg_age
from Employees

--7
select DepartmentName, count (*) as employee_count
from Employees
group by DepartmentName

--8
select Category, min(price) min_price, max(price) max_price
from Products
group by Category

--9
select Customerid, sum(saleamount) as total_sales
from Sales
group by CustomerID

--10
select departmentname, count(*) as employee_count
from Employees
group by DepartmentName
having count(*) > 5

--11
select ProductID,
        sum(SaleAmount) as total_sales,
    avg(SaleAmount) as avg_sales
    from sales
group by ProductID

--12
select count(*) hr_employees
from Employees
where DepartmentName = 'hr'

--13
select DepartmentName,
         max(salary) as max_salary,
     min(salary) as min_salary
from Employees
group by DepartmentName

--14
select Employeeid,
       avg(salary) as avg_salary
from Employees
group by EmployeeID

--15
select Employeeid,
       avg(salary) as avg_salary,
     count(*) as employee_count
from employees
group by employeeid 

--16
select Category, avg(price) as avg_price
from Products
group by Category
having avg(price) > 300

--17
select year(saledate) as sale_year,
       sum(saleamount) as total_sales
from Sales
group by year(saledate)

--18
select Customerid, count(*) as order_count
from Orders
group by CustomerID
having count(*) >= 3 

--19
select departmentname, avg(salary) as avg_salary
from Employees
group by DepartmentName
having avg(salary) > 60000

--20
select category, avg(price) as avg_price
from Products
group by category
having avg(price) > 150

--21
select Customerid, sum(saleAmount) as total_sales
from Sales
group by CustomerID
having sum(saleamount) >1500

--22
select departmentname, 
            sum(salary) as total_salary,
      avg(salary) as avg_salary
from Employees
group by DepartmentName
having avg(salary) >65000

select *from Orders
--24
select 
    year(orderdate) as order_year,
    month(orderdate) as order_month,
    sum(TotalAmount) as total_sales,
  count(distinct productid) as unique_productsSold
  from Orders
  group by year(orderdate), month(orderdate)
  having count(distinct productid) >=2

--25
select 
    year(orderdate) as order_year,
  max(quantity) as max_quantity,
  min(quantity) as min_quantity
  from Orders
group by year(orderdate)
