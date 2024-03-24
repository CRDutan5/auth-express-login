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

-- TUTORS - users.id: 1,2,3

    (TRUE, 'profile1.jpg', 'demo_tutor', '$2b$10$.z68x3792U9LyBwmghfsKexstMO7i0SeNCoDmeJa7bEFPQBnZU3bK', 'demo_tutor@example.com', 'Jane Doe', FALSE, TRUE, 'Mathematics', TRUE),
    (TRUE, 'tutor2.jpg', 'tutor2', 'hashed_password_2', 'tutor2@example.com', 'Jane Smith', FALSE, TRUE, 'Physics', TRUE),
    (TRUE, 'tutor3.jpg', 'tutor3', 'hashed_password_3', 'tutor3@example.com', 'Alice Johnson', FALSE, TRUE, 'Chemistry', TRUE),
-- Students - users.id 4,5,6
    (FALSE, 'profile2.jpg', 'demo_student', '$2b$10$L5QiYCI6r9hddL3aRdAWTO6c7wj6aXgsjSCaDJ00kLWnwgTJ9o4TG', 'demo_student@example.com', 'John Smith', TRUE, FALSE, 'Mathematics', TRUE),
    (FALSE, 'student1.jpg', 'student1', 'hashed_password_student1', 'student1@example.com', 'Michael Johnson', TRUE, FALSE, 'Physics', TRUE),
    (FALSE, 'student2.jpg', 'student2', 'hashed_password_student2', 'student2@example.com', 'Emma Wilson', TRUE, FALSE, 'Chemistry', TRUE)
;


-- Inserting a request where the tutor accepts
INSERT INTO requests (user_id, tutor_id, accepted, created_at) 
VALUES 
    (4, 1, TRUE, NOW()),
    (5, 2, TRUE, NOW()),
    (6, 3, TRUE, NOW())
;

-- Inserting a review for a student
INSERT INTO student_reviews (assigned_tutor_id, subject, description, user_id, ratings) 
VALUES (1, 'Mathematics', 'Great tutor, very helpful with calculus problems.', 4, 5),
(2, 'Physics', 'Great tutor, very helpful with inertia problems.', 5, 5),
(3, 'Chemistry', 'Great tutor, very helpful with stoichiometry problems.', 6, 5)
;