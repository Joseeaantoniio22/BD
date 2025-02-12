-- EJERCICIO 01	
 ALTER TABLE venta
DROP CONSTRAINT fk_venta_cajero;

ALTER TABLE venta
ADD CONSTRAINT fk_venta_cajero
FOREIGN KEY (cajero)
REFERENCES cajero(codigo)
ON DELETE CASCADE;DELETE FROM cajero WHERE codigo='1';
-- EJERCICIO 02
ALTER TABLE	venta DROP CONSTRAINT fk_venta_producto;

ALTER TABLE venta
ADD CONSTRAINT fk_venta_producto
FOREIGN KEY (producto)
REFERENCES producto(codigo)
ON DELETE CASCADE;
DELETE FROM producto WHERE precio > 100

--EJERCICIO 03
DELETE FROM maquina_registradora WHERE piso='2';

-- EJERCICIO 04
DELETE FROM venta 
WHERE cajero=2;

--EJERCICIO 05	
DELETE FROM producto
WHERE nombre LIKE 'C%';

--EJERCICIO 06 
DELETE FROM cajero 
WHERE nombrecompleto = 'Kumar';

--EJERCICIO 07	
DELETE FROM producto
WHERE precio BETWEEN 50 AND 150;

-- EJERCICIO 08
DELETE FROM maquina_registradora
WHERE piso=3 OR piso=4;

--EJERCICIO 09
DELETE FROM venta
WHERE producto=5 OR maquina=3;

--EJERCICIO 10
delete from cajero
where codigo < 10 AND nombrecompleto='Joe';

--EJERCIO 11
delete from producto
where precio !=200;

--EJERCICIO 12
DELETE FROM maquina_registradora
WHERE piso<2

--EJERCICIO 13
DELETE FROM producto
WHERE nombre LIKE '%X';

--EJERCICIO 14
UPDATE producto SET precio=120
WHERE codigo=1;

--EJERCICIO 15	
UPDATE cajero SET nombrecompleto = 'Maria Lopez'
WHERE codigo=2;

--EJERCICIO 16
UPDATE maquina_registradora SET piso=2 
WHERE piso=3;

--EJERCICIO 17
UPDATE producto SET precio= precio+10;

--EJERCICIO 18
UPDATE producto SET nombre='Oferta'
WHERE nombre='promociones'

--EJERCICIO 19
UPDATE cajero SET nombrecompleto= nombrecompleto + 'Perez'
WHERE nombrecompleto LIKE 'F%';

--EJERCICIO 20


SELECT * FROM producto