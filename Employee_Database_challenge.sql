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

-- retrieve the number of employees by their most recent job title who are about to retire.
-- First, retrieve the number of titles from the Unique Titles table.
-- Then, create a Retiring Titles table to hold the required information.
-- Group the table by title, then sort the count column in descending order.
-- Export the Retiring Titles table as retiring_titles.csv and save it to your Data folder in the Pewlett-Hackard-Analysis folder.
-- Before you export your table, confirm that it looks like this image:

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
ORDER BY title_count.count DESC;
