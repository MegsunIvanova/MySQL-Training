CREATE DATABASE `gamebar` DEFAULT CHARACTER SET utf8;

USE `gamebar`;

-- ============================
-- Task 01: Create Tables:
-- ============================

CREATE TABLE `employees` (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
    `first_name` VARCHAR(100) NOT NULL,
    `last_name` VARCHAR(100) NOT NULL
);

CREATE TABLE `categories` (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL
);

CREATE TABLE `products` (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL,
    `category_id` INT NOT NULL
);

-- ============================
-- Task 02: Insert Data in Tables:
-- ============================

INSERT INTO `employees` (`first_name`, `last_name`) VALUES ("Pesho", "Pesho");
INSERT INTO `employees` (`first_name`, `last_name`) VALUES 
	("Gosho", "Gosho"),
    ("Gergana", "Gergana");
 
-- ============================
-- Task 03: Alter Tables:
-- ============================

ALTER TABLE `employees`
ADD COLUMN `middle_name` VARCHAR(50);

-- ============================
-- Task 04: Adding Constraints:
-- ============================

ALTER TABLE `products`
ADD CONSTRAINT `fk_categories_id__products_category_id`
FOREIGN KEY (`category_id`) REFERENCES `categories`(`id`);

-- ============================
-- Task 05: Modifying Columns:
-- ============================

ALTER TABLE `employees` 
MODIFY COLUMN `middle_name` VARCHAR(100);

