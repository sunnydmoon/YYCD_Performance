-- Script MySQL para Sistema de Venta de Carros
-- Basado en las historias de usuario proporcionadas

-- Eliminar base de datos si existe para crear desde cero
DROP DATABASE IF EXISTS tienda_autos_db;
CREATE DATABASE tienda_autos_db;
USE tienda_autos_db;

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
    precio DECIMAL(12, 2) NOT NULL,
    kilometraje INT,
    color VARCHAR(50),
    transmision ENUM('Manual', 'Automática', 'CVT', 'Semiautomática') NOT NULL,
    combustible ENUM('Gasolina', 'Diesel', 'Híbrido', 'Eléctrico', 'Gas') NOT NULL,
    descripcion TEXT,
    estado ENUM('disponible', 'reservado', 'vendido') DEFAULT 'disponible',
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    ultima_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_modelo) REFERENCES modelos(id_modelo)
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

-- Tabla de ventas
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

-- Tabla para opciones de financiamiento
CREATE TABLE financiamiento (
    id_financiamiento INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT,
    plazo_meses INT NOT NULL,
    tasa_interes DECIMAL(5, 2) NOT NULL,
    entrada DECIMAL(12, 2),
    cuota_mensual DECIMAL(12, 2) NOT NULL,
    entidad_financiera VARCHAR(100),
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta)
);

-- Tabla para pruebas de manejo
CREATE TABLE pruebas_manejo (
    id_prueba INT AUTO_INCREMENT PRIMARY KEY,
    id_vehiculo INT NOT NULL,
    id_cliente INT NOT NULL,
    fecha_hora DATETIME NOT NULL,
    estado ENUM('programada', 'completada', 'cancelada') DEFAULT 'programada',
    comentarios TEXT,
    FOREIGN KEY (id_vehiculo) REFERENCES vehiculos(id_vehiculo),
    FOREIGN KEY (id_cliente) REFERENCES usuarios(id_usuario)
);

-- Tabla para quejas y sugerencias
CREATE TABLE quejas_sugerencias (
    id_queja INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    nombre VARCHAR(100),
    email VARCHAR(100),
    tipo ENUM('queja', 'sugerencia') NOT NULL,
    asunto VARCHAR(100) NOT NULL,
    mensaje TEXT NOT NULL,
    fecha_envio DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('pendiente', 'en_proceso', 'resuelta') DEFAULT 'pendiente',
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Tabla para promociones
CREATE TABLE promociones (
    id_promocion INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    descuento DECIMAL(5, 2), -- Porcentaje de descuento
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    estado ENUM('activa', 'inactiva') DEFAULT 'activa'
);

-- Tabla de relación entre promociones y vehículos
CREATE TABLE promociones_vehiculos (
    id_promocion INT NOT NULL,
    id_vehiculo INT NOT NULL,
    PRIMARY KEY (id_promocion, id_vehiculo),
    FOREIGN KEY (id_promocion) REFERENCES promociones(id_promocion),
    FOREIGN KEY (id_vehiculo) REFERENCES vehiculos(id_vehiculo)
);

-- Tabla para reseñas y valoraciones
CREATE TABLE resenas (
    id_resena INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_vehiculo INT,
    calificacion INT NOT NULL CHECK (calificacion BETWEEN 1 AND 5),
    comentario TEXT,
    fecha_publicacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_cliente) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_vehiculo) REFERENCES vehiculos(id_vehiculo)
);

-- Tabla para mensajes entre clientes y vendedores
CREATE TABLE mensajes (
    id_mensaje INT AUTO_INCREMENT PRIMARY KEY,
    id_emisor INT NOT NULL,
    id_receptor INT NOT NULL,
    id_vehiculo INT,
    asunto VARCHAR(100) NOT NULL,
    contenido TEXT NOT NULL,
    fecha_envio DATETIME DEFAULT CURRENT_TIMESTAMP,
    leido BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_emisor) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_receptor) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_vehiculo) REFERENCES vehiculos(id_vehiculo)
);

