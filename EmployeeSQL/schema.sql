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







