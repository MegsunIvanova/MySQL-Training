USE `diablo`;

-- ================================= --
-- 12. Games From 2011 and 2012 Year --
-- ================================= --

SELECT `name`, DATE_FORMAT(`start`, '%Y-%m-%d') AS 'start'
FROM `games`
WHERE YEAR(`start`) >= 2011 AND YEAR(`start`) <= 2012
ORDER BY `start`, `name`
LIMIT 50;

-- ======================== --
-- 13. User Email Providers --
-- ======================== --

SELECT 
	`user_name`,
    SUBSTRING(`email`, LOCATE('@', `email`) +1) AS 'email provider'
FROM `users`
ORDER BY `email provider`, `user_name`;

-- ========================================== --
-- 14. Get Users with IP Address Like Pattern --
-- ========================================== --

SELECT `user_name`, `ip_address`
FROM `users`
WHERE `ip_address` LIKE '___.1%.%.___'
ORDER BY `user_name`;

-- ================================ --
-- 15. Show All Games with Duration --
-- ================================ --

SELECT 
	`name` AS 'game',
	IF(HOUR(`start`) BETWEEN 0 AND 11, 'Morning', 
		IF(HOUR(`start`) BETWEEN 12 AND 17, 'Afternoon', 'Evening'))
        AS 'Part of the Day',
	IF(`duration`<= 3, 'Extra Short',
		IF(`duration` > 3 AND `duration` <= 6, 'Short',
        IF(`duration` > 6 AND `duration` <= 10, 'Long', 'Extra Long'))) 
        AS 'duration'
FROM `games`;