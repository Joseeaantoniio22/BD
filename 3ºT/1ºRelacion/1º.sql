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
WHERE cliente.ciudad = 'Almer�a'
)

PRINT(CONCAT('El n�mero de pedidos realizados por comerciales con clientes en Almer�a es: ', @numPedido))

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

PRINT(CONCAT('El codigo del empleado con la comisi�n m�s alta es: ',@comision))

--EJERCICIO 04
DECLARE @id INT = 1;
DECLARE @numPedidos INT;

SET @numPedidos = (
	SELECT COUNT(*)
	FROM cliente
	INNER JOIN pedido ON cliente.id = pedido.id_cliente
	WHERE pedido.id_cliente='1'
)

IF @numPedidos < 0
BEGIN
	PRINT (CONCAT('El cliente con ID ',@id,' no ha realizado ning�n pedido'));
END
ELSE
BEGIN 
	PRINT (CONCAT('El cliente con ID ',@id,' ha realizado ',@numPedidos,' pedidos'));
END

--EJERCICIO 05
DECLARE @id5 INT=1;
DECLARE @numPedidos5 INT;

SET @numPedidos5 = (
	SELECT COUNT(*)
	FROM cliente
	INNER JOIN pedido ON cliente.id = pedido.id_cliente
	WHERE pedido.id_cliente='1'
)

SELECT
CASE 
	WHEN @numPedidos5 = 0 THEN CONCAT('El cliente con ID ',@id5,' es un cliente nuevo')
	WHEN @numPedidos5<=5 AND @numPedidos5>=1 THEN CONCAT('El cliente con ID ',@id5,' es un cliente ocasional')
	WHEN @numPedidos5>5 THEN CONCAT('El cliente con ID ',@id5,' es un cliente frecuente')
END

--ejercicio 06
USE universidad;
DECLARE @grado NVARCHAR(255) = 'Grado en Ingenier�a Inform�tica (Plan 2015)';
DECLARE @incritos INT;

SET @incritos = (
SELECT COUNT(DISTINCT id_alumno)
from alumno_se_matricula_asignatura
INNER JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura=asignatura.id
INNER JOIN grado ON asignatura.id_grado=grado.id
WHERE grado.nombre= @grado
)

PRINT (CONCAT('Grado: ',@grado,' - Total de estudiantes inscritos: ',@incritos))

--EJERCICIO 07
DECLARE @asignatura NVARCHAR(255) = 'Introducci�n a la programaci�n';
DECLARE @inscritos7 INT;

SET @inscritos7 = (
SELECT COUNT(DISTINCT id_alumno)
FROM alumno_se_matricula_asignatura
INNER JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura=asignatura.id
WHERE asignatura.nombre=@asignatura
)

PRINT (CONCAT('Asignatura: ',@asignatura+' - Total de estudiantes inscritos: ',@inscritos7))

--EJERCICIO 08
DECLARE @asignatura8 NVARCHAR(255) = 'Introducci�n a la programaci�n';
DECLARE @inscritos8 INT;
DECLARE @hombres8 CHAR;
DECLARE @mujer8 CHAR;

SET @inscritos8 = (
SELECT COUNT(DISTINCT id_alumno)
FROM alumno_se_matricula_asignatura
INNER JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura=asignatura.id
WHERE asignatura.nombre=@asignatura8
)

SET @hombres8 = (
SELECT COUNT(DISTINCT id_alumno)
FROM alumno_se_matricula_asignatura
INNER JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura=asignatura.id
INNER JOIN persona ON alumno_se_matricula_asignatura.id_alumno=persona.id
WHERE asignatura.nombre='Introducci�n a la programaci�n' AND  persona.sexo='H'
)

SET @mujer8 = (
SELECT COUNT(DISTINCT id_alumno)
FROM alumno_se_matricula_asignatura
INNER JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura=asignatura.id
INNER JOIN persona ON alumno_se_matricula_asignatura.id_alumno=persona.id
WHERE asignatura.nombre='Introducci�n a la programaci�n' AND persona.sexo='M'
)

PRINT (CONCAT('Total de alumnos matriculados: ',@inscritos8))
PRINT (CONCAT('Total de hombre matriculados: ',@hombres8))
PRINT (CONCAT('Total de mujeres matriculadas: ',@mujer8))

--EJERCICIO 09
DECLARE @asignatura9 NVARCHAR(255) = 'Introducci�n a la programaci�n';
DECLARE @nombre9 NVARCHAR(255);
SET @nombre9 = (
	SELECT CONCAT(persona.nombre,' ', persona.apellido1,' ',persona.apellido2)
	FROM persona
	INNER JOIN profesor ON persona.id=profesor.id_profesor
	LEFT JOIN asignatura ON profesor.id_profesor=asignatura.id_profesor
	WHERE asignatura.nombre='Introducci�n a la programaci�n'
)

IF @nombre9 IS NULL
BEGIN
	PRINT(CONCAT('Profesor que imparte la asignatura "',@asignatura9,'" : "Sin profesor"'))
END
ELSE
BEGIN
	PRINT(CONCAT('Profesor que imparte la asignatura "',@asignatura9,'" : ',@nombre9))
END

--EJERCICIO 10
DECLARE @nombre10 NVARCHAR(255) = 'Salvador S�nchez';
DECLARE @asignatura10 NVARCHAR(255);
SET @asignatura10 = '�lgegra lineal y matem�tica discreta';
DECLARE @resultado10 NVARCHAR(255);
SELECT @resultado10=(
	SELECT CONCAT(persona.nombre,' ', persona.apellido1)
	FROM persona
	INNER JOIN alumno_se_matricula_asignatura ON persona.id=alumno_se_matricula_asignatura.id_alumno
	RIGHT JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura=asignatura.id
	WHERE persona.nombre='Salvador' AND persona.apellido1='S�nchez' AND asignatura.nombre=@asignatura10)
IF (@resultado10 IS NULL)
BEGIN 
	PRINT(CONCAT('El estudiante ', @nombre10, ' NO est� matriculado en ',@asignatura10))
END
ELSE 
BEGIN 
	PRINT(CONCAT('El estudiante ',@nombre10, ' SI est� matriculado en ', @asignatura10))	
END