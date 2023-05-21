USE `online_store`;

# 05. Categories
SELECT * FROM `categories`
ORDER BY `name` DESC;

# 06. Quantity
SELECT `id`, `brand_id`, `name`, `quantity_in_stock`
FROM `products`
WHERE `price` > 1000 AND `quantity_in_stock` < 30
ORDER BY `quantity_in_stock`, `id`;

# 07. Review
SELECT * FROM `reviews`
WHERE `content` LIKE 'My%'  AND CHAR_LENGTH(`content`) > 61
ORDER BY `rating` DESC;

# 08. First customers
SELECT 
	CONCAT(`c`.`first_name`, " ", `c`.`last_name`) AS `full_name`,
    `c`.`address`,
    `o`.`order_datetime`
FROM `customers` AS `c`
JOIN `orders` AS `o` ON `c`.`id` = `o`.`customer_id`
WHERE YEAR(`o`.`order_datetime`) <= 2018
ORDER BY `full_name` DESC;

# . Best categories
SELECT 
	COUNT(*) AS `items_count`,
    `c`.`name`,
    SUM(`p`.`quantity_in_stock`) AS `total_quantity`
FROM `categories` AS `c`
JOIN `products` AS `p` ON `c`.`id` = `p`.`category_id`
GROUP BY  `c`.`name`
ORDER BY `items_count` DESC, `total_quantity`
LIMIT 5;

# 10. Extract client cards count
SELECT COUNT(*) AS `total_products`
FROM `customers` AS `c`
JOIN `orders` AS `o` ON  `c`.`id` = `o`.`customer_id`
JOIN `orders_products` AS `op` ON `o`.`id` = `op`.`order_id`
JOIN `products` AS `p` ON `op`.`product_id` = `p`.`id`
WHERE `c`.`first_name` = 'Shirley';

DELIMITER $$

CREATE FUNCTION udf_customer_products_count(`name` VARCHAR(30))
RETURNS INT
DETERMINISTIC
BEGIN
	RETURN(
		SELECT COUNT(*) AS `total_products`
		FROM `customers` AS `c`
		JOIN `orders` AS `o` ON  `c`.`id` = `o`.`customer_id`
		JOIN `orders_products` AS `op` ON `o`.`id` = `op`.`order_id`
		JOIN `products` AS `p` ON `op`.`product_id` = `p`.`id`
		WHERE `c`.`first_name` = `name`
    );
END$$

DELIMITER ;

SELECT c.first_name, c.last_name, udf_customer_products_count('Shirley') as `total_products` 
FROM customers c
WHERE c.first_name = 'Shirley';

# 11. Reduce price
DELIMITER $$

CREATE PROCEDURE udp_reduce_price (category_name VARCHAR(50))
BEGIN
	UPDATE `products` AS `p`
	SET `p`.`price` = `p`.`price` * 0.70
	WHERE 
		(SELECT `name` FROM `categories` AS `c` WHERE `p`.`category_id` = `c`.`id`) = category_name 
		AND
		(SELECT `rating` FROM `reviews` AS `r` WHERE `p`.`review_id` = `r`.`id`) < 4;

END$$

DELIMITER ;

## Testing:
SELECT * 
FROM `products` AS `p`
WHERE 
	(SELECT `name` FROM `categories` AS `c` WHERE `p`.`category_id` = `c`.`id`) = 'Phones and tablets' 
    AND
    (SELECT `rating` FROM `reviews` AS `r` WHERE `p`.`review_id` = `r`.`id`) < 4;
    
UPDATE `products` AS `p`
SET `p`.`price` = `p`.`price` * 0.70
WHERE 
	(SELECT `name` FROM `categories` AS `c` WHERE `p`.`category_id` = `c`.`id`) = 'Phones and tablets' 
    AND
    (SELECT `rating` FROM `reviews` AS `r` WHERE `p`.`review_id` = `r`.`id`) < 4;

CALL udp_reduce_price ('Phones and tablets');

# `products`, `customers`, `orders`, `categories`, `brands`, `reviews`, `orders_products`