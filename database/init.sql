-- Creates the 'users' table to store information about each LINE user.
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    line_user_id VARCHAR(255) UNIQUE NOT NULL,
    display_name VARCHAR(255),
    role VARCHAR(50) DEFAULT 'employee',
    sick_leave_balance INT DEFAULT 30,
    vacation_leave_balance INT DEFAULT 10,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Creates the 'leave_requests' table to log all leave submissions.
CREATE TABLE leave_requests (
    request_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id) ON DELETE RESTRICT,
    leave_type VARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    reason TEXT,
    status VARCHAR(50) DEFAULT 'pending',
    manager_comment TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Creates the "leave_calendar" table to store each individual day an employee is on leave.
CREATE TABLE leave_calendar (
    id SERIAL PRIMARY KEY,
    request_id INT REFERENCES leave_requests(request_id) ON DELETE CASCADE,
    employee_id INT REFERENCES users(user_id) ON DELETE RESTRICT,
    date DATE NOT NULL,
    leave_type VARCHAR(50), -- Denormalized for faster read queries (sick, vacation, etc.)
    UNIQUE (employee_id, date) -- Ensures an employee cannot be on multiple types of leave on the same day
);

ALTER TABLE leave_calendar
ADD COLUMN google_event_id VARCHAR(255);