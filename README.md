# CWRUBootcamp_M7_092222_PewlettHackar_Hoynacke-

## Overview/Objective 
Determine the number of retiring employees per title, and identify employees who are eligible to participate in a mentorship program. Once that data has been retrieved write a report that summarizes the analysis and helps prepare Bobby’s manager for the “silver tsunami” as many current employees reach retirement age.

## Deliverable 1 

1. Create a Retirement Titles table for employees who are born between January 1, 1952 and December 31, 1955.
2. Create a Unique Titles table that contains the employee number, first and last name, and most recent title.
3. Create a Retiring Titles table that contains the number of titles filled by employees who are retiring. (10 pt)

Below shows the code used to retirieve the necessary information for Deliverable 1

1. Create new table: retirment_titles
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

2. Remove duplicate rows to create table with only unique names 
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO unique_titles
FROM retirement_titles 
ORDER BY emp_no, title DESC;

3. Return count of employees sorted by job title and close to retirement 
SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY title
ORDER BY COUNT(title) DESC;

Below are snippets of each table created for Deliverable 1

<img width="516" alt="Screen Shot 2022-09-29 at 5 48 48 PM" src="https://user-images.githubusercontent.com/111096384/193148348-6b7cb19e-9fb9-4486-b9f1-36f55fb8e830.png">

<img width="386" alt="Screen Shot 2022-09-29 at 5 50 17 PM" src="https://user-images.githubusercontent.com/111096384/193148612-3b07660d-3026-4741-8990-eb8ba482dae9.png">

<img width="189" alt="Screen Shot 2022-09-29 at 5 50 38 PM" src="https://user-images.githubusercontent.com/111096384/193148625-f08cefe6-52a9-41e9-bee0-fa9aaebadedf.png">

## Deliverable 2 

Create a Mentorship Eligibility table for current employees who were born between January 1, 1965 and December 31, 1965. 

Below shows the code to complete the above deliverable 

Deliverable 2: Create a table of Employees who are eligible for mentorship program
SELECT DISTINCT ON(e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title
INTO mentor_eligible
FROM employees as e
LEFT OUTER JOIN dept_emp as de 
ON (e.emp_no = de.emp_no)
LEFT OUTER JOIN titles as t 
ON (e.emp_no = t.emp_no) 
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

Below is a snippet of the mentorship eligibility table 

<img width="573" alt="Screen Shot 2022-09-29 at 5 56 44 PM" src="https://user-images.githubusercontent.com/111096384/193149402-26065aa0-2f50-494a-bae3-b0c7438bffde.png">

## Summary: Provide high-level responses to the following questions, then provide two additional queries or tables that may provide more insight into the upcoming "silver tsunami."

#### How many roles will need to be filled as the "silver tsunami" begins to make an impact?

Retiring Title Results:
count,title:
32452,Staff
29415,Senior Engineer
14221,Engineer
8047,Senior Staff
4502,Technique Leader
1761,Assistant Engineer

#### Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?
No, since there are potentially 93,398 employees retiring at any point and only 1,940 mentorship eligible employee. 

