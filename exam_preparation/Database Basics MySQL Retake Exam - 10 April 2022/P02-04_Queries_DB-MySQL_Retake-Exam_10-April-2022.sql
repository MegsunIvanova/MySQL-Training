USE softuni_imdb;

# 02. Insert
INSERT INTO `actors` (`first_name`, `last_name`, `birthdate`, `height`, `awards`, `country_id`)
SELECT 
	REVERSE(`first_name`) AS `first_name`,
    REVERSE(`last_name`) AS `last_name`,
    DATE_SUB(`birthdate`, INTERVAL 2 DAY) AS `birthdate`,
    (`height` + 10) AS `height`,
    `country_id` AS `awards`,
    (SELECT `id` FROM `countries` WHERE `name` = 'Armenia') AS `country_id`    
FROM `actors`
WHERE `id` <= 10;

# 03. Update
UPDATE `movies_additional_info`
SET `runtime` = `runtime` - 10
WHERE `id` BETWEEN 15 AND 25;

#04. Delete
DELETE FROM `countries` AS `c`
WHERE (SELECT COUNT(*) FROM `movies` AS `m` WHERE `m`.`country_id` = `c`.`id`) = 0;