CREATE TABLE region(
idRegion INT IDENTITY (1,1),
nombreRegion NVARCHAR (300),
hemisferioRegion NVARCHAR,
CONSTRAINT pk_region PRIMARY KEY (idRegion),
CONSTRAINT ch_hemisferio_region CHECK (hemisferioRegion IN('NORTE', 'SUR'))
);