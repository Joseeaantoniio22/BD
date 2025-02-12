--Jose Antonio Fernández Guerrero

USE instituto

--EJERCICIO 01
SELECT * FROM alumno 
WHERE id=1;

--EJERCICIO 02
SELECT * FROM alumno
WHERE teléfono=692735409;

--EJERCICIO 03	
SELECT * FROM alumno
WHERE es_repetidor='sí';

--EJERCICIO 04
SELECT * FROM alumno
WHERE es_repetidor='no';

--EJERCICIO 05
SELECT * FROM alumno
WHERE fecha_nacimiento<'01/01/1993';

--EJERCICIO 06
SELECT * FROM alumno
WHERE fecha_nacimiento>'01/01/1994';

--EJERCICIO 07
SELECT * FROM alumno
WHERE fecha_nacimiento>'01/01/1994' AND es_repetidor='no';

--EJERCICIO 08
SELECT * FROM alumno
WHERE YEAR(fecha_nacimiento) =1998;
--EJERCICIO 09
SELECT * FROM alumno
WHERE YEAR(fecha_nacimiento) !=1998;

--EJERCICIO 10
SELECT * FROM alumno
WHERE fecha_nacimiento  BETWEEN  '01/01/1998' AND '31/05/1998';

--EJERCICIO 11
SELECT nombre, REVERSE (nombre) AS NombreInvertido 
FROM alumno;

--EJERCICIO 12
SELECT CONCAT( nombre,' ' , apellido1,' ', apellido1) AS nombreCompleto, REVERSE (CONCAT(nombre,' ', apellido1,' ', apellido2)) AS NombreCompletoInvertido 
FROM alumno;

--EJERCICIO 13
SELECT UPPER(CONCAT( nombre,' ' , apellido1,' ', apellido1)) AS nombreCompleto,LOWER( REVERSE (CONCAT(nombre,' ', apellido1,' ', apellido2))) AS NombreCompletoInvertido 
FROM alumno;

--EJERCICIO 14
SELECT CONCAT( nombre,' ' , apellido1,' ', apellido1) AS nombreCompleto, LEN (CONCAT(nombre,' ', apellido1,' ', apellido2)) AS numeroCaracteres
FROM alumno;

--EJERCICIO 15
SELECT CONCAT( nombre,' ' , apellido1,' ', apellido1) AS nombreCompleto, LOWER(CONCAT(nombre,'.', apellido1,'@ies.org') ) correroElectronico
FROM alumno;

--EJERCICIO 16
SELECT CONCAT( nombre,' ' , apellido1,' ', apellido1) AS nombreCompleto, LOWER(CONCAT(nombre,'.', apellido1,'@ies.org') ) correroElectronico
, CONCAT((REVERSE(apellido2)),YEAR(fecha_nacimiento)) AS Contraseña
FROM alumno;

--EJERCICIO 17
SELECT fecha_nacimiento AS Fecha_Completa, DAY(fecha_nacimiento) AS Dia, MONTH(fecha_nacimiento) AS Mes, YEAR(fecha_nacimiento) AS Año
FROM alumno;

--EJERCICIO 18
SELECT fecha_nacimiento,
DATENAME(WEEKDAY, fecha_nacimiento) as Nombre_Dia,
DATENAME(MONTH, fecha_nacimiento) as Nombre_Mes
FROM alumno;

--EJERCICIO 19
SELECT fecha_nacimiento,
DATEDIFF(DAY, fecha_nacimiento, SYSDATETIME() ) AS Dias_Desde_Nacimiento
FROM alumno;
