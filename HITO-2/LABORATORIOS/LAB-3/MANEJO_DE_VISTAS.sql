CREATE DATABASE Hito_2_v2;

USE Hito_2_v2;

CREATE TABLE users
(
    id_user INTEGER AUTO_INCREMENT PRIMARY KEY ,
    name VARCHAR (50) NOT NULL ,
    lastname VARCHAR (50) NOT NULL ,
    age INTEGER NOT NULL ,
    email VARCHAR (100) NOT NULL
);

INSERT INTO users (name, lastname, age, email)
VALUES ('Name1','lastname1',20,'name1@gmail.com'),
       ('Name2','lastname2',30,'name2@gmail.com'),
       ('Name3','lastname3',40,'name3@gmail.com');

select * from users;

-- USO DE VISTAS (DEBE IR JUNTO CON LA CUNSULTA)
CREATE VIEW  mayores_a_30 AS
-- MOSTRAR LOS USUARIOS MAYORES A 30 (DEBE IR JUNTO CON LA VISTA)
SELECT * FROM users AS us
WHERE us.age > 30;

SELECT * FROM mayores_a_30;

-- MODIFICACION DE VISTAS

ALTER VIEW mayores_a_30 AS
    SELECT us.name,us.lastname,us.age,us.email
    FROM users AS us
    WHERE us.age > 30;

-- MODIFICAR LA VISTA ANTERIOR PARA QUE MUESTRE LOS SUGUIENTES CAMPOS
-- FULLNAME = Nombres y apellidos
-- EDAD_USUARIO = La edad de Usuario
-- EMAIL_USUARIO = email de usuario

ALTER VIEW mayores_a_30 AS
    SELECT CONCAT(us.name, ' ',  us.lastname ) AS FULLNAME,
    us.age AS EDAD_DEL_USUARIO , us.email  AS EMAIL_DEL_USUARIO
    FROM users AS us
WHERE us.age > 30;

-- CONSULTANDO A LA VISTA
SELECT *
    FROM mayores_a_30 AS us
WHERE us.EDAD_DEL_USUARIO > 30;

-- A LA VISTA ANTERIOR MOSTRAR AQUELLOS USUARIOS QUE TENGAN EL EL APELLIDO EL NUMERO 3
-- preguntar a mayores_a_30
SELECT us.FULLNAME
FROM mayores_a_30 AS us
where us.FULLNAME like '%3%';


-- ELIMINADO VISTAS
DROP VIEW mayores_a_30;
