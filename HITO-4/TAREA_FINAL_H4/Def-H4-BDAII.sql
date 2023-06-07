
/*===================================================================*/
/*===================== DEFENSA FINAL DEL HITO 4 ====================*/
/*============== BASE DE DATOS II - Ing. William Barra ==============*/
/*================= Est. Edson Iver Condori Condori =================*/
/*===================================================================*/

/*===================================================================*/
/*========================== PARTE PRACTICA =========================*/
/*===================================================================*/

# 9. Crear la siguiente Base de datos y sus registros.

CREATE DATABASE DefH4;

USE DefH4;

CREATE TABLE proyecto(
    id_proy INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombreProy VARCHAR (100) NOT NULL,
    tipoProy VARCHAR(30) NOT NULL
);

# INSERTANDO DATOS
INSERT INTO proyecto (nombreProy, tipoProy)
VALUES ('Maquetacion','Practico'),
       ('Reporte General','HISTORIA'),
       ('Enseñansa','EDUCACION'),
       ('Reporte General','FORESTACION'),
       ('Informe','CULTURA');

CREATE TABLE departamento(
    id_dep INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL ,
    nombre VARCHAR(50)
);

INSERT INTO departamento(nombre)
VALUES ('La Paz'),
       ('Oruro'),
       ('Santa Cruz'),
       ('El Alto'),
       ('Chuquisaca');


CREATE TABLE  provincia(
    id_prov INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL ,
    nombre VARCHAR (50),

    id_dep INTEGER NOT NULL,

    FOREIGN KEY (id_dep) REFERENCES departamento (id_dep)
);

INSERT INTO provincia (nombre, id_dep)
VALUES ('Murrillo',1),
       ('Carangas',2),
       ('Chiquitos',3),
       ('Carrasco',4),
       ('Juana Azurduy',5);

CREATE TABLE persona (
    id_per INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL ,
    nombre VARCHAR (20) NOT NULL ,
    apellido VARCHAR (50) NOT NULL ,
    fecha_nac DATE,
    edad INTEGER,
    email VARCHAR (50) NOT NULL,
    genero CHAR NOT NULL ,

    id_dep INTEGER NOT NULL ,
    id_prov INTEGER NOT NULL ,

    FOREIGN KEY (id_dep) REFERENCES departamento (id_dep),
    FOREIGN KEY (id_prov) REFERENCES provincia (id_prov)
);

INSERT INTO persona (nombre, apellido, fecha_nac, edad, email, genero, id_dep, id_prov)
VALUES ('Juan','Lopez','2000-10-12',23,'juanlop@gmail.com','M',1,1),
       ('Oscar','Mendoza','2001-01-25',22,'osmen@gmail.com','M',2,2),
       ('Rosio','Mamani','1998-03-12',25,'rosma@gmail.com','F',3,3),
       ('Carla','Soliz','2000-10-10',23,'carlasoliz@gmail.com','F',4,4),
       ('Pedro','Ramirez','1995-02-05',28,'pedroramirez@gmail.com','M',5,5);

CREATE TABLE detalle_proyecto(
    id_pd INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL ,
    id_per INTEGER NOT NULL ,
    id_proy INTEGER NOT NULL ,

    FOREIGN KEY (id_per) REFERENCES persona (id_per),
    FOREIGN KEY (id_proy) REFERENCES proyecto (id_proy)
);

INSERT INTO detalle_proyecto (id_per, id_proy)
VALUES (1,1),
       (2,2),
       (3,3),
       (4,4),
       (5,5);


/*===================================================================*/
# 10.Crear una función que sume los valores de la serie Fibonacci.
/*===================================================================*/

# Calculando La Serie Figonaci
CREATE OR REPLACE FUNCTION generar_fibonacci(NumerLimit INT)
RETURNS TEXT
BEGIN
  DECLARE num1 INT DEFAULT 0;
  DECLARE cont INT DEFAULT 1;
  DECLARE num2 INT DEFAULT 1;
  DECLARE result TEXT DEFAULT '';

  SerieFigonaci: LOOP
     IF cont > NumerLimit THEN
          LEAVE SerieFigonaci;  #LEAVE SALE DEL BUCLE
        END IF;

    SET result = CONCAT(result, num2, ',');
    SET num2 = num1 + num2;
    SET num1 = num2 - num1;
    SET cont = cont + 1;
  END LOOP SerieFigonaci;

RETURN SUBSTRING(result, 1,LENGTH(result) - 1);
END;

