USE `soft_uni`;

DELIMITER $$

# 03. Town Names Starting With

CREATE PROCEDURE usp_get_towns_starting_with (start_text VARCHAR(50))
 BEGIN
	SELECT `name` AS 'town_name' FROM `towns`
	WHERE `name` LIKE CONCAT(start_text,'%')
	ORDER BY `name`;
 END$$

CALL usp_get_towns_starting_with ('b')$$
