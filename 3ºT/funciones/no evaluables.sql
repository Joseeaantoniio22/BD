CREATE PROCEDURE  holaMundo
AS
BEGIN 
PRINT('¡Hola Mundo!')
END

EXEC holaMundo;



--EJERCICIO 06
CREATE PROCEDURE ejercicio04
@nota int ,
@mensaje NVARCHAR(100) OUTPUT
AS
BEGIN 
	SET @mensaje = CASE 
	WHEN @nota>=0 AND @nota<5 THEN 'Insuficiente'
	WHEN @nota>= 5 AND @nota<6 THEN 'Aprobado'
	WHEN @nota>= 6 AND @nota < 7 THEN 'Bien'
	WHEN @nota>=7 AND @nota<9 THEN 'Notable'
	WHEN @nota>= 9 AND @nota<=10 THEN 'Sobresaliente'
	WHEN @nota>10 OR @nota<0 THEN 'Esta nota no es cierta'
END
END

DROP PROCEDURE ejercicio04

BEGIN
DECLARE @mensajee NVARCHAR(100);
EXEC ejercicio04 @nota = 11.99,@mensaje=@mensajee OUTPUT
PRINT @mensajee;
END	

--EJERCICIO 07
CREATE PROCEDURE ejercicio07
 @numero int
 AS 
 BEGIN 
 IF(@numero%2=0)
	BEGIN
		PRINT('TRUE')
	END
ELSE
		PRINT('FALSE')
 END;

 EXEC ejercicio07 @numero = 12;

 --EJERCICIO 09
 CREATE PROCEDURE ejercicio09
 @numero1 int, 
 @numero2 int, 
 @numero3 int
 AS
 BEGIN
	IF(@numero1 > @numero2 AND @numero1 > @numero3) PRINT(CONCAT(@numero1, ' es el numero más grande'));
	IF(@numero2>@numero1 AND @numero2 > @numero3) PRINT(CONCAT(@numero2,' es el numero más grande'));
	IF(@numero3>@numero1 AND @numero3> @numero2) PRINT(CONCAT(@numero3,' es el numero más grande'));
 END

 EXEC ejercicio09 @numero1=11, @numero2=2, @numero3=7;

