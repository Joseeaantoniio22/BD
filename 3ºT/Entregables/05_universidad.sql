-- Eliminar la base de datos universidad si existe
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'universidad')
BEGIN
    DROP DATABASE universidad;
END;
GO

-- Crear y usar la base de datos universidad
CREATE DATABASE universidad;
GO

USE universidad;
GO

-- Creación de la tabla departamento
CREATE TABLE departamento (
    id INT IDENTITY(1,1),
    nombre NVARCHAR(50) NOT NULL,
    CONSTRAINT pk_departamento PRIMARY KEY (id)
);

-- Creación de la tabla persona
CREATE TABLE persona (
    id INT IDENTITY(1,1),
    nif NVARCHAR(9) UNIQUE,
    nombre NVARCHAR(25) NOT NULL,
    apellido1 NVARCHAR(50) NOT NULL,
    apellido2 NVARCHAR(50),
    ciudad NVARCHAR(25) NOT NULL,
    direccion NVARCHAR(50) NOT NULL,
    telefono NVARCHAR(9),
    fecha_nacimiento DATE NOT NULL,
    sexo CHAR(1) NOT NULL,
    tipo NVARCHAR(10) NOT NULL,
    CONSTRAINT pk_persona PRIMARY KEY (id),
    CONSTRAINT ck_persona_sexo CHECK (sexo IN ('H', 'M')),
    CONSTRAINT ck_persona_tipo CHECK (tipo IN ('profesor', 'alumno'))
);

-- Creación de la tabla profesor
CREATE TABLE profesor (
    id_profesor INT,
    id_departamento INT NOT NULL,
    CONSTRAINT pk_profesor PRIMARY KEY (id_profesor),
    FOREIGN KEY (id_profesor) REFERENCES persona(id),
    FOREIGN KEY (id_departamento) REFERENCES departamento(id)
);

-- Creación de la tabla grado
CREATE TABLE grado (
    id INT IDENTITY(1,1),
    nombre NVARCHAR(100) NOT NULL, 
    CONSTRAINT pk_grado PRIMARY KEY (id)
);

-- Creación de la tabla asignatura
CREATE TABLE asignatura (
    id INT IDENTITY(1,1),
    nombre NVARCHAR(100) NOT NULL,
    creditos FLOAT NOT NULL CHECK (creditos >= 0),
    tipo NVARCHAR(50) NOT NULL,
    curso TINYINT NOT NULL CHECK (curso >= 1 AND curso <= 4),
    cuatrimestre TINYINT NOT NULL CHECK (cuatrimestre IN (1, 2)),
    id_profesor INT,
    id_grado INT NOT NULL,
    CONSTRAINT pk_asignatura PRIMARY KEY (id),
    CONSTRAINT ck_asignatura_tipo CHECK (tipo IN ('básica', 'obligatoria', 'optativa')),
    FOREIGN KEY (id_profesor) REFERENCES profesor(id_profesor),
    FOREIGN KEY (id_grado) REFERENCES grado(id)
);

-- Creación de la tabla curso_escolar
CREATE TABLE curso_escolar (
    id INT IDENTITY(1,1),
    anyo_inicio INT NOT NULL,
    anyo_fin INT NOT NULL,
    CONSTRAINT pk_curso_escolar PRIMARY KEY (id),
    CONSTRAINT ck_curso_escolar_anyo_inicio CHECK (anyo_inicio >= 1900 AND anyo_inicio <= 2100),
    CONSTRAINT ck_curso_escolar_anyo_inicio_fin CHECK (anyo_fin >= 1900 AND anyo_fin <= 2100)
);

