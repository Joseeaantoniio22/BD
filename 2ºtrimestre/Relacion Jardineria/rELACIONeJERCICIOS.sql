--JOSE ANTONIO FERNANDEZ GUERRERO
USE jardineria

--EJERCICIO 01
SELECT ciudad, telefono
FROM oficina
WHERE pais='España';

--EJERCICIO 02
SELECT nombre, apellido1, apellido2, puesto
FROM empleado
WHERE puesto!='Representante Ventas';

--EJERCICIO 03
SELECT codigo_pedido, codigo_cliente, fecha_entrega, fecha_esperada
FROM pedido
WHERE DATEDIFF(DAY, fecha_entrega, fecha_esperada) >=2;

--EJERCICIO 04
SELECT *
FROM pedido
WHERE estado='Rechazado' AND YEAR(fecha_pedido)=2009;

--EJERCICIO 05
SELECT codigo_producto, nombre, gama, cantidad_en_stock, precio_venta
FROM producto
WHERE gama='Ornamentales' AND cantidad_en_stock>100
ORDER BY precio_venta DESC;

--EJERCICIO 06
SELECT codigo_cliente, nombre_cliente, ciudad, codigo_empleado_rep_ventas
FROM cliente
WHERE ciudad='Madrid' AND (codigo_empleado_rep_ventas=11 OR codigo_empleado_rep_ventas=30);

--EJERCICIO 07
SELECT nombre_cliente, CONCAT(empleado.nombre,'' , empleado.apellido1,' ', empleado.apellido2) AS nombre_completo_empleado
, oficina.ciudad AS ciudad_oficina
FROM cliente
INNER JOIN empleado ON cliente.codigo_empleado_rep_ventas=empleado.codigo_empleado
INNER JOIN oficina ON empleado.codigo_oficina=oficina.codigo_oficina


--EJERCICIO 08
SELECT cliente.nombre_cliente, pedido.fecha_entrega AS fecha_entrega
, pedido.fecha_esperada AS fecha_esperada
FROM cliente
INNER JOIN pedido ON cliente.codigo_cliente=pedido.codigo_cliente
WHERE DATEDIFF(DAY, fecha_entrega, fecha_esperada)<0;

--EJERCICIO 09
SELECT oficina.linea_direccion1, oficina.linea_direccion2, oficina.ciudad
FROM oficina
INNER JOIN empleado ON oficina.codigo_oficina=empleado.codigo_oficina
INNER JOIN cliente ON empleado.codigo_empleado=cliente.codigo_empleado_rep_ventas
WHERE cliente.ciudad='Fuenlabrada';

--EJERCICIO 10
SELECT cliente.nombre_cliente, gama_producto.gama AS gama
FROM cliente
INNER JOIN pedido ON cliente.codigo_cliente=pedido.codigo_cliente
INNER JOIN linea_pedido ON pedido.codigo_pedido=linea_pedido.codigo_pedido
INNER JOIN producto ON linea_pedido.codigo_producto=producto.codigo_producto
INNER JOIN gama_producto ON producto.gama=gama_producto.gama
GROUP BY cliente.nombre_cliente, gama_producto.gama
ORDER BY gama ASC;


--EJERCICIO 11
SELECT  oficina.codigo_oficina, oficina.ciudad, oficina.pais
FROM oficina
INNER JOIN empleado ON oficina.codigo_oficina=empleado.codigo_oficina
INNER JOIN cliente ON empleado.codigo_empleado=cliente.codigo_empleado_rep_ventas
INNER JOIN pedido ON cliente.codigo_cliente=pedido.codigo_cliente
INNER JOIN linea_pedido ON pedido.codigo_pedido=linea_pedido.codigo_pedido
INNER JOIN producto ON linea_pedido.codigo_producto=producto.codigo_producto
WHERE producto.gama='Frutales'
GROUP BY oficina.codigo_oficina, oficina.ciudad, oficina.pais;

--EJERCICIO 12
SELECT *
FROM empleado
LEFT JOIN cliente ON empleado.codigo_empleado=cliente.codigo_empleado_rep_ventas
WHERE cliente.codigo_empleado_rep_ventas IS NULL;

--EJERCICIO 13
SELECT CONCAT(empleado.nombre,' ', empleado.apellido1, ' ', empleado.apellido2)
AS nombre_empleado, CONCAT(jefe.nombre,' ', jefe.apellido1,' ',jefe.apellido2) AS nombre_jefe ,CONCAT(jefeDelJefe.nombre,' ',jefeDelJefe.apellido1,' ',jefeDelJefe.apellido2) AS nombre_jefe_jefe
FROM empleado
LEFT JOIN empleado jefe ON jefe.codigo_empleado=empleado.codigo_jefe
LEFT JOIN empleado jefeDelJefe ON jefe.codigo_jefe=jefeDelJefe.codigo_empleado