-- Tabla para comparación de vehículos (historial)
CREATE TABLE comparaciones (
    id_comparacion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_comparacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Tabla para elementos de comparación
CREATE TABLE elementos_comparacion (
    id_comparacion INT NOT NULL,
    id_vehiculo INT NOT NULL,
    PRIMARY KEY (id_comparacion, id_vehiculo),
    FOREIGN KEY (id_comparacion) REFERENCES comparaciones(id_comparacion),
    FOREIGN KEY (id_vehiculo) REFERENCES vehiculos(id_vehiculo)
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
INSERT INTO vehiculos (id_modelo, anio, precio, kilometraje, color, transmision, combustible, descripcion, estado) VALUES 
(1, 2023, 25000.00, 0, 'Blanco', 'Automática', 'Gasolina', 'Toyota Corolla 2023 0KM. Incluye garantía de fábrica por 5 años.', 'disponible'),
(1, 2020, 18500.00, 45000, 'Gris', 'Automática', 'Gasolina', 'Toyota Corolla en excelentes condiciones. Único dueño.', 'disponible'),
(2, 2022, 32000.00, 15000, 'Azul', 'Automática', 'Híbrido', 'RAV4 Híbrida con bajo kilometraje. Muy económica.', 'disponible'),
(3, 2021, 35000.00, 25000, 'Negro', 'Manual', 'Diesel', 'Toyota Hilux 4x4. Ideal para trabajo y aventura.', 'disponible'),
(4, 2022, 23000.00, 18000, 'Rojo', 'Automática', 'Gasolina', 'Honda Civic deportivo. Excelente rendimiento.', 'reservado'),
(5, 2023, 33500.00, 5000, 'Plata', 'Automática', 'Gasolina', 'Honda CR-V casi nueva, con todos los extras.', 'disponible'),
(6, 2020, 38000.00, 30000, 'Negro', 'Automática', 'Gasolina', 'Ford Explorer con tercera fila de asientos.', 'disponible'),
(7, 2022, 45000.00, 12000, 'Blanco', 'Automática', 'Diesel', 'Ford F-150 con capacidad de remolque extendida.', 'disponible'),
(10, 2023, 55000.00, 8000, 'Azul', 'Automática', 'Gasolina', 'BMW Serie 3 con paquete deportivo M.', 'disponible'),
(11, 2021, 68000.00, 22000, 'Negro', 'Automática', 'Diesel', 'BMW X5 con interior en cuero y techo panorámico.', 'vendido');

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

-- Insertar datos de ejemplo para ventas
INSERT INTO ventas (id_vehiculo, id_cliente, id_vendedor, fecha_venta, precio_venta, metodo_pago, estado) VALUES 
(10, 4, 2, '2025-01-15', 54000.00, 'contado', 'completada'),
(5, 5, 3, '2025-02-10', 22500.00, 'financiamiento', 'completada');

-- Insertar datos de ejemplo para financiamiento
INSERT INTO financiamiento (id_venta, plazo_meses, tasa_interes, entrada, cuota_mensual, entidad_financiera) VALUES 
(2, 48, 5.99, 5000.00, 410.25, 'Banco Nacional');

-- Insertar datos de ejemplo para pruebas de manejo
INSERT INTO pruebas_manejo (id_vehiculo, id_cliente, fecha_hora, estado, comentarios) VALUES 
(3, 4, '2025-03-15 10:00:00', 'programada', 'Cliente interesado en ver opciones de SUV híbrida'),
(6, 6, '2025-03-10 15:30:00', 'completada', 'Cliente satisfecho con la prueba, evaluando opciones de financiamiento'),
(8, 5, '2025-03-05 11:00:00', 'cancelada', 'Cliente canceló por problemas personales');

-- Insertar datos de ejemplo para promociones
INSERT INTO promociones (titulo, descripcion, descuento, fecha_inicio, fecha_fin, estado) VALUES 
('Liquidación de modelos 2020', 'Grandes descuentos en todos los vehículos modelo 2020', 10.00, '2025-03-01', '2025-04-30', 'activa'),
('Financiamiento especial', '0% de interés por los primeros 6 meses', NULL, '2025-03-15', '2025-03-31', 'activa');

-- Insertar datos de ejemplo para relación promociones-vehículos
INSERT INTO promociones_vehiculos (id_promocion, id_vehiculo) VALUES 
(1, 2),
(1, 6),
(2, 1),
(2, 3),
(2, 6),
(2, 7);

-- Insertar datos de ejemplo para reseñas
INSERT INTO resenas (id_cliente, id_vehiculo, calificacion, comentario, fecha_publicacion) VALUES 
(4, 10, 5, 'Excelente vehículo, muy cómodo y con gran rendimiento de combustible.', '2025-02-20'),
(5, 5, 4, 'Muy buen auto, aunque el consumo de combustible podría ser mejor.', '2025-02-25'),
(6, 6, 5, 'Increíble SUV, espaciosa y con todas las características que buscaba.', '2025-03-05');

-- Insertar datos de ejemplo para mensajes
INSERT INTO mensajes (id_emisor, id_receptor, id_vehiculo, asunto, contenido, fecha_envio, leido) VALUES 
(4, 2, 3, 'Consulta sobre RAV4 2022', '¿Tiene disponibilidad para una prueba de manejo este fin de semana?', '2025-03-08 09:30:00', TRUE),
(2, 4, 3, 'RE: Consulta sobre RAV4 2022', 'Claro, tenemos disponibilidad el sábado a las 10am o 3pm. ¿Cuál prefiere?', '2025-03-08 10:15:00', TRUE),
(5, 3, 7, 'Información sobre financiamiento', '¿Cuáles son las opciones de financiamiento para la F-150?', '2025-03-10 14:20:00', FALSE);

-- Insertar datos de ejemplo para comparaciones
INSERT INTO comparaciones (id_usuario, fecha_comparacion) VALUES 
(4, '2025-03-02 16:45:00'),
(5, '2025-03-09 11:30:00');

-- Insertar datos de ejemplo para elementos de comparación
INSERT INTO elementos_comparacion (id_comparacion, id_vehiculo) VALUES 
(1, 1),
(1, 4),
(1, 10),
(2, 3),
(2, 5),
(2, 6);

-- Índices para optimizar búsquedas
CREATE INDEX idx_vehiculos_precio ON vehiculos(precio);
CREATE INDEX idx_vehiculos_marca_modelo ON vehiculos(id_modelo);
CREATE INDEX idx_vehiculos_anio ON vehiculos(anio);
CREATE INDEX idx_vehiculos_estado ON vehiculos(estado);
CREATE INDEX idx_pruebas_fecha ON pruebas_manejo(fecha_hora);
CREATE INDEX idx_ventas_fecha ON ventas(fecha_venta);

-- Vista para mostrar los vehículos disponibles con sus detalles
CREATE VIEW vista_vehiculos_disponibles AS
SELECT 
    v.id_vehiculo,
    ma.nombre AS marca,
    mo.nombre AS modelo,
    mo.tipo AS tipo_vehiculo,
    v.anio,
    v.precio,
    v.kilometraje,
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
    v.precio,
    v.kilometraje,
    v.transmision,
    v.combustible
FROM 
    comparaciones c
    JOIN elementos_comparacion ec ON c.id_comparacion = ec.id_comparacion
    JOIN vehiculos v ON ec.id_vehiculo = v.id_vehiculo
    JOIN modelos mo ON v.id_modelo = mo.id_modelo
    JOIN marcas ma ON mo.id_marca = ma.id_marca;

-- Procedimiento almacenado para registrar una venta y actualizar estado del vehículo
DELIMITER //
CREATE PROCEDURE registrar_venta(
    IN p_id_vehiculo INT,
    IN p_id_cliente INT,
    IN p_id_vendedor INT,
    IN p_precio_venta DECIMAL(12, 2),
    IN p_metodo_pago VARCHAR(20)
)
BEGIN
    -- Registrar la venta
    INSERT INTO ventas (id_vehiculo, id_cliente, id_vendedor, precio_venta, metodo_pago)
    VALUES (p_id_vehiculo, p_id_cliente, p_id_vendedor, p_precio_venta, p_metodo_pago);
    
    -- Actualizar el estado del vehículo
    UPDATE vehiculos SET estado = 'vendido' WHERE id_vehiculo = p_id_vehiculo;
    
    -- Devolver el ID de la venta creada
    SELECT LAST_INSERT_ID() AS id_venta;
END //
DELIMITER ;

-- Trigger para verificar disponibilidad antes de programar prueba de manejo
DELIMITER //
CREATE TRIGGER verificar_disponibilidad_antes_prueba
BEFORE INSERT ON pruebas_manejo
FOR EACH ROW
BEGIN
    DECLARE v_estado VARCHAR(20);
    
    -- Obtener el estado actual del vehículo
    SELECT estado INTO v_estado FROM vehiculos WHERE id_vehiculo = NEW.id_vehiculo;
    
    -- Verificar si el vehículo está disponible para prueba
    IF v_estado = 'vendido' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede programar prueba para un vehículo ya vendido';
    END IF;
END //
DELIMITER ;

-- Procedimiento almacenado para búsqueda avanzada de vehículos
DELIMITER //
CREATE PROCEDURE buscar_vehiculos(
    IN p_marca INT,
    IN p_modelo INT,
    IN p_tipo VARCHAR(50),
    IN p_anio_min INT,
    IN p_anio_max INT,
    IN p_precio_min DECIMAL(12, 2),
    IN p_precio_max DECIMAL(12, 2),
    IN p_kilometraje_max INT
)
BEGIN
    SELECT 
        v.id_vehiculo,
        ma.nombre AS marca,
        mo.nombre AS modelo,
        mo.tipo AS tipo_vehiculo,
        v.anio,
        v.precio,
        v.kilometraje,
        v.color,
        v.transmision,
        v.combustible,
        v.descripcion,
        v.estado,
        (SELECT url_imagen FROM imagenes_vehiculos 
         WHERE id_vehiculo = v.id_vehiculo AND tipo = 'principal' LIMIT 1) AS imagen_principal
    FROM 
        vehiculos v
        JOIN modelos mo ON v.id_modelo = mo.id_modelo
        JOIN marcas ma ON mo.id_marca = ma.id_marca
    WHERE
        (p_marca IS NULL OR ma.id_marca = p_marca) AND
        (p_modelo IS NULL OR mo.id_modelo = p_modelo) AND
        (p_tipo IS NULL OR mo.tipo = p_tipo) AND
        (p_anio_min IS NULL OR v.anio >= p_anio_min) AND
        (p_anio_max IS NULL OR v.anio <= p_anio_max) AND
        (p_precio_min IS NULL OR v.precio >= p_precio_min) AND
        (p_precio_max IS NULL OR v.precio <= p_precio_max) AND
        (p_kilometraje_max IS NULL OR v.kilometraje <= p_kilometraje_max) AND
        v.estado = 'disponible';
END //
DELIMITER ;
