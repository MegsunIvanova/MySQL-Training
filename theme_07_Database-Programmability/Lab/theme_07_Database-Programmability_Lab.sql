USE soft_uni;

# Demo code task 1 (User-Defined Functions):

## Demo code for task
SELECT `town_id` FROM `towns` WHERE name = 'Sofia';
SELECT * FROM `addresses` WHERE `town_id` = 32;
SELECT * FROM `employees` WHERE `address_id` = 291;

SELECT COUNT(*) FROM `employees` AS `e`
JOIN `addresses` AS `a` ON `a`.`address_id`  = `e`.`address_id`
JOIN `towns` AS `t` ON `t`.`town_id` = `a`.`town_id`
WHERE `t`.`name` = 'Sofia';

SELECT COUNT(*) FROM `employees` AS `e`
WHERE `e`.`address_id` IN (
	SELECT `address_id` FROM `addresses` AS `a`
    WHERE `a`.`town_id` = (
		SELECT `town_id` FROM `towns` AS `t` WHERE `name` = 'Sofia'
	)
);

DELIMITER $$

# Task 1. Count Employees by Town:

CREATE FUNCTION ufn_count_employees_by_town(town_name VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE id_for_town INT;
    DECLARE count_by_town INT;
    
    SET id_for_town := (SELECT `town_id` FROM `towns` WHERE `name` = town_name);
    SET count_by_town := (
		SELECT COUNT(*) FROM `employees` AS `e`
		WHERE `e`.`address_id` IN (
			SELECT `address_id` FROM `addresses` WHERE `town_id` = id_for_town
		)
	);
    
	RETURN count_by_town;
END$$

-- function call: 
SELECT `soft_uni`.`ufn_count_employees_by_town`('Sofia')$$

# Task 2. Employees Promotion (User-Stored Procedures):

CREATE PROCEDURE usp_raise_salaries(department_name VARCHAR(50))
BEGIN
	UPDATE `employees` AS e
    SET `salary` = `salary` * 1.05
    WHERE `department_id` = (
		SELECT `department_id` FROM `departments` WHERE `name` = department_name
	);

END$$

CALL usp_raise_salaries('Engineering')$$

# Demo code (User-Stored Procedures with OUT parameter/s):

CREATE PROCEDURE usp_raise_salaries_out(
	department_name VARCHAR(50), 
    OUT affected_employees INT,
    OUT stuff VARCHAR(50))
BEGIN
	DECLARE dept_id INT;
    
    SET dept_id := (SELECT `department_id` FROM `departments` WHERE `name` = department_name);
    
    SET affected_employees := (SELECT COUNT(*) FROM `employees` WHERE `department_id` = dept_id);
    
	UPDATE `employees` AS e
    SET `salary` = `salary` * 1.05
    WHERE `department_id` = dept_id;
    
    SET stuff := 'EXECUTED';

END$$

-- User-Defined-Variables: 
SET @affected_employees = 0$$
SET @outside = 0$$

SELECT @outside, @affected_employees$$

-- Procedure call:
CALL usp_raise_salaries_out('Engineering', @affected_employees, @outside)$$
SELECT @outside, @affected_employees$$

-- the procedure could be called withot defining the variables before that:
CALL usp_raise_salaries_out('Engineering', @asd, @dsa)$$
SELECT @dsa, @asd$$

# Demo code (Transactions):

START TRANSACTION$$
SELECT * FROM `employees_projects`$$
DELETE FROM `employees_projects` WHERE `employee_id` = 3 AND `project_id` = 1$$
ROLLBACK$$ -- COMMIT$$
SELECT * FROM `employees_projects`  WHERE `employee_id` = 3$$

# Task 3. Employees Promotion By ID

CREATE PROCEDURE usp_raise_salary_by_id(id INT)
BEGIN
	DECLARE count_by_id INT;
    
	START TRANSACTION;
    SET count_by_id := (SELECT COUNT(*) FROM `employees` WHERE `employee_id` = id);
    
    UPDATE `employees` SET `salary` =  `salary` * 1.05 WHERE `employee_id` = id;
    
    IF(count_by_id < 1) THEN
		ROLLBACK;
	ELSE 
		COMMIT;
	END IF;
END$$

# Task 4. Triggered 

-- DROP TABLE `deleted_employees`$$

CREATE TABLE `deleted_employees` (
	`employee_id` INT PRIMARY KEY AUTO_INCREMENT,
    `first_name` VARCHAR(50),
    `last_name` VARCHAR(50),
    `middle_name` VARCHAR(50),
    `job_title` VARCHAR(50),
    `department_id` INT,
    `salary` DECIMAL(19,4)
    )$$
    
-- DROP TRIGGER `tr_deleted_employees`$$

CREATE TRIGGER `tr_deleted_employees`
AFTER DELETE
ON `employees` 
FOR EACH ROW
BEGIN
	INSERT INTO `deleted_employees` (
		`first_name`,
        `last_name`,
        `middle_name`,
        `job_title`,
        `department_id`,
        `salary`
    )
	VALUES (
		-- OLD.`employee_id`,
		OLD.`first_name`, 
        OLD.`last_name`, 
        OLD.`middle_name`, 
        OLD.`job_title`, 
        OLD.`department_id`, 
        OLD.`salary`);
        
END$$

SELECT * FROM `employees` AS `e`
WHERE (
	SELECT COUNT(*) 
	FROM `employees_projects` AS ep 
    WHERE `ep`.`employee_id` = `e`.`employee_id`
) = 0$$

SELECT * FROM `deleted_employees`$$

DELETE FROM `employees` WHERE `employee_id` = 28$$

# Demo code (Triggers)

-- DROP TRIGGER tr_projects_without_employees$$

CREATE TRIGGER tr_projects_without_employees
AFTER DELETE
ON `employees_projects`
FOR EACH ROW
BEGIN
	DECLARE employee_count INT;
    
	SET employee_count := (
		SELECT COUNT(*) 
        FROM `employees_projects` 
        WHERE `project_id` = OLD.`project_id`
	);
	
    IF (employee_count = 0) THEN
		UPDATE `projects` 
			SET `end_date` = NOW() 
            WHERE `project_id` = OLD.`project_id` AND `end_date` IS NULL;
    END IF;
END$$

SELECT * FROM  `projects` WHERE `end_date` IS NULL$$

SELECT * FROM `projects` WHERE `project_id` = 10$$

SELECT * FROM `employees_projects` WHERE `project_id` = 10$$

DELETE FROM `employees_projects` WHERE `project_id` = 10$$

DELIMITER ;

