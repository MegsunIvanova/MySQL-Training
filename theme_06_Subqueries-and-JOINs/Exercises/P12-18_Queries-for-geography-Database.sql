USE `geography`;

# 12. Highest Peaks in Bulgaria

SELECT c.`country_code`, m.`mountain_range` , p.`peak_name`, p.`elevation`
FROM `countries` AS c
JOIN `mountains_countries` AS mc ON c.`country_code` = mc.`country_code`
JOIN `mountains` AS m ON mc.`mountain_id` = m.`id`
JOIN `peaks` AS p ON m.`id` = p.`mountain_id`
WHERE c.`country_name` = 'Bulgaria' AND p.`elevation` > 2835
ORDER BY p.`elevation` DESC;

# 13. Count Mountain Ranges

SELECT c.`country_code`, COUNT(m.`mountain_range`) AS 'mountain_range'
FROM `countries` AS c
JOIN `mountains_countries` AS mc ON c.`country_code` = mc.`country_code`
JOIN `mountains` AS m ON mc.`mountain_id` = m.`id`
WHERE c.`country_name` = 'Bulgaria' OR c.`country_name` = 'United States' OR c.`country_name` = 'Russia'
GROUP BY c.`country_code`
ORDER BY `mountain_range` DESC;

# 14. Countries with Rivers

SELECT cntr.`country_name`, r.`river_name`
FROM `continents` AS cont
JOIN `countries` AS cntr ON cont.`continent_code` = cntr.`continent_code`
LEFT JOIN `countries_rivers` AS cr ON cntr.`country_code` = cr.`country_code`
LEFT JOIN `rivers` AS r ON cr.`river_id` = r.`id`
WHERE cont.`continent_name` = 'Africa'
ORDER BY cntr.`country_name`
LIMIT 5;

# 15. *Continents and Currencies

SELECT 
    `usages`.`continent_code`,
    `usages`.`currency_code`,
    `usages`.`usages`
FROM
    (SELECT 
        `con`.`continent_code`,
            `cu`.`currency_code`,
            COUNT(`cu`.`currency_code`) AS `usages`
    FROM
        `continents` AS `con`
    INNER JOIN `countries` AS `c` ON `c`.`continent_code` = `con`.`continent_code`
    INNER JOIN `currencies` AS `cu` ON `cu`.`currency_code` = `c`.`currency_code`
    GROUP BY `con`.`continent_code` , `cu`.`currency_code`) AS `usages`
        INNER JOIN
    (SELECT 
        `usages`.`continent_code`,
            MAX(`usages`.`usages`) AS `maxUsage`
    FROM
        (SELECT 
        `con`.`continent_code`,
            `cu`.`currency_code`,
            COUNT(`cu`.`currency_code`) AS `usages`
    FROM
        `continents` AS `con`
    INNER JOIN `countries` AS `c` ON `c`.`continent_code` = `con`.`continent_code`
    INNER JOIN `currencies` AS `cu` ON `cu`.`currency_code` = `c`.`currency_code`
    GROUP BY `con`.`continent_code` , `cu`.`currency_code`
    HAVING COUNT(`cu`.`currency_code`) > 1) AS `usages`
    GROUP BY `usages`.`continent_code`) AS `max_usages` ON `max_usages`.`continent_code` = `usages`.`continent_code`
        AND `max_usages`.`maxUsage` = `usages`.`usages`
ORDER BY `usages`.`continent_code` , `usages`.`currency_code`;

# 16. Countries without any Mountains

SELECT COUNT(*) AS 'country_count'
FROM `countries` AS c
LEFT JOIN `mountains_countries` AS mc ON mc.`country_code` = c.`country_code`
WHERE mc.`mountain_id` IS NULL;

# 17. Highest Peak and Longest River by Country

SELECT c.`country_name`,
		MAX(p.`elevation`) AS 'highest_peak_elevation',
        MAX(r.`length`) AS 'longest_river_length'
FROM `countries` AS c
LEFT JOIN `mountains_countries` AS mc ON mc.`country_code` = c.`country_code`
LEFT JOIN `peaks` AS p ON p.`mountain_id` = mc.`mountain_id`
LEFT JOIN `countries_rivers` AS cr ON cr.`country_code` = c.`country_code`
LEFT JOIN `rivers` AS r ON r.`id` = cr.`river_id`
GROUP BY c.`country_name`
ORDER BY `highest_peak_elevation` DESC,  `longest_river_length` DESC, c.`country_name`
LIMIT 5;