# Hallando la Suma de la Serie
CREATE OR REPLACE FUNCTION fibonacci_suma(NumerLimit INT)
RETURNS TEXT
BEGIN

  DECLARE num1 INT DEFAULT 0;
  DECLARE cont INT DEFAULT 1;
  DECLARE num2 INT DEFAULT 1;
  DECLARE result TEXT DEFAULT '';
  DECLARE suma INTEGER DEFAULT 0;

  SerieFigonaci: LOOP
      #verifica si se seguira cumpliendo la secuencia
     IF cont > NumerLimit THEN
          LEAVE SerieFigonaci;  #LEAVE SALE DEL BUCLE
        END IF;

    SET result = CONCAT(result, num2, ',');
    SET num2 = num1 + num2;
    SET num1 = num2 - num1;
    SET cont = cont + 1;

    SET suma = num1 + num2 - 1;

  END LOOP SerieFigonaci;
    RETURN suma;
end;

SELECT generar_fibonacci(5); #45 ES EL LIMITE
SELECT fibonacci_suma(5);



/*===================================================================*/
                    # 11.Manejo de vistas.
/*===================================================================*/

# ○ Crear una consulta SQL para lo siguiente.
# ■ La consulta de la vista debe reflejar como campos:
# 1. nombres y apellidos concatenados
# 2. la edad
# 3. fecha de nacimiento.
# 4. Nombre del proyecto
# ○ Obtener todas las personas del sexo femenino que hayan nacido en el
# departamento de El Alto en donde la fecha de nacimiento sea:
            # 1. fecha_nac = '2000-10-10'

# Creando la consulta
SELECT CONCAT(per.nombre ,' ', per.apellido) Nombre_Completo, per.edad, per.fecha_nac , proy.nombreProy
FROM persona as per
INNER JOIN proyecto as proy on per.id_per = proy.id_proy
INNER JOIN departamento as dep on proy.id_proy = dep.id_dep
WHERE per.genero = 'F' and dep.nombre = 'El Alto' and per.fecha_nac = '2000-10-10';

# CREANDO LA VISTA
CREATE OR REPLACE VIEW vista_de_datos_1 as
    SELECT CONCAT(per.nombre ,' ', per.apellido) Nombre_Completo, per.edad, per.fecha_nac , proy.nombreProy
    FROM persona as per
    INNER JOIN proyecto as proy on per.id_per = proy.id_proy
    INNER JOIN departamento as dep on proy.id_proy = dep.id_dep
    WHERE per.genero = 'F' and dep.nombre = 'El Alto' and per.fecha_nac = '2000-10-10';

SELECT * FROM vista_de_datos_1;



/*===================================================================*/
# 12.Manejo de TRIGGERS I.
/*===================================================================*/

# ○ Crear TRIGGERS Before or After para INSERT y UPDATE aplicado a la tabla
# PROYECTO
        # ■ Debera de crear 2 triggers minimamente.

# ○ Agregar un nuevo campo a la tabla PROYECTO.
        # ■ El campo debe llamarse ESTADO

# ○ Actualmente solo se tiene habilitados ciertos tipos de proyectos.
        # ■ EDUCACION, FORESTACION y CULTURA
# ○ Si al hacer insert o update en el campo tipoProy llega los valores
# EDUCACION, FORESTACIÓN o CULTURA, en el campo ESTADO colocar el valor
# ACTIVO. Sin embargo se llegat un tipo de proyecto distinto colocar
# INACTIVO

#Añadiendo un nuevi campo a la tabla proyecto
ALTER TABLE proyecto
ADD COLUMN estado VARCHAR(20);

# CREANDO EL TRIGGER PARA INSERT
CREATE  OR REPLACE  TRIGGER tr_insert_estado
BEFORE INSERT ON proyecto
FOR EACH ROW
BEGIN

    IF (NEW.tipoProy = 'Educacion' or NEW.tipoProy = 'Forestacion' or NEW.tipoProy = 'Cultura') THEN
        SET NEW.estado = 'ACTIVO';
    ELSE
        SET NEW.estado = 'INACTIVO';
    end if;

END;

INSERT INTO proyecto (nombreProy, tipoProy)
VALUES ('Tarea 5','CULTURA');

INSERT INTO proyecto (nombreProy, tipoProy)
VALUES ('TAREA 2','ANTROPOLOGIA');

SELECT * from proyecto;
DROP TRIGGER tr_insert_estado;

# PARA EL TRIGGER DE UPDATE

CREATE OR REPLACE  TRIGGER tr_update_estado
BEFORE UPDATE ON proyecto
FOR EACH ROW
BEGIN

    IF (NEW.tipoProy = 'Educacion' or NEW.tipoProy = 'Forestacion' or NEW.tipoProy = 'Cultura') THEN
        SET NEW.estado = 'ACTIVO';
    ELSE
        SET NEW.estado = 'INACTIVO';
    end if;

END;


SELECT * FROM proyecto;

# ACTUALIZANDO EL REGISTRO DE LA TABLA PROYECTO
UPDATE proyecto
SET tipoProy = 'Educacion'
WHERE id_proy = 1;

DROP TRIGGER tr_update_estado;



/*===================================================================*/
# 13.Manejo de Triggers II.
/*===================================================================*/

