print("salom")

lesson-4 
--1
select top 5 *
from Employees

--2
select distinct category
from Products

--3
select * from Products
where price > 100

--4
select * from Customers
where FirstName like 'a%'

--5
select * from Products
order by price asc

--6
select * from Employees
where salary >=60000 and DepartmentName = 'hr'

--7
select Employeeid, firstname, lastname,
       ISNULL(email, 'noemail@example.com') as email
from Employees

--8
select * from Products
where price between 50 and 100

--9
select distinct category, PRODUCTname
from Products

--10
select distinct category, PRODUCTname
from Products
order by productname desc

--11
select * from products
order by Price desc

--12
select Employeeid, coalesce(firstname, lastname) as displayname
from employees

--13
select distinct category, price 
from products

--14
select * from Employees
where(age between 30 and 40) or DepartmentName='marketing'

--15
select * from Employees
order by salary desc
offset 10 rows fetch next 10 rows only

--16
select * from products
where price <= 1000 and StockQuantity > 50
order by StockQuantity asc

--17
select * from Products
where ProductName like '%e%'

--18
select * from Employees
where DepartmentName in('hr', 'it', 'finance')

--19
select * from Customers
order by city asc, PostalCode desc

--20
select top 5 * from products 
order by category desc

--21
select Employeeid, firstname + ' ' + lastname as fullname
from Employees

--22
select distinct category, productname, price from Products
where price > 50

--23
select * from products
where price < 0.1 * (select avg(price) from products)

--24
select * from Employees
where age < 30 and DepartmentName in ('hr', 'it')

--25
select * from Customers
where Email like '%gmail.com%'

--26
select * from Employees
where salary > all (
      select salary 
    from Employees
    where DepartmentName ='sales'
    );
