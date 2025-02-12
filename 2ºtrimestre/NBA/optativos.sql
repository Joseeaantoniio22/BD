--JOSE ANTONIO FERNANDEZ GUERRERO
USE NBA
--EJERCICIO 01
SELECT *
from jugador
WHERE altura>(
SELECT AVG(altura)
from jugador
)

--EJERCICIO 02
SELECT nombre
FROM jugador
WHERE codigo IN(SELECT jugador
FROM estadistica 
WHERE temporada='98/99')
AND
(nombre_equipo IN(
SELECT equipo_local
FROM partido WHERE equipo_visitante='Raptors')
OR
nombre_equipo IN(
SELECT equipo_visitante
FROM partido WHERE equipo_local='Raptors'));

--EJERCICIO 03
SELECT nombre
FROM jugador
WHERE codigo IN (
SELECT jugador	
FROM estadistica
WHERE puntos_por_partido<'15' AND temporada='06/07'
)

--EJERCICIO 04
SELECT nombre
FROM jugador
WHERE nombre_equipo IN (
SELECT nombre
FROM equipo
WHERE conferencia='East') AND codigo IN (
SELECT jugador
FROM estadistica
WHERE temporada='07/08' AND puntos_por_partido>'20'
)

--EJERCICIO 05
SELECT nombre
FROM jugador
WHERE codigo IN (
SELECT jugador
FROM estadistica
WHERE temporada='05/06' AND tapones_por_partido>0.8
)

--EJERCICIO 06
SELECT nombre
from jugador
WHERE altura>(
SELECT AVG(altura)
from jugador
WHERE nombre_equipo='Timberwolves'
)

--EJERCICIO 07
SELECT nombre
FROM equipo
WHERE nombre IN (
SELECT nombre_equipo
FROM jugador
WHERE peso>'250') AND nombre LIKE 'C%'

--EJERCICIO 08
SELECT nombre
FROM jugador
WHERE codigo IN (
SELECT jugador
FROM estadistica
WHERE puntos_por_partido>(
SELECT AVG(puntos_por_partido)
FROM estadistica
WHERE temporada='06/07')AND temporada='06/07')

--EJERCICIO 09
SELECT nombre
FROM jugador
WHERE codigo IN (
SELECT jugador
FROM estadistica
WHERE temporada='07/08' AND rebotes_por_partido>=1)

--EJERCICIO 10
SELECT nombre
FROM jugador
WHERE codigo IN (
SELECT jugador
FROM estadistica
WHERE puntos_por_partido>10 AND temporada='04/05')

--EJERCICIO 11
SELECT nombre
FROM jugador
INNER JOIN estadistica ON jugador.codigo = estadistica.jugador
WHERE estadistica.asistencias_por_partido<3 AND temporada='03/04'

--EJERCICIO 12
SELECT nombre 
FROM jugador
WHERE codigo IN(
SELECT jugador
FROM estadistica
WHERE puntos_por_partido>(
SELECT AVG(puntos_por_partido)
FROM estadistica
WHERE temporada='07/08') AND temporada='07/08')

--EJERCICIO 13
SELECT *
FROM jugador
WHERE nombre_equipo
IN (
	SELECT nombre
	FROM equipo
	WHERE conferencia='East' AND nombre IN (
	SELECT equipo_visitante
	FROM partido))
AND codigo IN(
SELECT jugador
FROM estadistica
WHERE 10 <= (
SELECT AVG(puntos_por_partido)
FROM estadistica
WHERE jugador = jugador.codigo))
ORDER BY codigo ASC	

--EJERCICIO 14
SELECT nombre 
FROM jugador
WHERE codigo 
IN (
SELECT jugador
FROM estadistica
WHERE (SELECT AVG(puntos_por_partido)
FROM estadistica
WHERE temporada='07/08')
<
(SELECT SUM(puntos_por_partido)
FROM estadistica
WHERE temporada='07/08' AND jugador=jugador.codigo));

--EJERCICIO 15
SELECT nombre
FROM jugador
WHERE codigo IN (
SELECT jugador
FROM estadistica
WHERE temporada='05/06' AND 5>(
SELECT SUM(asistencias_por_partido)
FROM estadistica
WHERE jugador = jugador.codigo AND temporada='05/06'))

--EJERCICIO 16
SELECT nombre
FROM jugador
WHERE codigo IN (
SELECT jugador
FROM estadistica
WHERE puntos_por_partido > 
(SELECT AVG(puntos_por_partido)
FROM estadistica
WHERE jugador IN (
SELECT codigo
FROM jugador
WHERE nombre_equipo='Raptors')))





