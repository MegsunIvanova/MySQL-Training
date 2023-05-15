USE `soft_uni`;

DELIMITER $$

# 06. Employees by Salary Level

CREATE FUNCTION ufn_get_salary_level (salary DECIMAL(19,2))
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
	DECLARE result VARCHAR(10);
    
    IF (salary < 30000) THEN
		SET result := ('Low');
	ELSEIF (salary BETWEEN 30000 AND 50000) THEN
		SET result := ('Average');
	ELSE 
		SET result := ('High');
	END IF;
    
    RETURN result;
END$$

CREATE PROCEDURE usp_get_employees_by_salary_level (salary_level VARCHAR(7))
BEGIN	
	SELECT `first_name`, `last_name` FROM `employees`
	WHERE ufn_get_salary_level(`salary`) LIKE salary_level
    ORDER BY `first_name` DESC, `last_name` DESC;

END$$

CALL usp_get_employees_by_salary_level('high')$$