-- JOSE ANTONIO FERNÁNDEZ GUERRERO
USE NBA

--Ejercicio 01
CREATE VIEW ejercicio01 AS 
SELECT equipo_local AS equipo, COUNT(*) AS victorias_local
FROM partido
WHERE puntos_local>puntos_visitante
GROUP BY equipo_local;

SELECT * FROM ejercicio01;

--EJERCICIO 02
CREATE VIEW ejercicio02 AS 
SELECT nombre_equipo, CAST(AVG(altura) AS DECIMAL(3,2)) AS altura_promedio
FROM jugador
GROUP BY nombre_equipo;

SELECT * FROM ejercicio02;

--EJERCICIO 03
CREATE VIEW ejercicio03 AS 
SELECT equipo_local AS equipo, temporada, SUM(puntos_local + puntos_visitante) AS total_puntos_temporada
FROM partido
GROUP BY equipo_local, temporada;

SELECT * FROM ejercicio03;

--EJERCICIO 04
CREATE VIEW ejercicio04 AS 
SELECT nombre_equipo AS nombre, COUNT(*) AS cantidad_jugadores
FROM jugador
GROUP BY nombre_equipo
HAVING COUNT(*)>10

SELECT * FROM ejercicio04;

--EJERCICIO 05
CREATE VIEW ejercicio06 AS 
SELECT nombre AS nombre_jugador, nombre_equipo, CAST(AVG(estadistica.asistencias_por_partido)AS DECIMAL(4,2)) AS promedio_asistencias
FROM jugador
INNER JOIN estadistica ON jugador.codigo=estadistica.jugador
GROUP BY nombre, nombre_equipo
HAVING AVG(asistencias_por_partido)>5

SELECT * FROM ejercicio06