-- db/schema.sql
DROP DATABASE IF EXISTS authdb;

CREATE DATABASE authdb;


\c authdb

DROP TABLE IF EXISTS users;

-- CREATE TABLE users (
--     id SERIAL PRIMARY KEY,
--     username VARCHAR(255) UNIQUE NOT NULL,
--     password_hash VARCHAR(255) NOT NULL,
--     email VARCHAR(255) UNIQUE,
--     created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
--     updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
-- );


-- added user_type
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    user_type VARCHAR(20) NOT NULL DEFAULT 'student'
);
\d users;

--                                         Table "public.users"
--     Column     |           Type           | Collation | Nullable |              Default              
-- ---------------+--------------------------+-----------+----------+-----------------------------------
--  id            | integer                  |           | not null | nextval('users_id_seq'::regclass)
--  username      | character varying(255)   |           | not null | 
--  password_hash | character varying(255)   |           | not null | 
--  email         | character varying(255)   |           |          | 
--  created_at    | timestamp with time zone |           |          | CURRENT_TIMESTAMP
--  updated_at    | timestamp with time zone |           |          | CURRENT_TIMESTAMP
--  user_type     | character varying(20)    |           | not null | 'student'::character varying
-- Indexes:
--     "users_pkey" PRIMARY KEY, btree (id)
--     "users_email_key" UNIQUE CONSTRAINT, btree (email)
--     "users_username_key" UNIQUE CONSTRAINT, btree (username)
-- Referenced by:
--     TABLE "students" CONSTRAINT "students_user_id_fkey" FOREIGN KEY (user_id) REFERENCES users(id)
--     TABLE "tutors" CONSTRAINT "tutors_user_id_fkey" FOREIGN KEY (user_id) REFERENCES users(id)


DROP TABLE IF EXISTS tutors;
-- user_type "teachers"
CREATE TABLE tutors (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  profile_pic VARCHAR(255),
  name VARCHAR,
  username VARCHAR(20),
  description_bio VARCHAR(255),
  is_booked BOOLEAN,
  availability VARCHAR(255),
  remote BOOLEAN,
  description_subject VARCHAR(255),
  level VARCHAR
);
\d tutors;

--                                           Table "public.tutors"
--        Column        |          Type          | Collation | Nullable |              Default               
-- ---------------------+------------------------+-----------+----------+------------------------------------
--  id                  | integer                |           | not null | nextval('tutors_id_seq'::regclass)
--  user_id             | integer                |           |          | 
--  profile_pic         | character varying(255) |           |          | 
--  name                | character varying      |           |          | 
--  username            | character varying(20)  |           |          | 
--  description_bio     | character varying(255) |           |          | 
--  is_booked           | boolean                |           |          | 
--  availability        | character varying(255) |           |          | 
--  remote              | boolean                |           |          | 
--  description_subject | character varying(255) |           |          | 
--  level               | character varying      |           |          | 
-- Indexes:
--     "tutors_pkey" PRIMARY KEY, btree (id)
-- Foreign-key constraints:
--     "tutors_user_id_fkey" FOREIGN KEY (user_id) REFERENCES users(id)
-- Referenced by:
--     TABLE "student_reviews" CONSTRAINT "student_reviews_assigned_tutor_id_fkey" FOREIGN KEY (assigned_tutor_id) REFERENCES tutors(id)
--     TABLE "students" CONSTRAINT "students_tutor_id_fkey" FOREIGN KEY (tutor_id) REFERENCES tutors(id)

DROP TABLE IF EXISTS students;

-- user_type "student"
CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  is_enrolled BOOLEAN,
  tutor_id INTEGER REFERENCES tutors(id),
  remote BOOLEAN,
  level VARCHAR
);
\d students

--                                     Table "public.students"
--    Column    |       Type        | Collation | Nullable |               Default                
-- -------------+-------------------+-----------+----------+--------------------------------------
--  id          | integer           |           | not null | nextval('students_id_seq'::regclass)
--  user_id     | integer           |           |          | 
--  is_enrolled | boolean           |           |          | 
--  tutor_id    | integer           |           |          | 
--  remote      | boolean           |           |          | 
--  level       | character varying |           |          | 
-- Indexes:
--     "students_pkey" PRIMARY KEY, btree (id)
-- Foreign-key constraints:
--     "students_tutor_id_fkey" FOREIGN KEY (tutor_id) REFERENCES tutors(id)
--     "students_user_id_fkey" FOREIGN KEY (user_id) REFERENCES users(id)
-- Referenced by:
--     TABLE "student_reviews" CONSTRAINT "student_reviews_student_id_fkey" FOREIGN KEY (student_id) REFERENCES students(id)



DROP TABLE IF EXISTS student_reviews;
CREATE TABLE student_reviews (
  id SERIAL PRIMARY KEY,
  assigned_tutor_id INTEGER REFERENCES tutors(id),
  subject VARCHAR,
  description TEXT,
  student_id INTEGER REFERENCES students(id),
  ratings INTEGER
);
\d student_reviews;
--                                        Table "public.student_reviews"
--       Column       |       Type        | Collation | Nullable |                   Default                   
-- -------------------+-------------------+-----------+----------+---------------------------------------------
--  id                | integer           |           | not null | nextval('student_reviews_id_seq'::regclass)
--  assigned_tutor_id | integer           |           |          | 
--  subject           | character varying |           |          | 
--  description       | text              |           |          | 
--  student_id        | integer           |           |          | 
--  ratings           | integer           |           |          | 
-- Indexes:
--     "student_reviews_pkey" PRIMARY KEY, btree (id)
-- Foreign-key constraints:
--     "student_reviews_assigned_tutor_id_fkey" FOREIGN KEY (assigned_tutor_id) REFERENCES tutors(id)
--     "student_reviews_student_id_fkey" FOREIGN KEY (student_id) REFERENCES students(id)

-- Translate to sql somehow:
-- load table w/ no ref first
-- Ref: students.tutor_id - tutors.id

-- Ref: student_reviews.student_id > students.id 

-- search bar to filter out tutors depending on subjects
-- Ref: student_reviews.assigned_tutor_id > tutors.id

-- After Seeding:
-- only include tutors associated with students: shows student data on left that has a tutor and shows tutors on right (for student view)
SELECT * FROM students
LEFT JOIN tutors ON students.tutor_id = tutors.id;

-- show what they have in common (show only reviews by students - students create the reviews - many reviews to one student)
SELECT *
FROM student_reviews
INNER JOIN students ON student_reviews.student_id = students.id;

-- show what they have in common (show many reviews to one tutor so teachers can comment on student reviews - querying students review table for assigned tutor id)
SELECT *
FROM student_reviews
INNER JOIN tutors ON student_reviews.assigned_tutor_id = tutors.id;
