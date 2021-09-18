--STEPS 1-5
-- Query for retrive the employees who are born between January 1st 1952 to December 31th 1955.
SELECT e.emp_no,
	   e.first_name,
	   e.last_name,
	   tl.title,
	   tl.from_date,
	   tl.to_date
INTO retirement_titles	   
FROM employees as e
INNER JOIN  titles as tl
ON (e.emp_no = tl.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no; 

-- Check
SELECT * FROM retirement_titles;
SELECT COUNT(last_name) from retirement_titles; -- 133776

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (______) _____,
______,
______,
______

INTO nameyourtable
FROM _______
ORDER BY _____, _____ DESC;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO retirement_Uniq_titles
FROM retirement_titles as rt
ORDER BY rt.emp_no, rt.to_date DESC;


-- Check
SELECT COUNT(last_name) from retirement_uniq_titles; -- 90398

-- Create a table resume count group by titles name
SELECT COUNT(rut.title), rut.title
INTO retiring_titles
FROM retirement_uniq_titles as rut
GROUP BY rut.title
ORDER BY COUNT(rut.title) DESC;

-- Check 
SELECT * FROM retiring_titles;
SELECT SUM(count) from retiring_titles; -- 90398

-- Create a table for the eligibilty employees for mentorship
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	tl.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as tl
ON (e.emp_no = tl.emp_no)
WHERE (de.to_date = '9999-01-01')
	AND(e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

-- Check
SELECT * FROM mentorship_eligibilty;
SELECT COUNT(last_name) from mentorship_eligibilty; -- 1549

-- Create a table for the employees who will retire by department and title
SELECT count(e.first_name),
	d.dept_name,
	tl.title
INTO retirement_resume_dept_title
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
INNER JOIN retirement_uniq_titles as tl
ON (e.emp_no = tl.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01')
GROUP by (d.dept_no,tl.title)
ORDER BY (d.dept_no, tl.title);