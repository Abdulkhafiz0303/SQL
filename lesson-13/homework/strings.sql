print('lesson-13')


--1 You need to write a query that outputs "100-Steven King", meaning emp_id + first_name + last_name in that format using employees table.
select CONCAT(employee_id, '-', first_name, ' ', last_name) from Employees 

--2 Update the portion of the phone_number in the employees table, within the phone number the substring '124' will be replaced by '999'
select REPLACE(phone_number, 124, 999) from Employees

--3 That displays the first name and the length of the first name for all employees whose name starts with the letters 'A', 'J' or 'M'. Give each column an appropriate label. Sort the results by the employees' first names.(Employees)
select first_name, len(first_name) from Employees
where FIRST_NAME like 'a%' or FIRST_NAME like 'j%' or FIRST_NAME like 'm%'

--4 Write an SQL query to find the total salary for each manager ID.(Employees table)
select MANAGER_ID, sum(salary)
from Employees
group by MANAGER_ID

--5 Write a query to retrieve the year and the highest value from the columns Max1, Max2, and Max3 for each row in the TestMax table
select Year1, GREATEST(max1, max2, max3) as highest_values from TestMax

--6 Find me odd numbered movies and description is not boring.(cinema)
select * from cinema
where id % 2 = 1 and description != 'boring'

--7 You have to sort data based on the Id but Id with 0 should always be the last row. Now the question is can you do that with a single order by column.(SingleOrder)
select * from SingleOrder 
order by
case when id = 0 then 1 else 0 end, id
--8 Write an SQL query to select the first non-null value from a set of columns. If the first column is null, move to the next, and so on. If all columns are null, return null.(person)
select coalesce(ssn, passportid, itin) as first_non_null from person


--9 Split column FullName into 3 part ( Firstname, Middlename, and Lastname).(Students Table)
select * from Students
select left(fullname,CHARINDEX(' ', fullname)-1) as first_name,
 substring(FullName, CHARINDEX(' ', fullname)+1, charindex(' ', fullname, charindex(' ', fullname)+1)- charindex(' ', fullname)-1) as middlename,
(right((fullname), charindex(' ', (reverse(fullname)))-1)) as last_name
from Students

--10 For every customer that had a delivery to California, provide a result set of the customer orders that were delivered to Texas. (Orders Table)
select * from Orders
where DeliveryState = 'tx' and CustomerID in(select distinct CustomerID from Orders where DeliveryState = 'ca')

--11 Write an SQL statement that can group concatenate the following values.(DMLTable)
select CONCAT_WS(' ', SequenceNumber, String) from DMLTable

--12 Find all employees whose names (concatenated first and last) contain the letter "a" at least 3 times.
select * from Employees
where len(FIRST_NAME + last_name) >= 3
--13 The total number of employees in each department and the percentage of those employees who have been with the company for more than 3 years(Employees)


--14 Write an SQL statement that determines the most and least experienced Spaceman ID by their job description.(Personal)



--15 Write an SQL query that separates the uppercase letters, lowercase letters, numbers, and other characters from the given string 'tf56sd#%OqH' into separate columns.
select replace('tf56sd#%OqH', '[^A-Z]', '') AS UPPERCASE_LETTERS
select REPLACE('tf56sd#%OqH', '[a-z]', '') as lowercase_letters
select REPLACE('tf56sd#%OqH', '[0-9]', '') as numbers
select REPLACE('tf56sd#%OqH', '[A-Za-z0-9]', '') as special_charachters
