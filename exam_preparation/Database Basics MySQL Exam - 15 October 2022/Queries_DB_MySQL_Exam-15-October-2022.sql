CREATE DATABASE restaurant_db;

USE restaurant_db;

# 01. Table Design

CREATE TABLE `products` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(30) UNIQUE NOT NULL,
	`type` VARCHAR(30) NOT NULL,
    `price` DECIMAL(10,2) NOT NULL
);

CREATE TABLE `clients` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `first_name` VARCHAR(50) NOT NULL,
    `last_name` VARCHAR(50) NOT NULL,
    `birthdate` DATE NOT NULL,
    `card` VARCHAR(50),
    `review` TEXT
);

CREATE TABLE `tables` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `floor` INT NOT NULL,
    `reserved` TINYINT(1),
    `capacity` INT NOT NULL
);

CREATE TABLE `waiters` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `first_name` VARCHAR(50) NOT NULL,
    `last_name` VARCHAR(50) NOT NULL,
    `email` VARCHAR(50) NOT NULL,
    `phone` VARCHAR(50),
    `salary` DECIMAL (10,2)
);

CREATE TABLE `orders` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `table_id` INT NOT NULL,
	`waiter_id` INT NOT NULL,
    `order_time` TIME NOT NULL,
    `payed_status` TINYINT(1),
    CONSTRAINT `fk_tables_orders` FOREIGN KEY (`table_id`) REFERENCES `tables`(`id`),
    CONSTRAINT `fk_waiters_orders` FOREIGN KEY (`waiter_id`) REFERENCES `waiters`(`id`)
);

CREATE TABLE `orders_clients` (
	`order_id` INT,
    `client_id` INT,
    CONSTRAINT `fk_orders_orders_clients` FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`),
    CONSTRAINT `fk_clients_orders_clients` FOREIGN KEY (`client_id`) REFERENCES `clients`(`id`)
);


CREATE TABLE `orders_products` (
	`order_id` INT,
    `product_id` INT,
    CONSTRAINT `fk_orders_orders_products` FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`),
    CONSTRAINT `fk_products_orders_products` FOREIGN KEY (`product_id`) REFERENCES `products`(`id`)
);

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

# 05. Clients

SELECT * FROM `clients`
ORDER BY `birthdate` DESC, `id` DESC;

# 06. Birthdate

SELECT `first_name`, `last_name`, `birthdate`, `review` 
FROM `clients`
WHERE `card` IS NULL AND (YEAR(`birthdate`) BETWEEN 1978 AND 1993)
ORDER BY `last_name` DESC, `id` ASC
LIMIT 5;

# 07. Accounts

SELECT 
	CONCAT(`last_name`, `first_name`, CHAR_LENGTH(`first_name`), 'Restaurant') AS `username`,
    CONCAT(REVERSE(MID(`email`, 2, 13-2+1))) AS `password`
FROM `waiters`
WHERE `salary` IS NOT NULL
ORDER BY `password` DESC;

# 08. Top from menu

SELECT `p`.`id`, `p`.`name`, COUNT(*) AS `count`
FROM `products` AS `p`
JOIN `orders_products` AS `op` ON `p`.`id` = `op`.`product_id`
JOIN `orders` AS `o` ON `op`.`order_id` = `o`.`id`
GROUP BY `p`.`id`
HAVING `count` >= 5
ORDER BY `count` DESC, `p`.`name` ASC;

# 09. Availability

SELECT 
	`t`.`id`,
    `t`.`capacity`,
    COUNT(`c`.`id`) AS `count_clients`,
    CASE WHEN (`t`.`capacity` > COUNT(`c`.`id`)) THEN 'Free seats'
		WHEN (`t`.`capacity` = COUNT(`c`.`id`)) THEN 'Full'
		ELSE 'Extra seats' 
        END AS `availability`
FROM `tables` AS `t`
JOIN `orders` AS `o` ON `t`.`id` = `o`.`table_id`
JOIN `orders_clients` AS `oc` ON `o`.`id` = `oc`.`order_id`
JOIN `clients` AS `c` ON `oc`.`client_id` = `c`.`id`
WHERE `t`.`floor` = 1
GROUP BY `t`.`id`
ORDER BY `t`.`id` DESC;

# 10. Extract bill

SELECT 	 	    
    SUM(`p`.`price`)
FROM `clients` AS `c`
JOIN `orders_clients` AS `oc` ON `c`.`id` = `oc`.`client_id`
JOIN `orders` AS `o` ON `oc`.`order_id` = `o`.`id`
JOIN `orders_products` AS `op` ON `o`.`id` = `op`.`order_id`
JOIN `products` AS `p` ON `op`.`product_id` = `p`.`id`
WHERE CONCAT(`c`.`first_name`, ' ',`c`.`last_name`) = 'Silvio Blyth'
GROUP BY `c`.`id`;

DELIMITER $$

CREATE FUNCTION udf_client_bill(full_name VARCHAR(50))
RETURNS DECIMAL (19,2)
DETERMINISTIC
BEGIN
	RETURN (
		SELECT SUM(`p`.`price`)
		FROM `clients` AS `c`
		JOIN `orders_clients` AS `oc` ON `c`.`id` = `oc`.`client_id`
		JOIN `orders` AS `o` ON `oc`.`order_id` = `o`.`id`
		JOIN `orders_products` AS `op` ON `o`.`id` = `op`.`order_id`
		JOIN `products` AS `p` ON `op`.`product_id` = `p`.`id`
		WHERE CONCAT(`c`.`first_name`, ' ',`c`.`last_name`) = full_name
		GROUP BY `c`.`id`
	);
	
END$$

DELIMITER ;

SELECT c.first_name,c.last_name, udf_client_bill('Silvio Blyth') as 'bill' FROM clients c
WHERE c.first_name = 'Silvio' AND c.last_name= 'Blyth';

# 11. Happy hour

UPDATE `products`
SET `price` = `price` * 0.8
WHERE `type` = 'Cognac' AND `price` >= 10;

DELIMITER $$

CREATE PROCEDURE udp_happy_hour (product_type VARCHAR(50))
BEGIN
	UPDATE `products`
	SET `price` = `price` * 0.8
	WHERE `type` = product_type AND `price` >= 10;
    
END$$

DELIMITER ;	

CALL udp_happy_hour ('Cognac');	

SELECT * FROM `products`
WHERE `type` = 'Cognac';