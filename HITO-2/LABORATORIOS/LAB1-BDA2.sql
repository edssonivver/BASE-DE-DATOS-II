SHOW DATABASES;

CREATE DATABASE Hito_II;

USE Hito_II;

CREATE TABLE Estudiante (
    Ci VARCHAR (50) PRIMARY KEY,
    NOMBRE VARCHAR (20),
    APELLIDO VARCHAR (20)
);

INSERT INTO Estudiante (ci, nombre, apellido) values ('156516 LP', 'JUAN' , 'MENDOZA' );
INSERT INTO Estudiante (ci, nombre, apellido) values ('654654 SC','PEDRO', 'LOPEZ');

SELECT * FROM Estudiante
WHERE APELLIDO = 'MENDOZA';

/*-----------------------------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------------------------------*/

CREATE DATABASE Universidad;

USE Universidad;

CREATE TABLE Estudiante
(
    Id_Estudiante INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    Nombres VARCHAR (100) NOT NULL,
    Apellidos VARCHAR (100) NOT NULL,
    Edad  INT NOT NULL,
    Fono INT NOT NULL,
    Email VARCHAR (50) NOT NULL
);

DESCRIBE Estudiante;

INSERT INTO Estudiante (Nombres,Apellidos,Edad,Fono,Email)
VALUES ('Nombre 1','Apellido 1',10,11111,'user1@gmail.com'),
       ('Nombre2','Apellido2',20,11111,'user2@gmail.com'),
       ('Nombre3','Apellido3',10,11111,'user3@gmail.com');


-- Select last_insert_id()

SELECT * FROM Estudiante;

-- ALTERACION DE TABLAS

ALTER TABLE estudiante
ADD COLUMN Direccion varchar(30)  /* ADD COLUM PERMITE AÑADIR UNA NUEVA COLUMNA */
default 'EL ALTO';    /* default permite añadir un capor por defecto */