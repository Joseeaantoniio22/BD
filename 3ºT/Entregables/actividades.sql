--JOSE ANTONIO FERNÁNDEZ GUERRERO
USE universidad;

--EJERCICIO 01
CREATE OR ALTER PROCEDURE ejercicio01
@nombre NVARCHAR(50)
AS
BEGIN
	INSERT INTO departamento ( nombre) VALUES ( @nombre);
END

BEGIN 
	DECLARE @nombre NVARCHAR(50);
	SET @nombre = 'Ciencia';
	EXEC ejercicio01  @nombre;
END

--EJERCICIO 02
CREATE OR ALTER PROCEDURE ejercicio02EV
	@nif NVARCHAR(9),
	@nombre NVARCHAR(25),
	@apellido1 NVARCHAR(50),
	@apellido2 NVARCHAR(50),
	@ciudad NVARCHAR(50),
	@direccion NVARCHAR(50),
	@telefono INT,
	@fecha DATE,
	@sexo CHAR(1),
	@tipo NVARCHAR(10)
AS
BEGIN
	INSERT INTO persona VALUES (@nif, @nombre, @apellido1, 
	@apellido2, @ciudad, @direccion, @telefono, @fecha, @sexo, @tipo)
END

BEGIN 
	DECLARE @nif NVARCHAR(9);
	DECLARE @nombre NVARCHAR(25);
	DECLARE @apellido1 NVARCHAR(50);
	DECLARE @apellido2 NVARCHAR(50);
	DECLARE @ciudad NVARCHAR(50);
	DECLARE @direccion NVARCHAR(50);
	DECLARE @telefono INT;
	DECLARE @fecha DATE;
	DECLARE @sexo CHAR(1);
	DECLARE @tipo NVARCHAR(10);
	SET @nif = '12345678J';
	SET @nombre = 'Jose';
	SET @apellido1 = 'Ruiz';
	SET @apellido2 = 'Garcia';
	SET @ciudad = 'Barcelona';
	SET @direccion = 'Calle Flauta Mágica'
	SET @telefono = 666998877;
	SET @fecha = '12/12/12';
	SET @sexo = 'H';
	SET @tipo = 'profesor';
	EXEC ejercicio02EV @nif, @nombre, @apellido1, @apellido2, @ciudad, @direccion, @telefono, @fecha, @sexo, @tipo;
END

--EJERCICIO 03
CREATE OR ALTER PROCEDURE ejercicio03EV
@nombre NVARCHAR(50),
@apellido1 NVARCHAR(50),
@apellido2 NVARCHAR(50),
@departamento NVARCHAR(50)

AS
BEGIN
	DECLARE @hayProfesor INT;
	DECLARE @hayDepartamento INT;

	SET @hayDepartamento = (
	SELECT COUNT(*)
	FROM departamento
	WHERE nombre = 'informatica'
	)

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
	IF(@hayProfesor=0)
	BEGIN 
		THROW 50004, 'El departamento no existe en la base de datos',1;
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
	SET @departamento = 'Informátic';
	EXEC ejercicio03EV @nombre, @apellido1, @apellido2, @departamento;
END

--Ejercicio 04
CREATE OR ALTER PROCEDURE ejercicio04
    @grado NVARCHAR(100)
    AS
    BEGIN
        DECLARE @hayGrado BIT;

        SET @hayGrado = (SELECT COUNT(*) 
                            FROM grado 
                            WHERE id = 11);

        IF @hayGrado = 1
        BEGIN 
            THROW 50004, 'ERROR: El grado con ese ID ya existe.', 1;
        END
        ELSE 
        BEGIN
            INSERT INTO grado(nombre) VALUES(@grado);
        END
    END

    BEGIN 
        BEGIN TRY 
            EXEC ejercicio04 @grado = 'Grado en Carpinteria(Plan 2025)';
        END TRY
        BEGIN CATCH
            SELECT 
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage;
        END CATCH
    END
    GO

