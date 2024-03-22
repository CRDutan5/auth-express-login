-- db/schema.sql
DROP DATABASE IF EXISTS authdb;

CREATE DATABASE authdb;


\c authdb;

DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    is_tutor BOOLEAN,
    profile_pic VARCHAR(255),
    username VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    name VARCHAR(255),
    is_enrolled BOOLEAN,
    is_booked BOOLEAN,
    subject VARCHAR(255),
    is_remote BOOLEAN
);

CREATE TABLE requests (
  student_id INTEGER,
  tutor_id INTEGER,
  tutor_accepts BOOLEAN
);

CREATE TABLE student_reviews (
  id SERIAL PRIMARY KEY,
  assigned_tutor_id INTEGER REFERENCES tutors(id),
  subject VARCHAR(255),
  description VARCHAR(255),
  student_id INTEGER REFERENCES students(id),
  ratings INTEGER CHECK (ratings >= 1 AND ratings <= 5)
);