CREATE DATABASE pokedex
USE pokedex

CREATE TABLE tipo(
idTipo INT IDENTITY (1,1),
nombre NVARCHAR(100) UNIQUE NOT NULL,
CONSTRAINT pk_idTipo_Tipo PRIMARY KEY (idTipo));

CREATE TABLE Categoria(
idCategoria INT IDENTITY (1,1),
nombre NVARCHAR (100) UNIQUE NOT NULL, 
CONSTRAINT pk_idCategoria_Categoria PRIMARY KEY (idCategoria));

CREATE TABLE Pokemon(
numeroPokedex INT IDENTITY (1,1),
nombre NVARCHAR (100) UNIQUE NOT NULL,
descripcion NVARCHAR(100) NOT NULL,
foto NVARCHAR(100) NOT NULL,
idCategoria INT NOT NULL,
CONSTRAINT PK_numeroPokedex_Pokemon PRIMARY KEY (numeroPokedex),
CONSTRAINT fk_idCategoria_Pokemon FOREIGN KEY (idCategoria) REFERENCES Categoria(idCategoria)
);

CREATE TABLE habilidad(
idHabilidad INT IDENTITY(1,1),
nombre NVARCHAR(100) UNIQUE NOT NULL,
CONSTRAINT pk_idHabilidad_Habilidad PRIMARY KEY (idHabilidad));

CREATE TABLE Debilidad(
idDebilidad INT IDENTITY(1,1),
nombre NVARCHAR(100) UNIQUE,
CONSTRAINT pk_idDebilidad_Debilidad PRIMARY KEY (idDebilidad));

CREATE TABLE Estadistica(
numeroPokedex INT IDENTITY (1,1),
peso DECIMAL (5,2) NOT NULL,
altura DECIMAL(3,2) NOT NULL,
vida INT DEFAULT(0) NOT NULL,
velocidad INT DEFAULT(0) NOT NULL,
ataque INT DEFAULT(0) NOT NULL,
defensa INT DEFAULT(0) NOT NULL,
ata_esp INT DEFAULT(0) NOT NULL,
def_es INT DEFAULT(0) NOT NULL,

CONSTRAINT ch_vida_esatdistica CHECK (vida<=255),
CONSTRAINT ch_velocidad_Estadistica CHECK (velocidad<=255),
CONSTRAINT ch_atque_Estadistica CHECK (ataque<=255),
CONSTRAINT ch_defensa_Estadistica CHECK (defensa<=255),
CONSTRAINT ch_ataesp_Estadistica CHECK (ata_esp<=255),
CONSTRAINT ch_defes_Estadistica CHECK (def_es<=255),
CONSTRAINT pk_numeroPokedex_Estadistica PRIMARY KEY (numeroPokedex),
CONSTRAINT fk_numeroPokedex_Estadistica FOREIGN KEY (numeroPokedex) REFERENCES Pokemon(numeroPokedex)
);

CREATE TABLE TipoPokemon(
idTipo INT,
numeroPokedex INT,
CONSTRAINT pk_TipoPokemon PRIMARY KEY (idTipo, numeroPokedex),
CONSTRAINT fk_TipoPokemon FOREIGN KEY (idTipo) REFERENCES tipo(idTipo)

);

CREATE TABLE HabilidadPokemon(
idHabilidad INT,
numeroPokedex INT,
CONSTRAINT pk_HabilidadPokemon PRIMARY KEY (idHabilidad, numeroPokedex),
CONSTRAINT fk_HabilidadPokemon FOREIGN KEY (idHabilidad) REFERENCES Habilidad(idHabilidad)
);

CREATE TABLE DebilidadPokemon(
idDebilidad INT,
numeroPokedex INT,
CONSTRAINT pk_DebilidadPokemon PRIMARY KEY (idDebilidad, numeroPokedex),
CONSTRAINT fk_DebilidadPokemon FOREIGN KEY (idDebilidad) REFERENCES Habilidad(idHabilidad)
);

ALTER TABLE Pokemon
ADD tipo_Evolucion NVARCHAR(100),
CONSTRAINT ch_tipoEvolucion_Pokemon CHECK (tipo_Evolucion IN 'Nivel', 'Piedra Fuego', 'Piedra Agua', 'Piedra Trueno', 'Piedra Hoja', 'Piedra Lunar', 'Intercambio', 'No evoluciona');

/* Jose Antonio Fernandez Guerrero*/