--Ejercicio 05
CREATE OR ALTER PROCEDURE ejercicio05EV
@nombre NVARCHAR(100)
AS
BEGIN
	DECLARE @hayAsignatura INT;

	SET @hayAsignatura = (
		SELECT COUNT(*)
		FROM asignatura
		WHERE nombre = @nombre
	)

	IF(@hayAsignatura=0)
	BEGIN
		THROW 50001, 'La asignatura especificada no existe',1;
		RETURN;
	END
	ELSE
	BEGIN
		DECLARE @nombreAlumno NVARCHAR(100),
				@apellido2 NVARCHAR(100),
				@apellido1 NVARCHAR(100),
				@ciudad NVARCHAR(50),
				@sexo CHAR;

		DECLARE cursor05 CURSOR FOR 

		SELECT persona.nombre, persona.apellido1, persona.apellido2, persona.ciudad, persona.sexo
		FROM persona
		INNER JOIN alumno_se_matricula_asignatura ON persona.id=alumno_se_matricula_asignatura.id_alumno
		INNER JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura=asignatura.id
		WHERE asignatura.nombre = @nombre

		OPEN cursor05;

		FETCH NEXT FROM cursor05 INTO @nombreAlumno, @apellido1, @apellido2, @ciudad, @sexo

		WHILE @@FETCH_STATUS = 0
		BEGIN	
			IF(@sexo = 'M')
			BEGIN
				PRINT(CONCAT('Alumna: ',@nombreAlumno,' ',@apellido1,' ',@apellido2,', Ciudad: ',@ciudad))
			END
			ELSE
			BEGIN
				PRINT(CONCAT('Alumno: ',@nombreAlumno,' ',@apellido1,' ',@apellido2,', Ciudad: ',@ciudad))
			END

			FETCH NEXT FROM cursor05 INTO @nombreAlumno, @apellido1, @apellido2, @ciudad, @sexo;
		END;

		CLOSE cursor05;
		DEALLOCATE cursor05;
	END

END


DECLARE @nombre NVARCHAR(100);
set @nombre = 'Introducción a la programación';
EXEC ejercicio05EV @nombre;

--Ejercicio06

CREATE OR ALTER PROCEDURE ejercicio06EV
@nombre NVARCHAR(100)
AS
BEGIN
	DECLARE @hayGrado INT,
			@alumnosMatriculado INT;
	SET @hayGrado = (
		SELECT COUNT(*)
		FROM grado
		WHERE nombre = @nombre
	)

	SET @alumnosMatriculado = (
		SELECT COUNT(persona.nombre)
		FROM persona
		INNER JOIN	alumno_se_matricula_asignatura ON persona.id=alumno_se_matricula_asignatura.id_alumno	
		INNER JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura=asignatura.id
		INNER JOIN grado ON asignatura.id_grado = grado.id
		WHERE grado.nombre = 'Grado en Ingeniería Informática (Plan 2015)'
		GROUP BY persona.nombre
	)

	PRINT(@alumnosMatriculado)
END

DECLARE @nombre NVARCHAR(100);
SET @nombre = 'Grado en Ingeniería Informática (Plan 2015)';
EXEC ejercicio06EV @nombre;



--Ejercicio07

