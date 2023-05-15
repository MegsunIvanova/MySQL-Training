USE `soft_uni`;

# 01. Employee Address

SELECT
	e.`employee_id`,
    e.`job_title`,
    e.`address_id`,
    a.`address_text`
FROM `employees` AS e
LEFT JOIN `addresses` AS a
ON e.`address_id` = a.`address_id`
ORDER BY a.`address_id`
LIMIT 5;

# 02. Addresses with Towns

SELECT
	e.`first_name`,
    e.`last_name`,
    t.`name`,
    a.`address_text`
FROM `employees` AS e
LEFT JOIN `addresses` AS a
ON e.`address_id` = a.`address_id`
LEFT JOIN `towns` AS t
ON a.`town_id` = t.`town_id`
ORDER BY e.`first_name`, e.`last_name`
LIMIT 5;

# 03. Sales Employee

SELECT
	e.`employee_id`,
    e.`first_name`,
    e.`last_name`,
    d.`name` AS 'department_name'
FROM `employees` AS e
JOIN `departments` AS d
ON e.`department_id` = d.`department_id`
WHERE d.`name` = 'Sales'
ORDER BY `employee_id` DESC;

# 04. Employee Departments

SELECT
	e.`employee_id`,
    e.`first_name`,
    e.`salary`,
    d.`name` AS 'department_name'
FROM `employees` AS e
JOIN `departments` AS d
ON e.`department_id` = d.`department_id`
WHERE e.`salary` > 15000
ORDER BY d.`department_id` DESC
LIMIT 5;

# 05. Employees Without Project

SELECT
	e.`employee_id`,
    e.`first_name`
FROM `employees` AS e
LEFT JOIN `employees_projects` AS ed
ON e.`employee_id` = ed.`employee_id`
WHERE ed.`employee_id` IS NULL
ORDER BY e.`employee_id` DESC
LIMIT 3;

# 06. Employees Hired After

SELECT
    e.`first_name`,
    e.`last_name`,
    e.`hire_date`,
    d.`name` AS 'dept_name'
FROM `employees` AS e	
JOIN `departments` AS d
ON e.`department_id` = d.`department_id`
WHERE (e.`hire_date` > '1999-01-01') 
	AND (d.`name` = 'Sales' OR d.`name` = 'Finance')
ORDER BY e.`hire_date`;

# 07. Employees with Project

SELECT 
	e.`employee_id`,
    e.`first_name`,
    p.`name` AS 'project_name'
FROM `employees` AS e
JOIN `employees_projects` AS ep
ON e.`employee_id` = ep.`employee_id`
JOIN `projects` AS p
ON ep.`project_id` = p.`project_id`
WHERE p.`start_date`>= '2002-08-14' AND p.`end_date` IS NULL
ORDER BY e.`first_name`, p.`name`
LIMIT 5;

# 08. Employee 24

SELECT 
	ep.`employee_id`,
    e.`first_name`,
    IF(YEAR(p.`start_date`) >= 2005, 
		NULL, 
        p.`name`
        ) AS 'project_name'
FROM `employees` AS e
RIGHT JOIN `employees_projects` AS ep
ON e.`employee_id` = ep.`employee_id`
JOIN  `projects` AS p
ON ep.`project_id` = p.`project_id`
WHERE ep.`employee_id` = 24
ORDER BY p.`name`;

# 09. Employee Manager

SELECT 
	e.`employee_id`, 
    e.`first_name`, 
    e.`manager_id`,
    (
    SELECT m.`first_name`
    FROM `employees` AS m
    WHERE m.`employee_id` = e.`manager_id`
    ) AS 'manager_name'
FROM `employees` AS e
WHERE `manager_id` = 3 OR manager_id = 7
ORDER BY `first_name`;

# 10. Employee Summary

SELECT 
	e.`employee_id`, 
    CONCAT (e.`first_name`, ' ', e.`last_name`) AS 'employee_name', 
    CONCAT (m.`first_name`, ' ', m.`last_name`) AS 'manager_name',
    d.`name` AS 'department_name'
FROM `employees` AS e
	JOIN `employees` AS m ON e.`manager_id` = m.`employee_id`
	JOIN `departments` AS d ON e.`department_id` = d.`department_id`
ORDER BY e.`employee_id`
LIMIT 5;

# 11. Min Average Salary

SELECT AVG(`salary`) AS 'min_average_salary'
FROM `employees`
GROUP BY `department_id`
ORDER BY `min_average_salary`
LIMIT 1;