-- Script MySQL para Sistema de Gestión de Taller de Modificaciones

-- Eliminar base de datos si existe para crear desde cero
DROP DATABASE IF EXISTS taller_db;
CREATE DATABASE taller_db;
USE taller_db;

-- Tabla de usuarios (para autenticación de clientes y administradores/técnicos)
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    tipo ENUM('cliente', 'administrador', 'tecnico') NOT NULL,
    telefono VARCHAR(15),
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    ultimo_acceso DATETIME
);

-- Tabla de servicios (los 4 servicios específicos que ofrece el taller)
CREATE TABLE servicios (
    id_servicio INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    imagen_url VARCHAR(255)
);

-- Tabla de cotizaciones (adaptada a los 4 servicios específicos)
CREATE TABLE cotizaciones (
    id_cotizacion INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefono VARCHAR(15),
    presupuesto DECIMAL(12, 2),
    marca_vehiculo VARCHAR(100) NOT NULL,
    modelo_vehiculo VARCHAR(100) NOT NULL,
    anio INT NOT NULL,
    servicio_apariencia BOOLEAN DEFAULT FALSE,
    servicio_equipamiento BOOLEAN DEFAULT FALSE,
    servicio_iluminacion BOOLEAN DEFAULT FALSE,
    servicio_turbinas BOOLEAN DEFAULT FALSE,
    servicio_otro BOOLEAN DEFAULT FALSE,
    detalles TEXT,
    estado ENUM('pendiente', 'en_proceso', 'completada', 'rechazada') DEFAULT 'pendiente',
    fecha_solicitud DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabla de trabajos realizados
CREATE TABLE trabajos (
    id_trabajo INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_tecnico INT,
    marca_vehiculo VARCHAR(100) NOT NULL,
    modelo_vehiculo VARCHAR(100) NOT NULL,
    anio INT NOT NULL,
    fecha_inicio DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_finalizacion DATETIME,
    costo_total DECIMAL(12, 2),
    estado ENUM('en_espera', 'en_proceso', 'completado', 'cancelado') DEFAULT 'en_espera',
    FOREIGN KEY (id_cliente) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_tecnico) REFERENCES usuarios(id_usuario)
);

-- Tabla de detalles de trabajos (qué servicios se aplicaron)
CREATE TABLE detalles_trabajo (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_trabajo INT NOT NULL,
    id_servicio INT NOT NULL,
    descripcion TEXT,
    costo DECIMAL(12, 2),
    FOREIGN KEY (id_trabajo) REFERENCES trabajos(id_trabajo),
    FOREIGN KEY (id_servicio) REFERENCES servicios(id_servicio)
);

-- Tabla de imágenes de trabajos (antes/después)
CREATE TABLE imagenes_trabajo (
    id_imagen INT AUTO_INCREMENT PRIMARY KEY,
    id_trabajo INT NOT NULL,
    url_imagen VARCHAR(255) NOT NULL,
    tipo ENUM('antes', 'durante', 'despues') NOT NULL,
    FOREIGN KEY (id_trabajo) REFERENCES trabajos(id_trabajo)
);

-- Tabla de reviews
CREATE TABLE reviews (
    id_review INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_trabajo INT,
    comentario TEXT NOT NULL,
    puntuacion INT NOT NULL CHECK (puntuacion BETWEEN 1 AND 5),
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_cliente) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_trabajo) REFERENCES trabajos(id_trabajo)
);

