-- Eliminar la base de datos grandes_almacenes si existe
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'grandes_almacenes')
BEGIN
    DROP DATABASE grandes_almacenes;
END;
GO

-- Crear y usar la base de datos grandes_almacenes
CREATE DATABASE grandes_almacenes;
GO

USE grandes_almacenes;
GO

-- Creación de la tabla cajero
CREATE TABLE cajero (
   codigo INT NOT NULL,
   nombrecompleto CHAR(255) NOT NULL,
   CONSTRAINT pk_cajero PRIMARY KEY (codigo)
);
GO

-- Creación de la tabla producto
CREATE TABLE producto (
   codigo INT NOT NULL,
   nombre CHAR(100) NOT NULL,
   precio INT,
   CONSTRAINT pk_producto PRIMARY KEY (codigo)
);
GO

-- Creación de la tabla maquina_registradora
CREATE TABLE maquina_registradora (
   codigo INT NOT NULL,
   piso INT,
   CONSTRAINT pk_maquina_registradora PRIMARY KEY (codigo)
);
GO

-- Creación de la tabla venta
CREATE TABLE venta (
   cajero INT NOT NULL,
   maquina INT NOT NULL,
   producto INT NOT NULL,
   CONSTRAINT pk_venta PRIMARY KEY (cajero, maquina, producto),
   CONSTRAINT fk_venta_cajero FOREIGN KEY (cajero) REFERENCES cajero(codigo),
   CONSTRAINT fk_venta_maquina FOREIGN KEY (maquina) REFERENCES maquina_registradora(codigo),
   CONSTRAINT fk_venta_producto FOREIGN KEY (producto) REFERENCES producto(codigo)
);
GO

-- Insertar datos en la tabla cajero
INSERT INTO cajero(codigo, nombrecompleto) 
VALUES (1, 'Michael Rogers'),
       (2, 'Anand Manikutty'),
       (3, 'Carol Smith'),
       (4, 'Joe Stevens'),
       (5, 'Mary-Anne Foster'),	
       (6, 'George ODonnell'),
       (7, 'John Doe'),
       (8, 'David Smith'),
       (9, 'Zacary Efron'),
       (10, 'Eric Goldsmith'),
       (11, 'Elizabeth Doe'),
       (12, 'Kumar Swamy'),
       (13, 'Alice Johnson'),
       (14, 'Bob Brown'),
       (15, 'Cathy White'),
       (16, 'Daniel Green'),
       (17, 'Eva Black'),
       (18, 'Frank Blue'),
       (19, 'Grace Yellow'),
       (20, 'Henry Gray'),
       (21, 'Ivy Pink'),
       (22, 'Jack Orange'),
       (23, 'Kathy Purple'),
       (24, 'Leo Cyan'),
       (25, 'Mona Magenta'),
       (26, 'Nina Teal'),
       (27, 'Oscar Brown'),
       (28, 'Paul Red'),
       (29, 'Quinn Silver'),
       (30, 'Rita Gold');
GO

-- Insertar datos en la tabla producto
INSERT INTO producto(codigo, nombre, precio)
VALUES (1, 'Smartphone Samsung Galaxy S21', 799),
       (2, 'Laptop HP Pavilion', 999),
       (3, 'Televisor LG 55" 4K', 599),
       (4, 'Refrigerador Samsung 350L', 1200),
       (5, 'Camiseta Nike Dri-FIT', 29),
       (6, 'Zapatillas Adidas Running', 85),
       (7, 'Audífonos Sony WH-1000XM4', 299),
       (8, 'Promo reloj Apple Watch Series 6', 399),
       (9, 'Tablet Amazon Fire 7', 49),
       (10, 'Microondas Panasonic Inverter Premium', 149),
       (11, 'Colchón Memory Foam King Size', 600),
       (12, 'Lavadora LG 15 kg', 800),
       (13, 'Guitarra Fender Stratocaster', 699),
       (14, 'Juguete LEGO Star Wars', 99),
       (15, 'Cafetera Nespresso Vertuo', 199),
       (16, 'Bicicleta Montaña Trek', 1200),
       (17, 'Perfume Especial Chanel N°5', 115),
       (18, 'Aspiradora Dyson V11', 499),
       (19, 'Router Wi-Fi TP-Link AX6000', 250),
       (20, 'Silla Gamer Razer Iskur', 400),
       (21, 'Licuadora Oster Pro', 89),
       (22, 'Parrilla Eléctrica George Foreman', 69),
       (23, 'Promo camisa Casual Tommy Hilfiger', 55),
       (24, 'Premium Cámara Canon EOS Rebel T7', 450),
       (25, 'Maleta Samsonite Spinner', 120),
       (26, 'Purificador de Aire Philips', 199),
       (27, 'Plancha Premium de Vapor Rowenta', 60),
       (28, 'Promo juego de Ollas T-fal', 75),
       (29, 'Tostadora Hamilton Beach', 30),
       (30, 'Hervidor de Agua Eléctrico Cuisinart', 40);
GO

-- Insertar datos en la tabla maquina_registradora
INSERT INTO maquina_registradora(codigo, piso)
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (4, 4),
       (5, 5),
       (6, 6),
       (7, 7),
       (8, 8),
       (9, 9),
       (10, 10),
       (11, 11),
       (12, 12),
       (13, 13),
       (14, 14),
       (15, 15),
       (16, 16),
       (17, 17),
       (18, 18),
       (19, 19),
       (20, 20),
       (21, 21),
       (22, 22),
       (23, 23),
       (24, 24),
       (25, 25),
       (26, 26),
       (27, 27),
       (28, 28),
       (29, 29),
       (30, 30);
GO

-- Insertar datos en la tabla venta
INSERT INTO venta(cajero, maquina, producto)
VALUES (1, 1, 1),
       (1, 1, 2),
       (2, 12, 1),
       (2, 12, 2),
       (2, 12, 3),
       (3, 13, 4),
       (3, 14, 5),
       (4, 15, 6),
       (4, 15, 7),
       (5, 11, 8),
       (5, 10, 9),
       (6, 1, 10),
       (6, 2, 11),
       (7, 3, 12),
       (7, 4, 13),
       (8, 5, 14),
       (9, 6, 15),
       (10, 7, 16),
       (11, 8, 17),
       (12, 9, 18),
       (13, 10, 19),
       (14, 11, 20),
       (15, 12, 21),
       (16, 13, 22),
       (17, 14, 23),
       (18, 15, 24),
       (19, 16, 25),
       (20, 17, 26),
       (21, 18, 27),
       (22, 19, 28),
       (23, 20, 29),
       (24, 21, 30);
GO