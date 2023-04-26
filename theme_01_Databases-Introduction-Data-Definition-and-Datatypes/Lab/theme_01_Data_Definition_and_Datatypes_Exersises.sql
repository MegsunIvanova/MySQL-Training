CREATE DATABASE minions;

USE minions;

-- ====================== --
-- Task 01: Create Tables --
-- ====================== --

CREATE TABLE `minions` (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50),
    `age` INT
);

CREATE TABLE `towns` (
	`town_id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50)
);

-- ============================ --
-- Task 02: Alter Minions Table --
-- ============================ --

ALTER TABLE `towns`
CHANGE COLUMN `town_id` `id` INT AUTO_INCREMENT;

-- submit only this in judge:
ALTER TABLE `minions`
ADD COLUMN `town_id` INT,
ADD CONSTRAINT `fk_towns_id__minions_town_id`
FOREIGN KEY (`town_id`) REFERENCES `towns` (`id`); 

-- ====================================== --
-- Task 03: Insert Records in Both Tables --
-- ====================================== --

INSERT INTO `towns` (`id`, `name`) VALUES 
	(1, "Sofia"), 
    (2, "Plovdiv"), 
    (3, "Varna");

INSERT INTO `minions` (`id`, `name`, `age`, `town_id`) VALUES
	(1, "Kevin", 22, 1),
    (2, "Bob", 15, 3),
    (3, "Steward", NULL, 2);
    
-- =============================== --
-- Task 04: Truncate Table Minions --
-- =============================== --

TRUNCATE TABLE `minions`;

-- ======================== --
-- Task 05: Drop All Tables --
-- ======================== --

DROP TABLE `minions`;

DROP TABLE `towns`;

-- ============================ --
-- Task 06: Create Table People --
-- ============================ --

CREATE TABLE `people` (
	`id` INT AUTO_INCREMENT UNIQUE PRIMARY KEY,
    `name` VARCHAR(200) NOT NULL,
    `picture` MEDIUMBLOB,
    `height` DECIMAL (5, 2) DEFAULT NULL,
    CHECK (`height` >= 0) ,
    `weight` DECIMAL (5, 2) DEFAULT NULL,
	CHECK (`weight` >= 0),
    `gender` ENUM ("m", "f") NOT NULL,
    `birthdate` DATE NOT NULL,
    `biography`TEXT
);

INSERT INTO `people` (`name`, `gender`, `birthdate`)
VALUES 
	("Pesho", "m", DATE(NOW())),
	("Maria", "f", DATE(NOW())),
    ("Ivan", "m", DATE(NOW())),
    ("Kaloyan", "m", DATE(NOW())),
    ("Gergana", "f", DATE(NOW()));
    
-- =========================== --
-- Task 07: Create Table Users --
-- =========================== --

CREATE TABLE `users` (
	`id` INT AUTO_INCREMENT UNIQUE PRIMARY KEY,
    `username` VARCHAR (50) NOT NULl,
    `password` VARCHAR (26) NOT NULL,
    `profile_picture` MEDIUMBLOB,
    `last_login_time` DATETIME,
    `is_deleted` BOOLEAN
);

INSERT INTO `users` (`username`, `password`)
VALUES
	("pesho", "pesho123*"),
    ("ivan", "ivanPass*"),
    ("gergana", "gerito46*"),
    ("maria", "mar1a*"),
    ("kaloyan", "ka10yan*");
    
-- =========================== --
-- Task 08: Change Primary Key --
-- =========================== --
    
ALTER TABLE `users`
DROP PRIMARY KEY,
ADD CONSTRAINT `pk_users`
PRIMARY KEY (`id`, `username`);

-- ===================================== --
-- Task 09: Set Default Value of a Field --
-- ===================================== --

ALTER TABLE `users`
MODIFY COLUMN `last_login_time` DATETIME DEFAULT NOW();

-- ========================= --
-- Task 10: Set Unique Field --
-- ========================= --

ALTER TABLE `users`
DROP PRIMARY KEY,
ADD CONSTRAINT `pk_users`
PRIMARY KEY (`id`),
MODIFY COLUMN `username` VARCHAR (50) NOT NULl UNIQUE;

-- ======================== --
-- Task 11: Movies Database --
-- ======================== --

CREATE DATABASE `movies`;

USE `movies`;

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
    `rating` DOUBLE,
    `notes` TEXT,
	FOREIGN KEY (`director_id`) REFERENCES `directors`(`id`),
	FOREIGN KEY (`genre_id`) REFERENCES `genres`(`id`),
    FOREIGN KEY (`category_id`) REFERENCES `categories`(`id`)
);

INSERT INTO `movies` (`title`, `director_id`, `copyright_year`, `length`, `genre_id`, `category_id`)
VALUES
("The Godfather", 1, 1972, '2:55:00', 2,  1),
("The Lord of the Rings: The Return of the King", 2, 2003, '3:21:00', 3,  5),
("Pulp Fiction", 3, 1994, '2:34:00', 2,  1),
("The Lord of the Rings: The Fellowship of the Ring", 2, 2001, '2:58:00', 3,  5),
("The Lord of the Rings: The Two Towers", 2, 2002, '2:59:00', 3,  5);


    