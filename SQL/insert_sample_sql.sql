/* =========================
   SAMPLE DATA INSERT SCRIPT
   ========================= */
use Capstone;
   
   /* USERS */
INSERT INTO Users (name, email, password, role)
VALUES
('Alice Student', 'alice@student.fanshawe.ca', 'hashed_pw_1', 'student'),
('Bob Student', 'bob@student.fanshawe.ca', 'hashed_pw_2', 'student'),
('TechNova Inc', 'hr@technova.com', 'hashed_pw_3', 'startup'),
('DataSpark Ltd', 'contact@dataspark.com', 'hashed_pw_4', 'startup'),
('Admin User', 'admin@platform.com', 'hashed_pw_5', 'admin');

/* STUDENTS */
INSERT INTO Students (student_id, resume_path, rating, verified_status)
VALUES
(1, 'resumes/alice_resume.pdf', 4.50, 1),
(2, 'resumes/bob_resume.pdf', 3.80, 1);

/* STARTUPS */
INSERT INTO Startups (startup_id, company_name)
VALUES
(3, 'TechNova Inc'),
(4, 'DataSpark Ltd');

/* TASKS */
INSERT INTO Tasks (startup_id, title, description, required_skills, status)
VALUES
(3, 'Website Bug Fix',
 'Fix minor UI bugs on company website',
 'HTML,CSS,JavaScript',
 'open'),

(3, 'Data Cleaning',
 'Clean and format sales data',
 'Excel,SQL',
 'open'),

(4, 'Social Media Analysis',
 'Analyze engagement metrics',
 'Python,Excel',
 'assigned');

/* APPLICATIONS */
INSERT INTO Applications (task_id, student_id, match_score, status)
VALUES
(1, 1, 85.00, 'shortlisted'),
(1, 2, 60.00, 'applied'),
(2, 1, 90.00, 'selected'),
(3, 2, 75.50, 'applied');

/* RATINGS */
INSERT INTO Ratings (task_id, student_id, score, feedback)
VALUES
(2, 1, 5, 'Excellent work and quick delivery'),
(3, 2, 4, 'Good analysis, minor improvements needed');
