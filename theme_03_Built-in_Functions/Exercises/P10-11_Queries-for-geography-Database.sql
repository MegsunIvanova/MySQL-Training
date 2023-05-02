USE `geography`;

-- ========================= --
-- 10. Countries Holding 'A' --
-- ========================= --

SELECT `country_name`, `iso_code`
FROM `countries`
WHERE `country_name` LIKE '%a%a%a%'
ORDER BY `iso_code`;

-- =============================== --
-- 11. Mix of Peak and River Names --
-- =============================== --

SELECT 
	`peaks`.`peak_name`, 
    `rivers`.`river_name`,
    LOWER(CONCAT(`peaks`.`peak_name`, SUBSTRING(`rivers`.`river_name`, 2))) AS 'mix'
FROM `peaks`, `rivers`
WHERE LOWER(RIGHT(`peaks`.`peak_name`, 1)) = LOWER(LEFT(`rivers`.`river_name`, 1))
ORDER BY mix;
