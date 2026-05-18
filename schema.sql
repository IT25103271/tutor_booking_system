-- Create database
CREATE DATABASE IF NOT EXISTS tutor_booking_db;
USE tutor_booking_db;

-- Create reviews table
CREATE TABLE IF NOT EXISTS reviews (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    tutor_id BIGINT NOT NULL,
    student_id BIGINT NOT NULL,
    student_name VARCHAR(255) NOT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    review_text TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_verified BOOLEAN DEFAULT FALSE
);

-- Optional: Add some sample data
-- INSERT INTO reviews (tutor_id, student_id, student_name, rating, review_text, is_verified) 
-- VALUES (1, 101, 'John Doe', 5, 'Excellent tutor! Very helpful.', true);
