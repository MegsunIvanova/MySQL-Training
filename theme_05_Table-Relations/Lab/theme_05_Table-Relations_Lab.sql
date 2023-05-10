# 1. Mountains and Peaks
USE `demo_base`;

CREATE TABLE `mountains` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL
);
    
CREATE TABLE `peaks` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `mountain_id` INT
    -- CONSTRAINT `fk_peaks_mountains`
--     FOREIGN KEY (`mountain_id`)
--     REFERENCES `mountains`(`id`)
);

ALTER TABLE `peaks`
ADD CONSTRAINT `fk_peaks_mountains`
FOREIGN KEY (`mountain_id`)
REFERENCES `mountains`(`id`);

# 2. Trip Organization
USE `camp`;

SELECT 
    v.`driver_id`,
    v.`vehicle_type`,
    CONCAT(c.`first_name`, ' ', c.`last_name`) AS 'driver_name'
FROM
    `vehicles` AS v
        JOIN
    `campers` AS c ON c.`id` = v.`driver_id`;

# 3. SoftUni Hiking

SELECT 
    r.`starting_point` AS 'route_starting_point',
    r.`end_point` AS 'route_ending_point',
    r.`leader_id`,
    CONCAT(c.`first_name`, ' ', c.`last_name`) AS 'leader_id'
FROM
    `routes` AS r
        JOIN
    `campers` AS c ON r.`leader_id` = c.`id`;

# 4. Delete Mountains
-- DROP TABLE `peaks`;
-- DROP TABLE `mountains`;

CREATE TABLE `mountains` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(20) NOT NULL
);
    
CREATE TABLE `peaks` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(20) NOT NULL,
    `mountain_id` INT,
    CONSTRAINT `fk_mountain_id`
    FOREIGN KEY (`mountain_id`)
    REFERENCES `mountains`(`id`)
    ON DELETE CASCADE
);

# 5. Project Management DB*

CREATE DATABASE `project_management`;
USE `project_management`;

CREATE TABLE `clients` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `client_name` VARCHAR(100)
);

CREATE TABLE `projects` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `client_id` INT,
    `project_lead_id` INT
);

CREATE TABLE `employees` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `first_name` VARCHAR(30),
    `last_name` VARCHAR(30),
    `project_id` INT
);

ALTER TABLE `projects`
ADD CONSTRAINT `fk_projects_clients`
FOREIGN KEY (`client_id`)
REFERENCES `clients`(`id`),
ADD CONSTRAINT `fk_projects_employees`
FOREIGN KEY (`project_lead_id`)
REFERENCES `employees`(`id`);

ALTER TABLE `employees` 
ADD CONSTRAINT `fk_employees_projects`
FOREIGN KEY (`project_id`)
REFERENCES `projects`(`id`);
    
# Demos from Lab:
## Database Design:

CREATE DATABASE `demo_base`;
USE `demo_base`;

CREATE TABLE `document` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `content` TEXT
);

CREATE TABLE `users` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `document_id` INT NOT NULL,
    CONSTRAINT `fk_users_document_id__document_id`
    FOREIGN KEY (`document_id`)
    REFERENCES `document`(`id`)
);

## Table Relations:

INSERT INTO `peaks` (`name`, `mountain_id`)
VALUES ("Botev", 1), ("Musala", 0)


