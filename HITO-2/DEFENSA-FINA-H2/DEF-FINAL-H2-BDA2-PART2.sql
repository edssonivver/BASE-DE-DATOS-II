/*===================================================================*/
/*===================== DEFENSA FINAL DEL HITO 2 ====================*/
/*============== BASE DE DATOS II - Ing. William Barra ==============*/
/*================= Est. Edson Iver Condori Condori =================*/
/*===================================================================*/

CREATE DATABASE tareaHito2; -- CREACION DE LA BASE DE DATOS
USE tareaHito2; -- POCISIONAMIENTO

-- CREACION DE LA TABLA ESTUDIANTE
CREATE TABLE  estudiantes (
    id_est INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombres VARCHAR (50) NOT NULL ,
    apellidos VARCHAR (50) NOT NULL,
    edad INTEGER NOT NULL,
    fono INTEGER NOT NULL ,
    email VARCHAR (100) NOT NULL ,
    direccion VARCHAR (100) NOT NULL ,
    genero VARCHAR (20)
);

-- INGRESANDO DATOS A LA TABLA ESTUDIANTES
INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, genero)
VALUES ('Miguel', 'Gonzales Veliz', 20,2832115, 'miguel@gmail.com', 'Av. 6 de Agosto', 'masculino'),
('Sandra', 'Mavir Uria', 25,2832116, 'sandra@gmail.com','Av. 6 de Agosto', 'femenino'),
('Joel', 'Adubiri Mondar', 30, 2832117, 'joel@gmail.com','Av. 6 de Agosto', 'masculino'),
('Andrea', 'Arias Ballesteros', 21, 2832118,'andrea@gmail.com', 'Av. 6 de Agosto', 'femenino'),
('Santos', 'Montes Valenzuela', 24, 2832119,'santos@gmail.com', 'Av. 6 de Agosto', 'masculino');

-- REALIZANDO UNA CONSULTA SIMPLE
SELECT  * FROM  estudiantes;

-- CREACION DE LA TABLA MATERIAS
CREATE TABLE materias (
    id_mat INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre_mat VARCHAR(100) NOT NULL ,
    cod_mat VARCHAR(100) NOT NULL
);

-- INGRESANDO DATOS A LA TABLA MATERIAS
INSERT INTO materias (nombre_mat, cod_mat)
VALUES ('Introduccion a la Arquitectura', 'ARQ-101'),
('Urbanismo y Diseno', 'ARQ-102'),
('Dibujo y Pintura Arquitectonico', 'ARQ-103'),
('Matematica discreta', 'ARQ-104'),
('Fisica Basica', 'ARQ-105');

-- REALIZANDO UN CONSULTA SIMPLE A LA TABLA MATERIAS
SELECT * FROM materias;

-- CREACION DE LA TABLA INSCRIPCION (SE REALIZA LA REALCION CON LAS 2 TABLAS ANTERIORES)
CREATE TABLE inscripcion (
    id_ins INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    semestre VARCHAR (20) NOT NULL ,
    gestion INTEGER NOT NULL,
    id_est INTEGER NOT NULL ,
    id_mat INTEGER NOT NULL ,

    -- RELACIONANDO LAS TABLAS
    FOREIGN KEY (id_est) REFERENCES estudiantes (id_est),
    FOREIGN KEY (id_mat) REFERENCES materias (id_mat)
);

-- INGRESANDO REGISTROS A LA TABLA INSCRIPCION
INSERT INTO inscripcion (id_est, id_mat, semestre, gestion)
VALUES (1, 1, '1er Semestre', 2018),
(1, 2, '2do Semestre', 2018),
(2, 4, '1er Semestre', 2019),
(2, 3, '2do Semestre', 2019),
(3, 3, '2do Semestre', 2020),
(3, 1, '3er Semestre', 2020),
(4, 4, '4to Semestre', 2021),
(5, 5, '5to Semestre', 2021);

-- REALIZANDO UNA CONSILTA SIMPLE
SELECT * FROM inscripcion;

/* ○ Resolver lo siguiente:
■ Mostrar los nombres y apellidos de los estudiantes inscritos en la
materia ARQ-105, adicionalmente mostrar el nombre de la materia */

SELECT est.id_est ,est.nombres , est.apellidos , mat.nombre_mat, mat.cod_mat
FROM estudiantes AS est
INNER JOIN materias AS mat on est.id_est = mat.id_mat
INNER JOIN inscripcion AS ins on mat.id_mat = ins.id_ins
WHERE mat.cod_mat = 'ARQ-105';

-- =================================================================== --
-- =================================================================== --

/* ■ Deberá de crear una función que reciba dos parámetros y esta
función deberá ser utilizada en la cláusula WHERE. */


 -- creando la funcion que recibe dos parametros
