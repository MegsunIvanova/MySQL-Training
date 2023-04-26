-- ======================== --
-- Task 11: Movies Database --
-- ======================== --

CREATE DATABASE `movies`;

USE `movies`;

-- Submit in judge from here:
CREATE TABLE `directors` (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
    `director_name` VARCHAR (50) NOT NULL,
    `notes` TEXT
    );
    
INSERT INTO `directors` (`director_name`, `notes`) 
VALUES
	("Francis Ford Coppola", "test notes"),
	("Peter Jackson", "test notes"),
    ("Quentin Tarantino", "test notes"),
    ("Christopher Nolan", "test notes"),
    ("Frank Darabont", "test notes");

CREATE TABLE `genres` (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
    `genre_name` VARCHAR (20) NOT NULL,
    `notes` TEXT
);

INSERT INTO `genres` (`genre_name`, `notes`) 
VALUES
	("Commedy", "test notes"),
	("Drama", "test notes"),
    ("Action", "test notes"),
    ("Mistery", "test notes"),
    ("Sci-Fi", "test notes");
    
CREATE TABLE `categories` (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
    `category_name` VARCHAR (20) NOT NULL,
    `notes` TEXT
);

INSERT INTO `categories` (`category_name`, `notes`) 
VALUES
	("Crime", "test notes"),
	("Parody", "test notes"),
    ("Legends", "test notes"),
    ("Detective", "test notes"),
    ("Adventure", "test notes");
    
CREATE TABLE `movies` (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
    `title` VARCHAR (50) NOT NULL,
    `director_id` INT,
    `copyright_year` YEAR,
    `length` TIME,
    `genre_id` INT,
    `category_id` INT,
    `rating` DECIMAL(2,1),
    `notes` TEXT
	/*FOREIGN KEY (`director_id`) REFERENCES `directors`(`id`),
	FOREIGN KEY (`genre_id`) REFERENCES `genres`(`id`),
    FOREIGN KEY (`category_id`) REFERENCES `categories`(`id`)*/
);

INSERT INTO `movies` (`title`, `director_id`, `copyright_year`, `length`, `genre_id`, `category_id`)
VALUES
("The Godfather", 1, 1972, '2:55:00', 2,  1),
("The Lord of the Rings: The Return of the King", 2, 2003, '3:21:00', 3,  5),
("Pulp Fiction", 3, 1994, '2:34:00', 2,  1),
("The Lord of the Rings: The Fellowship of the Ring", 2, 2001, '2:58:00', 3,  5),
("The Lord of the Rings: The Two Towers", 2, 2002, '2:59:00', 3,  5);
