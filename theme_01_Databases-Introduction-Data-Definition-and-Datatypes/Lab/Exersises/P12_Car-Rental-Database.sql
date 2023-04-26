-- ============================ --
-- Task 12: Car Rental Database --
-- ============================ --

CREATE DATABASE `car_rental`;

USE `car_rental`;

-- Submit in judge from here:
CREATE TABLE `categories` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `category` VARCHAR(50) NOT NULL,
    `daily_rate` DECIMAL (2,1),
    `weekly_rate` DECIMAL (2,1),
    `monthly_rate` DECIMAL (2,1),
    `weekend_rate` DECIMAL (2,1)
);

INSERT INTO `categories` (`category`)
VALUES ("Coupe"), ("Sedan"), ("Hatchback");

CREATE TABLE `cars` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `plate_number` VARCHAR(10),
    `make` VARCHAR(30),
    `model` VARCHAR(30),
    `car_year` YEAR,
    `category_id` INT,
    `doors` VARCHAR(10),
    `picture` BLOB,
    `car_condition` VARCHAR (30),
    `available` BOOLEAN
);

INSERT INTO `cars` (`plate_number`, `make`, `model`, `car_year`, `category_id`, `doors`, `car_condition`, `available`)
VALUES (NULL, "Mercedes",  "Benz SL 55 AMG 4Matic +", 2022, 1, "2(3)", "new", true),
(NULL, "Fiat",  "500 Hybrid", 2022, 3, "2(3)", "new", true),
(NULL, "Lexus",  "Es 350 ULTRA LUXURY", 2022, 2, "4(5)", "new", true);

CREATE TABLE `employees` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`first_name` VARCHAR (30) NOT NULL,
`last_name` VARCHAR (30) NOT NULL,
`title` VARCHAR (30) NOT NULL,
`notes` TEXT
);

INSERT INTO `employees` (`first_name`, `last_name`, `title`)
VALUES ("Georgi", "Georgiev", "saleman"),
("Peter", "Petrov", "cashier"),
("Ivan", "Ivanov", "director");

CREATE TABLE `customers` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `driver_licence_number` VARCHAR (30) NOT NULL,
    `full_name` VARCHAR (50) NOT NULL,
    `address` VARCHAR (100) NOT NULL,
    `city` VARCHAR (50) NOT NULL,
    `zip_code` INT NOT NULL,
    `notes` TEXT
);

INSERT INTO `customers` (`driver_licence_number`, `full_name`, `address`, `city`, `zip_code`, `notes`)
VALUES ("1236547", "Test Full Name", "Test Addres", "Sofia", 1000, "test notes"),
("1236547", "Test Full Name", "Test Addres", "Varna", 9000, "test notes"),
("1236547", "Test Full Name", "Test Addres", "Plovdiv", 4000, "test notes");

CREATE TABLE `rental_orders` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `employee_id` INT,
    `customer_id` INT,
    `car_id` INT,
    `car_condition` VARCHAR (50),
    `tank_level` DOUBLE,
    `kilometrage_start` INT, 
    `kilometrage_end` INT, 
    `total_kilometrage` INT, 
    `start_date` DATE, 
    `end_date` DATE, 
    `total_days` INT, 
    `rate_applied` DOUBLE, 
    `tax_rate` DOUBLE, 
    `order_status` VARCHAR (50), 
    `notes` TEXT
);

INSERT INTO `rental_orders` (`employee_id`, `customer_id`, `car_id`, `car_condition`, 
`tank_level`, `kilometrage_start`, `kilometrage_end`, `total_kilometrage`,
 `start_date`, `end_date`, `total_days`, `rate_applied`, `tax_rate`, `order_status`, `notes`)
 VALUES (1, 1, 1, "perfect", 100.00, 1000, 1400, 400, '2023-04-25', '2023-04-26', 1, 0.5, 0.20, "complited", "test"),
    (2, 2, 2, "perfect", 100.00, 1000, 1400, 400, '2023-04-25', '2023-04-26', 1, 0.5, 0.20, "complited", "test"),
    (3, 3, 3, "perfect", 100.00, 1000, 1400, 400, '2023-04-25', '2023-04-26', 1, 0.5, 0.20, "complited", "test");