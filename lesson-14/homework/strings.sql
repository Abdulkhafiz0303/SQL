
--Write a SQL query to split the Name column by a comma into two separate columns: Name and Surname.(TestMultipleColumns)
select * from TestMultipleColumns

SELECT
  LTRIM(RTRIM(SUBSTRING(Name, 1, CHARINDEX(',', Name) - 1))) AS Name,
  LTRIM(RTRIM(SUBSTRING(Name, CHARINDEX(',', Name) + 1, LEN(Name)))) AS Surname
FROM TestMultipleColumns
WHERE CHARINDEX(',', Name) > 0;

--Write a SQL query to find strings from a table where the string itself contains the % character.(TestPercent)
select * from TestPercent
where Strs like '%[%]%'

--In this puzzle you will have to split a string based on dot(.).(Splitter)
select 
left(Vals, CHARINDEX('.', Vals)-1) as part1,
substring(Vals, charindex('.', Vals)+1, len(Vals)) as part2
from Splitter

--Write a SQL query to replace all integers (digits) in the string with 'X'.(1234ABC123456XYZ1234567890ADS)
select REPLACE('1234ABC123456XYZ1234567890ADS', '1', 'X') AS REPLACESTRING

--Write a SQL query to return all rows where the value in the Vals column contains more than two dots (.).(testDots)
SELECT *
FROM testDots
WHERE LEN(Vals) - LEN(REPLACE(Vals, '.', '')) > 2;

--Write a SQL query to count the spaces present in the string.(CountSpaces)
SELECT
  LEN(texts) - LEN(REPLACE(texts, ' ', '')) AS SpaceCount
FROM CountSpaces;

--write a SQL query that finds out employees who earn more than their managers.(Employee)
SELECT * FROM Employee 
WHERE Salary = (SELECT MAX(SALARY) FROM EMPLOYEE)

--Find the employees who have been with the company for more than 10 years, but less than 15 years. Display their Employee ID, First Name, Last Name, Hire Date, and the Years of Service (calculated as the number of years between the current date and the hire date).(Employees)
SELECT 
EMPLOYEE_ID,
FIRST_NAME,
LAST_NAME,
HIRE_DATE,
DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS YEARS_OF_SERVICE
FROM Employees
WHERE DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 10 AND 14

--Write a SQL query to separate the integer values and the character values into two different columns.(rtcfvty34redt)
SELECT REPLACE('rtcfvty34redt', LEFT('rtcfvty34redt',7), '') AS GAP,

--write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.(weather)
SELECT w1.Id
FROM weather as w1
join weather as w2 on DATEDIFF(day, w2.RecordDate, w1.RecordDate) = 1
where w1.Temperature>w2.Temperature

--Write an SQL query that reports the first login date for each player.(Activity)
SELECT
  player_id,
  MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id;

--Your task is to return the third item from that list.(fruits)
select value from string_split('apple,banana,orange,grape',',',1)
where ordinal=3

--You are given two tables: p1 and p2. Join these tables on the id column. The catch is: when the value of p1.code is 0, replace it with the value of p2.code.(p1,p2)
select 
    p1.id,
    case
	   when p1.code = 0 then p2.code
	   else p1.code
	   end as final_code
from p1
join p2 on p1.id=p2.id

--Write an SQL query to determine the Employment Stage for each employee based on their HIRE_DATE. The stages are defined as follows:

select 
EMPLOYEE_ID,
FIRST_NAME,
LAST_NAME,
HIRE_DATE,
DATEDIFF(year, HIRE_DATE, GETDATE()) as years_of_service,
  case
       WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 1 THEN 'New Hire'
    WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 1 AND 5 THEN 'Junior'
    WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 6 AND 10 THEN 'Mid-level'
    ELSE 'Senior'
  END AS EmploymentStage
from Employees
