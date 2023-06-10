USE `universities_db`;

# 05. Cities

SELECT * FROM `cities`
ORDER BY `population` DESC;

# 06. Students age

SELECT `first_name`, `last_name`, `age`, `phone`, `email`
FROM `students`
WHERE `age` >= 21
ORDER BY `first_name` DESC, `email` ASC, `id` ASC
LIMIT 10;

# 07. New students

SELECT 
	CONCAT(`first_name`, " ", `last_name`) AS 'full_name',
    SUBSTRING(`s`.`email`, 2, 10) AS `username`,
    REVERSE(`s`.`phone`) AS `password`
FROM `students` AS `s` 
LEFT JOIN `students_courses` AS `sc` ON `s`.`id` = `sc`.`student_id`
WHERE `sc`.`course_id` IS NULL
ORDER BY `password` DESC;

# 08. Students count

SELECT 
	COUNT(sc.`student_id`) AS `students_count`,
    u.`name` AS `university_name`
FROM `universities` AS u
JOIN `courses` AS c ON c.`university_id` = u.`id`
JOIN `students_courses` AS sc ON `c`.`id` = sc.`course_id`
GROUP BY u.`id`
HAVING `students_count` >= 8
ORDER BY `students_count` DESC, `university_name` DESC;

# 09. Price rankings

SELECT 
	u.`name` AS 'university_name',
    c.`name` AS 'city_name',
	u.`address` AS 'address',
    CASE 
		WHEN u.`tuition_fee`< 800 THEN 'cheap'
        WHEN u.`tuition_fee`>= 800 AND u.`tuition_fee` < 1200  THEN 'normal'
        WHEN u.`tuition_fee`>= 1200 AND u.`tuition_fee` < 2500  THEN 'high'
        WHEN u.`tuition_fee`>= 2500  THEN 'expensive'
		END AS'price_rank',
    u.`tuition_fee`
FROM `universities` AS u
JOIN `cities` AS c ON c.`id` = u.`city_id`
ORDER BY u.`tuition_fee`;
