/*===================================================================*/
/*============== BASE DE DATOS II - Ing. William Barra ==============*/
/*================= Est. Edson Iver Condori Condori =================*/
/*===================================================================*/


SHOW DATABASES;  -- VISUALIZANDO LAS BASES DE DATOS EXISTENTES

CREATE DATABASE Hito_II; -- CREANDO LA BASE DE DATOS

USE  Hito_II; -- POSICIONADO EN LA BASE DE DATOS HITO-II

-- CREANDO LA TABLA
CREATE TABLE Estudiante
(
  ci VARCHAR (50) PRIMARY KEY  NOT NULL ,
  Nombre VARCHAR (50) NOT NULL ,
  Apellido VARCHAR (50) NOT NULL
);

-- INGRESANDO REGISTROS A LA TABLA
INSERT INTO estudiante (ci, Nombre, Apellido)
values ('464645 LP','JUAN','LOPEZ'),
       ('654654 LP','PEDRO','GUTIERREZ');

-- REALIZANDO UNA CONSULTA
SELECT * FROM estudiante
WHERE Apellido = 'LOPEZ';

/*-----------------------------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------------------------------*/

CREATE DATABASE Universidad; -- CREANDO LA BASE DE DATOS

USE Universidad;  -- POSICIONANDO EN LA BASE DE DATOS UNIVERSIDAD

-- CREANDO LA TABLA ESTUDIANTE
CREATE TABLE Estudiante
(
    Id_Estudiante INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    Nombres VARCHAR (100) NOT NULL,
    Apellidos VARCHAR (100) NOT NULL,
    Edad  INT NOT NULL,
    Fono INT NOT NULL,
    Email VARCHAR (50) NOT NULL
);

-- VISUALIZANDO LOS ATRIBUTOS DE NUESTA TABLA
DESCRIBE Estudiante; -- DESCRIBE NOS SIRVE PARA PODER VER TODOS LOS ATRIBUTOS QUE ESTAN EL LA TABLA

-- INSERTANDO DATOS/REGISTROS A LA TABLA ESTUDIANTE
INSERT INTO Estudiante (Nombres,Apellidos,Edad,Fono,Email)
VALUES ('Nombre 1','Apellido 1',10,11111,'user1@gmail.com'),
       ('Nombre2','Apellido2',20,11111,'user2@gmail.com'),
       ('Nombre3','Apellido3',10,11111,'user3@gmail.com');

-- VISUALIZANDO EL ULTIMO REGISTRO
Select last_insert_id();
-- Select last_insert_id()  NOS SIRVE PARA PODER VER EL ULTIMO REGISTRO

-- CONSULTANDO A LA TABLA ESTUDIANTE
SELECT * FROM Estudiante;

-- ALTERACION DE TABLAS
ALTER TABLE estudiante  -- COMANDO ALTER NOS PERMITE ALTERAR LA TABLA
ADD COLUMN Direccion varchar(30)  /* ADD COLUM PERMITE AÑADIR UNA NUEVA COLUMNA */
default 'EL ALTO';    /* default permite añadir un capor por defecto */