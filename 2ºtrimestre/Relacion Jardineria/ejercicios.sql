-- Jose Antonueio Fern�ndez Guerrero
USE jardineria

-- Ejercicio 01
INSERT INTO oficina (codigo_oficina, pais, ciudad, region, codigo_postal, telefono, linea_direccion1, linea_direccion2)
VALUES (12345, 'Espa�a', 'Almeria', 'Almeria', 04001, 654321380, 'calle espa�a n�25', 'avenida andalucia');

--Ejercicio 02
INSERT INTO empleado(codigo_empleado, nombre, apellido1, apellido2, extension, email, codigo_oficina, codigo_jefe, puesto)
VALUES	 (2005, 'Jose', 'Garcia', 'Ramirez', 'Espa�ol', 'jose@gmail.com', 12345, 2005, 'Representante de ventas');

--EJERCICIO 03
INSERT INTO cliente (codigo_cliente, nombre_cliente, nombre_contacto, apellido_contacto, telefono, fax, linea_direccion1, linea_direccion2, ciudad, region, pais, codigo_postal
,codigo_empleado_rep_ventas, limite_credito)
VALUES (1234, 'Andres', 'Juan', 'Vaquero', 696548721, 666, 'Calle granada', 'Calle marmoles', 'Almeria', 'Almeria', 'Espa�a', 04002, 2005, 10000);

--Ejercicio 04
INSERT INTO	pedido (codigo_pedido, fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, codigo_cliente)
VALUES (54321, '10/10/2025', '22/10/2025', '20/10/2025', 'Entregado', 'Entregar de noche', 1234);

INSERT INTO linea_pedido (codigo_pedido, codigo_producto, cantidad, precio_unidad, numero_linea)
VALUES	(54321, 'FR-21', 1, 4.00,1 );

INSERT INTO linea_pedido (codigo_pedido, codigo_producto, cantidad, precio_unidad, numero_linea)
VALUES	(54321, 'FR-22', 1, 4.00,2 );

--Ejercicio 05
UPDATE cliente
SET codigo_cliente=40
WHERE codigo_cliente=1234;

ALTER TABLE pedido
DROP CONSTRAINT fk_pedido_cliente;

ALTER TABLE pedido
ADD CONSTRAINT fk_pedido_cliente
FOREIGN KEY (codigo_cliente)
REFERENCES cliente(codigo_cliente)
ON UPDATE CASCADE;

--No es posible actualizarlo porque tienes que borrar la clave for�nea para poder poner el update cascade
--para que se actualicen todos los datos relacionados. Y ya te dejar�a

--Ejercicio 06

--No es posible actualizarlo porque tienes que borrar la clave for�nea para poder poner el delete cascade
--para que se puedan borrar todos los datos relacionados. Y ya te dejar�a

DELETE FROM cliente
WHERE codigo_cliente=40;

ALTER TABLE pedido
DROP CONSTRAINT fk_pedido_cliente;

ALTER TABLE pedido
ADD CONSTRAINT fk_pedido_cliente
FOREIGN KEY (codigo_cliente)
REFERENCES cliente(codigo_cliente)

ALTER TABLE linea_pedido
DROP CONSTRAINT fk_linea_pedido_pedido;

ALTER TABLE linea_pedido
ADD CONSTRAINT fk_linea_pedido_pedido
FOREIGN KEY (codigo_pedido)
REFERENCES pedido(codigo_pedido)
ON DELETE CASCADE;

--Ejercicio 07
ALTER TABLE linea_pedido
ADD total_linea DECIMAL (12,2);

UPDATE linea_pedido
SET total_linea = precio_unidad * cantidad * (1+21/100);

--Ejercicio 08
INSERT INTO oficina (codigo_oficina, pais, ciudad, region, codigo_postal, telefono, linea_direccion1, linea_direccion2)
VALUES (2345, 'Espa�a', 'Granada', 'Granada', 18001, 654321381, 'calle espa�a n�25', 'avenida andalucia');

INSERT INTO empleado(codigo_empleado, nombre, apellido1, apellido2, extension, email, codigo_oficina, codigo_jefe, puesto)
VALUES	 (2006, 'Adrian', 'Garcia', 'Ramirez', 'Espa�ol', 'adrian@gmail.com', 2345, 2006, 'Representante de ventas');

INSERT INTO empleado(codigo_empleado, nombre, apellido1, apellido2, extension, email, codigo_oficina, codigo_jefe, puesto)
VALUES	 (2007, 'Daniel', 'Garcia', 'Vaquero', 'Espa�ol', 'daniel@gmail.com', 2345, 2007, 'Representante de ventas');

INSERT INTO empleado(codigo_empleado, nombre, apellido1, apellido2, extension, email, codigo_oficina, codigo_jefe, puesto)
VALUES	 (2008, 'Miguel', 'Romero', 'Ramirez', 'Espa�ol', 'miguel@gmail.com', 2345, 2008, 'Representante de ventas');

--Ejercicio 09
INSERT INTO cliente (codigo_cliente, nombre_cliente, nombre_contacto, apellido_contacto, telefono, fax, linea_direccion1, linea_direccion2, ciudad, region, pais, codigo_postal
,codigo_empleado_rep_ventas, limite_credito)
VALUES (1235, 'Sofia', 'Sofia', 'Florido', 696589054, 666, 'Calle granada', 'Calle marmoles', 'Almeria', 'Almeria', 'Espa�a', 04009, 2006, 10000);

INSERT INTO cliente (codigo_cliente, nombre_cliente, nombre_contacto, apellido_contacto, telefono, fax, linea_direccion1, linea_direccion2, ciudad, region, pais, codigo_postal
,codigo_empleado_rep_ventas, limite_credito)
VALUES (1236, 'Juan', 'Juan', 'Vaquero', 696501721, 666, 'Calle granada', 'Calle marmoles', 'Almeria', 'Almeria', 'Espa�a', 18010, 2007, 10000);

INSERT INTO cliente (codigo_cliente, nombre_cliente, nombre_contacto, apellido_contacto, telefono, fax, linea_direccion1, linea_direccion2, ciudad, region, pais, codigo_postal
,codigo_empleado_rep_ventas, limite_credito)
VALUES (1237, 'Carlos', 'Carlos', 'Vaquero', 696540021, 666, 'Calle granada', 'Calle marmoles', 'Almeria', 'Almeria', 'Espa�a', 18190, 2008, 10000);

--Ejercicio 10
DELETE FROM cliente
WHERE codigo_cliente=1235;

--En este caso si me ha dejado de borrar a la primera el cliente ya que hab�a realizado anteriormente
-- el DELETE CASCADE. Solo ha cambiado la tabla cliente ya que he borrado el cliente y no aparece, en las otras tablas no he notado ning�n cambio.