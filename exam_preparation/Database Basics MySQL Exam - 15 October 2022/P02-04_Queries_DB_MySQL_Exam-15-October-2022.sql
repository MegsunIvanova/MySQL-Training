# 02. Insert

INSERT INTO `products` (`name`, `type`, `price`)
SELECT
	CONCAT(`last_name`, " ", "specialty") AS `name`,
	'Cocktail' AS `type`,
	CEIL(`salary` * 0.01) AS `price`
FROM `waiters`
WHERE `id` > 6;

# 03. Update

UPDATE `orders`
SET `table_id` = `table_id` - 1
WHERE `id` BETWEEN 12 AND 23;

# 04. Delete

DELETE FROM `waiters` AS `w`
WHERE (SELECT COUNT(*) FROM `orders` AS `o` WHERE `o`.`waiter_id` = `w`.`id` ) = 0;