-- Creación de la tabla alumno_se_matricula_asignatura
CREATE TABLE alumno_se_matricula_asignatura (
    id_alumno INT NOT NULL,
    id_asignatura INT NOT NULL,
    id_curso_escolar INT NOT NULL,
    CONSTRAINT pk_alumno_se_matricula_asignatura PRIMARY KEY (id_alumno, id_asignatura, id_curso_escolar),
    CONSTRAINT fk_alumno_se_matricula_asignatura_persona FOREIGN KEY (id_alumno) REFERENCES persona(id),
    CONSTRAINT fk_alumno_se_matricula_asignatura_asignatura FOREIGN KEY (id_asignatura) REFERENCES asignatura(id),
    CONSTRAINT fk_alumno_se_matricula_asignatura_curso_escolar FOREIGN KEY (id_curso_escolar) REFERENCES curso_escolar(id)
);

-- Insertar datos en la tabla Departamento
INSERT INTO departamento VALUES ('Informática');
INSERT INTO departamento VALUES ('Matemáticas');
INSERT INTO departamento VALUES ('Economía y Empresa');
INSERT INTO departamento VALUES ('Educación');
INSERT INTO departamento VALUES ('Agronomía');
INSERT INTO departamento VALUES ('Química y Física');
INSERT INTO departamento VALUES ('Filología');
INSERT INTO departamento VALUES ('Derecho');
INSERT INTO departamento VALUES ('Biología y Geología');
 
-- Insertar datos en la tabla Persona
INSERT INTO persona VALUES ('26902806M', 'Salvador', 'Sánchez', 'Pérez', 'Almería', 'C/ Real del barrio alto', '950254837', '1991/03/28', 'H', 'alumno');
INSERT INTO persona VALUES ('89542419S', 'Juan', 'Saez', 'Vega', 'Almería', 'C/ Mercurio', '618253876', '1992/08/08', 'H', 'alumno');
INSERT INTO persona VALUES ('11105554G', 'Zoe', 'Ramirez', 'Gea', 'Almería', 'C/ Marte', '618223876', '1979/08/19', 'M', 'profesor');
INSERT INTO persona VALUES ('17105885A', 'Pedro', 'Heller', 'Pagac', 'Almería', 'C/ Estrella fugaz', NULL, '2000/10/05', 'H', 'alumno');
INSERT INTO persona VALUES ('38223286T', 'David', 'Schmidt', 'Fisher', 'Almería', 'C/ Venus', '678516294', '1978/01/19', 'H', 'profesor');
INSERT INTO persona VALUES ('04233869Y', 'José', 'Koss', 'Bayer', 'Almería', 'C/ Júpiter', '628349590', '1998/01/28', 'H', 'alumno');
INSERT INTO persona VALUES ('97258166K', 'Ismael', 'Strosin', 'Turcotte', 'Almería', 'C/ Neptuno', NULL, '1999/05/24', 'H', 'alumno');
INSERT INTO persona VALUES ('79503962T', 'Cristina', 'Lemke', 'Rutherford', 'Almería', 'C/ Saturno', '669162534', '1977/08/21', 'M', 'profesor');
INSERT INTO persona VALUES ('82842571K', 'Ramón', 'Herzog', 'Tremblay', 'Almería', 'C/ Urano', '626351429', '1996/11/21', 'H', 'alumno');
INSERT INTO persona VALUES ('61142000L', 'Esther', 'Spencer', 'Lakin', 'Almería', 'C/ Plutón', NULL, '1977/05/19', 'M', 'profesor');
INSERT INTO persona VALUES ('46900725E', 'Daniel', 'Herman', 'Pacocha', 'Almería', 'C/ Andarax', '679837625', '1997/04/26', 'H', 'alumno');
INSERT INTO persona VALUES ('85366986W', 'Carmen', 'Streich', 'Hirthe', 'Almería', 'C/ Almanzora', NULL, '1971-04-29', 'M', 'profesor');
INSERT INTO persona VALUES ('73571384L', 'Alfredo', 'Stiedemann', 'Morissette', 'Almería', 'C/ Guadalquivir', '950896725', '1980/02/01', 'H', 'profesor');
INSERT INTO persona VALUES ('82937751G', 'Manolo', 'Hamill', 'Kozey', 'Almería', 'C/ Duero', '950263514', '1977/01/02', 'H', 'profesor');
INSERT INTO persona VALUES ('80502866Z', 'Alejandro', 'Kohler', 'Schoen', 'Almería', 'C/ Tajo', '668726354', '1980/03/14', 'H', 'profesor');
INSERT INTO persona VALUES ('10485008K', 'Antonio', 'Fahey', 'Considine', 'Almería', 'C/ Sierra de los Filabres', NULL, '1982/03/18', 'H', 'profesor');
INSERT INTO persona VALUES ('85869555K', 'Guillermo', 'Ruecker', 'Upton', 'Almería', 'C/ Sierra de Gádor', NULL, '1973/05/05', 'H', 'profesor');
INSERT INTO persona VALUES ('04326833G', 'Micaela', 'Monahan', 'Murray', 'Almería', 'C/ Veleta', '662765413', '1976/02/25', 'H', 'profesor');
INSERT INTO persona VALUES ('11578526G', 'Inma', 'Lakin', 'Yundt', 'Almería', 'C/ Picos de Europa', '678652431', '1998/09/01', 'M', 'alumno');
INSERT INTO persona VALUES ('79221403L', 'Francesca', 'Schowalter', 'Muller', 'Almería', 'C/ Quinto pino', NULL, '1980/10/31', 'H', 'profesor');
INSERT INTO persona VALUES ('79089577Y', 'Juan', 'Gutiérrez', 'López', 'Almería', 'C/ Los pinos', '678652431', '1998/01/01', 'H', 'alumno');
INSERT INTO persona VALUES ('41491230N', 'Antonio', 'Domínguez', 'Guerrero', 'Almería', 'C/ Cabo de Gata', '626652498', '1999/02/11', 'H', 'alumno');
INSERT INTO persona VALUES ('64753215G', 'Irene', 'Hernández', 'Martínez', 'Almería', 'C/ Zapillo', '628452384', '1996/03/12', 'M', 'alumno');
INSERT INTO persona VALUES ('85135690V', 'Sonia', 'Gea', 'Ruiz', 'Almería', 'C/ Mercurio', '678812017', '1995/04/13', 'M', 'alumno');
 
