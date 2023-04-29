USE `geography`;

-- ====================== --
-- 21. All Mountain Peaks --
-- ====================== --

SELECT `peak_name` FROM `peaks`
ORDER BY `peak_name`;

-- =================================== --
-- 22. Biggest Countries by Population --
-- =================================== --

SELECT `country_name`, `population` FROM `countries`
WHERE `continent_code` = 'EU'
ORDER BY `population` DESC, `country_name` ASC
LIMIT 30;

-- ============================================ --
-- 23. Countries and Currency (Euro / Not Euro) --
-- ============================================ --

SELECT `country_name`, `country_code`, IF(`currency_code`='EUR', 'Euro', 'Not Euro')
FROM `countries`
WHERE `currency_code` IS NOT NULL
ORDER BY `country_name`;