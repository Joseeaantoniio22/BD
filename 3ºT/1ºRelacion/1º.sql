--JOSE ANTONIO FERNANDEZ GUERRERO
USE ventas;

--EJERCICIO 01
DECLARE @numero INT;
SET @numero =
(SELECT COUNT(*)
FROM comercial
WHERE 1<=(
	SELECT COUNT(*)
	FROM cliente
	WHERE id IN (SELECT id_cliente
		FROM pedido
		WHERE id_comercial = comercial.id)AND ciudad='Granada'))

PRINT(CONCAT('El numero de comerciales con clientes en Granada es: ', @numero))

--EJERCICIO 02
DECLARE @numPedido INT;
DECLARE @totalPedidos INT;

SET @numPedido =
(
SELECT COUNT(*)
FROM comercial
INNER JOIN pedido ON comercial.id = pedido.id_comercial
INNER JOIN	cliente ON cliente.id = pedido.id_cliente
WHERE cliente.ciudad = 'Almería'
)

PRINT(CONCAT('El número de pedidos realizados por comerciales con clientes en Almería es: ', @numPedido))

SET @totalPedidos = (
SELECT COUNT(*)
FROM comercial
INNER JOIN pedido ON comercial.id = pedido.id_comercial
INNER JOIN	cliente ON cliente.id = pedido.id_cliente
WHERE comercial.nombre='Antonio' AND comercial.apellido1='Carretero' AND comercial.apellido2='Ortega'
)

PRINT(CONCAT('El total de los pedidos hechos por el comercial Antonio Carretero Ortega: ', @totalPedidos))

--EJERCICIO 03
DECLARE @comision INT;
SET @comision = (
SELECT TOP(1) id
FROM comercial
ORDER BY comision DESC
)

PRINT(CONCAT('El codigo del empleado con la comisión más alta es: ',@comision))

--EJERCICIO 04
DECLARE @id INT;
DECLARE @numPedidos;

SET @id = (

)

