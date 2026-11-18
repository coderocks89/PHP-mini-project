-- Online Voting System Database Schema
CREATE DATABASE IF NOT EXISTS online_voting_db;
USE online_voting_db;

-- Table for Users / Voters
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    voter_id VARCHAR(50) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('voter', 'admin') DEFAULT 'voter',
    has_voted TINYINT(1) DEFAULT 0,
    voted_candidate_id INT DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for Candidates
CREATE TABLE IF NOT EXISTS candidates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    party VARCHAR(100) NOT NULL,
    manifesto TEXT NOT NULL,
    vote_count INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for Votes Log
CREATE TABLE IF NOT EXISTS votes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    candidate_id INT NOT NULL,
    voted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (candidate_id) REFERENCES candidates(id) ON DELETE CASCADE
);

-- Default Admin Account (Password: admin123)
INSERT INTO users (voter_id, full_name, email, password, role) 
VALUES ('ADMIN001', 'System Administrator', 'admin@voting.org', '$2y$10$e0MYzXyjpJS7Pd0RVvHwHe1g.n5AByJ9GfHnS3G2K1h7v8Kx5i0l2', 'admin')
ON DUPLICATE KEY UPDATE id=id;

-- Sample Candidates (Updated to 2 candidates)
TRUNCATE TABLE candidates;
INSERT INTO candidates (name, party, manifesto, vote_count) VALUES 
('Tanishq', 'Progressive Tech Alliance', 'Focusing on digital innovation, student welfare, and campus sustainability.', 0),
('Barnali', 'Youth Power Coalition', 'Promoting equal opportunities, transparent governance, and skill development.', 0);