CREATE OR ALTER PROCEDURE ejercicio07EV
@nombre NVARCHAR(100),
@apellido1 NVARCHAR(100),
@apellido2 NVARCHAR(100)
AS
BEGIN
	DECLARE @hayProfesor INT;
	SET @hayProfesor = (
		SELECT COUNT(*)
		FROM profesor
		INNER JOIN persona ON profesor.id_profesor=persona.id
		WHERE persona.nombre = @nombre AND persona.apellido1 = @apellido1 AND persona.apellido2 = @apellido2
	)

	DECLARE @sexo CHAR;

	IF(@hayProfesor=0)
	BEGIN
		THROW 50001, 'El profesor especificado no existe',1;
		RETURN;
	END
	ELSE
	BEGIN
		SET @sexo = (
			SELECT sexo
			FROM persona
			WHERE persona.nombre = @nombre AND persona.apellido1 = @apellido1 AND persona.apellido2 = @apellido2
		)

		IF(@sexo='M')
		BEGIN
			PRINT('Profesora: '+@nombre+' '+@apellido1+' '+@apellido2)
		END
		ELSE
		BEGIN
			PRINT('Profesor: '+@nombre+' '+@apellido1+' '+@apellido2)
		END
		PRINT('Lista de asignaturas impartidas: ')

		DECLARE @grado NVARCHAR(100),
				@asignatura NVARCHAR(100);

		DECLARE c_07 CURSOR FOR
		SELECT asignatura.nombre, grado.nombre
		FROM asignatura
		INNER JOIN grado ON asignatura.id_grado=grado.id
		INNER JOIN profesor ON asignatura.id_profesor=profesor.id_profesor
		INNER JOIN persona ON profesor.id_profesor=persona.id
		WHERE persona.nombre = @nombre AND persona.apellido1 = @apellido1 AND persona.apellido2 = @apellido2

		OPEN c_07;
		FETCH NEXT FROM c_07 INTO @asignatura, @grado;

		WHILE @@FETCH_STATUS = 0
		BEGIN
			PRINT('Asignatura: '+@asignatura+' ('+@grado+')')
			FETCH NEXT FROM c_07 INTO @asignatura, @grado;
		END

		CLOSE c_07;
		DEALLOCATE C_07;

	END

END

DECLARE @nombre NVARCHAR(100),
		@apellido1 NVARCHAR(100),
		@apellido2 NVARCHAR(100);

SET @nombre = 'Zoe';
SET @apellido1 = 'Ramirez';
SET @apellido2 = 'Gea';

EXEC ejercicio07EV @nombre, @apellido1, @apellido2;


--EJERCICIO 01.2
USE NBAv2;

CREATE OR ALTER PROCEDURE ejercicio01_2
@nombreEquipo NVARCHAR(100)
AS
BEGIN
	DECLARE @hayEquipo INT;
	SET @hayEquipo = (
		SELECT COUNT(*)
		FROM equipo
		WHERE nombre = @nombreEquipo
	)

	DECLARE @ciudad NVARCHAR(100);
	set @ciudad = (
		SELECT ciudad
		FROM equipo
		WHERE nombre = @nombreEquipo
	)

	IF(@hayEquipo=0)
	BEGIN
		THROW 50001, 'El equipo no existe en la base de datos',1;
		RETURN;
	END
	ELSE
	BEGIN
		PRINT('La ciudad del equipo '+@nombreEquipo+' es: '+@ciudad)
	END
END

DECLARE @nombre NVARCHAR(100);
SET @nombre = 'Lakers';
EXEC ejercicio01_2 @nombre;

--EJERCICIO 02
CREATE OR ALTER PROCEDURE ejercicio02_2
@nombre NVARCHAR(100),
@temporada NVARCHAR(100)
AS
BEGIN 
	DECLARE @hayEquipo INT;
	set @hayEquipo=(
		SELECT COUNT(*)
		FROM equipo
		WHERE nombre = @nombre
	)

	IF(@hayEquipo=0)
	BEGIN
		THROW 50001,'El equipo no existe en la base de datos',1;
		RETURN;
	END
	ELSE
	BEGIN
		DECLARE @hayJugadores INT;
		SET @hayJugadores = (
			SELECT COUNT(*)
			FROM jugador
			INNER JOIN jugador_equipo ON jugador.codigo = jugador_equipo.codigo_jugador
			INNER JOIN equipo ON jugador_equipo.codigo_equipo = equipo.codigo
			WHERE jugador_equipo.temporada = @temporada AND equipo.nombre = @nombre
		)
		
		IF(@hayJugadores=0)
		BEGIN
			PRINT('No hay jugadores del equipo '+@nombre+' en la temporada '+@temporada);
		END
		ELSE
		BEGIN
			PRINT('Jugadores del equipo '+@nombre+' en la temporada: '+@temporada);
			PRINT('---------------------------------------------------------------');

			DECLARE @nombreJugador NVARCHAR(100);
			DECLARE c_02_2 CURSOR FOR
			SELECT jugador.nombre
			FROM jugador_equipo
			INNER JOIN jugador ON jugador.codigo = jugador_equipo.codigo_jugador
			INNER JOIN equipo ON jugador_equipo.codigo_equipo = equipo.codigo
			WHERE temporada = @temporada AND equipo.nombre = @nombre;

			OPEN c_02_2;

			FETCH NEXT FROM c_02_2 INTO @nombreJugador;

			WHILE @@FETCH_STATUS=0
			BEGIN
				PRINT('Nombre: '+@nombreJugador);
				FETCH NEXT FROM c_02_2 INTO @nombreJugador;
			END
			CLOSE c_02_2;
			DEALLOCATE c_02_2; 
		END
	END	
