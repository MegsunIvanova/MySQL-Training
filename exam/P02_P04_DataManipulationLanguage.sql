USE `universities_db`;

# 02. Insert

INSERT INTO `courses` 
(
`name`, `duration_hours`, `start_date`, `teacher_name`, `description`, `university_id`
)
SELECT 
	CONCAT(`teacher_name`, " " , "course")  AS `name`,
    CHAR_LENGTH(`name`) / 10 AS `duration_hours`,
    ADDDATE(`start_date`, INTERVAL 5 DAY) AS `start_date`,
    REVERSE(`teacher_name`) AS `teacher_name`,
    CONCAT("Course " , `teacher_name` , REVERSE(`description`)) AS `description`,
    DAY(`start_date`) AS `univesity_id`    
FROM `courses`
WHERE `id` <= 5;

# 03.	Update

UPDATE `universities`
SET `tuition_fee` = `tuition_fee` + 300
WHERE `id` BETWEEN 5 AND 12;

# 04. Delete

DELETE FROM `universities`
WHERE `number_of_staff` IS NULL;