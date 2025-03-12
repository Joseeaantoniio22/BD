USE NBA;

--EJERCICIO 01
CREATE VIEW ejercicio1 AS 
SELECT DISTINCT ciudad FROM equipo

SELECT * FROM ejercicio1;

--EJERCICIO 02
CREATE VIEW ejercicio2 AS
SELECT nombre, procedencia, peso 
FROM jugador WHERE peso>100;

SELECT * FROM ejercicio2;

--EJERCICIO 03
CREATE VIEW ejercicio3 AS 
SELECT nombre, ciudad, conferencia, division
FROM equipo WHERE conferencia='East';

SELECT * FROM ejercicio3;

--EJERCICIO 04
CREATE VIEW ejercicio4 AS 
SELECT division, COUNT(*) AS cantidad_equipo
FROM equipo
GROUP BY division;

SELECT * FROM ejercicio4;

--EJERCICIO 05
--EJERCICIO 09
CREATE VIEW ejercicio09 AS 
SELECT equipo_local, puntos_local
FROM partido
WHERE puntos_local>100;

SELECT * FROM ejercicio09;


--EJERCICIO 10
CREATE VIEW ejercicio10 AS 
SELECT nombre, procedencia
FROM jugador
WHERE procedencia!='USA';

SELECT * FROM ejercicio10;

--EJERCICIO 11
CREATE VIEW ejercicio11 AS
SELECT nombre, posicion
FROM jugador 
WHERE posicion NOT LIKE '%C%';

ALTER VIEW ejercicio11 AS 
SELECT nombre, posicion
FROM jugador
WHERE posicion NOT LIKE '%C%';

SELECT * FROM ejercicio11;

--EJERCICIO 12
CREATE VIEW ejercicio12 AS 
SELECT DISTINCT nombre_equipo, equipo.ciudad
FROM jugador
INNER JOIN equipo ON jugador.nombre_equipo=equipo.nombre
WHERE altura<2.00;

SELECT * FROM ejercicio12;

--EJERCICIO 14
CREATE VIEW ejercicio14 AS 
SELECT equipo_local, SUM(puntos_local) AS total_puntos_local, SUM(puntos_visitante) AS total_equipo_visitante
FROM partido
GROUP BY equipo_local;
SELECT * FROM ejercicio14;



