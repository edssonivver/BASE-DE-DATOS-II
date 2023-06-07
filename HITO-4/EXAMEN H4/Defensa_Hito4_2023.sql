/*===================================================================*/
/*===================== EXAMEN FINAL DEL HITO 4 ====================*/
/*============== BASE DE DATOS II - Ing. William Barra ==============*/
/*================= Est. Edson Iver Condori Condori =================*/
/*===================================================================*/


CREATE DATABASE Defensa_H4_2023;

USE Defensa_H4_2023;

CREATE TABLE proyecto(
    id_proy INTEGER  PRIMARY KEY  ,
    nombreProy VARCHAR (100) ,
    tipoProy VARCHAR(30)
);

# INSERTANDO DATOS
INSERT INTO proyecto (id_proy,nombreProy, tipoProy)
VALUES (1,'Maquetacion','Practico'),
       (2,'Reporte General','HISTORIA');

CREATE TABLE departamento(
    id_dep INTEGER  PRIMARY KEY ,
    nombre VARCHAR(50)
);

INSERT INTO departamento(id_dep, nombre)
VALUES (1,'La Paz'),
       (2,'El Alto');


CREATE TABLE  provincia(
    id_prov INTEGER PRIMARY KEY ,
    nombre VARCHAR (50),

    id_dep INTEGER,

    FOREIGN KEY (id_dep) REFERENCES departamento (id_dep)
);

INSERT INTO provincia (id_prov,nombre, id_dep)
VALUES (1,'Murrillo',1),
       (2,'Carangas',2);

CREATE TABLE persona (
    id_per INTEGER PRIMARY KEY ,
    nombre VARCHAR (20)   ,
    apellido VARCHAR (50)   ,
    fecha_nac DATE,
    edad INTEGER,
    email VARCHAR (50)  ,
    genero CHAR   ,

    id_dep INTEGER   ,
    id_prov INTEGER   ,

    FOREIGN KEY (id_dep) REFERENCES departamento (id_dep),
    FOREIGN KEY (id_prov) REFERENCES provincia (id_prov)
);

INSERT INTO persona (id_per,nombre, apellido, fecha_nac, edad, email, genero, id_dep, id_prov)
VALUES (1,'Juan','Lopez','1999-02-25',24,'juanlop@gmail.com','M',1,1),
       (2,'Carla','Soliz','2000-10-10',23,'carlasoliz@gmail.com','F',2,2);

CREATE TABLE detalle_proyecto(
    id_pd INTEGER  PRIMARY KEY   ,
    id_per INTEGER   ,
    id_proy INTEGER   ,

    FOREIGN KEY (id_per) REFERENCES persona (id_per),
    FOREIGN KEY (id_proy) REFERENCES proyecto (id_proy)
);

INSERT INTO detalle_proyecto (id_pd,id_per, id_proy)
VALUES (1,1,1),
       (2,2,2);



/*===================================================================*/
/*========================== EJERCICIO 1 ========================*/
/*===================================================================*/


CREATE TABLE audit_proyectos(
    nombre_proy_anterior VARCHAR(30),
    nombre_proy_posterior VARCHAR(30),
    tipo_proy_anterior VARCHAR(30),
    tipo_proy_posterior VARCHAR(30),
    operation VARCHAR(30),
    userId VARCHAR(30) ,
    hostName VARCHAR(30),
    fecha VARCHAR (30)
);



# PARA INSERT
CREATE OR REPLACE TRIGGER audit_proyectos_insert
BEFORE INSERT ON proyecto
FOR EACH ROW
    BEGIN
         INSERT INTO audit_proyectos(nombre_proy_anterior, nombre_proy_posterior,   tipo_proy_anterior, tipo_proy_posterior, operation, userId, hostName,fecha)
         SELECT 'NO EXISTE VALORES PREVIOS',NEW.nombreProy,'NO EXISTE VALORES PREVIOS',NEW.tipoProy,'INSERT',USER(),@@HOSTNAME,NOW();
    END;

SELECT * FROM proyecto;
SELECT * FROM audit_proyectos;



# PARA UPDATE
create or replace trigger audit_proyectos_update
before update on proyecto
for each row
begin
    insert into audit_proyectos (nombre_proy_anterior, nombre_proy_posterior, tipo_proy_anterior, tipo_proy_posterior, operation, userId, hostName, fecha)
    values(OLD.nombreProy, new.nombreProy, old.tipoProy, new.tipoProy, 'update', user(), @@hostName, NOW());
end;

update proyecto
set nombreProy='proyecto3'
where id_proy=1;

select * from audit_proyectos;



