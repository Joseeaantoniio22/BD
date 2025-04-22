USE jardineriav2;
--EJERCICIO 01
	CREATE PROCEDURE ejercicio01
	@pais NVARCHAR(50)
	AS
	BEGIN
		DECLARE @codigo_cliente NVARCHAR(100);
		DECLARE @nombre_cliente NVARCHAR(50);
		DECLARE @telefono NVARCHAR(15);
		DECLARE @ciudad NVARCHAR(50);

		DECLARE c_ejercicio01 CURSOR FOR
		SELECT codigo_cliente, nombre_cliente, telefono, ciudad
		FROM cliente
		WHERE pais=@pais

		OPEN c_ejercicio01;
		FETCH NEXT FROM 
		c_ejercicio01 INTO @codigo_cliente, @nombre_cliente, 
		@telefono, @ciudad;

		WHILE @@FETCH_STATUS = 0
		BEGIN
			PRINT('Pedido ID: '+@codigo_cliente+', Cliente: '+
			@nombre_cliente+', Telefono: '+@telefono+', Ciudad: '+@ciudad)
			FETCH NEXT FROM c_ejercicio01 INTO @codigo_cliente, 
			@nombre_cliente, @telefono, @ciudad;
		END

		CLOSE c_ejercicio01;
		DEALLOCATE c_ejercicio01;
	END

	DECLARE @pais NVARCHAR(50);
	SET @pais = 'Spain';
	EXEC ejercicio01 @pais;

--EJERCICIO 02
CREATE OR ALTER PROCEDURE ejercicio02
@metodoPago NVARCHAR(40)
AS
BEGIN 
	DECLARE @hayPago BIT;
	DECLARE @hayMetodo BIT;
	
	SET @hayMetodo = (
		SELECT COUNT(forma_pago)
		FROM pago
		WHERE forma_pago=@metodoPago

	)

	IF(@hayMetodo = 0)
	BEGIN
		THROW 50001, 'El metodo de pago seleccionado no existe',1;
		RETURN;
	END

	SET @hayPago = (
		SELECT COUNT(pedido.codigo_pedido)
		FROM pedido
		INNER JOIN pago_pedido ON pedido.codigo_pedido=pago_pedido.codigo_pedido
		INNER JOIN pago ON pago_pedido.codigo_pago=pago.codigo_pago
		WHERE pago.forma_pago=@metodoPago
	)

	IF(@hayPago=0)
	BEGIN
		PRINT(CONCAT('No se encontraron pagos realizados mediante ',@metodoPago))
	END	
	ELSE
	BEGIN
		
		DECLARE @cliente NVARCHAR(50);
		DECLARE @id_transaccion NVARCHAR(50);
		DECLARE @fecha DATE;
		DECLARE @cantidad_pago FLOAT;
		
		DECLARE c_ejercicio02 CURSOR FOR 
			SELECT TOP 1
			cliente.nombre_cliente,
			pago_pedido.id_transaccion,
			pago_pedido.fecha_pago,
			MAX(linea_pedido.cantidad*linea_pedido.precio_unidad) AS cantidad
			FROM pago_pedido
			INNER JOIN pago ON pago_pedido.codigo_pago=pago.codigo_pago
			INNER JOIN pedido ON pago_pedido.codigo_pedido=pedido.codigo_pedido
			INNER JOIN cliente ON pedido.codigo_cliente=cliente.codigo_cliente
			INNER JOIN linea_pedido ON pedido.codigo_pedido=linea_pedido.codigo_pedido
			GROUP BY pago_pedido.id_transaccion, pago_pedido.fecha_pago,
			pago.forma_pago, cliente.nombre_cliente
			HAVING pago.forma_pago=@metodoPago
			order by cantidad DESC;
	
			OPEN c_ejercicio02;
			FETCH NEXT FROM c_ejercicio02 INTO @cliente, 
			@id_transaccion, @fecha,
			@cantidad_pago;
	
			WHILE @@FETCH_STATUS = 0
			BEGIN
				PRINT(CONCAT('El pago de máximo valor realizado con la forma de ',@metodoPago,' es de ',@cantidad_pago))
				PRINT(CONCAT('Cliente: ',@cliente))
				PRINT(CONCAT('Fecha de pago: ',@fecha))
				PRINT(CONCAT('ID de transacción: ',@id_transaccion))
				FETCH NEXT FROM c_ejercicio02 INTO @cliente, 
				@id_transaccion, @fecha,
				@cantidad_pago; 
			END
			CLOSE c_ejercicio02;
			DEALLOCATE c_ejercicio02;
		END
