use empleados

--EJERCICIO 01
INSERT INTO departamento (codigo, nombre, presupuesto, gastos) VALUES (2005,'DAM', 50000, 1000 )

--EJERCICIO 02
INSERT INTO empleado (dni, nombre, apellidos, departamento) VALUES	('88888888F', 'Jose', 'García', 37)

--EJERCICIO 03

--EJERCICIO 04
DELETE FROM departamento
WHERE nombre='Estadística';

--EJERCICIO 05
DELETE FROM departamento
WHERE nombre='IT';

ALTER TABLE empleado
DROP CONSTRAINT fk_departamento_codigo;

ALTER TABLE empleado
ADD CONSTRAINT fk_departamento_codigo
FOREIGN KEY (departamento)
REFERENCES departamento(codigo)
ON DELETE CASCADE;

--EJERCICIO 06
UPDATE departamento
SET codigo=30
WHERE nombre='IT';


--EJERCICIO 08
UPDATE departamento
SET presupuesto=presupuesto+50000
WHERE presupuesto < 20000;

SELECT * FROM departamento
SELECT * FROM empleado