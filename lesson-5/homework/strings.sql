print("salom")

--1
select productname as name 
from Products

--2
select * 
from Customers as client

--3
select productname from products
union
select productname from products_discounted

--4
select productname from products
intersect
select productname from products_discounted

--5
select distinct CustomerID, country
from Customers

--6
select productname, price,
      case when price > 1000 then 'high'
    else 'low' end as pricecategory
from Products

--7
select productname, stockquantity,
        iif(stockquantity > 100, 'yes', 'no') as instock
    from Products_Discounted

--8
select ProductName from Products
union
select productname from Products_Discounted

--9
select ProductName from Products
except
select productname from Products_Discounted

--10
select productname, price,
       iif (price > 1000, 'expensive', 'affordable') as pricestatus
from products

--11
select * from Employees
where age <25 or salary >60000

--12
update Employees
set salary = salary * 1.10
where DepartmentName = 'hr' or EmployeeID = 5
select * from Employees

--13
select saleid, customerid, saleamount,
    case
    when saleamount > 500 then 'top tier'
    when saleamount between 200 and 500 then 'mid tier'
    else 'low tier' end as salecategory
    from Sales

--14
select Customerid from Orders
except
select Customerid from Sales

--15
select customerid, quantity,
    case
        when quantity = 1 then '3%'
      when quantity between 2 and 3 then '5%'
      else '7%' end as discountpercentage
from orders
