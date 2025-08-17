--1. You must provide a report of all distributors and their sales by region. 
--If a distributor did not have any sales for a region, rovide a zero-dollar value for that day. 
--Assume there is at least one sale for each region

DROP TABLE IF EXISTS #RegionSales;
GO
CREATE TABLE #RegionSales (
  Region      VARCHAR(100),
  Distributor VARCHAR(100),
  Sales       INTEGER NOT NULL,
  PRIMARY KEY (Region, Distributor)
);
GO
INSERT INTO #RegionSales (Region, Distributor, Sales) VALUES
('North','ACE',10), ('South','ACE',67), ('East','ACE',54),
('North','ACME',65), ('South','ACME',9), ('East','ACME',1), ('West','ACME',7),
('North','Direct Parts',8), ('South','Direct Parts',7), ('West','Direct Parts',12);

select * from #RegionSales

-- Step 1: Get all unique Regions and Distributors
;WITH cte AS (
    SELECT DISTINCT Region FROM #RegionSales
),
Distributors AS (
    SELECT DISTINCT Distributor FROM #RegionSales
),
-- Step 2: Create all possible combinations
AllCombinations AS (
    SELECT 
        r.Region, 
        d.Distributor
    FROM cte as r
    CROSS JOIN Distributors as d
)
-- Step 3: Left join with actual sales to fill in missing combinations
SELECT 
    ac.Region,
    ac.Distributor,
    COALESCE(rs.Sales, 0) AS Sales
FROM AllCombinations as ac
LEFT JOIN #RegionSales as rs
    ON ac.Region = rs.Region AND ac.Distributor = rs.Distributor
ORDER BY ac.Distributor, ac.Region;

--2
--Find managers with at least five direct reports

CREATE TABLE Employee (id INT, name VARCHAR(255), department VARCHAR(255), managerId INT);
TRUNCATE TABLE Employee;
INSERT INTO Employee VALUES
(101, 'John', 'A', NULL), (102, 'Dan', 'A', 101), (103, 'James', 'A', 101),
(104, 'Amy', 'A', 101), (105, 'Anne', 'A', 101), (106, 'Ron', 'B', 101);

select 
     e.managerId,
	 em.name as manager_name,
	 count(*) as direct_reports
from Employee as e
join Employee as em
on e.managerId = em.managerId
group by e.managerId, em.name
having count(*) >=5

--3
--Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.

CREATE TABLE Products (product_id INT, product_name VARCHAR(40), product_category VARCHAR(40));
INSERT INTO Products VALUES
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'), (4, 'Lenovo', 'Laptop'), (5, 'Leetcode Kit', 'T-shirt');

CREATE TABLE Orderss (product_id INT, order_date DATE, unit INT);
INSERT INTO Orderss VALUES
(1,'2020-02-05',60),(1,'2020-02-10',70),
(2,'2020-01-18',30),(2,'2020-02-11',80),
(3,'2020-02-17',2),(3,'2020-02-24',3),
(4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),
(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);


select 
	  pp.product_name,
	  sum(o.unit) as total_units_ordered
from products as pp
join orderss as o
on pp.product_id = o.product_id
where o.order_date >= '2020-02-01' and o.order_date < '2020-03-01'
group by pp.product_name
having sum(o.unit) >= 100

--4 
--Write an SQL statement that returns the vendor from which each customer has placed the most orders

CREATE TABLE Ordersss (
  OrderID    INTEGER PRIMARY KEY,
  CustomerID INTEGER NOT NULL,
  [Count]    MONEY NOT NULL,
  Vendor     VARCHAR(100) NOT NULL
);
INSERT INTO Ordersss VALUES
(1,1001,12,'Direct Parts'), (2,1001,54,'Direct Parts'), (3,1001,32,'ACME'),
(4,2002,7,'ACME'), (5,2002,16,'ACME'), (6,2002,5,'Direct Parts');

;with cte as(
select customerid, sum([count]) as total, vendor from Ordersss
group by customerid, vendor)
select * from cte
where total = (select max(total) from cte as c2 where cte.customerid=c2.customerid)

