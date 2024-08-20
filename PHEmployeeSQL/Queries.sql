-- JOIN tables & create view for reference, Full Employee Info = employee table + salary, title, dept_no, dept_name:
CREATE VIEW employee_info AS
SELECT e.*, s.salary, t.title, de.dept_no, d.dept_name FROM employees AS e
LEFT JOIN salaries AS s ON s.emp_no = e.emp_no
LEFT JOIN titles AS t ON t.title_id = e.emp_title_id
LEFT JOIN dept_emp AS de ON de.emp_no = e.emp_no
LEFT JOIN departments AS d ON d.dept_no = de.dept_no
;

-- SELECT * FROM employee_info;
-- SELECT COUNT(emp_no) FROM employees;


-- Create view for reference, Manager Info = employee table + dept_manager
CREATE VIEW manager_info AS 
SELECT * FROM employee_info
WHERE emp_no IN (
	SELECT emp_no FROM dept_manager);

SELECT * FROM manager_info;



-- DATA ANALYSIS
SELECT * FROM employee_info;

-- List the employee number, last name, first name, sex, and salary of each employee.
SELECT emp_no, last_name, first_name, sex, salary
FROM employee_info
ORDER BY emp_no
;

-- List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employee_info
WHERE hire_date >= '1986-01-01' AND hire_date <= '1986-12-31'
ORDER BY hire_date 
;

-- List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT title, dept_no, dept_name, emp_no, last_name, first_name 
FROM manager_info
ORDER BY dept_no
;

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT dept_no, emp_no, last_name, first_name, dept_name
FROM employee_info
ORDER BY emp_no 
;

-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employee_info
WHERE first_name = 'Hercules'
	AND last_name ILIKE 'b%'
ORDER BY last_name 
;

-- List each employee in the Sales department, including their employee number, last name, and first name.
SELECT dept_name, emp_no, last_name, first_name
FROM employee_info
WHERE dept_name = 'Sales'
ORDER BY emp_no 
;

-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT emp_no, last_name, first_name, dept_name
FROM employee_info
WHERE dept_name = 'Sales'
	OR dept_name = 'Development'
ORDER BY emp_no 
;

-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(emp_no) AS "Frequency"
FROM employee_info
GROUP BY last_name
ORDER BY "Frequency" DESC
;