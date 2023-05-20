# 05. Countries
SELECT * FROM `countries`
ORDER BY `currency` DESC, `id` ASC;

# 06. Old movies
SELECT
	`ai`.`id`,
    `m`.`title`,
	`ai`. `runtime`,
	`ai`. `budget`,
    `ai`.`release_date`
FROM `movies_additional_info` AS `ai`
JOIN `movies` AS `m` ON `ai`.`id` = `m`.`movie_info_id`
WHERE YEAR(`ai`.`release_date`) BETWEEN 1996 AND 1999
ORDER BY `ai`.`runtime`, `ai`.`id`
LIMIT 20;

# 07. Movie casting
SELECT 
	CONCAT(`a`.`first_name`, " ", `a`.`last_name`) AS `full_name`,
    CONCAT(REVERSE(`a`.`last_name`), CHAR_LENGTH(`a`.`last_name`), '@cast.com') AS `email`,
    (2022 - YEAR(`a`.`birthdate`)) AS `age`,
    `a`.`height`
FROM `actors` AS `a`
WHERE (SELECT COUNT(*) FROM `movies_actors` AS `ma` WHERE `a`.`id` = `actor_id`) = 0
ORDER BY  `a`.`height`;

# 08. International festival
SELECT `c`.`name`, COUNT(*) AS `movies_count`
FROM `countries` AS `c` JOIN `movies` AS `m` ON `c`.`id` = `m`.`country_id`
GROUP BY `c`.`name`
HAVING `movies_count` >= 7
ORDER BY `c`.`name` DESC;

# 09. Rating system

DELIMITER $$

CREATE FUNCTION ufn_get_raiting_as_text(raiting DECIMAL(10,2))
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
	DECLARE result VARCHAR(10);
    
	CASE
		WHEN (raiting <= 4) THEN SET result := 'poor';
		WHEN(raiting <= 7) THEN SET result := 'good';
		ELSE SET result := 'excellent';
    END CASE;
    
    RETURN result;
    
END$$

CREATE FUNCTION ufn_get_subtitles (has_subtitles TINYINT(1))
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN	   
	IF (has_subtitles) THEN RETURN 'english';
    ELSE RETURN '-';
    END IF;
    
END$$

DELIMITER ;

SELECT 
	`m`.`title`,
    ufn_get_raiting_as_text(`ai`.`rating`) AS `raiting`,
    ufn_get_subtitles(`ai`.`has_subtitles`) AS `subtitles`,
    `ai`.`budget`
FROM `movies` AS `m`
JOIN `movies_additional_info` AS `ai` ON `m`.`movie_info_id` = `ai`.`id`
ORDER BY `ai`.`budget` DESC;

# 10. History movies
DELIMITER $$

CREATE FUNCTION udf_actor_history_movies_count(full_name VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE history_movies INT;
    
    SET history_movies := (
		SELECT COUNT(*) AS `history_movies`
		FROM `actors` AS `a`
		JOIN `movies_actors` AS `ma` ON `a`.`id` = `ma`.`actor_id`
		JOIN `genres_movies` AS `gm` ON `ma`.`movie_id` = `gm`.`movie_id`
		JOIN `genres` AS `g` ON `gm`.`genre_id` = `g`.`id`
		WHERE `g`.`name` = 'History' AND CONCAT(`a`.`first_name`, " ", `a`.`last_name`) = full_name
		GROUP BY `a`.`id`
    );
    
    RETURN history_movies;

END$$

SELECT udf_actor_history_movies_count('Stephan Lundberg')  AS 'history_movies'$$

SELECT udf_actor_history_movies_count('Jared Di Batista')  AS 'history_movies'$$

# 11. Movie awards
    
CREATE PROCEDURE udp_award_movie (movie_title VARCHAR(50))
BEGIN
	UPDATE `actors` AS `a`
	JOIN  `movies_actors` AS `ma` ON `ma`.`actor_id` = `a`.`id`
	JOIN `movies` AS `m`ON `m`.`id` = `ma`.`movie_id` 
	SET `a`.`awards` = `a`.`awards` + 1
	WHERE `m`.`title` = movie_title;
          
END$$

CALL udp_award_movie('Tea For Two')$$
# RESULT:
SELECT 
		CONCAT(`a`.`first_name`, ' ',`a`.`last_name`) AS `full_name`,
        (`a`.`awards` - 1) AS 'awards before',
        '->',
        `a`.`awards` AS 'awards after'
	FROM `actors` AS `a`
    JOIN  `movies_actors` AS `ma` ON `ma`.`actor_id` = `a`.`id`
	JOIN `movies` AS `m`ON `m`.`id` = `ma`.`movie_id` 
    WHERE `m`.`title` = 'Tea For Two'$$

DELIMITER ;


