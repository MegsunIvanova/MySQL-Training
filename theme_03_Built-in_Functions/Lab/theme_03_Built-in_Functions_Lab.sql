USE `book_library`;

-- ==================== --
-- 01. Find Book Titles --
-- ==================== --
	
SELECT `title` FROM `books`
WHERE SUBSTRING(`title`, 1, 3) = 'The'
ORDER BY `id`;

-- ================== --
-- 02. Replace Titles --
-- ================== --

SELECT REPLACE(`title`, 'The', '***') AS 'title'
FROM `books`
WHERE SUBSTRING(`title`, 1, 3) = 'The'
ORDER BY `id`;

-- ========================= --
-- 03. Sum Cost of All Books --
-- ========================= --

SELECT ROUND(SUM(`cost`), 2)
FROM `books`;

-- ============== --
-- 04. Days Lived --
-- ============== --

SELECT 
	CONCAT_WS(' ', `first_name`, `last_name`) AS 'Full Name',
	TIMESTAMPDIFF(DAY, `born`, `died`) AS 'Days Lived'
FROM `authors`;

-- ====================== --
-- 05. Harry Potter Books --
-- ====================== --

SELECT `title`
FROM `books`
WHERE `title` LIKE 'Harry Potter%'
ORDER BY `id`;

-- ================= --
-- === LAB DEMOS === --

-- String Functions --
-- ================ --

SELECT LTRIM("              Trimmed   
  ");
-- 'Trimmed   \n  '

SELECT RTRIM("              Trimmed   
  ");
-- '              Trimmed   \n'

SELECT LTRIM(RTRIM("              Trimmed   
  "));
-- 'Trimmed   \n'

SELECT `title`, LENGTH(`title`), CHAR_LENGTH(`title`)
FROM `books`;

SELECT LEFT(`title`, 3), SUBSTRING(`title`, 1, 3)
FROM `books`;

SELECT RIGHT(`title`, 3), SUBSTRING(`title`, -3, 3)
FROM `books`;

SELECT `title`
FROM `books`
WHERE UPPER(SUBSTRING(`title`, 1, 5)) = "HARRY";

SELECT REVERSE("Harry");

SELECT REPEAT("Harry", 4);

SELECT LOCATE("Ha", "Harry");

SELECT LOCATE("Ha", "Harry", 2);

SELECT INSERT("Harry Potter", 1, 0, "The ");

-- Math Functions --
-- ============== --

SELECT 13 / 5, 13 DIV 5, 13 MOD 5;

SELECT PI();

SELECT ABS(-5);

SELECT SQRT(35);

SELECT POW(5, 3);

SELECT CONV(1550, 10, 16);

SELECT ROUND(2.657585, 3);

SELECT FLOOR(2.657585), CEILING (2.657585);

SELECT SIGN(-6), SIGN(6), SIGN(0);

SELECT CEILING(RAND() * 7);

SELECT FLOOR(RAND() * 11) + 5;

-- Date Functions --
-- ============== --

SELECT EXTRACT(YEAR FROM '2022-09-20'); /* 2022 */

SELECT EXTRACT(MINUTE FROM '2022-09-20 19:50'); /* 50 */

SELECT ABS(TIMESTAMPDIFF(MINUTE,'2022-09-20 19:50','2022-09-19')); /* 2630 */

SELECT NOW();

SELECT DATE_FORMAT (`born`, '%D %b %Y')
FROM `authors`;

-- Wildcards --
-- ========= --

SELECT `title`
FROM `books`
WHERE `title` REGEXP('^The [a-z]+$');

SELECT * FROM `categories` WHERE `name` REGEXP '^[sd]'; /* name starts with 's' or 'd' */

SELECT * FROM `departments` WHERE `name` REGEXP '[sd]'; /* name contains 's' or 'd' */