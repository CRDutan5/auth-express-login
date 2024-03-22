--db/seed.sql
\c authdb

-- INSERT INTO users (username, password_hash, email, created_at, updated_at)
-- VALUES 
-- ('demo', '$2b$10$.z68x3792U9LyBwmghfsKexstMO7i0SeNCoDmeJa7bEFPQBnZU3bK', 'demo@example.com', NOW(), NOW());

-- added user_type
INSERT INTO users (username, password_hash, email, user_type, created_at, updated_at)
VALUES 
('demo', '$2b$10$.z68x3792U9LyBwmghfsKexstMO7i0SeNCoDmeJa7bEFPQBnZU3bK', 'demo@example.com', 'student', NOW(), NOW());

-- Students
INSERT INTO students (id, user_id, is_enrolled, tutor_id, remote, level)
VALUES
    (1, 1, true, 3, true, 'Beginner'),
    (2, 2, false, 4, false, 'Intermediate');

-- Tutors
INSERT INTO tutors (id, user_id, profile_pic, name, username, description_bio, is_booked, availability, remote, description_subject, level)
VALUES
-- make values

-- Student Reviews
INSERT INTO student_reviews (id, assigned_tutor_id, subject, description, student_id, ratings)
VALUES
-- make values