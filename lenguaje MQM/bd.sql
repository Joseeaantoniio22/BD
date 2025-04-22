CREATE DATABASE MasQueMotor;
USE MasQueMotor;

CREATE TABLE cliente(
	cod_cliente INT IDENTITY(1,1),
	nombre NVARCHAR(100),
	ciudad NVARCHAR(100),
	pais NVARCHAR(100),
	DNI NVARCHAR(9), 
	telefono INT, 
	constrasena NVARCHAR(200),
	correo NVARCHAR(100),
	codPostal INT
	CONSTRAINT pk_codCliente_cliente PRIMARY KEY (cod_cliente)

);
