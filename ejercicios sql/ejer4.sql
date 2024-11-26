ALTER TABLE pais
ADD CONSTRAINT ch_nombre_pais CHECK (nombrePais IN ('Italia','India','China'));