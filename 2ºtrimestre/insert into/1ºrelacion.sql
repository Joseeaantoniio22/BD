--Ejercicio 01--
INSERT INTO alumno (nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, teléfono) VALUES ('Laura', 'Gomez', 'Garcia', '15-03-2000', 'no', 654987321);

--Ejercicio 02
DELETE FROM alumno WHERE teléfono=692735409;

--Ejercicio 03
UPDATE alumno SET es_repetidor= 'no' 
WHERE nombre='Irene' AND apellido1='Gutiérrez' AND apellido2='Sánchez';

--Ejercicio 04
INSERT INTO alumno (nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor) VALUES ('Carlos', 'López', 'Martínez', '10-05-1997', 'sí');

--Ejercicio 05
DELETE FROM alumno WHERE id=3;

--Ejercicio 06
UPDATE alumno SET teléfono= 699123456
WHERE nombre='Cristina' AND apellido1='Fernández' AND apellido2='Ramírez';

--Ejercicio 07 
INSERT INTO alumno (nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, teléfono) VALUES ('Raúl', 'Sánchez', 'Ruiz', '25-12-1995', 'no', 62245678);

--Ejercicio 08
DELETE FROM alumno WHERE teléfono IS NULL;

--Ejercicio 09
UPDATE alumno SET apellido1='Sancho'
WHERE apellido1='Sánchez';

--Ejercicio 10
INSERT INTO alumno (nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, teléfono) VALUES ('Ana', 'Torres', 'García', '30-11-1999', 'sí', 687654321);

--Ejercicio 11
DELETE FROM alumno WHERE es_repetidor='sí';

--Ejercicio 12 RUINA

--Ejercicio 13
INSERT INTO alumno (nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, teléfono) VALUES ('Marta', 'Pérez', 'López', '20-08-1993', 'no', 634567890);

--Ejercicio 14
DELETE FROM alumno WHERE fecha_nacimiento < '01-01-1990';

--Ejercicio 15
UPDATE alumno SET teléfono=600000000
WHERE teléfono IS NULL;

--Ejercicio 17
DELETE FROM alumno WHERE nombre='Antonio';

--Ejercicio 18
UPDATE alumno SET es_repetidor='sí' WHERE fecha_nacimiento>'01-01-1995';

--Ejercicio 19
INSERT INTO alumno (nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, teléfono) VALUES ('Sofía', 'Matínez', 'Ruiz', '10-10-1998', 'sí', 609876543);

--Ejercicio 20
DELETE FROM alumno WHERE apellido2='Ortega';

SELECT * FROM alumno