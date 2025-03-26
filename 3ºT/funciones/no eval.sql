USE tienda_informatica;

--EJERCICIO 01
CREATE PROCEDURE ejercicio01
AS
BEGIN
DECLARE @productos int
	SET @productos = (
		SELECT COUNT(*)
		FROM producto
	)
	PRINT(CONCAT('En la base de datos hay ',@productos,' productos'))
END

DROP PROCEDURE ejercicio01;

EXEC ejercicio01;

--EJERCICIO 02
CREATE PROCEDURE ejercicio02
@codFabricante INT
AS
BEGIN 
DECLARE @media FLOAT
	set	 @media = (
		SELECT CAST(AVG(precio) AS DECIMAL(4,2))
		FROM producto
		WHERE cod_fabricante=@codFabricante
	)

	PRINT(CONCAT('El precio medio de los prodecutos del fabricante ',@codFabricante,' es: ',@media));
END

EXEC ejercicio02 @codFabricante=2;

--EJERCICIO 03
 CREATE PROCEDURE ejercicio03
 @codFabricante INT
 AS
 BEGIN
	DECLARE @precio FLOAT
	SET @precio = (
		SELECT MAX(precio)
		FROM producto
		WHERE cod_fabricante = @codFabricante
	)
	PRINT(CONCAT('El precio máximo de los productos del fabricante ',@codFabricante,' es: ',@precio));

 END

 EXEC ejercicio03 @codFabricante = 3