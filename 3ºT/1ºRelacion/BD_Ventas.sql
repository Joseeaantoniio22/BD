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