-- Habitra Database Schema

-- Users table
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT UNIQUE NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Habits table
CREATE TABLE habits (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    title TEXT NOT NULL,
    description TEXT,
    frequency TEXT NOT NULL, -- daily, weekly, monthly
    reminder_time TEXT,
    streak_count INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

-- Habit logs table
CREATE TABLE habit_logs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    habit_id INTEGER NOT NULL,
    completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    FOREIGN KEY (habit_id) REFERENCES habits (id) ON DELETE CASCADE
);

-- Categories table
CREATE TABLE categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    color TEXT NOT NULL,
    user_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

-- Habit categories junction table
CREATE TABLE habit_categories (
    habit_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    PRIMARY KEY (habit_id, category_id),
    FOREIGN KEY (habit_id) REFERENCES habits (id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE CASCADE
);

-- Indexes for better performance
CREATE INDEX idx_habits_user_id ON habits(user_id);
CREATE INDEX idx_habit_logs_habit_id ON habit_logs(habit_id);
CREATE INDEX idx_categories_user_id ON categories(user_id);
CREATE INDEX idx_habit_categories_habit_id ON habit_categories(habit_id);
CREATE INDEX idx_habit_categories_category_id ON habit_categories(category_id);

-- Common Queries

-- Create a new user
INSERT INTO users (username, email, password) VALUES (?, ?, ?);

-- Get user by email
SELECT * FROM users WHERE email = ?;

-- Create a new habit
INSERT INTO habits (user_id, title, description, frequency, reminder_time) 
VALUES (?, ?, ?, ?, ?);

-- Get all habits for a user
SELECT * FROM habits WHERE user_id = ?;

-- Update a habit
UPDATE habits 
SET title = ?, description = ?, frequency = ?, reminder_time = ? 
WHERE id = ?;

-- Delete a habit
DELETE FROM habits WHERE id = ?;

-- Log habit completion
INSERT INTO habit_logs (habit_id, notes) VALUES (?, ?);

-- Get habit logs
SELECT * FROM habit_logs WHERE habit_id = ? ORDER BY completed_at DESC;

-- Create a new category
INSERT INTO categories (name, color, user_id) VALUES (?, ?, ?);

-- Get user categories
SELECT * FROM categories WHERE user_id = ?;

-- Add habit to category
INSERT INTO habit_categories (habit_id, category_id) VALUES (?, ?);

-- Get categories for a habit
SELECT c.* FROM categories c
JOIN habit_categories hc ON c.id = hc.category_id
WHERE hc.habit_id = ?;

-- Get habit statistics
SELECT 
    h.streak_count as current_streak,
    COUNT(hl.id) as total_completions,
    (COUNT(hl.id) * 100.0 / 
        (julianday('now') - julianday(h.created_at))) as completion_rate
FROM habits h
LEFT JOIN habit_logs hl ON h.id = hl.habit_id
WHERE h.id = ?
GROUP BY h.id;

-- Get daily completion statistics for a user
SELECT 
    date(hl.completed_at) as date,
    COUNT(*) as completions
FROM habit_logs hl
JOIN habits h ON hl.habit_id = h.id
WHERE h.user_id = ?
GROUP BY date(hl.completed_at)
ORDER BY date DESC
LIMIT 30;

-- Get habits with their categories
SELECT 
    h.*,
    GROUP_CONCAT(c.name) as category_names,
    GROUP_CONCAT(c.color) as category_colors
FROM habits h
LEFT JOIN habit_categories hc ON h.id = hc.habit_id
LEFT JOIN categories c ON hc.category_id = c.id
WHERE h.user_id = ?
GROUP BY h.id;

-- Get habits due for today
SELECT h.* 
FROM habits h
WHERE h.user_id = ? 
AND (
    h.frequency = 'daily'
    OR (h.frequency = 'weekly' AND strftime('%w', 'now') = '1')
    OR (h.frequency = 'monthly' AND strftime('%d', 'now') = '1')
);

-- Get streak information for a habit
SELECT 
    COUNT(*) as current_streak,
    MAX(streak) as longest_streak
FROM (
    SELECT 
        date(completed_at) as date,
        COUNT(*) as streak
    FROM habit_logs
    WHERE habit_id = ?
    GROUP BY date(completed_at)
    ORDER BY date DESC
); 