# ○ El trigger debe de llamarse calculaEdad.
# ○ El evento debe de ejecutarse en un BEFORE INSERT.
# ○ Cada vez que se inserta un registro en la tabla PERSONA, el trigger debe de
# calcular la edad en función a la fecha de nacimiento.
# ○ Adjuntar el código SQL generado y una imagen de su correcto
# funcionamiento.


CREATE OR REPLACE TRIGGER tr_calculaEdad
BEFORE INSERT ON persona
FOR EACH ROW
    BEGIN
        # NOS PERMITIRA SABER LA EDAD DE LA PERSONA
        SET NEW.edad = TIMESTAMPDIFF(YEAR, NEW.fecha_nac, CURDATE());
    END;

INSERT INTO persona (nombre, apellido, fecha_nac, email, genero, id_dep, id_prov)
VALUES ('EDSON','CONDORI','2004-04-01','edsco@gmail.com','M',1,1);

SELECT * from persona;

drop trigger tr_calculaEdad;


/*===================================================================*/
            # 14.Manejo de TRIGGERS III.
/*===================================================================*/

# ○ Crear otra tabla con los mismos campos de la tabla persona(Excepto el
# primary key id_per).
#       ■ No es necesario que tenga PRIMARY KEY.
# ○ Cada vez que se haga un INSERT a la tabla persona estos mismos valores
# deben insertarse a la tabla copia.
# ○ Para resolver esto deberá de crear un trigger before insert para la tabla
# PERSONA.
# ○ Adjuntar el código SQL generado y una imagen de su correcto
# funcionamiento.

# CRENADO LA TABLA DE COPIA
CREATE TABLE persona_COPIA (
    id_per INTEGER NOT NULL ,
    nombre VARCHAR (20) NOT NULL ,
    apellido VARCHAR (50) NOT NULL ,
    fecha_nac DATE,
    edad INTEGER,
    email VARCHAR (50) NOT NULL,
    genero CHAR NOT NULL ,

    id_dep INTEGER NOT NULL ,
    id_prov INTEGER NOT NULL ,

    FOREIGN KEY (id_dep) REFERENCES departamento (id_dep),
    FOREIGN KEY (id_prov) REFERENCES provincia (id_prov)
);

# CREACION DEL TRIGGER QUE COPIARA LOS DATOS
CREATE OR REPLACE TRIGGER tr_copia_tabla_persona
BEFORE INSERT ON persona
FOR EACH ROW
    BEGIN
        INSERT INTO persona_COPIA(id_per, nombre, apellido, fecha_nac, edad, email, genero, id_dep, id_prov)
        SELECT NEW.id_per, NEW.nombre, NEW.apellido , NEW.fecha_nac, NEW.edad , NEW.email, NEW.genero, NEW.id_dep, NEW.id_prov;
    END;

INSERT INTO persona (nombre, apellido, fecha_nac, edad, email, genero, id_dep, id_prov)
VALUES ('Iver','Condori','2003-04-01',20,'edco@yahoo.com','M',4,4);

SELECT * from persona;

select * from persona_COPIA;


/*===================================================================*/
# 15.Crear una consulta SQL que haga uso de todas las tablas.
/*===================================================================*/

#     ○ La consulta generada convertirlo a VISTA

# GENERANDO LA CONSULTA CON USO DE TODAS LAS TABLAS
SELECT proye.id_proy, proye.nombreProy , dep.nombre DEPARTAMENTO , prov.nombre, CONCAT(pers.nombre ,' ', pers.apellido) NOMBRE_COMPLETO, detpro.id_pd
FROM proyecto as proye
INNER JOIN departamento as dep on proye.id_proy = dep.id_dep
INNER JOIN provincia as prov on dep.id_dep = prov.id_prov
INNER JOIN persona as pers on prov.id_prov = pers.id_per
INNER JOIN detalle_proyecto as detpro on pers.id_per = detpro.id_pd
WHERE dep.nombre = 'EL ALTO';

# CREANDO LAS VISTAS
CREATE OR REPLACE VIEW vista_general as
SELECT proye.id_proy, proye.nombreProy , dep.nombre DEPARTAMENTO , prov.nombre, CONCAT(pers.nombre ,' ', pers.apellido) NOMBRE_COMPLETO, detpro.id_pd
FROM proyecto as proye
INNER JOIN departamento as dep on proye.id_proy = dep.id_dep
INNER JOIN provincia as prov on dep.id_dep = prov.id_prov
INNER JOIN persona as pers on prov.id_prov = pers.id_per
INNER JOIN detalle_proyecto as detpro on pers.id_per = detpro.id_pd
WHERE dep.nombre = 'EL ALTO';


SELECT * FROM vista_general;


# REALIZADO POR: ED$ØN CØNDØRI
# BASE DE DATOS II - ING. WILLIAM BARRA
# TERCER SEMESTRE 