END

	DECLARE @metodoPago NVARCHAR(40);
	SET @metodoPago = 'Tarjeta de crédito';
	EXEC ejercicio02 @metodoPago;


--EJERCICIO 03
CREATE OR ALTER PROCEDURE ejercicio03
@metodoPago NVARCHAR(40)
AS
BEGIN
	DECLARE @minPago FLOAT;
	DECLARE @maxPago FLOAT;
	DECLARE @medPago FLOAT;
	DECLARE @sumPago FLOAT;
	DECLARE @numeroPago INT;
	DECLARE @hayPago BIT;
	DECLARE @hayMetodo BIT;

	SET @sumPago = (
		SELECT  SUM(linea_pedido.cantidad*linea_pedido.precio_unidad) AS cantidad
		FROM pedido
			INNER JOIN linea_pedido ON linea_pedido.codigo_pedido=pedido.codigo_pedido
			INNER JOIN pago_pedido ON pedido.codigo_pedido=pago_pedido.codigo_pedido
			INNER JOIN pago ON pago_pedido.codigo_pago=pago.codigo_pago
		WHERE pago.forma_pago=@metodoPago
	)

	
	SET @numeroPago = (
		SELECT  COUNT(*) AS cantidad
		FROM pedido
			INNER JOIN pago_pedido ON pedido.codigo_pedido=pago_pedido.codigo_pedido
			INNER JOIN pago ON pago_pedido.codigo_pago=pago.codigo_pago
		WHERE pago.forma_pago=@metodoPago
	)

	SET @minPago = (
		SELECT TOP 1 SUM(linea_pedido.cantidad*linea_pedido.precio_unidad) AS cantidad
		FROM pedido
			INNER JOIN linea_pedido ON linea_pedido.codigo_pedido=pedido.codigo_pedido
			INNER JOIN pago_pedido ON pago_pedido.codigo_pedido=pedido.codigo_pedido
			INNER JOIN pago ON pago.codigo_pago=pago_pedido.codigo_pago
		WHERE pago.forma_pago=@metodoPago
		GROUP BY pedido.codigo_pedido
		ORDER BY cantidad ASC
	)

	SET @maxPago = (
		SELECT TOP 1 SUM(linea_pedido.cantidad*linea_pedido.precio_unidad) AS cantidad
		FROM pedido
			INNER JOIN linea_pedido ON linea_pedido.codigo_pedido=pedido.codigo_pedido
			INNER JOIN pago_pedido ON pago_pedido.codigo_pedido=pedido.codigo_pedido
			INNER JOIN pago ON pago.codigo_pago=pago_pedido.codigo_pago
		WHERE pago.forma_pago=@metodoPago
		GROUP BY pedido.codigo_pedido
		ORDER BY cantidad DESC
	)

	SET @medPago = (
		SELECT AVG(cantidad)
		FROM (
		SELECT	SUM(linea_pedido.cantidad*linea_pedido.precio_unidad) AS cantidad
		FROM pedido
			INNER JOIN linea_pedido ON linea_pedido.codigo_pedido=pedido.codigo_pedido
			INNER JOIN pago_pedido ON pago_pedido.codigo_pedido=pedido.codigo_pedido
			INNER JOIN pago ON pago.codigo_pago=pago_pedido.codigo_pago
		WHERE pago.forma_pago=@metodoPago
		GROUP BY pedido.codigo_pedido) as algo
	)

	SET @hayMetodo = (
		SELECT COUNT(forma_pago)
		FROM pago
		WHERE forma_pago=@metodoPago

	)

	IF(@hayMetodo = 0)
	BEGIN
		THROW 50002, 'No se encontraron metodos de pagos',1;
		RETURN;
	END

	SET @hayPago = (
		SELECT COUNT(pedido.codigo_pedido)
		FROM pedido
			INNER JOIN pago_pedido ON pedido.codigo_pedido=pago_pedido.codigo_pedido
			INNER JOIN pago ON pago_pedido.codigo_pago=pago.codigo_pago
		WHERE pago.forma_pago=@metodoPago
	)

	IF(@hayPago=0)
	BEGIN
		PRINT(CONCAT('No se encontraron pagos realizados mediante ',@metodoPago))
	END	
	ELSE
	BEGIN
		PRINT(CONCAT('Estadísticas para la forma de pago: ', @metodoPago))
		PRINT('-----------------------------------------------------------------')
		PRINT(CONCAT('Pago de máximo valor: ',@maxPago,' Euros'))
		PRINT(CONCAT('Pago de mínimo valor: ',@minPago,' Euros'))
		PRINT(CONCAT('Valor medio de los pagos: ',@medPago,' Euros'))
		PRINT(CONCAT('Suma total de los pagos: ',@sumPago,' Euros'))
		PRINT(CONCAT('Número de pagos realizados: ',@numeroPago))
	END

