-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;


-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
    dept_emp.to_date

FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;


- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
    dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;


SELECT ri.emp_no,
    ri.first_name,
ri.last_name,
    de.to_date

FROM retirement_info as ri
LEFT JOIN dept_emp as de

ON ri.emp_no = de.emp_no;



-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date

FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;




SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date

FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;



SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
	de.to_date

INTO current_emp

FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no

WHERE de.to_date = ('9999-01-01');




SELECT emp_to_join.emp_no,
	emp_to_join.first_name,
	emp_to_join.last_name,
	emp_to_join.birth_date,
	titles_to_join.title,
	titles_to_join.from_date,
	titles_to_join.to_date
-- INTO retirement_titles
FROM emp_to_join
LEFT JOIN titles_to_join
ON emp_to_join.emp_no = titles_to_join.emp_no;
SELECT * FROM retirement_titles WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY emp_no;
