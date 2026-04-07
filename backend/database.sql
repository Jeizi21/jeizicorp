CREATE DATABASE IF NOT EXISTS industrial_control CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE industrial_control;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(120) NOT NULL,
    role VARCHAR(40) NOT NULL DEFAULT 'operador',
    api_token VARCHAR(128) NULL,
    token_expires_at DATETIME NULL,
    last_login_at DATETIME NULL,
    active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS process_headers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    production_date DATE NOT NULL,
    shift_name VARCHAR(50) NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    application_method VARCHAR(80) NOT NULL,
    week_label VARCHAR(20) NULL,
    created_by INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS process_entries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    header_id INT NOT NULL,
    hour_mark TIME NULL,
    lot_number VARCHAR(80) NOT NULL,
    ph_value DECIMAL(4,2) NOT NULL,
    water_temp_c DECIMAL(5,2) NOT NULL,
    turbidity_ntu DECIMAL(6,2) NOT NULL,
    water_changed TINYINT(1) NOT NULL DEFAULT 0,
    water_liters DECIMAL(8,2) NOT NULL DEFAULT 0,
    disinfectant_ml DECIMAL(8,2) NOT NULL DEFAULT 0,
    concentration_ppm INT NOT NULL DEFAULT 0,
    observations VARCHAR(255) NULL,
    operator_initials VARCHAR(20) NULL,
    supervisor_name VARCHAR(120) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (header_id) REFERENCES process_headers(id) ON DELETE CASCADE
);

-- Usuario demo: admin / Admin123*
INSERT INTO users (username, password_hash, full_name, role)
VALUES (
    'admin',
    '$2y$12$5Phk2lq8Ofh02rmR2ILdjOYOjzZ1sG8cd50kbCCHBlO4qmfpCz4lO',
    'Supervisor General',
    'supervisor'
)
ON DUPLICATE KEY UPDATE username = username;
