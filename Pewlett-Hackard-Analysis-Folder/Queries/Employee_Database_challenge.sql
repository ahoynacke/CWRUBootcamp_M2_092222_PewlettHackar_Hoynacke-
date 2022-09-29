-- Deliverable 1: Count of retiring employees by title 

--- Create new table 
SELECT e.emp_no,
	   e.first_name,
	   e.last_name,
	   t.title,
	   t.from_date,
	   t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t 
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

--- Remove duplicate rows to create table with only unique names 
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO unique_titles
FROM retirement_titles 
ORDER BY emp_no, title DESC;

--- Return count of employees sorted by job title and close to retirement 
SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY title
ORDER BY COUNT(title) DESC;

-- Deliverable 2: Create a table of Employees who are eligible for mentorship program
SELECT DISTINCT ON(e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title
INTO mentor_eligible
FROM employees as e
LEFT OUTER JOIN dept_emp as de 
ON (e.emp_no = de.emp_no)
LEFT OUTER JOIN titles as t 
ON (e.emp_no = t.emp_no) 
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;