-- Database schema for Finance Tracker

-- Users table
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(191) UNIQUE NOT NULL, -- changed from 255 to 191 for utf8mb4
  password VARCHAR(255) NOT NULL,
  role ENUM('admin', 'user', 'read-only') DEFAULT 'user',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- auto creation time
  updated_at DATETIME DEFAULT NULL                -- app must update this on UPDATE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Transactions table
CREATE TABLE IF NOT EXISTS transactions (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  description VARCHAR(255) NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  type ENUM('income', 'expense') NOT NULL,
  category VARCHAR(100) NOT NULL,
  date DATE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- auto creation time
  updated_at DATETIME DEFAULT NULL,               -- app must update this on UPDATE
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Categories table (for predefined categories)
CREATE TABLE IF NOT EXISTS categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  type ENUM('income', 'expense') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert default categories
INSERT IGNORE INTO categories (name, type) VALUES
-- Income categories
('Salary', 'income'),
('Freelance', 'income'),
('Investment', 'income'),
('Business', 'income'),
('Other Income', 'income'),

-- Expense categories
('Food & Dining', 'expense'),
('Transportation', 'expense'),
('Shopping', 'expense'),
('Entertainment', 'expense'),
('Healthcare', 'expense'),
('Education', 'expense'),
('Housing', 'expense'),
('Utilities', 'expense'),
('Insurance', 'expense'),
('Other Expenses', 'expense');

-- Create indexes for better performance
CREATE INDEX idx_transactions_user_id ON transactions(user_id);
CREATE INDEX idx_transactions_date ON transactions(date);
CREATE INDEX idx_transactions_type ON transactions(type);
CREATE INDEX idx_transactions_category ON transactions(category);
-- email is already UNIQUE (auto index), so the next line is optional
-- CREATE INDEX idx_users_email ON users(email);
