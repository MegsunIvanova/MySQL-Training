USE `hotel`;
-- ==================================== --
-- Task 01: Select Employee Information --
-- ==================================== --

SELECT `id`, `first_name`, `last_name`, `job_title` 
FROM employees 
ORDER BY `id`;

-- ===================================== --
-- Task 02: Select Employees with Filter --
-- ===================================== --

SELECT
	`id`,
    CONCAT (`first_name`, ' ',  `last_name`) AS 'Full_name', 
    `job_title` AS 'Job Title', 
    `salary` AS 'Salary'
FROM `employees` 
WHERE `salary` > 1000.00;

-- ============================================= --
-- Task 05: Select Employees by Multiple Filters --
-- ============================================= --

SELECT `id`, `first_name`, `last_name`, `job_title`, `department_id`, `salary`
FROM `employees`
WHERE `department_id` = 4 AND `salary` >= 1000
ORDER BY `id`;

-- ========================== --
-- Task 04: Top Paid Employee --
-- ========================== --

CREATE VIEW `v_top_paid_employee` AS
	SELECT * FROM `employees`
    ORDER BY `salary`DESC
    LIMIT 1;
    
SELECT * FROM `v_toemployeesp_paid_employee`;

-- ================================= --
-- Task 03: Update Salary and Select --
-- ================================= --

UPDATE `employees`
SET `salary` = `salary` + 100
WHERE `job_title` = 'Manager';

SELECT `salary` FROM `employees`;

-- ========================== --
-- Task 06: Delete from Table --
-- ========================== --

DELETE FROM `employees`
WHERE `department_id` IN (1, 2);

SELECT * FROM `employees`
ORDER BY `id`;

-- =============== --
-- Demos, Examples: --
-- =============== --

SELECT 
	`id` AS 'No.', 
    `first_name` AS 'First Name', 
    `last_name` AS 'Last Name', 
    `job_title` AS 'Title' 
FROM `employees` 
ORDER BY `first_name`, `last_name`;

SELECT 
	`id` AS 'No.', 
    CONCAT (`first_name`, ' ', `last_name`) AS 'Full Name'
FROM `employees` 
ORDER BY `first_name`, `last_name`;

SELECT 
	`id` AS 'No.', 
    CONCAT_WS (' ', `first_name`,  `last_name`, `job_title`) AS 'Full Title'
FROM `employees` 
ORDER BY `first_name`, `last_name`;

SELECT CONCAT_WS (' ', `first_name`,  `middle_name`, `last_name`) AS 'Full Name'
FROM `gamebar`.`employees`
ORDER BY `first_name`;

SELECT CONCAT (`first_name`, ' ', `middle_name`, ' ',  `last_name`) AS 'Full Name'
FROM `gamebar`.`employees`;

SELECT DISTINCT `department_id`
FROM `employees`;

SELECT `id`, `first_name`, `department_id`
FROM `employees`
WHERE `department_id` = 1 OR `department_id` = 2;

SELECT `id`, `first_name`, `department_id`
FROM `employees`
WHERE `department_id` = 2 AND `first_name` = 'John';

SELECT `id`, `first_name`, `department_id`
FROM `employees`
WHERE NOT (`department_id` = 2 AND `first_name` = 'John');

SELECT `id`, `first_name`, `department_id`
FROM `employees`
WHERE `department_id` IN (1, 2);

SELECT `id`, `first_name`, `department_id`
FROM `employees`
WHERE `department_id` NOT IN (1, 2);

SELECT 
	`id` AS 'No.', 
    `first_name` AS 'First Name',
    `last_name` AS 'Last Name',
    `job_title` AS 'Title'
FROM `employees` AS e 
ORDER BY `first_name` ASC, `last_name` DESC;

CREATE VIEW `employees_from_1_3_4_salary_over_1000` AS
	SELECT 
		`id` AS 'No.', 
		`first_name` AS 'First Name',
		`last_name` AS 'Last Name',
		`job_title` AS 'Title'
	FROM `employees` AS e 
	WHERE `department_id` IN (1, 3, 4) AND  `salary` > 1000
	ORDER BY `first_name` ASC, `last_name` DESC;

SELECT * FROM `employees_from_1_3_4_salary_over_1000`;

SELECT * FROM `employees`
    ORDER BY `salary`DESC
    LIMIT 1, 2;
    
CREATE VIEW `deleted_column` AS	
	SELECT `id`, `to_be_deleted`
    FROM `hotel`.`employees`;
    
SELECT * FROM `deleted_column`;

SELECT CONCAT('Hello', ', ', 'Word') FROM `employees`;

INSERT INTO `hotel`.`rooms`(`type`) VALUES
	('Single Delux Room');

INSERT INTO `hotel`.`rooms`(`type`)
	(SELECT CONCAT('Hello', ', ', 'Word') FROM `hotel`.`employees`);

  SELECT NOW();  
  
  SELECT `id`, `first_name`, `salary` FROM `v_top_paid_employee`;
  
  CREATE VIEW `top_paid_col_subset` AS
	SELECT `id`, `first_name`, `salary` FROM `v_top_paid_employee`;
    
SELECT * FROM `top_paid_col_subset`;