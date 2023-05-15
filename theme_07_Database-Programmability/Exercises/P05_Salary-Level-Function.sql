USE `soft_uni`;

DELIMITER $$

# 05. Salary Level Function

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

SELECT ufn_get_salary_level(13500.00)$$
SELECT ufn_get_salary_level(43300.00)$$
SELECT ufn_get_salary_level(125500.00)$$