-- Insertar datos de ejemplo para usuarios
INSERT INTO usuarios (nombre, apellido, email, password, tipo, telefono) VALUES 
('Admin', 'Sistema', 'admin@yycd.com', '$2a$12$vZG5Fm3zeE9KNs6n4Yht/.4SPZ/QBrF5nZAYd1aDEcQNuAIlmkXo6', 'administrador', '555-1000'),
('Carlos', 'Rodríguez', 'carlos@yycd.com', '$2a$12$lK1aOwPVVBEwObgGUH1mHepGSQUYI4FvQrYSu4UmzZDJFr9BifR9K', 'tecnico', '555-1001'),
('Laura', 'Martínez', 'laura@yycd.com', '$2a$12$3.Y1FO3Auz0QHXbPgU4bGeL2qQDwHvr7/.4GUkGGwzSzKE2AQwKE2', 'tecnico', '555-1002'),
('Juan', 'Pérez', 'juan@example.com', '$2a$12$lK1aOwPVVBEwObgGUH1mHepGSQUYI4FvQrYSu4UmzZDJFr9BifR9K', 'cliente', '555-2001'),
('María', 'Gómez', 'maria@example.com', '$2a$12$3.Y1FO3Auz0QHXbPgU4bGeL2qQDwHvr7/.4GUkGGwzSzKE2AQwKE2', 'cliente', '555-2002'),
('Roberto', 'Sánchez', 'roberto@example.com', '$2a$12$lK1aOwPVVBEwObgGUH1mHepGSQUYI4FvQrYSu4UmzZDJFr9BifR9K', 'cliente', '555-2003');

-- Insertar los 4 servicios específicos
INSERT INTO servicios (nombre, descripcion, imagen_url) VALUES 
('Apariencia', 'Transforma la estética de tu auto con pintura personalizada, acabados especiales y modificaciones exclusivas.', '/img/Apariencia.png'),
('Equipamiento', 'Optimiza el rendimiento con componentes deportivos, accesorios de alta tecnología e interiores personalizados.', '/img/Equipamiento.png'),
('Iluminación', 'Instala sistemas LED, iluminación adaptativa y ópticas modernas para mayor seguridad y estilo.', '/img/Iluminacion.png'),
('Turbinas', 'Aumenta la potencia de tu motor con kits de inducción forzada y sistemas turbo avanzados.', '/img/Turbinas.png');

-- Insertar datos de ejemplo para reviews
INSERT INTO reviews (id_cliente, comentario, puntuacion) VALUES 
(4, 'Excelente servicio, mi auto ganó potencia y estilo.', 5),
(5, 'Muy satisfecha con el resultado.', 4),
(6, 'Buen trabajo, aunque podría ser mejor.', 3);

-- Insertar datos de ejemplo para cotizaciones
INSERT INTO cotizaciones (nombre, email, telefono, marca_vehiculo, modelo_vehiculo, anio, servicio_apariencia, servicio_turbinas, detalles) VALUES 
('Juan Pérez', 'juan@example.com', '555-2001', 'Toyota', 'Corolla', 2020, TRUE, TRUE, 'Interesado en viniles y kit de turbo');

-- Índices para optimizar consultas
CREATE INDEX idx_cotizaciones_email ON cotizaciones(email);
CREATE INDEX idx_cotizaciones_estado ON cotizaciones(estado);
CREATE INDEX idx_trabajos_cliente ON trabajos(id_cliente);
CREATE INDEX idx_trabajos_estado ON trabajos(estado);
CREATE INDEX idx_reviews_cliente ON reviews(id_cliente);

-- Vista para mostrar las cotizaciones pendientes con detalles
CREATE VIEW vista_cotizaciones_pendientes AS
SELECT 
    c.id_cotizacion,
    c.nombre,
    c.email,
    c.telefono,
    c.marca_vehiculo,
    c.modelo_vehiculo,
    c.anio,
    CASE WHEN c.servicio_apariencia THEN 'Sí' ELSE 'No' END AS apariencia,
    CASE WHEN c.servicio_equipamiento THEN 'Sí' ELSE 'No' END AS equipamiento,
    CASE WHEN c.servicio_iluminacion THEN 'Sí' ELSE 'No' END AS iluminacion,
    CASE WHEN c.servicio_turbinas THEN 'Sí' ELSE 'No' END AS turbinas,
    c.detalles,
    c.fecha_solicitud
FROM 
    cotizaciones c
WHERE 
    c.estado = 'pendiente'
ORDER BY 
    c.fecha_solicitud ASC;