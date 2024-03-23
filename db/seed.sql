--db/seed.sql
\c authdb

-- orifginal for reference
-- INSERT INTO users (username, password_hash, email, created_at, updated_at)
-- VALUES 
-- ('demo', '$2b$10$.z68x3792U9LyBwmghfsKexstMO7i0SeNCoDmeJa7bEFPQBnZU3bK', 'demo@example.com', NOW(), NOW());

-- seed for a user who is a tutor named Jane Doe who teaches Mathematics remotely and
-- a student named John Smith who is enrolled in a Mathematics course remotely
INSERT INTO users (is_tutor, profile_pic, username, password_hash, email, name, is_enrolled, is_booked, subject, is_remote)
VALUES
    (TRUE, 'profile1.jpg', 'demo_tutor', '$2b$10$.z68x3792U9LyBwmghfsKexstMO7i0SeNCoDmeJa7bEFPQBnZU3bK', 'demo_tutor@example.com', 'Jane Doe', FALSE, TRUE, 'Mathematics', TRUE),
    (FALSE, 'profile2.jpg', 'demo_student', '$2b$10$L5QiYCI6r9hddL3aRdAWTO6c7wj6aXgsjSCaDJ00kLWnwgTJ9o4TG', 'demo_student@example.com', 'John Smith', TRUE, FALSE, 'Mathematics', TRUE);

-- Inserting a request where the tutor accepts
INSERT INTO requests (student_id, tutor_id, accepted, created_at) 
VALUES (1, 1, TRUE, NOW());

-- Inserting a review for a student
INSERT INTO student_reviews (assigned_tutor_id, subject, description, student_id, ratings) 
VALUES (1, 'Mathematics', 'Great tutor, very helpful with calculus problems.', 1, 5);
