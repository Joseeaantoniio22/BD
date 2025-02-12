-- Eliminar la base de datos ventas si existe
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'ventas')
BEGIN
    DROP DATABASE ventas;
END;
GO

-- Crear y usar la base de datos ventas
CREATE DATABASE ventas;
GO

USE ventas;
GO

-- Crear la tabla cliente
CREATE TABLE cliente (
    id INT IDENTITY(1,1),
    nombre NVARCHAR(100) NOT NULL,
    apellido1 NVARCHAR(100) NOT NULL,
    apellido2 NVARCHAR(100),
    ciudad NVARCHAR(100),
    categoria INT,
    CONSTRAINT pk_cliente PRIMARY KEY (id),
    CONSTRAINT chk_categoria CHECK (categoria >= 0)
);
GO

-- Crear la tabla comercial
CREATE TABLE comercial (
    id INT IDENTITY(1,1),
    nombre NVARCHAR(100) NOT NULL,
    apellido1 NVARCHAR(100) NOT NULL,
    apellido2 NVARCHAR(100),
    comision FLOAT,
    CONSTRAINT pk_comercial PRIMARY KEY (id),
    CONSTRAINT chk_comision CHECK (comision >= 0)
);
GO

-- Crear la tabla pedido
CREATE TABLE pedido (
    id INT IDENTITY(1,1),
    total FLOAT NOT NULL,
    fecha DATE,
    id_cliente INT NOT NULL,
    id_comercial INT NOT NULL,
    CONSTRAINT pk_pedido PRIMARY KEY (id),
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id),
    CONSTRAINT fk_pedido_comercial FOREIGN KEY (id_comercial) REFERENCES comercial(id)
);
GO

-- Insertar datos en la tabla cliente
INSERT INTO cliente (nombre, apellido1, apellido2, ciudad, categoria) VALUES
('Aarón', 'Rivero', 'Gómez', 'Almería', 100),
('Adela', 'Salas', 'Díaz', 'Granada', 200),
('Adolfo', 'Rubio', 'Flores', 'Sevilla', NULL),
('Adrián', 'Suárez', NULL, 'Jaén', 300),
('Marcos', 'Loyola', 'Méndez', 'Almería', 200),
('María', 'Santana', 'Moreno', 'Cádiz', 100),
('Pilar', 'Ruiz', NULL, 'Sevilla', 300),
('Pepe', 'Ruiz', 'Santana', 'Huelva', 200),
('Guillermo', 'López', 'Gómez', 'Granada', 225),
('Daniel', 'Santana', 'Loyola', 'Sevilla', 125);
GO

-- Insertar datos en la tabla comercial
INSERT INTO comercial (nombre, apellido1, apellido2, comision) VALUES
('Daniel', 'Sáez', 'Vega', 0.15),
('Juan', 'Gómez', 'López', 0.13),
('Diego', 'Flores', 'Salas', 0.11),
('Marta', 'Herrera', 'Gil', 0.14),
('Antonio', 'Carretero', 'Ortega', 0.12),
('Manuel', 'Domínguez', 'Hernández', 0.13),
('Antonio', 'Vega', 'Hernández', 0.11),
('Alfredo', 'Ruiz', 'Flores', 0.05);
GO

-- Insertar datos en la tabla pedido
INSERT INTO pedido (total, fecha, id_cliente, id_comercial) VALUES
(150.5, '2017-10-05', 5, 2),
(270.65, '2016-09-10', 1, 5),
(65.26, '2017-10-05', 2, 1),
(110.5, '2016-08-17', 8, 3),
(948.5, '2017-09-10', 5, 2),
(2400.6, '2016-07-27', 7, 1),
(5760, '2015-09-10', 2, 1),
(1983.43, '2017-10-10', 4, 6),
(2480.4, '2016-10-10', 8, 3),
(250.45, '2015-06-27', 8, 2),
(75.29, '2016-08-17', 3, 7),
(3045.6, '2017-04-25', 2, 1),
(545.75, '2019-01-25', 6, 1),
(145.82, '2017-02-02', 6, 1),
(370.85, '2019-03-11', 1, 5),
(2389.23, '2019-03-11', 1, 5);
GO
