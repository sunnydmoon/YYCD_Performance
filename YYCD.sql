-- Script MySQL para Sistema de Gestión de Taller

-- Eliminar base de datos si existe para crear desde cero
DROP DATABASE IF EXISTS taller_db;
CREATE DATABASE taller_db;
USE taller_db;

-- Tabla de usuarios (para autenticación de clientes y administradores/vendedores)
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    tipo ENUM('cliente', 'administrador', 'vendedor') NOT NULL,
    telefono VARCHAR(15),
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    ultimo_acceso DATETIME
);

-- Tabla de marcas de vehículos
CREATE TABLE marcas (
    id_marca INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    pais_origen VARCHAR(50),
    logo_url VARCHAR(255)
);

-- Tabla de modelos de vehículos
CREATE TABLE modelos (
    id_modelo INT AUTO_INCREMENT PRIMARY KEY,
    id_marca INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    tipo ENUM('Sedan', 'SUV', 'Pickup', 'Hatchback', 'Deportivo', 'Camioneta', 'Otro') NOT NULL,
    FOREIGN KEY (id_marca) REFERENCES marcas(id_marca)
);

-- Tabla de vehículos
CREATE TABLE vehiculos (
    id_vehiculo INT AUTO_INCREMENT PRIMARY KEY,
    id_modelo INT NOT NULL,
    anio INT NOT NULL,
    color VARCHAR(50),
    transmision ENUM('Manual', 'Automática', 'CVT', 'Semiautomática') NOT NULL,
    combustible ENUM('Gasolina', 'Diesel', 'Híbrido', 'Eléctrico', 'Gas') NOT NULL,
    descripcion TEXT,
    estado ENUM('disponible', 'reservado', 'vendido') DEFAULT 'disponible',
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    ultima_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_modelo) REFERENCES modelos(id_modelo)
);

-- Tabla de servicios
CREATE TABLE servicios (
    id_servicio INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL, -- "Apariencia", "Turbinas", etc.
    descripcion TEXT NOT NULL,
    imagen_url VARCHAR(255)
);

-- Tabla de cotizaciones
CREATE TABLE cotizaciones (
    id_cotizacion INT AUTO_INCREMENT PRIMARY KEY,
    modelo_auto VARCHAR(100) NOT NULL,
    servicio_requerido VARCHAR(100) NOT NULL,
    contacto VARCHAR(100) NOT NULL
);

-- Tabla de reviews
CREATE TABLE reviews (
    id_review INT AUTO_INCREMENT PRIMARY KEY,
    cliente VARCHAR(100) NOT NULL,
    comentario TEXT NOT NULL,
    puntuacion INT NOT NULL CHECK (puntuacion BETWEEN 1 AND 5)
);

-- Tabla de características de vehículos
CREATE TABLE caracteristicas_vehiculos (
    id_caracteristica INT AUTO_INCREMENT PRIMARY KEY,
    id_vehiculo INT NOT NULL,
    tipo VARCHAR(50) NOT NULL, -- 'seguridad', 'confort', 'tecnología', etc.
    descripcion VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_vehiculo) REFERENCES vehiculos(id_vehiculo)
);

-- Tabla de imágenes de vehículos
CREATE TABLE imagenes_vehiculos (
    id_imagen INT AUTO_INCREMENT PRIMARY KEY,
    id_vehiculo INT NOT NULL,
    url_imagen VARCHAR(255) NOT NULL,
    tipo ENUM('principal', 'interior', 'exterior', 'otros') NOT NULL,
    FOREIGN KEY (id_vehiculo) REFERENCES vehiculos(id_vehiculo)
);

-- Tabla de ventas (puede ser usada para registrar servicios)
CREATE TABLE ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_vehiculo INT NOT NULL,
    id_cliente INT NOT NULL,
    id_vendedor INT NOT NULL,
    fecha_venta DATETIME DEFAULT CURRENT_TIMESTAMP,
    precio_venta DECIMAL(12, 2) NOT NULL,
    metodo_pago ENUM('contado', 'financiamiento', 'leasing') NOT NULL,
    estado ENUM('completada', 'cancelada', 'pendiente') DEFAULT 'completada',
    FOREIGN KEY (id_vehiculo) REFERENCES vehiculos(id_vehiculo),
    FOREIGN KEY (id_cliente) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_vendedor) REFERENCES usuarios(id_usuario)
);

-- Insertar datos de ejemplo para marcas
INSERT INTO marcas (nombre, pais_origen) VALUES 
('Toyota', 'Japón'),
('Honda', 'Japón'),
('Ford', 'Estados Unidos'),
('Chevrolet', 'Estados Unidos'),
('BMW', 'Alemania'),
('Mercedes-Benz', 'Alemania'),
('Hyundai', 'Corea del Sur'),
('Kia', 'Corea del Sur');

