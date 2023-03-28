/*===================================================================*/
/*===================== DEFENSA FINAL DEL HITO 2 ====================*/
/*============== BASE DE DATOS II - Ing. William Barra ==============*/
/*================= Est. Edson Iver Condori Condori =================*/
/*===================================================================*/

--  PARTE PRACTICA
CREATE DATABASE Pollos_Copa; -- creacion de la base de datos
USE Pollos_Copa; -- posicionando en la base de datos

-- CREACION DE TABLA CLIENTES
CREATE TABLE Clientes(
    id_cliente INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL ,
    fullname VARCHAR (30) NOT NULL,
    lastname VARCHAR (30) NOT NULL,
    edad INTEGER NOT NULL ,
    domicilio VARCHAR (50) NOT NULL
);

-- INGRESANDO REGISTROS A LA TABLA CLIENTES
INSERT INTO Clientes (fullname, lastname, edad, domicilio)
VALUES('Edson Iver','Condori Condori',19,'Faro Murillo'),
      ('Jhonatan David','Alanoca Blanco',21,'16 de Julio'),
      ('Carlo Hernesto','Torres de la Cruz',22,'Obelisco'),
      ('Juan Carlos','Vazques Ramos',25,'Sopocachi'),
      ('Carmen Gabriela','Lopez Mendoza',23,'Costanera');

-- REALIZANDO UNA CONSULTA BASICA A LA TABLA CLIENTES
SELECT * FROM clientes;

-- CREACION DE TABLA PEDIDO
CREATE TABLE pedido (
    id_pedido INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    articulo VARCHAR (100) NOT NULL,
    costo INTEGER NOT NULL,
    fecha DATE NOT NULL
);

-- INGRESANDO REGISTROS A LA TABLA PEDIDO
INSERT INTO pedido (articulo, costo,fecha)
VALUES('Cesta de Pollo',95,'2022-03-25'),
      ('1/2 de Pollo',85,'2022-03-22'),
      ('Combo Fiesta',60,'2022-03-18'),
      ('Balde de Alitas',70,'2022-03-15'),
      ('Combo Doble',45,'2022-03-10');

-- REALIZANDO UN CONSULTA BASICA A LA TABLA PEDIDO
SELECT * FROM pedido;

-- CRENADO LA TABLA DETALLE PEDIDO CON RELACION DE LAS 2 TABLAS ANTERIORES
CREATE TABLE detalle_pedido (
    id_detalle INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    id_cliente INTEGER NOT NULL,
    id_pedido INTEGER NOT NULL,

    FOREIGN KEY (id_cliente) REFERENCES Clientes  (id_cliente),
    FOREIGN KEY (id_pedido) REFERENCES pedido (id_pedido)
);

-- INGRESANDO REGISTROS A LA TABLA DETALLE PEDIDO
INSERT INTO detalle_pedido (id_cliente, id_pedido)
VALUES (1,1),
       (2,2),
       (3,3),
       (4,4),
       (5,5);

SELECT * FROM detalle_pedido;

/* 12.Crear una consulta SQL en base al ejercicio anterior.
○ Debe de utilizar las 3 tablas creadas anteriormente.
○ Para relacionar las tablas utilizar INEER JOIN.
○ Adjuntar el código SQL generado. */

SELECT cl.fullname,cl.lastname,ped.costo,ped.fecha,detped.id_pedido -- LO QUE SE MUESTRA
FROM clientes as cl
INNER JOIN pedido as ped on cl.id_cliente = ped.id_pedido -- RELACIONANDO LAS TABLAS EN LA CONSULTA
INNER JOIN detalle_pedido as detped on ped.id_pedido = detped.id_detalle
WHERE cl.fullname like '%Ed%' and ped.costo = 95; -- LAS CONDICIONES QUE SE DEBEN CUMPLIR

-- OTRO EJEMPLO
SELECT cl.fullname,cl.lastname,ped.costo,ped.fecha,detped.id_pedido -- LO QUE SE MUESTRA
FROM clientes as cl
INNER JOIN pedido as ped on cl.id_cliente = ped.id_pedido
INNER JOIN detalle_pedido as detped on ped.id_pedido = detped.id_detalle
WHERE ped.articulo = 'Combo Fiesta'; -- LA CONDICION QUE SE DEBE CUMPLIR


