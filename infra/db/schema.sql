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
    area_name TEXT NOT NULL
);
CREATE TABLE equipment (
    equipment_id SERIAL PRIMARY KEY,
    area_id INT REFERENCES areas(area_id),
    equipment_name TEXT NOT NULL,
    equipment_type TEXT,
    status TEXT DEFAULT 'ACTIVE'
);
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    name TEXT,
    role TEXT,
    area_id INT NOT NULL REFERENCES areas(area_id)
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
DROP TABLE alerts;

CREATE TABLE alerts (
    alert_id SERIAL PRIMARY KEY,
    area_id INT REFERENCES areas(area_id),
    equipment_id INT REFERENCES equipment(equipment_id),
    alert_level TEXT,
    message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT alerts_source_check
        CHECK (
            area_id IS NOT NULL
            OR equipment_id IS NOT NULL
        )
);
CREATE INDEX idx_package_flow_area_time ON package_flow_metrics(area_id, timestamp);
CREATE INDEX idx_equipment_events_equipment_time ON equipment_events(equipment_id, event_time);
CREATE INDEX idx_alerts_area_time ON alerts(area_id, created_at);