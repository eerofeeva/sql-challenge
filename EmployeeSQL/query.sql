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
