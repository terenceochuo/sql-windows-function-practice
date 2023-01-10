create database vision;
use vision;
CREATE TABLE employee (
    Emp_ID INT,
    Emp_Name VARCHAR(50),
    Dep_Name VARCHAR(50),
    salary INT
);
insert into employee values 
(101, 'Mohan', 'Admin', 4000),
(102, 'Rajkumar', 'HR', 3000),
(103, 'Akbar', 'IT', 4000),
(104, 'Dorvin', 'Finance', 6500),
(105, 'Rohit', 'HR', 3000),
(106, 'Rajesh',  'Finance', 5000),
(107, 'Preet', 'HR', 7000),
(108, 'Maryam', 'Admin', 4000),
(109, 'Sanjay', 'IT', 6500),
(110, 'Vasudha', 'IT', 7000),
(111, 'Melinda', 'IT', 8000),
(112, 'Komal', 'IT', 10000),
(113, 'Gautham', 'Admin', 2000),
(114, 'Manisha', 'HR', 3000),
(115, 'Chandni', 'IT', 4500),
(116, 'Satya', 'Finance', 6500),
(117, 'Adarsh', 'HR', 3500),
(118, 'Tejaswi', 'Finance', 5500),
(119, 'Cory', 'HR', 8000),
(120, 'Monica', 'Admin', 5000),
(121, 'Rosalin', 'IT', 6000),
(122, 'Ibrahim', 'IT', 8000),
(123, 'Vikram', 'IT', 8000),
(124, 'Dheeraj', 'IT', 11000);
commit;
SELECT Dep_Name,
    MAX(salary) AS max_salary   
FROM
    employee
GROUP BY Dep_Name
order by max_salary;
select e.*, max(salary) over (partition by Dep_Name) as max_salary
from employee e;
select * from
(select e.*,
row_number () over (partition by Dep_Name order by Emp_ID ) as rn 
from employee e) x
where x.rn < 3;
select * from 
(select e.* ,
rank () over (partition by Dep_Name order by salary desc) as rnk 
from employee e) x
where x.rnk < 4;

select e.*,
lag (salary ) over (partition by Dep_Name order by Emp_ID) AS prev_emp_salary,
case when e.salary > lag (salary ) over (partition by Dep_Name order by Emp_ID) then 'Higher than previous employee'
	when e.salary < lag (salary ) over (partition by Dep_Name order by Emp_ID) then 'Lower than previous employee'
    when e.salary = lag (salary ) over (partition by Dep_Name order by Emp_ID) then 'same than previous employee'
    end sal_range
from employee e ;