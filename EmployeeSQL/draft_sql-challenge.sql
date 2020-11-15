--DROP TABLE Departments;
--DROP TABLE Titles;
--DROP TABLE Employees;
--DROP TABLE Dep_MGT;
--DROP TABLE Dep_EMP;
--DROP TABLE Salaries;

CREATE TABLE Departments
( 
	dept_no VARCHAR(4)   NOT NULL PRIMARY KEY,
    dept_name VARCHAR(100)   NOT NULL
);

COPY Departments(dept_no, dept_name)
FROM 'C:\ClassRepo\sql-challenge\EmployeeSQL\data\departments.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE Titles
(
	title_id VARCHAR(5) NOT NULL PRIMARY KEY,
	title VARCHAR NOT NULL
);

COPY Titles(title_id, title)
FROM 'C:\ClassRepo\sql-challenge\EmployeeSQL\data\titles.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE Employees
(
	emp_no	INTEGER NOT NULL PRIMARY KEY,
	emp_title_id	VARCHAR(5) NOT NULL,
	FOREIGN KEY (emp_title_id) REFERENCES Titles(title_id),
	birth_date	DATE NOT NULL DEFAULT CURRENT_DATE,
	first_name	VARCHAR NOT NULL,
	last_name	VARCHAR NOT NULL,
	sex			CHAR(1) NOT NULL,
	hire_date 	DATE NOT NULL DEFAULT CURRENT_DATE
);
COPY Employees(emp_no, emp_title_id,birth_date,first_name,last_name, sex, hire_date)
FROM 'C:\ClassRepo\sql-challenge\EmployeeSQL\data\employees.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE Dep_MGT
(
	dept_no VARCHAR(4) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES Departments(dept_no),	
	emp_no INTEGER NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),	
	PRIMARY KEY (dept_no, emp_no)
);
COPY Dep_MGT(dept_no, emp_no)
FROM 'C:\ClassRepo\sql-challenge\EmployeeSQL\data\dept_manager.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE Dep_EMP
(
	emp_no INTEGER NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),	
	dept_no VARCHAR(4) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES Departments(dept_no),
	PRIMARY KEY (emp_no, dept_no)
);
COPY Dep_EMP( emp_no, dept_no)
FROM 'C:\ClassRepo\sql-challenge\EmployeeSQL\data\dept_emp.csv'
DELIMITER ','
CSV HEADER;


CREATE TABLE Salaries
(
	emp_no INTEGER NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),	
	salary INTEGER NOT NULL
);
COPY salaries( emp_no, salary)
FROM 'C:\ClassRepo\sql-challenge\EmployeeSQL\data\salaries.csv'
DELIMITER ','
CSV HEADER;

---check
select count(*) from Departments;
select count(*) from Titles;
select count(*) from Employees;
select count(*) from Dep_MGT;
select count(*) from Dep_EMP;
select count(*) from Salaries;

-------------------------------------------------------------------------------------------
--QUERY/ANALYSIS
--List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary 
FROM Employees e 
JOIN Salaries s on e.emp_no=s.emp_no 


--List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date 
FROM Employees  
WHERE '[1985-12-31, 1987-01-01]'::daterange @> hire_date 

--List the manager of each department with the following information: department number, department name,
--the manager's employee number, last name, first name.
-- same result is achieved without join to Titles, so that where serves as a check

SELECT d.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name
FROM DEP_MGT dm
JOIN Employees e ON dm.emp_no = e.emp_no
JOIN Departments d ON dm.dept_no = d.dept_no
JOIN Titles t on e.emp_title_id=t.title_id
where t.title = 'Manager'

--List the department of each employee with the following information: employee number, last name, 
--first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM DEP_EMP de
JOIN Employees e ON de.emp_no = e.emp_no
JOIN Departments d ON de.dept_no = d.dept_no

--List first name, last name, and sex for employees whose first name is "Hercules" 
--and last names begin with "B."
SELECT first_name, last_name, sex
FROM Employees
WHERE first_name = 'Hercules' and last_name LIKE 'B%'

--List all employees in the Sales department, including their employee number, last name, first name, 
--and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM DEP_EMP de
JOIN Employees e ON de.emp_no = e.emp_no
JOIN Departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales'

--List all employees in the Sales and Development departments, including their employee number, 
--last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM DEP_EMP de
JOIN Employees e ON de.emp_no = e.emp_no
JOIN Departments d ON de.dept_no = d.dept_no
WHERE d.dept_name in ('Sales', 'Development')

--In descending order, list the frequency count of employee last names, i.e., how many employees 
--share each last name.
SELECT last_name, COUNT(last_name) AS frequency
FROM Employees
GROUP BY last_name
order by frequency desc






