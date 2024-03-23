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
  id SERIAL PRIMARY KEY,
  student_id INTEGER,
  tutor_id INTEGER,
  accepted BOOLEAN,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (student_id) REFERENCES users(id),
  FOREIGN KEY (tutor_id) REFERENCES users(id)
);

CREATE TABLE student_reviews (
  id SERIAL PRIMARY KEY,
  assigned_tutor_id INTEGER REFERENCES users(id),
  subject VARCHAR(255),
  description VARCHAR(255),
  student_id INTEGER REFERENCES users(id),
  ratings INTEGER CHECK (ratings >= 1 AND ratings <= 5)
);