USE pokedex

CREATE LOGIN Oak
WITH PASSWORD = 'profesor';
CREATE USER Oak
FOR LOGIN Oak;

GRANT SELECT, INSERT, UPDATE, DROP FOR Oak TO Pokemon

/* Jose Antonio Fernandez Guerrero*/