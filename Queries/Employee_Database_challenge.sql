-- Create employees table to join
SELECT employees.emp_no,
	employees.first_name,
	employees.last_name,
	employees.birth_date
INTO emp_to_join
    FROM employees

-- Create titles table to join
SELECT titles.emp_no,
	titles.title,
	titles.from_date,
	titles.to_date
INTO titles_to_join
	FROM titles

-- Join the two tables

SELECT emp_to_join.emp_no,
	emp_to_join.first_name,
	emp_to_join.last_name,
	titles_to_join.title,
	titles_to_join.from_date,
	titles_to_join.to_date
INTO retirement_titles
FROM emp_to_join

LEFT JOIN titles_to_join
ON emp_to_join.emp_no = titles_to_join.emp_no
WHERE (emp_to_join.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON(retirement_titles.emp_no)
	emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM retirement_titles
ORDER BY retirement_titles.emp_no ASC, retirement_titles.to_date DESC;


-- Create count employees table to join
SELECT COUNT(unique_titles.emp_no)

INTO retiring_count
FROM unique_titles
GROUP BY unique_titles.title

-- Create titles table to join
SELECT COUNT(unique_titles.emp_no),
	unique_titles.title
INTO title_count
FROM unique_titles
GROUP BY unique_titles.title


-- Join the two tables

SELECT title_count.count,
	title_count.title
INTO retiring_titles
FROM title_count
LEFT JOIN retiring_count
ON retiring_count.count = title_count.count
ORDER BY title_count.count DESC


SELECT DISTINCT ON (em.emp_no)
					em.emp_no,
					em.first_name,
					em.last_name,
					em.birth_date,
					de.from_date,
					de.to_date,
 					ti.title
INTO mentorship_eligibility
FROM employees as em

LEFT OUTER JOIN dept_emp AS de
        ON (em.emp_no = de.emp_no)
RIGHT OUTER JOIN titles AS ti
        ON (em.emp_no = ti.emp_no)
WHERE (em.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
		AND (de.to_date = '9999-01-01')
ORDER BY em.emp_no;


-- SYNTAX FOR DELIVERABLE 3
-- Get the retiring salaries per department
SELECT unique_titles.emp_no,
	salaries.salary,
	dept_emp.dept_no,
	dept_info.dept_name
INTO salaries_by_dept
FROM unique_titles

INNER JOIN salaries
ON unique_titles.emp_no = salaries.emp_no
INNER JOIN  dept_emp
ON unique_titles.emp_no = dept_emp.emp_no
INNER JOIN dept_info
ON unique_titles.emp_no = dept_info.emp_no;

-- SUM the salaries and group by department name

SELECT (salaries_by_dept.dept_name),
SUM (salaries_by_dept.salary)
INTO dept_salaries_total
FROM salaries_by_dept
GROUP BY dept_name;
