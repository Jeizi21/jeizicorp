CREATE DATABASE IF NOT EXISTS cleaning_module;
USE cleaning_module;

CREATE TABLE IF NOT EXISTS inventario (
  id INT AUTO_INCREMENT PRIMARY KEY,
  categoria ENUM('EPP', 'QUIMICO', 'ETIQUETA', 'OTRO') NOT NULL,
  nombre VARCHAR(120) NOT NULL,
  stock INT NOT NULL DEFAULT 0,
  stock_minimo INT NOT NULL DEFAULT 0,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS movimientos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  tipo ENUM('ENTREGA_EPP', 'ENTREGA_QUIMICO', 'RECIBO_ETIQUETA', 'LIMPIEZA_AREA', 'AJUSTE_INVENTARIO') NOT NULL,
  item VARCHAR(120) NOT NULL,
  cantidad INT NOT NULL,
  area VARCHAR(120) NOT NULL,
  fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  observaciones TEXT NULL
);

INSERT INTO inventario (categoria, nombre, stock, stock_minimo) VALUES
('EPP', 'Guantes nitrilo', 120, 50),
('EPP', 'Mascarillas', 80, 40),
('QUIMICO', 'Desengrasante', 40, 20),
('QUIMICO', 'Cloro industrial', 15, 20),
('ETIQUETA', 'Etiqueta roja', 300, 100),
('ETIQUETA', 'Etiqueta amarilla', 90, 100);

INSERT INTO movimientos (tipo, item, cantidad, area, fecha, observaciones) VALUES
('ENTREGA_EPP', 'Guantes nitrilo', 20, 'Producción A', NOW() - INTERVAL 1 DAY, 'Entrega de turno mañana'),
('ENTREGA_QUIMICO', 'Desengrasante', 4, 'Cocina industrial', NOW() - INTERVAL 6 HOUR, 'Reabastecimiento'),
('RECIBO_ETIQUETA', 'Etiqueta roja', 200, 'Almacén', NOW() - INTERVAL 4 HOUR, 'Ingreso proveedor'),
('LIMPIEZA_AREA', 'Limpieza profunda', 1, 'Baños planta 2', NOW() - INTERVAL 2 HOUR, 'Completado sin incidentes');
