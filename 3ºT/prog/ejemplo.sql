DECLARE @numero INT = 1;
DECLARE @iter INT = 0;
DECLARE @resultado INT = 0;
WHILE @numero <=10
BEGIN
	SET @iter = 0
	WHILE @iter<=10
		BEGIN
			SET @resultado = @numero * @iter
			SELECT CONCAT(@numero,'*',@iter,'=',@resultado) AS MULTIPLICACION
			set @iter = @iter +1
		END
SET @numero = @numero + 1
END
