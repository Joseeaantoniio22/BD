-- Eliminar la base de datos empleados si existe
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'empleados')
BEGIN
    DROP DATABASE empleados;
END;
GO

-- Crear y usar la base de datos empleados
CREATE DATABASE empleados;
GO

USE empleados;
GO

-- Crear la tabla departamento
CREATE TABLE departamento (
   codigo INT NOT NULL,
   nombre NVARCHAR(255) NOT NULL,
   presupuesto DECIMAL(18, 2) NOT NULL,
   gastos DECIMAL(18, 2) NOT NULL, 
   CONSTRAINT pk_departamento PRIMARY KEY (codigo)
);
GO

-- Crear la tabla empleado
CREATE TABLE empleado (
   dni NVARCHAR(9) NOT NULL,
   nombre NVARCHAR(255) NOT NULL,
   apellidos NVARCHAR(255) NOT NULL,
   departamento INT NOT NULL,
   CONSTRAINT pk_empleado PRIMARY KEY (dni),
   CONSTRAINT fk_departamento_codigo FOREIGN KEY(departamento) REFERENCES departamento(codigo)
);
GO

-- Insertar datos en la tabla departamento
INSERT INTO departamento (codigo, nombre, presupuesto, gastos) VALUES (14, 'IT', 65000, 25800);
INSERT INTO departamento (codigo, nombre, presupuesto, gastos) VALUES (37, 'Accounting', 15000, 2500);
INSERT INTO departamento (codigo, nombre, presupuesto, gastos) VALUES (59, 'Human Resources', 240000, 147500);
INSERT INTO departamento (codigo, nombre, presupuesto, gastos) VALUES (77, 'Research', 55000, 28000);
GO

-- Insertar datos en la tabla empleado
INSERT INTO empleado (dni, nombre, apellidos, departamento) VALUES ('12323487A', 'Michael', 'Rogers', 14);
INSERT INTO empleado (dni, nombre, apellidos, departamento) VALUES ('15293448B', 'Anand', 'Manikutty', 14);
INSERT INTO empleado (dni, nombre, apellidos, departamento) VALUES ('22236488C', 'Carol', 'Smith', 37);
INSERT INTO empleado (dni, nombre, apellidos, departamento) VALUES ('32658741D', 'Joe', 'Stevens', 37);
INSERT INTO empleado (dni, nombre, apellidos, departamento) VALUES ('33215471E', 'Mary-Anne', 'Foster', 14);
INSERT INTO empleado (dni, nombre, apellidos, departamento) VALUES ('33256984F', 'George', 'O''Donnell', 77);
INSERT INTO empleado (dni, nombre, apellidos, departamento) VALUES ('54652347G', 'John', 'Doe', 59);
INSERT INTO empleado (dni, nombre, apellidos, departamento) VALUES ('38382980M', 'David', 'Smith', 77);
INSERT INTO empleado (dni, nombre, apellidos, departamento) VALUES ('65487321H', 'Zacary', 'Efron', 59);
INSERT INTO empleado (dni, nombre, apellidos, departamento) VALUES ('74568521I', 'Eric', 'Goldsmith', 59);
INSERT INTO empleado (dni, nombre, apellidos, departamento) VALUES ('84565724J', 'Elizabeth', 'Doe', 14);
INSERT INTO empleado (dni, nombre, apellidos, departamento) VALUES ('84565724K', 'Kumar', 'Swamy', 14);
GO