--Ejercicio 01--
INSERT INTO alumno (nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, tel�fono) VALUES ('Laura', 'Gomez', 'Garcia', '15-03-2000', 'no', 654987321);

--Ejercicio 02
DELETE FROM alumno WHERE tel�fono=692735409;

--Ejercicio 03
UPDATE alumno SET es_repetidor= 'no' 
WHERE nombre='Irene' AND apellido1='Guti�rrez' AND apellido2='S�nchez';

--Ejercicio 04
INSERT INTO alumno (nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor) VALUES ('Carlos', 'L�pez', 'Mart�nez', '10-05-1997', 's�');

--Ejercicio 05
DELETE FROM alumno WHERE id=3;

--Ejercicio 06
UPDATE alumno SET tel�fono= 699123456
WHERE nombre='Cristina' AND apellido1='Fern�ndez' AND apellido2='Ram�rez';

--Ejercicio 07 
INSERT INTO alumno (nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, tel�fono) VALUES ('Ra�l', 'S�nchez', 'Ruiz', '25-12-1995', 'no', 62245678);

--Ejercicio 08
DELETE FROM alumno WHERE tel�fono IS NULL;

--Ejercicio 09
UPDATE alumno SET apellido1='Sancho'
WHERE apellido1='S�nchez';

--Ejercicio 10
INSERT INTO alumno (nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, tel�fono) VALUES ('Ana', 'Torres', 'Garc�a', '30-11-1999', 's�', 687654321);

--Ejercicio 11
DELETE FROM alumno WHERE es_repetidor='s�';

--Ejercicio 12 RUINA

--Ejercicio 13
INSERT INTO alumno (nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, tel�fono) VALUES ('Marta', 'P�rez', 'L�pez', '20-08-1993', 'no', 634567890);

--Ejercicio 14
DELETE FROM alumno WHERE fecha_nacimiento < '01-01-1990';

--Ejercicio 15
UPDATE alumno SET tel�fono=600000000
WHERE tel�fono IS NULL;

--Ejercicio 17
DELETE FROM alumno WHERE nombre='Antonio';

--Ejercicio 18
UPDATE alumno SET es_repetidor='s�' WHERE fecha_nacimiento>'01-01-1995';

--Ejercicio 19
INSERT INTO alumno (nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, tel�fono) VALUES ('Sof�a', 'Mat�nez', 'Ruiz', '10-10-1998', 's�', 609876543);

--Ejercicio 20
DELETE FROM alumno WHERE apellido2='Ortega';

SELECT * FROM alumno