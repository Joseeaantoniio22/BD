USE tienda_informatica
--EJERCICIO 01 
INSERT INTO fabricante(codigo, nombre) VALUES (123, 'newFabricante');

--EJERCICIO 02
INSERT INTO	producto(codigo, nombre, precio, cod_fabricante) VALUES	(888, 'lejia', 3.50, 123);

--EJERCICIO 03	
DELETE FROM fabricante
WHERE nombre='Asus';

ALTER TABLE producto
DROP CONSTRAINT fk_producto_fabricante;

 ALTER TABLE producto
 ADD CONSTRAINT fk_producto_fabricante
 FOREIGN KEY (cod_fabricante)
 REFERENCES fabricante(codigo)
 ON DELETE CASCADE; --EJERCICIO 04 DELETE FROM fabricante WHERE nombre='Xiaomi'; --EJERCICIO 05 UPDATE fabricante SET codigo=81  WHERE nombre='newFabricante';  ALTER TABLE producto DROP CONSTRAINT fk_producto_fabricante; ALTER TABLE producto ADD CONSTRAINT fk_producto_fabricante FOREIGN KEY (cod_fabricante) REFERENCES fabricante(codigo) ON UPDATE CASCADE; --EJERCICIO 06 UPDATE fabricante SET codigo=130 WHERE nombre='Huawei'; --EJERCICIO 07UPDATE producto SET precio=precio+5;--EJERCICIO 08 DELETE FROM productoWHERE nombre LIKE '%printer%' AND precio<200;--EJERCICIO 09DELETE FROM productoWHERE precio=5;--EJERCICIO 10DELETE FROM fabricanteWHERE codigo=6;--EJERCICIO 11DELETE FROM productoWHERE precio>200;--EJERCICIO 12DELETE FROM productoWHERE precio<=90;--EJERCICIO 13

SELECT * FROM producto
SELECT * FROM fabricante

