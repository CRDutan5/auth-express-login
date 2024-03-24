--db/seed.sql
\c authdb

-- original for reference
-- INSERT INTO users (username, password_hash, email, created_at, updated_at)
-- VALUES 
-- ('demo', '$2b$10$.z68x3792U9LyBwmghfsKexstMO7i0SeNCoDmeJa7bEFPQBnZU3bK', 'demo@example.com', NOW(), NOW());

-- seed for a user who is a tutor named Jane Doe who teaches Mathematics remotely and
-- a student named John Smith who is enrolled in a Mathematics course remotely
INSERT INTO users (is_tutor, profile_pic, user_name, password_hash, email, name, is_enrolled, is_booked, subject, is_remote)
VALUES

-- INSERT INTO users (username, password_hash, email, created_at, updated_at)
-- VALUES 
-- ('demo', '$2b$10$.z68x3792U9LyBwmghfsKexstMO7i0SeNCoDmeJa7bEFPQBnZU3bK', 'demo@example.com', NOW(), NOW());

-- TUTORS
    (TRUE, 'profile1.jpg', 'demo_tutor', '$2b$10$HPLJUtC6QBjI9n5itRII6.5KQ2WzDYD0AKWumZFjAECRjOBUyzf7O', 'demo_tutor@example.com', 'Jane Doe', FALSE, TRUE, 'Mathematics', TRUE),
-- STUDENTS
    (FALSE, 'profile2.jpg', 'demo_student', '$2b$10$OYLY5m48a3wH1mEVxhzXIefm/doMJVrXUg4CjPUkwcHayzqslv1.K', 'demo_student@example.com', 'John Smith', TRUE, FALSE, 'Mathematics', TRUE);
--demo_tutor pw: password
--demo_student pw: 12345

-- Inserting a request where the tutor accepts
INSERT INTO requests (user_id, tutor_id, accepted, created_at) 
VALUES (2, 1, FALSE, NOW());

-- Inserting a review for a student
INSERT INTO student_reviews (assigned_tutor_id, subject, description, user_id, ratings) 
VALUES (1, 'Mathematics', 'Great tutor, very helpful with calculus problems.', 1, 5);
