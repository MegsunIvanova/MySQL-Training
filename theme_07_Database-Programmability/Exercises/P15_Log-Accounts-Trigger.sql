USE `soft_uni`;

# 15. Log Accounts Trigger

CREATE TABLE `logs` (
	`log_id` INT PRIMARY KEY AUTO_INCREMENT,
    `account_id` INT NOT NULL,
    `old_sum` DECIMAL (19,4) NOT NULL,
    `new_sum` DECIMAL (19,4) NOT NULL,
    CONSTRAINT `logs_accounts` FOREIGN KEY (`account_id`) REFERENCES `accounts`(`id`)
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

SELECT * FROM `logs`$$