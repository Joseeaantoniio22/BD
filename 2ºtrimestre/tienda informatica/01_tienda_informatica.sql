-- Eliminar la base de datos tienda_informatica si existe
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'tienda_informatica')
BEGIN
    DROP DATABASE tienda_informatica;
END;
GO

-- Crear y usar la base de datos tienda_informatica
CREATE DATABASE tienda_informatica;
GO

USE tienda_informatica;
GO

-- Crear la tabla fabricante
CREATE TABLE fabricante (
  codigo INT NOT NULL,
  nombre NVARCHAR(255) NOT NULL, 
  CONSTRAINT pk_fabricante PRIMARY KEY (codigo),
);
GO

-- Crear la tabla producto
CREATE TABLE producto (
  codigo INT NOT NULL,
  nombre NVARCHAR(255) NOT NULL,
  precio DECIMAL(10, 2) NOT NULL,
  cod_fabricante INT NOT NULL,
  CONSTRAINT pk_producto PRIMARY KEY (codigo),
  CONSTRAINT fk_producto_fabricante FOREIGN KEY (cod_fabricante) REFERENCES fabricante(codigo)
);
GO

-- Insertar datos en la tabla fabricante
INSERT INTO fabricante(codigo, nombre) VALUES (1, 'Sony');
INSERT INTO fabricante(codigo, nombre) VALUES (2, 'Creative Labs');
INSERT INTO fabricante(codigo, nombre) VALUES (3, 'Hewlett-Packard');
INSERT INTO fabricante(codigo, nombre) VALUES (4, 'Iomega');
INSERT INTO fabricante(codigo, nombre) VALUES (5, 'Fujitsu');
INSERT INTO fabricante(codigo, nombre) VALUES (6, 'Winchester');
INSERT INTO fabricante(codigo, nombre) VALUES (7, 'Samsung');
INSERT INTO fabricante(codigo, nombre) VALUES (8, 'LG');
INSERT INTO fabricante(codigo, nombre) VALUES (9, 'Seagate');
INSERT INTO fabricante(codigo, nombre) VALUES (10, 'Western Digital');
INSERT INTO fabricante(codigo, nombre) VALUES (11, 'Asus');
INSERT INTO fabricante(codigo, nombre) VALUES (12, 'Acer');
GO

-- Insertar datos en la tabla producto
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (1, 'Hard drive', 240, 5);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (2, 'Memory', 120, 6);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (3, 'ZIP drive', 150, 4);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (4, 'Floppy disk', 5, 6);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (5, 'Monitor', 240, 1);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (6, 'DVD drive', 180, 2);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (7, 'CD drive', 90, 2);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (8, 'Printer', 270, 3);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (9, 'Toner cartridge', 66, 3);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (10, 'DVD burner', 180, 2);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (11, 'DVD +R', 15, 2);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (12, 'DVD -R', 15, 2);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (13, 'CD +R', 10, 2);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (14, 'CD -R', 10, 2);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (15, 'External Hard Drive', 120, 5);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (16, 'USB Flash Drive 32GB', 25, 7);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (17, 'USB Flash Drive 64GB', 45, 7);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (18, 'Blu-Ray Drive', 90, 1);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (19, 'Graphics Card', 300, 11);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (20, 'SSD 500GB', 150, 9);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (21, 'SSD 1TB', 280, 9);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (22, 'Monitor 24-inch', 200, 8);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (23, 'Monitor 27-inch', 320, 8);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (24, 'RAM 8GB', 60, 6);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (25, 'RAM 16GB', 120, 6);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (26, 'Wireless Mouse', 25, 12);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (27, 'Wireless Keyboard', 30, 12);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (28, 'Gaming Headset', 85, 3);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (29, 'Laptop 15-inch', 800, 10);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (30, 'Laptop 13-inch', 900, 10);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (31, 'Desktop PC', 700, 11);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (32, 'Gaming Desktop', 1500, 12);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (33, 'DVD RW', 25, 1);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (34, 'CD RW', 20, 2);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (35, 'Printer Ink', 30, 3);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (36, 'Scanner', 100, 5);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (37, 'Smartphone', 600, 7);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (38, 'Tablet', 350, 8);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (39, 'Router', 70, 9);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (40, 'External SSD 1TB', 300, 4);
INSERT INTO producto(codigo, nombre, precio, cod_fabricante) VALUES (41, 'DVD +R', 13, 8);
GO