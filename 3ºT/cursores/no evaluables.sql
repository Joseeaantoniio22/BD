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
CREATE PROCEDURE ejercicio02
@metodoPago NVARCHAR(40)
AS
BEGIN 
	DECLARE @cliente NVARCHAR(50);
	DECLARE @id_transaccion NVARCHAR(50);
	DECLARE @fecha DATE;
	DECLARE @cantidad_pago FLOAT;

	DECLARE c_ejercicio02 CURSOR FOR 
		SELECT TOP 1
		pago_pedido.id_transaccion,
		pago_pedido.fecha_pago,
		pago.forma_pago,
		MAX(linea_pedido.cantidad*linea_pedido.precio_unidad) AS cantidad,
		cliente.nombre_cliente
		FROM pago_pedido
		INNER JOIN pago ON pago_pedido.codigo_pago=pago.codigo_pago
		INNER JOIN pedido ON pago_pedido.codigo_pedido=pedido.codigo_pedido
		INNER JOIN cliente ON pedido.codigo_cliente=cliente.codigo_cliente
		INNER JOIN linea_pedido ON pedido.codigo_pedido=linea_pedido.codigo_pedido
		GROUP BY pago_pedido.id_transaccion, pago_pedido.fecha_pago,
		pago.forma_pago, cliente.nombre_cliente
		HAVING pago.forma_pago='Tarjeta de crédito'
		order by cantidad DESC;
END

