USE `soft_uni`;

SELECT `id` AS 'account_id', `account_holder_id`, `balance`
FROM `accounts`
WHERE `id` = 1;

DELIMITER $$

# 13. Withdraw Money

CREATE PROCEDURE usp_withdraw_money(account_id INT, money_amount DECIMAL(19,4))
BEGIN
	DECLARE count_by_id INT;
	DECLARE new_balance DECIMAL (19,4);
    
    START TRANSACTION;
	
    SET count_by_id = (SELECT COUNT(*) FROM `accounts` WHERE `id`= account_id);
	SET new_balance = (SELECT (`balance` - money_amount) FROM `accounts` WHERE `id`= account_id);
    
    UPDATE `accounts` SET `balance` = new_balance WHERE `id`= account_id;
    
    IF(count_by_id <> 1 OR money_amount < 0 OR new_balance < 0) THEN
		ROLLBACK;
	ELSE
		COMMIT;
	END IF;
    
END$$

CALL usp_withdraw_money(1, 200)$$