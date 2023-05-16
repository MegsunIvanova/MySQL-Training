USE `soft_uni`;

# 16. Emails Trigger

CREATE TABLE `logs` (
	`log_id` INT PRIMARY KEY AUTO_INCREMENT,
    `account_id` INT NOT NULL,
    `old_sum` DECIMAL (19,4),
    `new_sum` DECIMAL (19,4)
);

CREATE TABLE `notification_emails` (
	`id` INT PRIMARY KEY AUTO_INCREMENT, 
    `recipient` INT NOT NULL,
    `subject` VARCHAR(100), 
    `body` VARCHAR(255)
);

DELIMITER $$

CREATE TRIGGER tr_accounts_balance_update
AFTER UPDATE
ON `accounts`
FOR EACH ROW
BEGIN
	INSERT INTO `logs` (`account_id`, `old_sum`, `new_sum`)
    VALUES (OLD.`id`, OLD.`balance`, NEW.`balance`);
    
END$$

CREATE TRIGGER tr_email_on_log_balance_change
BEFORE INSERT
ON `logs`
FOR EACH ROW
BEGIN
	INSERT INTO `notification_emails` (`recipient`, `subject`, `body`)
    VALUES(
		NEW.`account_id`,
        CONCAT('Balance change for account: ', NEW.`account_id`),
        CONCAT('On ', DATE_FORMAT(NOW(), '%b %d %Y at %r'), ' your balance was changed from ', ROUND(NEW.`old_sum`, 2), ' to ', ROUND(NEW.`new_sum`, 2), '.')
    );
    
END$$

#Tests

DROP TRIGGER tr_email_on_log_balance_change;
DROP TABLE `notification_emails`;
CALL usp_transfer_money (5, 6, 100);
SELECT * FROM `notification_emails`;
