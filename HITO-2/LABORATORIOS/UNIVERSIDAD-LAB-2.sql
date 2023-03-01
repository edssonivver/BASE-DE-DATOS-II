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


/*--------------------------------------*/
/*---------------- CLASE 2 -------------*/
/*--------------------------------------*/

-- AGREGANDO DOS CAMPOS A UNA TABLA SIN ELIMINAR LOS DATOS Y LA TABLA
ALTER TABLE Estudiante
ADD COLUMN Fax VARCHAR(10),
ADD COLUMN Genero VARCHAR(10);

SELECT *FROM Estudiante;

-- BORRANDO UNA COLUMNA DE UNA TABLA
-- con este comando se puede boorar una colunma de una tabla
ALTER TABLE estudiante
DROP COLUMN Fax;

-- REALIZANDO CONSULTAS CON WHERE

SELECT * FROM Estudiante as est
WHERE est.Nombres = 'Nombre3';


-- mostrar toslos los datos del estudiante donde el estudiante sea mayor a 18
SELECT   est.Nombres,
         est.Apellidos as 'apellidos de la persona',
         est.edad
from estudiante as est
WHERE est.Edad >= 18;

-- MOSTRAR LOS REGISTROS CUYA ID SEA PAR O IMPAR

SELECT * FROM estudiante as est
WHERE est.Id_Estudiante %2=!0;


-- BORRANDO LA TABLA
DROP DATABASE Universidad;

CREATE DATABASE Universidad;

USE Universidad;

CREATE TABLE Estudiantes (
    id_est INTEGER AUTO_INCREMENT PRIMARY kEY NOT NULL ,
    Nombre VARCHAR (100) not null ,
    apellidos varchar (100) not null ,
    edad integer not null,
    fono integer not null ,
    email varchar(100) not null
);

CREATE TABLE Materias (
    id_mat INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL ,
    Nombre_mat VARCHAR (100) NOT NULL ,
    cod_mat VARCHAR(100) NOT NULL
);

CREATE TABLE inscripcion (
    id_inst integer auto_increment primary key not null ,
    id_est integer not null ,
    id_mat integer not null ,

    FOREIGN KEY (id_est) REFERENCES Estudiantes(id_est),
    FOREIGN KEY (id_mat)REFERENCES Materias(id_mat)
);

/*=====================================================*/
/*=====================================================*/
-- CREACION DE UNA NUEVA BASE DE DATOS PARA UNA LIBRERIA
/*=====================================================*/
/*=====================================================*/


CREATE DATABASE Libreria;
USE Libreria;

    CREATE TABLE Categories(
        Category_id INTEGER auto_increment primary key not null,
        name varchar (50) not null
    );

create table  Publishers (
    publisherd_id integer auto_increment primary key not null ,
    name varchar(50)
);

CREATE TABLE books(
    books_id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL ,
    title VARCHAR(50) NOT NULL ,
    isbn VARCHAR (50) NOT NULL ,
    published_date DATE NOT NULL ,
    descripcion VARCHAR(50) not null ,
    category_id INTEGER NOT NULL ,
    publisherd_id  INTEGER NOT NULL,

    FOREIGN KEY (category_id) REFERENCES Categories(category_id),
    FOREIGN KEY (publisherd_id) REFERENCES Publishers(publisherd_id)
);