CREATE OR REPLACE FUNCTION comparaMateria(cod_mat VARCHAR(100), edad INTEGER)
RETURNS VARCHAR (100) -- retornamos en tipo varchar
BEGIN
    DECLARE result VARCHAR(100); -- declaramos para obtener la respuesta

    -- Implementamos la consulta anterior con algunas modificaiones
    -- concatenamos lo que queremos mostrar
    SELECT CONCAT(est.id_est,' ', est.nombres,' ', est.apellidos,' ', est.edad,' ', mat.nombre_mat,' ', mat.cod_mat)
    INTO result -- almacenamos la concatenacion en la variable decalrada anteriormente
    FROM estudiantes AS est
    INNER JOIN materias AS mat ON est.id_est = mat.id_mat -- estabelcemos lo que se va relacionar entre tablas
    WHERE mat.cod_mat = cod_mat and est.edad = edad; -- se deben de cumplir las condiciones que se manden

    -- En caso de que no se encuentre nada se devolvera o retornara lo siguiente
    IF result IS NULL THEN
        SET result = 'No se encontraron coincidencias';
    END IF;

    RETURN result; -- Se devuelve la respuesta de la funcion
END; -- Fin de la Funcion

-- CONSULTA A LA FUNCION
SELECT comparaMateria('ARQ-105',24);

-- =================================================================== --
-- =================================================================== --

/* Crear una función que permita obtener el promedio de las edades del género
masculino o femenino de los estudiantes inscritos en la asignatura ARQ-104.
○ La función recibe como parámetro el género y el código de materia. */

-- REAKIZANDO UN CONSULTA PARA LUEGO IMPLEMENTAR A UNA FUNCION
SELECT est.nombres, est.apellidos,AVG (est.edad)
FROM estudiantes AS est
INNER JOIN inscripcion ins on est.id_est = ins.id_est
INNER JOIN materias mat on ins.id_mat = mat.id_mat
WHERE mat.cod_mat = 'ARQ-104' AND est.genero = 'Femenino';

-- USANDO LA CONSULTA ANTERIOR EN UNA FUNCION
CREATE OR REPLACE FUNCTION promiedioedadgenero (genero VARCHAR(50),cod_mat VARCHAR(50))
RETURNS VARCHAR(100)
BEGIN

    DECLARE response VARCHAR(100);

    SELECT AVG (est.edad)
    INTO  response
    FROM estudiantes AS est
    INNER JOIN inscripcion ins on est.id_est = ins.id_est
    INNER JOIN materias mat on ins.id_mat = mat.id_mat
    WHERE mat.cod_mat = cod_mat AND est.genero = genero ;

     IF response IS NULL THEN
        SET response = 'No se encontraron coincidencias';
    END IF;

    RETURN response;
END;

SELECT promiedioedadgenero('femenino','ARQ-103');


-- =================================================================== --
-- =================================================================== --

/* 15.Crear una función que permita concatenar 3 cadenas.
○ La función recibe 3 parámetros.
○ Si las cadenas fuesen:
■ Pepito
■ Pep
■ 50
○ La salida debería ser: (Pepito), (Pep), (50)
○ La función creada utilizarlo en una consulta SQL.
■ Es decir podría mostrar el nombre,apellidos y la edad de los
estudiantes. */

-- CREACION DE LA FUNCION
CREATE OR REPLACE FUNCTION datosestudiante (nom VARCHAR(50), ape VARCHAR(50) , edad INTEGER )
RETURNS VARCHAR(100)
BEGIN

    DECLARE response VARCHAR(100); -- DECLARANDO TIPO DE VARIABLE

    -- CONSULTA
    SELECT CONCAT(est.nombres,' ',est.apellidos,' ',est.edad)
    INTO response
    FROM estudiantes as est
    WHERE est.nombres = nom and est.apellidos = ape and est.edad = edad;

    -- RESPUESTA EN CASO DE NO ENCONTRAR NADA
    IF response IS NULL THEN
        SET response = 'No se encontraron coincidencias';
    END IF;

    RETURN response; -- DEVOLVIENDO LA RESPUESTA
END;

-- REALIZANDO LA CONSULTA A LA FUNCION
SELECT datosestudiante('Miguel','Gonzales Veliz',20);

-- =================================================================== --
-- =================================================================== --

/* 16.Crear la siguiente VISTA:
○ La vista deberá llamarse ARQUITECTURA_DIA_LIBRE
○ El dia viernes tendrán libre los estudiantes de la carrera de
ARQUITECTURA debido a su aniversario
■ Este permiso es solo para aquellos estudiantes inscritos en el año
2018.
■ La vista deberá tener los siguientes campos.
1. Nombres y apellidos concatenados = FULLNAME
2. La edad del estudiante = EDAD
3. El año de inscripción = GESTION
4. Generar una columna de nombre DIA_LIBRE
a. Si tiene libre mostrar LIBRE
b. Caso contrario mostrar NO LIBRE */


-- CONSULTA PREVIA ANTES DE LA IMPLEMENTACION DE VISTA

SELECT CONCAT(est.nombres,' ',est.apellidos) as fullname,
       est.edad as  edad,
       ins.gestion as gestion,
        CASE
          WHEN EXISTS (SELECT 1 FROM inscripcion
                       WHERE ins.id_ins = est.id_est
                       AND ins.gestion = '2018'
                      )
          THEN 'LIBRE'
          ELSE 'NO LIBRE'
       END AS DIA_LIBRE

