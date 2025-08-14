--1
/*drop table if exists employees

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2)
);

INSERT INTO employees (id, name, salary) VALUES
(1, 'Alice', 50000),
(2, 'Bob', 60000),
(3, 'Charlie', 50000); */

--Task: Retrieve employees who earn the minimum salary in the company. Tables: employees (columns: id, name, salary)
select id, name, salary
from employees
where salary = (select min(salary) from employees)

--2
/*drop table if exists products
CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

INSERT INTO products (id, product_name, price) VALUES
(1, 'Laptop', 1200),
(2, 'Tablet', 400),
(3, 'Smartphone', 800),
(4, 'Monitor', 300);*/

--Task: Retrieve products priced above the average price. Tables: products (columns: id, product_name, price)
select * from products
select id, product_name, price
from products
where price > (select avg(price) from products)

--3
/*drop table if exists departments

CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);
drop table if exists employees
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments (id, department_name) VALUES
(1, 'Sales'),
(2, 'HR');

INSERT INTO employees (id, name, department_id) VALUES
(1, 'David', 1),
(2, 'Eve', 2),
(3, 'Frank', 1);*/

--Find Employees in Sales Department Task: Retrieve employees who work in the "Sales" department. 
--Tables: employees (columns: id, name, department_id), departments (columns: id, department_name)

select employees.id, employees.name
from departments
join employees on departments.id=employees.id
where departments.department_name= 'sales'

--4
/*
drop table if exists customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100)
);
drop table if exists orders

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, name) VALUES
(1, 'Grace'),
(2, 'Heidi'),
(3, 'Ivan');

INSERT INTO orders (order_id, customer_id) VALUES
(1, 1),
(2, 1);
*/
--Task: Retrieve customers who have not placed any orders.
--Tables: customers (columns: customer_id, name), orders (columns: order_id, customer_id)\

select customers.customer_id,customers.name
from customers
join orders on customers.customer_id = orders.customer_id
where orders.order_id is null;


--5
/*
drop table if exists products
CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

INSERT INTO products (id, product_name, price, category_id) VALUES
(1, 'Tablet', 400, 1),
(2, 'Laptop', 1500, 1),
(3, 'Headphones', 200, 2),
(4, 'Speakers', 300, 2);*/

--Task: Retrieve products with the highest price in each category. Tables: products (columns: id, product_name, price, category_id)

select * from  products as p1
where price = (select max(price) from products as p2 where p2.category_id=p1.category_id)

--6
/*
drop table departments

CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);
drop table if exists employees
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments (id, department_name) VALUES
(1, 'IT'),
(2, 'Sales');

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Jack', 80000, 1),
(2, 'Karen', 70000, 1),
(3, 'Leo', 60000, 2);
*/
--Task: Retrieve employees working in the department with the highest average salary. 
--Tables: employees (columns: id, name, salary, department_id), departments (columns: id, department_name)

SELECT e.id, e.name, e.salary, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.id
WHERE e.department_id = (
    SELECT top 1 department_id
    FROM employees
    GROUP BY department_id
    ORDER BY avg(salary) desc
);


--7
/*
drop table if exists employees
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Mike', 50000, 1),
(2, 'Nina', 75000, 1),
(3, 'Olivia', 40000, 2),
(4, 'Paul', 55000, 2);
*/
--Task: Retrieve employees earning more than the average salary in their department. 
--Tables: employees (columns: id, name, salary, department_id)

select em1.id, em1.name, em1.salary, em1.department_id
from employees as em1
where em1.salary > (select avg(em2.salary)
from employees as em2 
where em2.department_id=em1.department_id
)
