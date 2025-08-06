print("lesson-2")

--1
create table employees(
empid int,
name varchar(50),
salary decimal(10,2)
);

--2
-- Single-row insert
INSERT INTO Employees (EmpID, Name, Salary)
VALUES (1, 'Alice', 6000.00);

-- Multiple-row insert
INSERT INTO Employees (EmpID, Name, Salary)
VALUES 
(2, 'Bob', 5500.00),
(3, 'Charlie', 5000.00);

--3
update employees
set salary = 7000
where empid = 1;

--4
delete from employees
where empid=2;

--5
--DELETE
--Removes specific rows, can use WHERE, logs each row.
--TRUNCATE
--Deletes all rows, cannot use WHERE, faster than DELETE, minimal logging.
--DROP
--Deletes the entire table structure and data permanently.

--6
alter table employees
add department varchar(50);

--7
alter table employees
alter column name varchar(100)

--8
alter table employees
alter column salary float;

--9
create table departments (
departmentid int primary key,
departmentname varchar(50)
);

--10
truncate table employees

--11
INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT 1, 'HR' UNION
SELECT 2, 'IT' UNION
SELECT 3, 'Finance' UNION
SELECT 4, 'Marketing' UNION
SELECT 5, 'Logistics';

--12
update employees
set department ='management'
where salary > 5000

--13
truncate table employees;

--14
alter table employees
drop column department;

--15
exec sp_rename 'employees', 'staffmemebers';

--16
drop table departments