END

DECLARE @nombre NVARCHAR(100);
DECLARE @temporada NVARCHAR(100);
set @nombre = 'Lakers';
SET @temporada = '2022-23';
EXEC ejercicio02_2 @nombre, @temporada;

--EJERCICIO 03
CREATE OR ALTER PROCEDURE ejercicio03_2
@nombre NVARCHAR(100),
@temporada NVARCHAR(100),
@posicion NVARCHAR(100)
AS
BEGIN 
	DECLARE @hayEquipo INT;
	set @hayEquipo=(
		SELECT COUNT(*)
		FROM equipo
		WHERE nombre = @nombre
	)

	IF(@hayEquipo=0)
	BEGIN
		THROW 50001,'El equipo no existe en la base de datos',1;
		RETURN;
	END
	ELSE
	BEGIN
		DECLARE @hayJugadores INT;
		SET @hayJugadores = (
			SELECT COUNT(*)
			FROM jugador
			INNER JOIN jugador_equipo ON jugador.codigo = jugador_equipo.codigo_jugador
			INNER JOIN equipo ON jugador_equipo.codigo_equipo = equipo.codigo
			WHERE jugador_equipo.temporada = @temporada AND equipo.nombre = @nombre
		)
		
		IF(@hayJugadores=0)
		BEGIN
			PRINT('No hay jugadores del equipo '+@nombre+' en la temporada '+@temporada);
		END
		ELSE
		BEGIN
			DECLARE @hayPosicion INT;
			SET @hayPosicion = (
				SELECT COUNT(*)
				FROM jugador
				INNER JOIN jugador_equipo ON jugador.codigo = jugador_equipo.codigo_jugador
				INNER JOIN equipo ON jugador_equipo.codigo_equipo = equipo.codigo
				WHERE jugador_equipo.temporada = @temporada AND equipo.nombre = @nombre AND jugador_equipo.posicion = @posicion
			)
			IF(@hayPosicion=0)
			BEGIN
				PRINT('No hay jugadores en el equipo '+@nombre+' en la temporada '+@temporada+' que jueguen en la posición de '+@posicion);
			END
			ELSE
			BEGIN
				PRINT('Jugadores del equipo '+@nombre+' en la temporada: '+@temporada);
				PRINT('---------------------------------------------------------------');

				DECLARE @nombreJugador NVARCHAR(100);
				DECLARE c_03_2 CURSOR FOR
				SELECT jugador.nombre
				FROM jugador
				INNER JOIN jugador_equipo ON jugador.codigo = jugador_equipo.codigo_jugador
				INNER JOIN equipo ON jugador_equipo.codigo_equipo = equipo.codigo
				WHERE jugador_equipo.temporada = @temporada AND equipo.nombre = @nombre AND jugador_equipo.posicion = @posicion

				OPEN c_03_2;

				FETCH NEXT FROM c_03_2 INTO @nombreJugador;

				WHILE @@FETCH_STATUS=0
				BEGIN
					PRINT(@nombreJugador);
					FETCH NEXT FROM c_03_2 INTO @nombreJugador;
				END
				CLOSE c_03_2;
				DEALLOCATE c_03_2;
			END
		END
	END	
END

DECLARE @nombre NVARCHAR(100);
DECLARE @temporada NVARCHAR(100);
DECLARE @posicion NVARCHAR(100);
set @nombre = 'Lakers';
SET @posicion = 'Aleros';
SET @temporada = '2022-23';
EXEC ejercicio03_2 @nombre, @temporada, @posicion;