-- Insertar datos en la tabla Profesor
INSERT INTO profesor VALUES (3, 1);
INSERT INTO profesor VALUES (5, 2);
INSERT INTO profesor VALUES (8, 3);
INSERT INTO profesor VALUES (10, 4);
INSERT INTO profesor VALUES (12, 4);
INSERT INTO profesor VALUES (13, 6);
INSERT INTO profesor VALUES (14, 1);
INSERT INTO profesor VALUES (15, 2);
INSERT INTO profesor VALUES (16, 3);
INSERT INTO profesor VALUES (17, 4);
INSERT INTO profesor VALUES (18, 5);
INSERT INTO profesor VALUES (20, 6);
 
-- Insertar datos en la tabla Grado
INSERT INTO grado VALUES ('Grado en Ingeniería Agrícola (Plan 2015)');
INSERT INTO grado VALUES ('Grado en Ingeniería Eléctrica (Plan 2014)');
INSERT INTO grado VALUES ('Grado en Ingeniería Electrónica Industrial (Plan 2010)');
INSERT INTO grado VALUES ('Grado en Ingeniería Informática (Plan 2015)');
INSERT INTO grado VALUES ('Grado en Ingeniería Mecánica (Plan 2010)');
INSERT INTO grado VALUES ('Grado en Ingeniería Química Industrial (Plan 2010)');
INSERT INTO grado VALUES ('Grado en Biotecnología (Plan 2015)');
INSERT INTO grado VALUES ('Grado en Ciencias Ambientales (Plan 2009)');
INSERT INTO grado VALUES ('Grado en Matemáticas (Plan 2010)');
INSERT INTO grado VALUES ('Grado en Química (Plan 2009)');
 
