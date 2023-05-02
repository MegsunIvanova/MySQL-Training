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

SELECT `name`
FROM `towns`
WHERE CHAR_LENGTH(`name`) BETWEEN 5 AND 6
ORDER BY `name`;

-- ============================ --
-- 06. Find Towns Starting With --
-- ============================ --

SELECT `town_id`, `name`
FROM `towns`
WHERE `name` LIKE ('m%') OR `name` LIKE ('k%') OR `name` LIKE ('b%') OR `name` LIKE ('e%')
/* WHERE `name` REGEXP '^[m, k, b, e][a-z]*' */
ORDER BY `name`;

-- ================================ --
-- 07. Find Towns Not Starting With --
-- ================================ --

SELECT `town_id`, `name`
FROM `towns`
WHERE `name` NOT LIKE ('r%') AND `name` NOT LIKE ('b%') AND `name` NOT LIKE ('d%')
ORDER BY `name`;

-- ===================================== --
-- 08. Create View Employees Hired After --
-- ===================================== --

CREATE VIEW `v_employees_hired_after_2000` AS
	SELECT `first_name`, `last_name`
    FROM `employees`
    WHERE YEAR(`hire_date`) > 2000;
    
SELECT * FROM `v_employees_hired_after_2000`;

-- ======================= --
-- 09. Length of Last Name --
-- ======================= --

SELECT `first_name`, `last_name`
    FROM `employees`
    WHERE CHARACTER_LENGTH(`last_name`) = 5;