-- Insertar datos de ejemplo para modelos
INSERT INTO modelos (id_marca, nombre, tipo) VALUES 
(1, 'Corolla', 'Sedan'),
(1, 'RAV4', 'SUV'),
(1, 'Hilux', 'Pickup'),
(2, 'Civic', 'Sedan'),
(2, 'CR-V', 'SUV'),
(3, 'Explorer', 'SUV'),
(3, 'F-150', 'Pickup'),
(4, 'Cruze', 'Sedan'),
(4, 'Silverado', 'Pickup'),
(5, 'Serie 3', 'Sedan'),
(5, 'X5', 'SUV'),
(6, 'Clase C', 'Sedan'),
(6, 'GLE', 'SUV'),
(7, 'Elantra', 'Sedan'),
(7, 'Tucson', 'SUV'),
(8, 'Sportage', 'SUV');

-- Insertar datos de ejemplo para usuarios
INSERT INTO usuarios (nombre, apellido, email, password, tipo, telefono) VALUES 
('Admin', 'Sistema', 'admin@autosystem.com', '$2a$12$vZG5Fm3zeE9KNs6n4Yht/.4SPZ/QBrF5nZAYd1aDEcQNuAIlmkXo6', 'administrador', '555-1000'),
('Carlos', 'Rodríguez', 'carlos@autosystem.com', '$2a$12$lK1aOwPVVBEwObgGUH1mHepGSQUYI4FvQrYSu4UmzZDJFr9BifR9K', 'vendedor', '555-1001'),
('Laura', 'Martínez', 'laura@autosystem.com', '$2a$12$3.Y1FO3Auz0QHXbPgU4bGeL2qQDwHvr7/.4GUkGGwzSzKE2AQwKE2', 'vendedor', '555-1002'),
('Juan', 'Pérez', 'juan@example.com', '$2a$12$lK1aOwPVVBEwObgGUH1mHepGSQUYI4FvQrYSu4UmzZDJFr9BifR9K', 'cliente', '555-2001'),
('María', 'Gómez', 'maria@example.com', '$2a$12$3.Y1FO3Auz0QHXbPgU4bGeL2qQDwHvr7/.4GUkGGwzSzKE2AQwKE2', 'cliente', '555-2002'),
('Roberto', 'Sánchez', 'roberto@example.com', '$2a$12$lK1aOwPVVBEwObgGUH1mHepGSQUYI4FvQrYSu4UmzZDJFr9BifR9K', 'cliente', '555-2003');

-- Insertar datos de ejemplo para vehículos
INSERT INTO vehiculos (id_modelo, anio, color, transmision, combustible, descripcion, estado) VALUES 
(1, 2023, 'Blanco', 'Automática', 'Gasolina', 'Toyota Corolla 2023 0KM. Incluye garantía de fábrica por 5 años.', 'disponible'),
(1, 2020, 'Gris', 'Automática', 'Gasolina', 'Toyota Corolla en excelentes condiciones. Único dueño.', 'disponible'),
(2, 2022, 'Azul', 'Automática', 'Híbrido', 'RAV4 Híbrida con bajo kilometraje. Muy económica.', 'disponible'),
(3, 2021, 'Negro', 'Manual', 'Diesel', 'Toyota Hilux 4x4. Ideal para trabajo y aventura.', 'disponible'),
(4, 2022, 'Rojo', 'Automática', 'Gasolina', 'Honda Civic deportivo. Excelente rendimiento.', 'reservado'),
(5, 2023, 'Plata', 'Automática', 'Gasolina', 'Honda CR-V casi nueva, con todos los extras.', 'disponible'),
(6, 2020, 'Negro', 'Automática', 'Gasolina', 'Ford Explorer con tercera fila de asientos.', 'disponible'),
(7, 2022, 'Blanco', 'Automática', 'Diesel', 'Ford F-150 con capacidad de remolque extendida.', 'disponible'),
(10, 2023, 'Azul', 'Automática', 'Gasolina', 'BMW Serie 3 con paquete deportivo M.', 'disponible'),
(11, 2021, 'Negro', 'Automática', 'Diesel', 'BMW X5 con interior en cuero y techo panorámico.', 'vendido');

