CREATE TABLE facilities (
    facility_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    city TEXT,
    state TEXT
);
CREATE TABLE operations_shift (
    shift_id SERIAL PRIMARY KEY,
    facility_id INT REFERENCES facilities(facility_id),
    shift_name TEXT,
    start_time TIMESTAMP,
    end_time TIMESTAMP
);
CREATE TABLE areas (
    area_id SERIAL PRIMARY KEY,
    facility_id INT REFERENCES facilities(facility_id),
    area_name TEXT
);
CREATE TABLE equipment (
    equipment_id SERIAL PRIMARY KEY,
    area_id INT REFERENCES areas(area_id),
    equipment_name TEXT,
    equipment_type TEXT,
    status TEXT
);
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    name TEXT,
    role TEXT,
    area_id INT REFERENCES areas(area_id)
);
CREATE TABLE package_flow_metrics (
    metric_id SERIAL PRIMARY KEY,
    area_id INT REFERENCES areas(area_id),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    packages_processed INT,
    missorts INT,
    scan_rate NUMERIC,
    backlog_count INT
);
CREATE TABLE equipment_events (
    event_id SERIAL PRIMARY KEY,
    equipment_id INT REFERENCES equipment(equipment_id),
    event_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    event_type TEXT,
    description TEXT
);
CREATE TABLE alerts (
    alert_id SERIAL PRIMARY KEY,
    area_id INT REFERENCES areas(area_id),
    alert_level TEXT,
    message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);