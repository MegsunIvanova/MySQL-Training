USE `universities_db`;

# 10. Average grades

SELECT ROUND(AVG(sc.`grade`), 2)
FROM `courses` as c
JOIN `students_courses` as sc ON c.`id` = sc.`course_id`
JOIN `students` as s ON s.`id` = sc.`student_id`
WHERE  s.`is_graduated` AND c.`name` = 'Quantum Physics';

DELIMITER $$ 

CREATE FUNCTION udf_average_alumni_grade_by_course_name (course_name VARCHAR(60))
RETURNS DECIMAL(19,2)
DETERMINISTIC
BEGIN
	DECLARE result DECIMAL(19,2);
    SET result := (
					SELECT ROUND(AVG(sc.`grade`), 2)
						FROM `courses` as c
						JOIN `students_courses` as sc ON c.`id` = sc.`course_id`
						JOIN `students` as s ON s.`id` = sc.`student_id`
						WHERE  s.`is_graduated` AND c.`name` = course_name
				);
	RETURN result;
END$$

DELIMITER ;

SELECT c.name, udf_average_alumni_grade_by_course_name('Quantum Physics') as average_alumni_grade FROM courses c 
WHERE c.name = 'Quantum Physics';

# 11. Graduate students

UPDATE `students` as s
JOIN `students_courses` as sc ON s.`id` = sc.`student_id`
JOIN  `courses` as c ON c.`id` = sc.`course_id`
SET s.`is_graduated` = 1
WHERE YEAR(c.`start_date`) = 2017;

DELIMITER $$

CREATE PROCEDURE udp_graduate_all_students_by_year (year_started INT)
	BEGIN
		UPDATE `students` as s
		JOIN `students_courses` as sc ON s.`id` = sc.`student_id`
		JOIN  `courses` as c ON c.`id` = sc.`course_id`
		SET s.`is_graduated` = 1
		WHERE YEAR(c.`start_date`) = year_started;
	
	END$$

DELIMITER ;

CALL udp_graduate_all_students_by_year(2017);