USE tienda_informatica
--Jose Antonio Fernandez Guerrero

--EJERCICIO 01
SELECT *
FROM producto
WHERE cod_fabricante IN (
SELECT codigo
FROM fabricante
WHERE nombre='Sony'
);

--EJERCICIO 02
SELECT *
FROM producto
WHERE precio = ALL(
SELECT MAX(precio)
FROM producto
WHERE cod_fabricante=(
SELECT codigo
FROM fabricante
WHERE nombre='Samsung'
)
);

--EJERCICIO 03
SELECT nombre
FROM producto
WHERE precio = ALL(
SELECT MAX(precio)
FROM producto
WHERE cod_fabricante=(
SELECT codigo
FROM fabricante
WHERE nombre='Hewlett-Packard'
)
)

--EJERCICIO 04

