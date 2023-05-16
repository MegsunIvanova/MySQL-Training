USE `soft_uni`;

DELIMITER $$

# 9. People with Balance Higher Than *

CREATE PROCEDURE usp_get_holders_with_balance_higher_than (num INT)
BEGIN
	SELECT `h`.`first_name`, `h`.`last_name`
	FROM `account_holders` AS `h`
	JOIN `accounts` AS `a` ON `h`.`id` = `a`.`account_holder_id`
	GROUP BY `h`.`id`
	HAVING SUM(`a`.`balance`) > num;
    
END$$

CALL usp_get_holders_with_balance_higher_than (7000)$$