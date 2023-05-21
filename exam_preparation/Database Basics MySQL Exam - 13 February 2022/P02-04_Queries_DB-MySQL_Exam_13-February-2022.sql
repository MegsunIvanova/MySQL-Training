USE `online_store`;

# 02. Insert
INSERT INTO `reviews` (`content`, `picture_url`, `published_at`, `rating`)
SELECT
	LEFT(`description`,15) AS 'content',
    REVERSE(`name`) AS 'picture_url',
    '2010-10-10' AS 'published_at',
    `price`/8 AS 'rating'
FROM `products`
WHERE `id` >= 5;

# 03. Update
UPDATE `products`
SET `quantity_in_stock` = `quantity_in_stock` - 5
WHERE `quantity_in_stock` BETWEEN 60 AND 70;

# 04. Delete
DELETE FROM `customers` AS `c`
WHERE (
	SELECT COUNT(*) 
	FROM `orders` AS `o`
    WHERE `c`.`id` = `o`.`customer_id`
) = 0;

# `products`, `customers`, `orders`, `categories`, `brands`, `reviews`, `orders_products`