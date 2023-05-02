USE `soft_uni`;

-- ============================================= --
-- 01. Find Names of All Employees by First Name --
-- ============================================= --

SELECT `first_name`, `last_name`
FROM `employees`
WHERE LOCATE('Sa', `first_name`) = 1
ORDER BY `employee_id`;

-- ============================================ --
-- 02. Find Names of All Employees by Last Name --
-- ============================================ --

SELECT `first_name`, `last_name`
FROM `employees`
WHERE LOCATE('ei', `last_name`) > 0
ORDER BY `employee_id`;

-- ===================================== --
-- 03. Find First Names of All Employess --
-- ===================================== --

SELECT `first_name`
FROM `employees`
WHERE 
	(`department_id` = 3 OR `department_id` = 10) 
    AND 
    (EXTRACT(YEAR FROM `hire_date`) BETWEEN 1995 AND 2005)
ORDER BY `employee_id`;

-- ======================================= --
-- 04. Find All Employees Except Engineers --
-- ======================================= --

SELECT `first_name`, `last_name`
FROM `employees`
WHERE LOCATE('engineer', `job_title`) = 0
ORDER BY `employee_id`;

-- =============================== --
-- 05. Find Towns with Name Length --
-- =============================== --


