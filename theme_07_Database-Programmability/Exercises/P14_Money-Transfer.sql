USE `soft_uni`;

SELECT `id` AS 'account_id', `account_holder_id`, `balance`
FROM `accounts`
WHERE `id` IN (1, 2) ;

SELECT (`balance` - 100) FROM `accounts` WHERE `id`= 1;

DELIMITER $$

# 14. Money Transfer

CREATE PROCEDURE usp_transfer_money(from_account_id INT, to_account_id INT, amount DECIMAL(19,4))
BEGIN
	DECLARE from_count_by_id INT;
	DECLARE from_new_balance DECIMAL (19,4);
    DECLARE to_count_by_id INT;
	DECLARE to_new_balance DECIMAL (19,4);
    
    START TRANSACTION;
	
    SET from_count_by_id := (SELECT COUNT(*) FROM `accounts` WHERE `id`= from_account_id);
	SET from_new_balance := (SELECT (`balance` - amount) FROM `accounts` WHERE `id`= from_account_id);
    
    SET to_count_by_id := (SELECT COUNT(*) FROM `accounts` WHERE `id`= to_account_id);
	SET to_new_balance := (SELECT (`balance` + amount) FROM `accounts` WHERE `id`= to_account_id);
    
    UPDATE `accounts` SET `balance` = from_new_balance WHERE `id`= from_account_id;
    UPDATE `accounts` SET `balance` = to_new_balance WHERE `id`= to_account_id;
    
    IF(
		from_count_by_id <> 1 OR 
		to_count_by_id <> 1 OR 
        amount < 0 OR
        from_new_balance < 0 OR 
        from_account_id = to_account_id
	) THEN 
		ROLLBACK;
	ELSE
		COMMIT;
	END IF;    
    
END$$

CALL usp_transfer_money (5, 6, 100)$$