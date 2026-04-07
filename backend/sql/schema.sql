-- Ranchox: esquema base MySQL 8

CREATE TABLE users (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(120) NOT NULL,
  email VARCHAR(160) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  role ENUM('admin','encargado','veterinario','consulta') NOT NULL DEFAULT 'consulta',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE species (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  code VARCHAR(30) NOT NULL UNIQUE,
  name VARCHAR(80) NOT NULL
);

CREATE TABLE animals (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  animal_code VARCHAR(50) NOT NULL UNIQUE,
  name VARCHAR(120) NOT NULL,
  species_id BIGINT UNSIGNED NOT NULL,
  breed VARCHAR(120),
  sex ENUM('macho','hembra') NOT NULL,
  birth_date DATE,
  current_weight_kg DECIMAL(8,2),
  health_status ENUM('saludable','observacion','enfermo') NOT NULL DEFAULT 'saludable',
  sale_status ENUM('no_venta','en_venta','vendido') NOT NULL DEFAULT 'no_venta',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_animals_species FOREIGN KEY (species_id) REFERENCES species(id)
);

CREATE TABLE vaccinations (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  animal_id BIGINT UNSIGNED NOT NULL,
  vaccine_name VARCHAR(140) NOT NULL,
  application_date DATE NOT NULL,
  next_due_date DATE,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_vaccinations_animals FOREIGN KEY (animal_id) REFERENCES animals(id)
);

CREATE TABLE health_events (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  animal_id BIGINT UNSIGNED NOT NULL,
  event_type ENUM('sintoma','diagnostico','tratamiento','urgencia') NOT NULL,
  title VARCHAR(160) NOT NULL,
  description TEXT,
  severity ENUM('baja','media','alta','emergencia') NOT NULL DEFAULT 'baja',
  event_date DATETIME NOT NULL,
  created_by BIGINT UNSIGNED,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_health_events_animals FOREIGN KEY (animal_id) REFERENCES animals(id),
  CONSTRAINT fk_health_events_users FOREIGN KEY (created_by) REFERENCES users(id)
);

CREATE TABLE production_logs (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  animal_id BIGINT UNSIGNED NOT NULL,
  metric_code VARCHAR(50) NOT NULL,
  metric_value DECIMAL(12,2) NOT NULL,
  unit VARCHAR(20) NOT NULL,
  log_date DATE NOT NULL,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_production_logs_animals FOREIGN KEY (animal_id) REFERENCES animals(id)
);

CREATE TABLE finance_transactions (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  animal_id BIGINT UNSIGNED,
  tx_type ENUM('gasto','ingreso','inversion') NOT NULL,
  category VARCHAR(80) NOT NULL,
  amount DECIMAL(12,2) NOT NULL,
  tx_date DATE NOT NULL,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_finance_transactions_animals FOREIGN KEY (animal_id) REFERENCES animals(id)
);

CREATE TABLE animal_images (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  animal_id BIGINT UNSIGNED NOT NULL,
  image_url VARCHAR(255) NOT NULL,
  caption VARCHAR(180),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_animal_images_animals FOREIGN KEY (animal_id) REFERENCES animals(id)
);
