CREATE database teacherintouch;
USE teacherintouch

CREATE TABLE faculty (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(25) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	gender CHAR(1) NOT NULL,
	homeroom VARCHAR(5),
	grade INT
);

CREATE TABLE student (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(25) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	gender CHAR(1) NOT NULL,
	homeroom_teacher INT NOT NULL,
	FOREIGN KEY(homeroom_teacher) REFERENCES faculty(id)
);

CREATE TABLE guardian (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(25) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(50),
	gender CHAR(1) NOT NULL
);

--Junction table
CREATE TABLE relationship (
	student_id int NOT NULL,
	guardian_id int NOT NULL,
	relation VARCHAR(25) NOT NULL,
	FOREIGN KEY (student_id) REFERENCES student(id),
	FOREIGN KEY (guardian_id) REFERENCES guardian(id),
	PRIMARY KEY(student_id, guardian_id)
);

/**
 * 1 to many relationship.  Guardian can have many phone numbers
 * but a phone number can  only belong to one guardian
 */
CREATE TABLE phone_details (
	guardian_id INT NOT NULL, 
	phone_number VARCHAR(12),
	phone_type VARCHAR(12),
	FOREIGN KEY (guardian_id) REFERENCES guardian(id),
	PRIMARY KEY(phone_number, guardian_id),
	UNIQUE(guardian_id, phone_number)
);

CREATE TABLE student_comment (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	student_id INT NOT NULL,
	comment_date DATETIME NOT NULL,
	comment TEXT,
	FOREIGN KEY (student_id) REFERENCES student(id) 
);

CREATE TABLE guardian_comment (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	guardian_id INT NOT NULL,
	comment_date DATETIME NOT NULL,
	comment TEXT,
	FOREIGN KEY (guardian_id) REFERENCES guardian(id) 
);

CREATE TABLE subject (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(30) NOT NULL,
	UNIQUE(name)
);

CREATE TABLE assignment (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(30),
	type_id VARCHAR(15) NOT NULL,
	subject VARCHAR(30) NOT NULL,
	FOREIGN KEY (subject) REFERENCES subject(name)
);

CREATE TABLE assignment_comment (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	assignment_id INT NOT NULL,
	comment_date DATETIME NOT NULL,
	comment TEXT,
	FOREIGN KEY (assignment_id) REFERENCES assignment(id) 
);

CREATE TABLE gradebook (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	student_id INT NOT NULL,
	entry_date DATETIME NOT NULL,
	assignment_id INT NOT NULL,
	grade INT NOT NULL,
	comment TEXT,
	FOREIGN KEY (student_id) REFERENCES student(id) ,
	FOREIGN KEY (assignment_id) REFERENCES assignment(id),
	UNIQUE(student_id, assignment_id)
);