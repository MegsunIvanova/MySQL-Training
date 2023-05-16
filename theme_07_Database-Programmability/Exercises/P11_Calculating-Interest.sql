USE `soft_uni`;

DELIMITER $$

# 11. Calculating Interest

CREATE FUNCTION ufn_calculate_future_value(sum DECIMAL(19, 4), yearly_rate DOUBLE, years INT)
RETURNS DECIMAL (19, 4)
DETERMINISTIC
BEGIN
	DECLARE futute_value DECIMAL(19, 4);
    
    SET futute_value := sum * POW(1 + yearly_rate, years);
    
    RETURN futute_value;
	
END$$

CREATE PROCEDURE usp_calculate_future_value_for_account (id INT, rate DECIMAL(19,4))
BEGIN
	SELECT 
		`a`.`id` AS 'account_id', 
        `h`.`first_name`, 
        `h`.`last_name`, 
        `a`.`balance` AS 'current_balance',
        ufn_calculate_future_value (`a`.`balance`, rate, 5) AS 'balance_in_5_years'
	FROM `account_holders` AS `h`
	JOIN `accounts` AS `a` ON `h`.`id` = `a`.`account_holder_id`
    WHERE `a`.`id` = id;
    
END$$

CALL usp_calculate_future_value_for_account (1, 0.1)$$