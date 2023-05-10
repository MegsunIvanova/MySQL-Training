USE demo_base;

# 03. Many-To-Many Relationship

CREATE TABLE `students` (
	`student_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL
);

CREATE TABLE `exams` (
	`exam_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL
);

CREATE TABLE `students_exams` (
    `student_id` INT,
    `exam_id` INT,
    CONSTRAINT `fk_students_exams__students` FOREIGN KEY (`student_id`)
        REFERENCES `students` (`student_id`),
    CONSTRAINT `fk_students_exams__exams` FOREIGN KEY (`exam_id`)
        REFERENCES `exams` (`exam_id`)
);

ALTER TABLE `exams` AUTO_INCREMENT=101;

INSERT INTO `students` (`name`)
VALUES ('Mila'), ('Toni'), ('Ron');

INSERT INTO `exams` (`name`)
VALUES ('Spring MVC'), ('Neo4j'), ('Oracle 11g');

INSERT INTO `students_exams` (`student_id`, `exam_id`)
VALUES (1, 101), (1, 102), (2, 101), (3, 103), (2, 102), (2, 103);

##

SELECT 
    s.`student_id`, s.`name`, e.`exam_id`, e.`name`
FROM
    `students` AS s
        JOIN
    `students_exams` AS se ON s.`student_id` = se.`student_id`
        JOIN
    `exams` AS e ON se.`exam_id` = e.`exam_id`;