-- Insertar datos en la tabla Asignatura
INSERT INTO asignatura VALUES ('Álgegra lineal y matemática discreta', 6, 'básica', 1, 1, 3, 4);
INSERT INTO asignatura VALUES ('Cálculo', 6, 'básica', 1, 1, 14, 4);
INSERT INTO asignatura VALUES ('Física para informática', 6, 'básica', 1, 1, 3, 4);
INSERT INTO asignatura VALUES ('Introducción a la programación', 6, 'básica', 1, 1, 14, 4);
INSERT INTO asignatura VALUES ('Organización y gestión de empresas', 6, 'básica', 1, 1, 3, 4);
INSERT INTO asignatura VALUES ('Estadística', 6, 'básica', 1, 2, 14, 4);
INSERT INTO asignatura VALUES ('Estructura y tecnología de computadores', 6, 'básica', 1, 2, 3, 4);
INSERT INTO asignatura VALUES ('Fundamentos de electrónica', 6, 'básica', 1, 2, 14, 4);
INSERT INTO asignatura VALUES ('Lógica y algorítmica', 6, 'básica', 1, 2, 3, 4);
INSERT INTO asignatura VALUES ('Metodología de la programación', 6, 'básica', 1, 2, 14, 4);
INSERT INTO asignatura VALUES ('Arquitectura de Computadores', 6, 'básica', 2, 1, 3, 4);
INSERT INTO asignatura VALUES ('Estructura de Datos y Algoritmos I', 6, 'obligatoria', 2, 1, 3, 4);
INSERT INTO asignatura VALUES ('Ingeniería del Software', 6, 'obligatoria', 2, 1, 14, 4);
INSERT INTO asignatura VALUES ('Sistemas Inteligentes', 6, 'obligatoria', 2, 1, 3, 4);
INSERT INTO asignatura VALUES ('Sistemas Operativos', 6, 'obligatoria', 2, 1, 14, 4);
INSERT INTO asignatura VALUES ('Bases de Datos', 6, 'básica', 2, 2, 14, 4);
INSERT INTO asignatura VALUES ('Estructura de Datos y Algoritmos II', 6, 'obligatoria', 2, 2, 14, 4);
INSERT INTO asignatura VALUES ('Fundamentos de Redes de Computadores', 6 ,'obligatoria', 2, 2, 3, 4);
INSERT INTO asignatura VALUES ('Planificación y Gestión de Proyectos Informáticos', 6, 'obligatoria', 2, 2, 3, 4);
INSERT INTO asignatura VALUES ('Programación de Servicios Software', 6, 'obligatoria', 2, 2, 14, 4);
INSERT INTO asignatura VALUES ('Desarrollo de interfaces de usuario', 6, 'obligatoria', 3, 1, 14, 4);
INSERT INTO asignatura VALUES ('Ingeniería de Requisitos', 6, 'optativa', 3, 1, NULL, 4);
INSERT INTO asignatura VALUES ('Integración de las Tecnologías de la Información en las Organizaciones', 6, 'optativa', 3, 1, NULL, 4);
INSERT INTO asignatura VALUES ('Modelado y Diseño del Software 1', 6, 'optativa', 3, 1, NULL, 4);
INSERT INTO asignatura VALUES ('Multiprocesadores', 6, 'optativa', 3, 1, NULL, 4);
INSERT INTO asignatura VALUES ('Seguridad y cumplimiento normativo', 6, 'optativa', 3, 1, NULL, 4);
INSERT INTO asignatura VALUES ('Sistema de Información para las Organizaciones', 6, 'optativa', 3, 1, NULL, 4); 
INSERT INTO asignatura VALUES ('Tecnologías web', 6, 'optativa', 3, 1, NULL, 4);
INSERT INTO asignatura VALUES ('Teoría de códigos y criptografía', 6, 'optativa', 3, 1, NULL, 4);
INSERT INTO asignatura VALUES ('Administración de bases de datos', 6, 'optativa', 3, 2, NULL, 4);
INSERT INTO asignatura VALUES ('Herramientas y Métodos de Ingeniería del Software', 6, 'optativa', 3, 2, NULL, 4);
INSERT INTO asignatura VALUES ('Informática industrial y robótica', 6, 'optativa', 3, 2, NULL, 4);
INSERT INTO asignatura VALUES ('Ingeniería de Sistemas de Información', 6, 'optativa', 3, 2, NULL, 4);
INSERT INTO asignatura VALUES ('Modelado y Diseño del Software 2', 6, 'optativa', 3, 2, NULL, 4);
INSERT INTO asignatura VALUES ('Negocio Electrónico', 6, 'optativa', 3, 2, NULL, 4);
INSERT INTO asignatura VALUES ('Periféricos e interfaces', 6, 'optativa', 3, 2, NULL, 4);
INSERT INTO asignatura VALUES ('Sistemas de tiempo real', 6, 'optativa', 3, 2, NULL, 4);
INSERT INTO asignatura VALUES ('Tecnologías de acceso a red', 6, 'optativa', 3, 2, NULL, 4);
INSERT INTO asignatura VALUES ('Tratamiento digital de imágenes', 6, 'optativa', 3, 2, NULL, 4);
INSERT INTO asignatura VALUES ('Administración de redes y sistemas operativos', 6, 'optativa', 4, 1, NULL, 4);
INSERT INTO asignatura VALUES ('Almacenes de Datos', 6, 'optativa', 4, 1, NULL, 4);
INSERT INTO asignatura VALUES ('Fiabilidad y Gestión de Riesgos', 6, 'optativa', 4, 1, NULL, 4);
INSERT INTO asignatura VALUES ('Líneas de Productos Software', 6, 'optativa', 4, 1, NULL, 4);
INSERT INTO asignatura VALUES ('Procesos de Ingeniería del Software 1', 6, 'optativa', 4, 1, NULL, 4);
INSERT INTO asignatura VALUES ('Tecnologías multimedia', 6, 'optativa', 4, 1, NULL, 4);
INSERT INTO asignatura VALUES ('Análisis y planificación de las TI', 6, 'optativa', 4, 2, NULL, 4);
INSERT INTO asignatura VALUES ('Desarrollo Rápido de Aplicaciones', 6, 'optativa', 4, 2, NULL, 4);
INSERT INTO asignatura VALUES ('Gestión de la Calidad y de la Innovación Tecnológica', 6, 'optativa', 4, 2, NULL, 4);
INSERT INTO asignatura VALUES ('Inteligencia del Negocio', 6, 'optativa', 4, 2, NULL, 4);
INSERT INTO asignatura VALUES ('Procesos de Ingeniería del Software 2', 6, 'optativa', 4, 2, NULL, 4);
INSERT INTO asignatura VALUES ('Seguridad Informática', 6, 'optativa', 4, 2, NULL, 4);
INSERT INTO asignatura VALUES ('Biologia celular', 6, 'básica', 1, 1, NULL, 7);
INSERT INTO asignatura VALUES ('Física', 6, 'básica', 1, 1, NULL, 7);
INSERT INTO asignatura VALUES ('Matemáticas I', 6, 'básica', 1, 1, NULL, 7);
INSERT INTO asignatura VALUES ('Química general', 6, 'básica', 1, 1, NULL, 7);
INSERT INTO asignatura VALUES ('Química orgánica', 6, 'básica', 1, 1, NULL, 7);
INSERT INTO asignatura VALUES ('Biología vegetal y animal', 6, 'básica', 1, 2, NULL, 7);
INSERT INTO asignatura VALUES ('Bioquímica', 6, 'básica', 1, 2, NULL, 7);
INSERT INTO asignatura VALUES ('Genética', 6, 'básica', 1, 2, NULL, 7);
INSERT INTO asignatura VALUES ('Matemáticas II', 6, 'básica', 1, 2, NULL, 7);
INSERT INTO asignatura VALUES ('Microbiología', 6, 'básica', 1, 2, NULL, 7);
INSERT INTO asignatura VALUES ('Botánica agrícola', 6, 'obligatoria', 2, 1, NULL, 7);
INSERT INTO asignatura VALUES ('Fisiología vegetal', 6, 'obligatoria', 2, 1, NULL, 7);
INSERT INTO asignatura VALUES ('Genética molecular', 6, 'obligatoria', 2, 1, NULL, 7);
INSERT INTO asignatura VALUES ('Ingeniería bioquímica', 6, 'obligatoria', 2, 1, NULL, 7);
INSERT INTO asignatura VALUES ('Termodinámica y cinética química aplicada', 6, 'obligatoria', 2, 1, NULL, 7);
INSERT INTO asignatura VALUES ('Biorreactores', 6, 'obligatoria', 2, 2, NULL, 7);
INSERT INTO asignatura VALUES ('Biotecnología microbiana', 6, 'obligatoria', 2, 2, NULL, 7);
INSERT INTO asignatura VALUES ('Ingeniería genética', 6, 'obligatoria', 2, 2, NULL, 7);
INSERT INTO asignatura VALUES ('Inmunología', 6, 'obligatoria', 2, 2, NULL, 7);
INSERT INTO asignatura VALUES ('Virología', 6, 'obligatoria', 2, 2, NULL, 7);
INSERT INTO asignatura VALUES ('Bases moleculares del desarrollo vegetal', 4.5, 'obligatoria', 3, 1, NULL, 7);
INSERT INTO asignatura VALUES ('Fisiología animal', 4.5, 'obligatoria', 3, 1, NULL, 7);
INSERT INTO asignatura VALUES ('Metabolismo y biosíntesis de biomoléculas', 6, 'obligatoria', 3, 1, NULL, 7);
INSERT INTO asignatura VALUES ('Operaciones de separación', 6, 'obligatoria', 3, 1, NULL, 7);
INSERT INTO asignatura VALUES ('Patología molecular de plantas', 4.5, 'obligatoria', 3, 1, NULL, 7);
INSERT INTO asignatura VALUES ('Técnicas instrumentales básicas', 4.5, 'obligatoria', 3, 1, NULL, 7);
INSERT INTO asignatura VALUES ('Bioinformática', 4.5, 'obligatoria', 3, 2, NULL, 7);
INSERT INTO asignatura VALUES ('Biotecnología de los productos hortofrutículas', 4.5, 'obligatoria', 3, 2, NULL, 7);
INSERT INTO asignatura VALUES ('Biotecnología vegetal', 6, 'obligatoria', 3, 2, NULL, 7);
INSERT INTO asignatura VALUES ('Genómica y proteómica', 4.5, 'obligatoria', 3, 2, NULL, 7);
INSERT INTO asignatura VALUES ('Procesos biotecnológicos', 6, 'obligatoria', 3, 2, NULL, 7);
INSERT INTO asignatura VALUES ('Técnicas instrumentales avanzadas', 4.5, 'obligatoria', 3, 2, NULL, 7);

-- Insertar datos en la tabla Curso escolar
INSERT INTO curso_escolar VALUES (2014, 2015);
INSERT INTO curso_escolar VALUES (2015, 2016);
INSERT INTO curso_escolar VALUES (2016, 2017);
INSERT INTO curso_escolar VALUES (2017, 2018);
INSERT INTO curso_escolar VALUES (2018, 2019);

-- Insertar datos en la tabla Alumno se matricula en asignatura
INSERT INTO alumno_se_matricula_asignatura VALUES (1, 1, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (1, 2, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (1, 3, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (2, 1, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (2, 2, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (2, 3, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (4, 1, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (4, 2, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (4, 3, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (24, 1, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (24, 2, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (24, 3, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (24, 4, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (24, 5, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (24, 6, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (24, 7, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (24, 8, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (24, 9, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (24, 10, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (23, 1, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (23, 2, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (23, 3, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (23, 4, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (23, 5, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (23, 6, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (23, 7, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (23, 8, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (23, 9, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (23, 10, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (19, 1, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (19, 2, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (19, 3, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (19, 4, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (19, 5, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (19, 6, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (19, 7, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (19, 8, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (19, 9, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (19, 10, 5);