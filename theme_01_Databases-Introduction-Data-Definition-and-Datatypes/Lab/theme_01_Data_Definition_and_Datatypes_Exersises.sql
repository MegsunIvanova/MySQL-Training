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