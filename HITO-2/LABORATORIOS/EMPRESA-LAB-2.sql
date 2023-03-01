CREATE DATABASE EMPRESA;
USE EMPRESA;

DROP DATABASE Empresa;

CREATE TABLE Empleado(
    id_empl INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL ,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    edad INTEGER NOT NULL
);

CREATE TABLE Area(
    id_area integer auto_increment primary key  not null ,
    nombre_area VARCHAR(50)
);

CREATE TABLE Empresa(
    Nit INTEGER PRIMARY KEY NOT NULL ,
    nombre_empresa VARCHAR (50)NOT NULL,
    id_empl INTEGER NOT NULL ,
    id_area INTEGER NOT NULL ,

    FOREIGN KEY (id_empl) REFERENCES Empleado (id_empl),
    FOREIGN KEY (id_area) REFERENCES Area (id_area)
);

INSERT INTO Empleado (nombre, apellido, edad)
VALUES ('JUAN','LOPEZ',25),
       ('CARLOS','MENDEZ',28),
       ('JOSE','HEREDIA',19),
       ('PEDRO','MENDOZA',32),
       ('OSCAR','MAMANI',24);

INSERT INTO Area (nombre_area)
VALUES ('sistemas'),
       ('logistica'),
       ('produccion'),
       ('marketin'),
       ('ventas');

    INSERT INTO Empresa (Nit, nombre_empresa, id_empl, id_area )
    VALUES (1001111,'PIL',1,1),
           (2552222,'ENDE',2,2),
           (3663333,'IMCRUZ',3,3),
           (4994444,'UNIFRANZ',4,4),
           (5665555,'PANDA',5,5);


SELECT E.nombre , A.nombre_area , nombre_empresa
FROM Empresa INNER JOIN Empleado E on Empresa.id_empl = E.id_empl
INNER JOIN Area A on Empresa.id_area = A.id_area
WHERE E.nombre = 'CARLOS'
