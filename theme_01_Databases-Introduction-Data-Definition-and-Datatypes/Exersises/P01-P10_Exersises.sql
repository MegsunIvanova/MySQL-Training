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


