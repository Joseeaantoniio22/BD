-- Eliminar la base de datos instituto si existe
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'instituto')
BEGIN
    DROP DATABASE instituto;
END;
GO

-- Crear y usar la base de datos instituto
CREATE DATABASE instituto;
GO

USE instituto;
GO

-- Creación de la tabla alumno
CREATE TABLE alumno (
    id INT IDENTITY(1,1),
    nombre NVARCHAR(100) NOT NULL,
    apellido1 NVARCHAR(100) NOT NULL,
    apellido2 NVARCHAR(100),
    fecha_nacimiento DATE NOT NULL,
    es_repetidor NVARCHAR(2) NOT NULL,
    teléfono NVARCHAR(9),
    CONSTRAINT pk_alumno PRIMARY KEY (id),
    CONSTRAINT ck_alumno_es_repetidor CHECK (es_repetidor IN ('sí', 'no'))
);
GO

-- Insertar datos en la tabla alumno
INSERT INTO alumno (nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, teléfono) VALUES 
('María', 'Sánchez', 'Pérez', '1990-12-01', 'no', NULL),
('Juan', 'Sáez', 'Vega', '1998-04-02', 'no', '618253876'),
('Pepe', 'Ramírez', 'Gea', '1988-01-03', 'no', NULL),
('Lucía', 'Sánchez', 'Ortega', '1993-06-13', 'sí', '678516294'),
('Paco', 'Martínez', 'López', '1995-11-24', 'no', '692735409'),
('Irene', 'Gutiérrez', 'Sánchez', '1991-03-28', 'sí', NULL),
('Cristina', 'Fernández', 'Ramírez', '1996-09-17', 'no', '628349590'),
('Antonio', 'Carretero', 'Ortega', '1994-05-20', 'sí', '612345633'),
('Manuel', 'Domínguez', 'Hernández', '1999-07-08', 'no', NULL),
('Daniel', 'Moreno', 'Ruiz', '1998-02-03', 'no', NULL);
GO