FROM estudiantes as est
INNER JOIN materias as mat on est.id_est = mat.id_mat
INNER JOIN inscripcion as ins on mat.id_mat = ins.id_ins
WHERE ins.gestion = 2018;

-- ===================================================================--

-- EXPLICACION DE CODIGO
SELECT CONCAT(est.nombres,' ',est.apellidos) as fullname, -- CONCATENANDO LO QUE SE DESEA MOSTRAR y ASIGNADO ALIAS
       est.edad as  edad,
       ins.gestion as gestion,

    CASE -- REALIZAMOS LA EVALUACION

        WHEN    -- WHEN ESPECIFICA LA CONCICION QUE SE DEBE CUMPLIR
        EXISTS  -- EXISTS verificara SI existe algun registro en la tabla

        (SELECT 1 FROM inscripcion  -- SELECT 1 buscara un registro q cumpla con la condicion
                                    -- si encuientra una lo devolvera como verdadero

        WHERE ins.id_ins = est.id_est -- condicionamos para que se cumpla
          AND ins.gestion = '2018') -- CONDICION Y ESTAMOS BUSCANDO
                              -- QUE SE CUMPLA ESTA CONDICION (ACTUA DE  RECEPTOR Y VERIFICADOR)

            THEN 'LIBRE'    -- THEN DEVOLVERA EL VALOR/RESPUESTA CORRECTA SI CUMPLE CON LA CONDICION
        ELSE 'NO LIBRE'     -- ELSE DEVOLVERA UNA RESPUESTA NEGATIVA SI NO CUMPLE CON LA CONDICION
        END AS DIA_LIBRE    -- ESTABLECIOENDO LA NUEVA COLUMNA

FROM estudiantes as est     -- RELACIONANDO TABLAS
INNER JOIN materias as mat on est.id_est = mat.id_mat
INNER JOIN inscripcion as ins on mat.id_mat = ins.id_ins
WHERE ins.gestion = 2020;   -- AQUI PREGUNTAMOS LO QUE SE BUSCA (ACTUA DE EMISOR "lo manda al where de arriba")


-- =================================================================--

-- IMPLEMENTANDOLO EN UNA VISTA
CREATE OR REPLACE VIEW arquitectura_dia_libre AS
SELECT CONCAT(est.nombres,' ',est.apellidos) as fullname,
       est.edad as  edad,
       ins.gestion as gestion,
        CASE
          WHEN EXISTS (SELECT 1 FROM inscripcion
                       WHERE ins.id_ins = est.id_est
                       AND ins.gestion = '2018'
                      )
          THEN 'LIBRE'
          ELSE 'NO LIBRE'
       END AS DIA_LIBRE

FROM estudiantes as est
INNER JOIN materias as mat on est.id_est = mat.id_mat
INNER JOIN inscripcion as ins on mat.id_mat = ins.id_ins
WHERE ins.gestion = 2018;

-- =================================================================== --
-- =================================================================== --

/* 17. Crear la siguiente VISTA:
○ Agregar una tabla cualquiera al modelo de base de datos.
○ Después generar una vista que maneje las 4 tablas
■ La vista deberá llamarse PARALELO_DBA_I */

-- CREANDO UN TABLA
CREATE TABLE SEDE (
    id_sede INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL ,
    nombre_sede VARCHAR (100) NOT NULL ,
    id_ins INTEGER NOT NULL ,

    FOREIGN KEY (id_ins) REFERENCES inscripcion (id_ins)
);

-- INGRESANDO REGISTROS A LA TABLA
INSERT INTO SEDE (nombre_sede, id_ins)
VALUES ('El Alto',1),
       ('La Paz',2),
       ('Oruro',3),
       ('Cochabamba',4),
       ('Santa Cruz',5);

-- REALIZANDO LA CONSULTA
SELECT est.nombres,est.apellidos,mat.cod_mat,ins.semestre,ins.gestion,se.nombre_sede
FROM estudiantes as est
INNER JOIN materias as mat on est.id_est = mat.id_mat
INNER JOIN inscripcion as ins on mat.id_mat = ins.id_ins
INNER JOIN SEDE as se on ins.id_ins = se.id_sede
WHERE ins.gestion = 2019 and se.nombre_sede = 'Oruro';

-- IMPLEMENTANDO LA VISTA
CREATE OR REPLACE VIEW PARALELO_DBA_I AS
SELECT est.nombres,est.apellidos,mat.cod_mat,ins.semestre,ins.gestion,se.nombre_sede
FROM estudiantes as est
INNER JOIN materias as mat on est.id_est = mat.id_mat
INNER JOIN inscripcion as ins on mat.id_mat = ins.id_ins
INNER JOIN SEDE as se on ins.id_ins = se.id_sede
WHERE ins.gestion = 2019 and se.nombre_sede = 'Oruro';

-- =============== REALIZADO POR: =============== --
-- ========= Edson Iver Condori Condori ========= --