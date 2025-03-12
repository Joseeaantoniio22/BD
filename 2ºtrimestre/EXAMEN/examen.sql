USE pokedex;
--JOSE ANTONIO FERNÁNDEZ GUERRERO
--EJERCICIO 01
SELECT nombre, ps, ataque, defensa, at_especial,df_especial,velocidad
FROM pokemon
WHERE at_especial>=df_especial;

--EJERCICIO 02
SELECT categoria, COUNT(nombre) AS cantidad
FROM pokemon
GROUP BY categoria

--EJERCICIO 03
SELECT nombre, ataque
FROM pokemon
WHERE ataque > (
SELECT AVG(ataque)
FROM pokemon)
ORDER BY ataque DESC;

--EJERCICIO 04
SELECT pokemon.nombre, COUNT(habilidad.nombre) AS cantidad_habilidades
FROM pokemon
INNER JOIN pokemon_habilidad ON pokemon.numeropokedex=pokemon_habilidad.id_pokemon
INNER JOIN habilidad ON pokemon_habilidad.id_habilidad=habilidad.id
GROUP BY pokemon.nombre
HAVING COUNT(habilidad.nombre)>1
ORDER BY cantidad_habilidades DESC;

--EJERCICIO 05
SELECT pokemon.nombre, evolucion.metodo
FROM pokemon
INNER JOIN evolucion ON pokemon.numeropokedex=evolucion.id_pokemon_base
WHERE evolucion.metodo LIKE '%Piedra%';

--EJERCICIO 06
SELECT pokemon.nombre, evolucion.id_pokemon_base, evolucion.metodo
FROM pokemon
LEFT JOIN evolucion ON pokemon.numeropokedex=evolucion.id_pokemon_base;

--EJERCICIO 07
SELECT pokemon.nombre, tipo1.nombre AS tipo1,tipo2.nombre AS Tipo2 , descripcion, categoria
FROM pokemon
INNER JOIN tipo tipo1 ON pokemon.tipo1=tipo1.id
INNER JOIN tipo tipo2 ON pokemon.tipo2=tipo2.id;

--EJERCICIO 08



--EJERCICIO 09
SELECT nombre
FROM tipo
WHERE id IN (
SELECT iddebil
FROM fortaleza WHERE idfuerte = 1 )

--EJERCICIO 10
SELECT pokemon.numeropokedex, pokemon.nombre, pokemon.ataque, pokemon.velocidad, tipo.nombre, habilidad.nombre AS habilidad, habilidad.descripcion AS descripcion_habilidad
FROM habilidad
INNER JOIN pokemon_habilidad ON habilidad.id=pokemon_habilidad.id_habilidad
INNER JOIN pokemon ON pokemon_habilidad.id_pokemon=pokemon.numeropokedex
INNER JOIN tipo ON pokemon.tipo1=tipo.id
WHERE tipo.nombre='veneno' AND velocidad>ataque
ORDER BY numeropokedex ASC;

--EJERCICIO 11
SELECT nombre, velocidad, categoria
FROM pokemon
WHERE velocidad>(
SELECT MAX(velocidad)
FROM pokemon
WHERE categoria = 'Pokémon Dragón')
ORDER BY peso DESC;

--EJERCICIO 12
SELECT pokemon.nombre, COUNT(region.idregion) AS cantidad_versiones
FROM pokemon
INNER JOIN pokemon_region ON pokemon.numeropokedex=pokemon_region.id_pokemon
INNER JOIN region ON pokemon_region.id_region=region.idregion
GROUP BY pokemon.nombre
ORDER BY cantidad_versiones DESC;

--EJERCICIO 13
SELECT pokemon.nombre, tipo.nombre , pokemon.velocidad, habilidad.nombre, habilidad.descripcion AS descripcion_habilidad
FROM pokemon
WHERE numeropokedex IN (
SELECT numeropokedex
FROM pokemon WHERE velocidad > ALL ()) 