-- Insertar datos de ejemplo para características de vehículos
INSERT INTO caracteristicas_vehiculos (id_vehiculo, tipo, descripcion) VALUES 
(1, 'seguridad', 'Sistema de frenos ABS'),
(1, 'seguridad', '6 Airbags'),
(1, 'confort', 'Aire acondicionado'),
(1, 'tecnología', 'Pantalla táctil de 8 pulgadas'),
(1, 'tecnología', 'Cámara de reversa'),
(2, 'seguridad', 'Control de estabilidad'),
(2, 'confort', 'Asientos eléctricos'),
(3, 'seguridad', 'Sistema de monitoreo de puntos ciegos'),
(3, 'tecnología', 'Apple CarPlay y Android Auto'),
(4, 'seguridad', 'Barra antivuelco'),
(4, 'confort', 'Asientos calefactables');

-- Insertar datos de ejemplo para imágenes de vehículos
INSERT INTO imagenes_vehiculos (id_vehiculo, url_imagen, tipo) VALUES 
(1, '/imagenes/corolla2023_1.jpg', 'principal'),
(1, '/imagenes/corolla2023_2.jpg', 'exterior'),
(1, '/imagenes/corolla2023_3.jpg', 'interior'),
(2, '/imagenes/corolla2020_1.jpg', 'principal'),
(2, '/imagenes/corolla2020_2.jpg', 'interior'),
(3, '/imagenes/rav4_2022_1.jpg', 'principal'),
(3, '/imagenes/rav4_2022_2.jpg', 'exterior');

-- Insertar datos de ejemplo para ventas (usadas para registrar servicios)
INSERT INTO ventas (id_vehiculo, id_cliente, id_vendedor, fecha_venta, precio_venta, metodo_pago, estado) VALUES 
(10, 4, 2, '2025-01-15', 54000.00, 'contado', 'completada'),
(5, 5, 3, '2025-02-10', 22500.00, 'financiamiento', 'completada');

-- Insertar datos de ejemplo para reviews
INSERT INTO reviews (cliente, comentario, puntuacion) VALUES 
('Juan Pérez', 'Excelente servicio, mi auto ganó potencia y estilo.', 5),
('María Gómez', 'Muy satisfecha con el resultado.', 4),
('Roberto Sánchez', 'Buen trabajo, aunque podría ser mejor.', 3);

-- Insertar datos de ejemplo para servicios
INSERT INTO servicios (nombre, descripcion, imagen_url) VALUES 
('Cambio de aceite', 'Servicio de cambio de aceite de alta calidad.', '/imagenes/aceite.jpg'),
('Lavado y encerado', 'Lavado y encerado completo del vehículo.', '/imagenes/lavado.jpg'),
('Revisión de frenos', 'Revisión y ajuste completo del sistema de frenos.', '/imagenes/frenos.jpg');

-- Insertar datos de ejemplo para cotizaciones
INSERT INTO cotizaciones (modelo_auto, servicio_requerido, contacto) VALUES 
('Toyota Corolla', 'Cambio de aceite', 'juan@example.com'),
('Honda Civic', 'Lavado y encerado', 'maria@example.com'),
('Ford Explorer', 'Revisión de frenos', 'roberto@example.com');

-- Índices para optimizar búsquedas
CREATE INDEX idx_vehiculos_estado ON vehiculos(estado);
CREATE INDEX idx_reviews_cliente ON reviews(cliente);
CREATE INDEX idx_servicios_nombre ON servicios(nombre);
CREATE INDEX idx_cotizaciones_contacto ON cotizaciones(contacto);

-- Vista para mostrar los vehículos disponibles con sus detalles
CREATE VIEW vista_vehiculos_disponibles AS
SELECT 
    v.id_vehiculo,
    ma.nombre AS marca,
    mo.nombre AS modelo,
    mo.tipo AS tipo_vehiculo,
    v.anio,
    v.color,
    v.transmision,
    v.combustible,
    v.descripcion,
    (SELECT url_imagen FROM imagenes_vehiculos 
     WHERE id_vehiculo = v.id_vehiculo AND tipo = 'principal' LIMIT 1) AS imagen_principal
FROM 
    vehiculos v
    JOIN modelos mo ON v.id_modelo = mo.id_modelo
    JOIN marcas ma ON mo.id_marca = ma.id_marca
WHERE 
    v.estado = 'disponible';

-- Vista para comparación de vehículos
CREATE VIEW vista_comparacion_vehiculos AS
SELECT 
    c.id_comparacion,
    c.id_usuario,
    c.fecha_comparacion,
    v.id_vehiculo,
    ma.nombre AS marca,
    mo.nombre AS modelo,
    v.anio,
    v.color,
    v.transmision,
    v.combustible
FROM 
    comparaciones c
    JOIN elementos_comparacion ec ON c.id_comparacion = ec.id_comparacion
    JOIN vehiculos v ON ec.id_vehiculo = v.id_vehiculo
    JOIN modelos mo ON v.id_modelo = mo.id_modelo
    JOIN marcas ma ON mo.id_marca = ma.id_marca;