DROP TABLE IF EXISTS Users;
CREATE TABLE Users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    email NVARCHAR(150) NOT NULL UNIQUE,
    password NVARCHAR(255) NOT NULL,
    role NVARCHAR(20) NOT NULL
        CHECK (role IN ('student', 'startup', 'admin'))
);

DROP TABLE IF EXISTS Students;
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    resume_path NVARCHAR(255),
    rating DECIMAL(3,2) DEFAULT 0.00,
    verified_status BIT DEFAULT 0,
    CONSTRAINT FK_Students_Users
        FOREIGN KEY (student_id)
        REFERENCES Users(user_id)
        ON DELETE CASCADE
);

DROP TABLE IF EXISTS Startups;
CREATE TABLE Startups (
    startup_id INT PRIMARY KEY,
    company_name NVARCHAR(150) NOT NULL,
    CONSTRAINT FK_Startups_Users
        FOREIGN KEY (startup_id)
        REFERENCES Users(user_id)
        ON DELETE CASCADE
);

DROP TABLE IF EXISTS Tasks;
CREATE TABLE Tasks (
    task_id INT IDENTITY(1,1) PRIMARY KEY,
    startup_id INT NOT NULL,
    title NVARCHAR(200) NOT NULL,
    description NVARCHAR(MAX),
    required_skills NVARCHAR(MAX),
    status NVARCHAR(20) DEFAULT 'open'
        CHECK (status IN ('open', 'assigned', 'completed')),
    CONSTRAINT FK_Tasks_Startups
        FOREIGN KEY (startup_id)
        REFERENCES Startups(startup_id)
        ON DELETE CASCADE
);

DROP TABLE IF EXISTS Applications;
CREATE TABLE Applications (
    application_id INT IDENTITY(1,1) PRIMARY KEY,
    task_id INT NOT NULL,
    student_id INT NOT NULL,
    match_score DECIMAL(5,2),
    status NVARCHAR(20) DEFAULT 'applied'
        CHECK (status IN ('applied', 'shortlisted', 'selected', 'rejected')),

    CONSTRAINT FK_Applications_Tasks
        FOREIGN KEY (task_id)
        REFERENCES Tasks(task_id)
        ON DELETE CASCADE,

    CONSTRAINT FK_Applications_Students
        FOREIGN KEY (student_id)
        REFERENCES Students(student_id)
        ON DELETE NO ACTION,

    CONSTRAINT UQ_Task_Student UNIQUE (task_id, student_id)
);


DROP TABLE IF EXISTS Ratings;
CREATE TABLE Ratings (
    rating_id INT IDENTITY(1,1) PRIMARY KEY,
    task_id INT NOT NULL,
    student_id INT NOT NULL,
    score INT NOT NULL CHECK (score BETWEEN 1 AND 5),
    feedback NVARCHAR(MAX),

    CONSTRAINT FK_Ratings_Tasks
        FOREIGN KEY (task_id)
        REFERENCES Tasks(task_id)
        ON DELETE CASCADE,

    CONSTRAINT FK_Ratings_Students
        FOREIGN KEY (student_id)
        REFERENCES Students(student_id)
        ON DELETE NO ACTION,

    CONSTRAINT UQ_Rating_Task_Student UNIQUE (task_id, student_id)
);