# PARA DELETE
CREATE OR REPLACE TRIGGER audit_proyectos_delete
AFTER DELETE ON proyecto
FOR EACH ROW
    BEGIN

    insert into audit_proyectos (nombre_proy_anterior, nombre_proy_posterior, tipo_proy_anterior, tipo_proy_posterior, operation, userId, hostName, fecha)
    values(OLD.nombreProy, 'no hay datos que mostrar', old.tipoProy, 'No hay datos que mostrar', 'DELETE', user(), @@hostName, NOW());

    END;

select * from proyecto;
select * from audit_proyectos;


/*===================================================================*/
/*========================== EJERCICIO 2 ========================*/
/*===================================================================*/

SELECT CONCAT(per.nombre ,' ', per.apellido) FULLNAME ,
       CONCAT(pro.nombreProy ,' ', pro.tipoProy) DESCRIPCION_PROYECTO,
       d.nombre as departamento ,
       d.id_dep
FROM persona as per
INNER JOIN detalle_proyecto detpr on per.id_per = detpr.id_pd
INNER JOIN proyecto pro on detpr.id_pd = pro.id_proy
INNER JOIN departamento d on pro.id_proy = d.id_dep
INNER JOIN provincia vin on vin.id_prov = d.id_dep;



CREATE OR REPLACE VIEW reporte_proyecto as
SELECT CONCAT(per.nombre ,' ', per.apellido) FULLNAME ,
    CONCAT(pro.nombreProy , pro.tipoProy) DESCRIPCION_PROYECTO,
    d.nombre as departamento , d.id_dep,
     CASE
            when d.nombre = 'La Paz' then 'LP'
            when d.nombre = 'El ALTO' then 'EAT'
    END AS codigo_dep
FROM persona as per
INNER JOIN detalle_proyecto detpr on per.id_per = detpr.id_pd
INNER JOIN proyecto pro on detpr.id_pd = pro.id_proy
INNER JOIN departamento d on pro.id_proy = d.id_dep
INNER JOIN provincia vin on vin.id_prov = d.id_dep;


SELECT * FROM reporte_proyecto;

/*===================================================================*/
/*========================== EJERCICIO 3 ========================*/
/*===================================================================*/

select * from proyecto;

CREATE OR REPLACE TRIGGER tr_validacion
BEFORE INSERT ON proyecto
FOR EACH ROW
    BEGIN

        DECLARE dia_senama TEXT DEFAULT '';
        DECLARE mes TEXT DEFAULT '';
        SET mes = MONTHNAME(CURRENT_DATE);
        SET dia_senama = DAYNAME(CURRENT_DATE);

     IF dia_senama = 'Wednesday'  AND new.tipoProy = 'FORESTACION' AND  mes = 'JULY' THEN
            SIGNAL SQLSTATE '45000'
            SET  MESSAGE_TEXT = 'NO SE ADMITEN DATOS';
        end if;
    END;

INSERT INTO proyecto(id_proy, nombreProy, tipoProy)
VALUES (6,'PRACTICA','FORESTACION');

INSERT INTO proyecto(id_proy, nombreProy, tipoProy)
VALUES (7,'PRACTICA','EDUCACION');

SELECT * FROM proyecto;


CREATE OR REPLACE TRIGGER tr_validacion_V2
BEFORE INSERT ON proyecto
FOR EACH ROW
    BEGIN
        DECLARE dia_senama TEXT DEFAULT '';
        DECLARE mes TEXT DEFAULT '';
        SET mes = MONTHNAME(CURRENT_DATE);
        SET dia_senama = DAYNAME(CURRENT_DATE);

     IF dia_senama = 'Wednesday'  AND new.tipoProy = 'FORESTACION' AND  mes = 'JUNE' THEN
            SIGNAL SQLSTATE '45000'
            SET  MESSAGE_TEXT = 'NO SE ADMITEN DATOS DE FORESTACION';
        end if;
    END;

INSERT INTO proyecto(id_proy, nombreProy, tipoProy)
VALUES (5,'PRACTICA','FORESTACION');

INSERT INTO proyecto(id_proy, nombreProy, tipoProy)
VALUES (6,'PRACTICA','EDUCACION');


SELECT * FROM proyecto;

/*===================================================================*/
/*========================== EJERCICIO 4 ========================*/
/*===================================================================*/

CREATE or REPLACE FUNCTION diccionario (dia text)
RETURNS TEXT
BEGIN
    DECLARE response TEXT DEFAULT '';
    CASE
            when dia = 'Monday' then SET response = 'Lunes';
            when dia = 'Tuesday ' then SET response = 'Martes';
            when dia = 'Wednesday ' then SET response = 'Miercoles';
            when dia = 'Thursday ' then SET response = 'Jueves';
            when dia = 'Friday ' then SET response = 'viernes';
            when dia = 'Saturday ' then SET response = 'Sabado';
            when dia = 'Sunday ' then SET response = 'Domingo';
    END CASE;

    RETURN response;
END;

select  diccionario  ('Friday');
select  diccionario  ('Sunday');
select  diccionario  ('Wednesday');
