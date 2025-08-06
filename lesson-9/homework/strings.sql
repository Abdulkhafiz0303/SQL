print("lesson-9")

--1
select Products.ProductName, Suppliers.SupplierName
from Products
cross join Suppliers

--2
select Departments.DepartmentName, Employees.Name 
from Departments
cross join Employees

--3
select Suppliers.SupplierName, Products.ProductName
from Products
inner join Suppliers on Products.SupplierID = Suppliers.SupplierID

--4
select Customers.FirstName, Orders.OrderID
from Orders
inner join Customers on orders.customerid = customers.customerid

--5
select Courses.CourseName, Students.Name
from Courses
cross join Students

--6
select products.ProductName, Orders.OrderID
from Products
inner join Orders on Products.ProductID = Orders.ProductID

--7
select Departments.DepartmentName, Employees.Name
from Departments
inner join Employees on Departments.DepartmentID = Employees.DepartmentID

--8
select Students.Name, Enrollments.EnrollmentID 
from Students
inner join Enrollments on Students.StudentID = Enrollments.StudentID

--9
select Payments.PaymentID, Orders.OrderID
from Payments
inner join Orders on Payments.OrderID = Payments.OrderID

--10
select Orders.OrderID, Products.ProductName, Products.Price 
from Orders
inner join Products on orders.ProductID = Products.ProductID
where price > 100

--11
select Employees.Name, Departments.DepartmentName
from Employees
cross join Departments
where Employees.DepartmentID <> Departments.DepartmentID

--12
select orders.OrderID, Products.ProductName, Orders.Quantity, Products.StockQuantity 
from Orders
inner join Products on Orders.ProductID= Products.ProductID
where orders.Quantity > products.StockQuantity

--13
select Customers.FirstName, Customers.LastName, Sales.SaleAmount
from Customers
inner join Sales on Customers.CustomerID = Sales.CustomerID
where SaleAmount >= 500

--14
select Students.Name, Courses.CourseName
from Enrollments
inner join  Students on Enrollments.StudentID = Students.StudentID
inner join Courses on Enrollments.CourseID = Courses.CourseID 

--15
select Products.ProductName, Suppliers.SupplierName  
from Products
inner join Suppliers on Products.SupplierID = Suppliers.SupplierID
where SupplierName like 'tech%'


--16
select Orders.OrderID, orders.TotalAmount, payments.Amount
from Orders
inner join Payments on orders.OrderID = Payments.OrderID
where Payments.Amount < Orders.TotalAmount

--17
select Employees.Name, Departments.DepartmentName
from Employees
inner join Departments on Employees.DepartmentID = Departments.DepartmentID

--18
select Products.ProductName, Suppliers.SupplierName
from Products
inner join Suppliers on Products.SupplierID = Suppliers.SupplierID
where SupplierName in ('tech distributors', 'clothing mart')

--19
select sales.ProductID, Customers.FirstName, Customers.Country
from Sales
inner join Customers on Sales.CustomerID = Customers.CustomerID
where Customers.Country = 'usa'

--20
select orders.CustomerID, orders.TotalAmount, Customers.Country
from Orders
inner join Customers on Orders.CustomerID = Customers.CustomerID
where Customers.Country = 'germany' and Orders.TotalAmount > 100

--21
select * from Employees
select * from Departments