--5
--You will be given a number as a variable called @Check_Prime check if this number is prime then return 
'This number is prime' else eturn 'This number is not prime'

DECLARE @Check_Prime INT = 29;  -- Change this number to test others
DECLARE @i INT = 2;
DECLARE @IsPrime BIT = 1;

-- Handle edge cases
IF @Check_Prime < 2
BEGIN
    SET @IsPrime = 0;
END
ELSE
BEGIN
    WHILE @i <= SQRT(@Check_Prime)
    BEGIN
        IF @Check_Prime % @i = 0
        BEGIN
            SET @IsPrime = 0;
            BREAK;
        END
        SET @i = @i + 1;
    END
END

-- Final output
IF @IsPrime = 3
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';

--6
--Write an SQL query to return the number of locations,in which location most signals sent, 
--and total number of signal for each device from the given table.

CREATE TABLE Device(
  Device_id INT,
  Locations VARCHAR(25)
);
INSERT INTO Device VALUES
(12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'),
(12,'Hosur'), (12,'Hosur'),
(13,'Hyderabad'), (13,'Hyderabad'), (13,'Secunderabad'),
(13,'Secunderabad'), (13,'Secunderabad');

SELECT * FROM Device

;WITH cte AS (
    SELECT 
        device_id,
        Locations,
        COUNT(*) AS signal_count
    FROM Device
    GROUP BY device_id, Locations
),
RankedSignals AS (
    SELECT 
        device_id,
        Locations,
        signal_count,
		  RANK() OVER (PARTITION BY device_id ORDER BY signal_count DESC) AS rnk
    FROM cte
),
DeviceSummary AS (
    SELECT 
        device_id,
        COUNT(DISTINCT locations) AS no_of_location,
        SUM(signal_count) AS no_of_signals
    FROM cte
    GROUP BY device_id
)
SELECT 
    d.device_id,
    d.no_of_location,
    r.Locations AS max_signal_location,
    d.no_of_signals
FROM DeviceSummary d
JOIN RankedSignals r 
    ON d.device_id = r.device_id AND r.rnk = 1
ORDER BY d.device_id;

--7
--Write a SQL to find all Employees who earn more than the average salary in their corresponding department. 
--Return EmpID, EmpName,Salary in your output

CREATE TABLE Employe (
  EmpID INT,
  EmpName VARCHAR(30),
  Salary FLOAT,
  DeptID INT
);
INSERT INTO Employe VALUES
(1001,'Mark',60000,2), (1002,'Antony',40000,2), (1003,'Andrew',15000,1),
(1004,'Peter',35000,1), (1005,'John',55000,1), (1006,'Albert',25000,3), (1007,'Donald',35000,3);

select * from Employe

SELECT 
    e.EmpID,
    e.EmpName,
    e.Salary
FROM Employe as e
join (
 SELECT 
        DeptID,
        AVG(Salary) AS avg_salary
    FROM Employe
    GROUP BY DeptID
) as dept_avg
ON e.DeptID = dept_avg.DeptID
WHERE e.Salary > dept_avg.avg_salary;

--8
--You are part of an office lottery pool where you keep a table of the winning lottery numbers along with a table of each ticket’s chosen numbers. 
--If a ticket has some but not all the winning numbers, you win $10.
--If a ticket has all the winning numbers, you win $100. Calculate the total winnings for today’s drawing.

-- Step 1: Create the table
CREATE TABLE Numbers (
    Number INT
);

-- Step 2: Insert values into the table
INSERT INTO Numbers (Number)
VALUES
(25),
(45),
(78);

-- Step 1: Create the Tickets table
CREATE TABLE Tickets (
    TicketID VARCHAR(10),
    Number INT
);

-- Step 2: Insert the data into the table
INSERT INTO Tickets (TicketID, Number)
VALUES
('A23423', 25),
('A23423', 45),
('A23423', 78),
('B35643', 25),
('B35643', 45),
('B35643', 98),
('C98787', 67),
('C98787', 86),
('C98787', 91);

SELECT * FROM Numbers
SELECT * FROM Tickets

;with cte AS (
    SELECT 
        t.ticketid,
        COUNT(*) AS match_count
    FROM Tickets t
    JOIN Numbers n ON t.number = n.number
    GROUP BY t.ticketid
),
WinningCount AS (
    SELECT COUNT(*) AS total_numbers FROM Numbers
),
Winnings AS (
    SELECT 
        m.ticketid,
        CASE 
            WHEN m.match_count = wc.total_numbers THEN 100
            WHEN m.match_count > 0 THEN 10
            ELSE 0
        END AS prize
    FROM cte as m
    CROSS JOIN WinningCount as wc
)
-- Final total winnings
SELECT SUM(prize) AS total_winnings
FROM Winnings;

--9
--The Spending table keeps the logs of the spendings history of users that make purchases from an online shopping website which has a desktop and a mobile devices.
--Write an SQL query to find the total number of users and the total amount spent using mobile only, desktop only and both mobile and desktop together for each date.

CREATE TABLE Spending (
  User_id INT,
  Spend_date DATE,
  Platform VARCHAR(10),
  Amount INT
);
INSERT INTO Spending VALUES
(1,'2019-07-01','Mobile',100),
(1,'2019-07-01','Desktop',100),
(2,'2019-07-01','Mobile',100),
(2,'2019-07-02','Mobile',100),
(3,'2019-07-01','Desktop',100),
(3,'2019-07-02','Desktop',100);


select * from Spending

;WITH UserDevices AS (
    SELECT DISTINCT user_id, Spend_date, Platform
    FROM Spending
),
UserDeviceType AS (
    SELECT 
        user_id,
        Spend_date,
        MAX(CASE WHEN Platform = 'mobile' THEN 1 ELSE 0 END) AS used_mobile,
        MAX(CASE WHEN Platform = 'desktop' THEN 1 ELSE 0 END) AS used_desktop
    FROM UserDevices
    GROUP BY user_id, Spend_date
),
UserCategory AS (
    SELECT 
        user_id,
        Spend_date,
        CASE 
            WHEN used_mobile = 1 AND used_desktop = 0 THEN 'mobile_only'
            WHEN used_mobile = 0 AND used_desktop = 1 THEN 'desktop_only'
            WHEN used_mobile = 1 AND used_desktop = 1 THEN 'both'
        END AS usage_type
    FROM UserDeviceType
),
SpendingWithCategory AS (
    SELECT 
        s.Spend_date,
        s.user_id,
        s.amount,
        uc.usage_type
    FROM Spending s
    JOIN UserCategory uc 
        ON s.user_id = uc.user_id AND s.Spend_date = uc.Spend_date
)
SELECT 
    Spend_date,
    usage_type,
    COUNT(DISTINCT user_id) AS total_users,
    SUM(amount) AS total_spent
FROM SpendingWithCategory
GROUP BY Spend_date, usage_type
ORDER BY Spend_date, usage_type;

--10
-- Write an SQL Statement to de-group the following data.

DROP TABLE IF EXISTS Grouped;
CREATE TABLE Grouped
(
  Product  VARCHAR(100) PRIMARY KEY,
  Quantity INTEGER NOT NULL
);
INSERT INTO Grouped (Product, Quantity) VALUES
('Pencil', 3), ('Eraser', 4), ('Notebook', 2);

select * from Grouped

;WITH Grouped AS (
    SELECT 'Pencil' AS Product, 3 AS Quantity
    UNION ALL SELECT 'Eraser', 4
    UNION ALL SELECT 'Notebook', 2
),
Expanded AS (
    SELECT Product, 1 AS Qty
    FROM Grouped
    WHERE Quantity >= 1

    UNION ALL

    SELECT g.Product, e.Qty + 1
    FROM Expanded e
    JOIN Grouped as g ON e.Product = g.Product
    WHERE e.Qty + 1 <= g.Quantity
)
SELECT Product
FROM Expanded
ORDER BY Product