END

	DECLARE @metodoPago NVARCHAR(40);
	SET @metodoPago = 'trueque';
	EXEC ejercicio03 @metodoPago;

--EJERCICIO 04
CREATE OR ALTER PROCEDURE ejercicio04
@cod_pedido INT
AS
BEGIN
	DECLARE @fechaPedido DATE;
	DECLARE @fechaEsperada DATE;
	DECLARE @fechaEntrega DATE;
	DECLARE @estado NVARCHAR(50);
	DECLARE @comentarios NVARCHAR(40);
	DECLARE @cliente NVARCHAR(100);
	DECLARE @formaPago NVARCHAR(100);

	SET @fechaPedido = (
		SELECT fecha_pedido
		FROM pedido
		WHERE codigo_pedido=@cod_pedido
	)

	SET @fechaEsperada = (
		SELECT fecha_esperada
		FROM pedido
		WHERE codigo_pedido=@cod_pedido
	)

	SET @fechaEntrega = (
		SELECT fecha_entrega
		FROM pedido
		WHERE codigo_pedido=@cod_pedido
	)

	SET @estado = (
		SELECT estado
		FROM pedido
		WHERE codigo_pedido=@cod_pedido
	)

	SET @comentarios = (
		SELECT comentarios
		FROM pedido
		WHERE codigo_pedido=@cod_pedido
	)

	SET @cliente = (
		SELECT cliente.nombre_cliente
		FROM pedido
		INNER JOIN cliente ON cliente.codigo_cliente=pedido.codigo_cliente
		WHERE pedido.codigo_pedido=24
	)

	SET @formaPago = (
		SELECT pago.forma_pago
		FROM pedido
		INNER JOIN pago_pedido ON pago_pedido.codigo_pedido=pedido.codigo_pedido
		INNER JOIN pago ON pago.codigo_pago=pago_pedido.codigo_pago
		WHERE pedido.codigo_pedido= 24
	)

	PRINT('Datos del pedido: ')
	PRINT('--------------------')
	PRINT(CONCAT('Código de pedido: ',@cod_pedido))
	PRINT(CONCAT('Fecha de pedido: ', @fechaPedido))
	PRINT(CONCAT('Fecha esperada: ', @fechaEsperada))
	PRINT(CONCAT('Fecha de entrega: ', @fechaEntrega))
	PRINT(CONCAT('Estado: ', @estado))
	PRINT(CONCAT('Comentarios: ', @comentarios))
	PRINT(CONCAT('Cliente: ', @cliente))
	PRINT(CONCAT('Forma de pago: ', @formaPago))
	PRINT('Líneas de pedido: ')
	PRINT('-----------------')
	PRINT('Número de línea | Nombre del producto | Cantidad |
	Precio por unidad | Total de la línea')
	PRINT('----------------------------------------------------------------------------------------------')

	DECLARE @numeroLinea INT;
	DECLARE @nombre NVARCHAR(50);
	DECLARE @cantidad INT;
	DECLARE @precioUnidad FLOAT;
	DECLARE @total FLOAT;

	DECLARE c_ejercicio04 CURSOR FOR
	SELECT 
		numero_linea, producto.nombre, cantidad, precio_unidad, precio_unidad*cantidad AS total
	FROM linea_pedido
	INNER JOIN producto ON linea_pedido.codigo_producto=producto.codigo_producto
	where codigo_pedido=@cod_pedido

	OPEN c_ejercicio04;

	FETCH NEXT FROM c_ejercicio04 INTO
	@numeroLinea, @nombre, @cantidad, @precioUnidad, @total;

	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT(CONCAT(@numeroLinea,' | ',@nombre,' | ',@cantidad,' | ', @precioUnidad,' | ', @total));
		FETCH NEXT FROM c_ejercicio04 INTO 
		@numeroLinea, @nombre, @cantidad, @precioUnidad, @total;
	END
	CLOSE c_ejercicio04;
	DEALLOCATE c_ejercicio04;

END

	DECLARE @cod_pedido INT;
	SET @cod_pedido = 24;
	EXEC ejercicio04 @cod_pedido;



--Ejercicio 01
USE	universidad;

CREATE OR ALTER PROCEDURE ejercicio05
@nombre NVARCHAR(50),
@apellido1 NVARCHAR(50),
@apellido2 NVARCHAR(50),
@departamento NVARCHAR(50)

AS
BEGIN
	DECLARE @hayProfesor INT;

	SET @hayProfesor = (
		SELECT COUNT(*)
		FROM persona
		WHERE nombre = @nombre AND apellido1 = @apellido1
		AND apellido2 = @apellido2
	)

	IF(@hayProfesor=0)
	BEGIN 
		THROW 50003, 'El profesor o profesora no existe en la base de datos',1;
		RETURN;
	END
	ELSE
	BEGIN

		DECLARE @sexo CHAR(1);
		SET @sexo=(
			SELECT sexo
			FROM persona
			WHERE nombre = @nombre AND apellido1 = @apellido1
			AND apellido2 = @apellido2
		)
	
		DECLARE @idPersona INT;
		DECLARE @idDepartamento INT;

		SET @idPersona = (
			SELECT id
			FROM persona
			WHERE nombre = @nombre AND apellido1 = @apellido1
			AND apellido2 = @apellido2
		)

		SET @idDepartamento = (
			SELECT id
			FROM departamento
			WHERE nombre = @departamento
		)

		UPDATE profesor
		SET id_departamento= @idDepartamento
		WHERE id_profesor=@idPersona

		IF(@sexo='M')
		BEGIN
			PRINT(CONCAT('La profesora ',@nombre,' ',@apellido1,' ',
			@apellido2, ' ha sido asiganda al departamento "',
			@departamento,'".'));
		END
		ELSE
		BEGIN
			PRINT(CONCAT('El profesor ',@nombre,' ',@apellido1,' ',
			@apellido2, ' ha sido asigando al departamento "',
			@departamento,'".'));
		END

	END
END

BEGIN
	DECLARE @nombre NVARCHAR(50);
	DECLARE @apellido1 NVARCHAR(50);
	DECLARE @apellido2 NVARCHAR(50);
	DECLARE @departamento NVARCHAR(50);
	SET @nombre = 'Cristina';
	SET @apellido1 = 'Lemke';
	SET @apellido2 = 'Rutherford';
	SET @departamento = 'Informática';
	EXEC ejercicio05 @nombre, @apellido1, @apellido2, @departamento;
END

--EJERCICIO02

CREATE OR ALTER PROCEDURE ejercicio06
@grado NVARCHAR(100)
AS
BEGIN
	DECLARE @hayGrado INT;
	SET @hayGrado = (
		SELECT COUNT(*)
		FROM grado
		WHERE nombre= @grado
	)

	IF(@hayGrado=0)
	BEGIN
		THROW 50004, 'El grado especificado no existe',1;
		RETURN;
	END
	ELSE
	BEGIN
		PRINT(CONCAT('Asignaturas del grado "',@grado,'":'))

	END
END
