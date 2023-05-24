Create DATABASE Hito_4;
Use Hito_4;

#   Conceptos

# Los TRIGGERS son programas almacenados
# que se ejecutan automaticamenete cuando ocurre un evento
# INSERT - UPDATE - DELETE (EVENTOS)

# ESTRUCTURA DE UN TRIGGER

# INSERT

# CREATE TRIGGER (NOMBRE TRIGGER)
# BEFORE INSERT -- INSERTANDO DATOS
# ON: (TABLA)
# FOR EACH ROW
# BEGIN
#   SET NEW.(ATRIBUTO) = POWER(NEW.(TABLA),NUEVO VALOR A ELEVAR EL NUMERO);
#   SET NEW.(ATRIBUTO) = POWER(NEW.(TABLA),NUEVO VALOR A ELEVAR EL NUMERO);
#   SET NEW.(ATRIBUTO) = POWER(NEW.(TABLA));
# END;

# DELETE

# CREATE TRIGGER (NOMBRE TRIGGER)
# BEFORE DELETE ON (TABLA)
# FOR EACH ROW
# BEGIN
#   INSERT INTO (RESPALDO/BACKUP)  VALUES (OLD,(ATRIBUTO));
# END;

# UPDATE

# CREATE TRIGGER (NOMBRE TRIGGER)
# BEFORE UPDATE ON (TABLA)
# FOR EACH ROW
# BEGIN
#  SET NEW.(TABLA) = NEW.(TABLA) + (VALOR A INCREMENTAR);
#  INSERT INTO (TABLA) VALUES (OLD.(TABLA));
# END;

# ======================================================================== #

# si un trigger hace la misma funcion exixte unchoque

DROP TABLE Numeros;

CREATE TABLE Numeros(
    numero BIGINT PRIMARY KEY NOT NULL,
    cuadrado BIGINT,
    cubo BIGINT,
    raiz_cuadrada REAL,
    suma_total REAL
);

CREATE OR REPLACE TRIGGER t_completa_datos
    BEFORE INSERT
    ON Numeros
FOR EACH ROW
BEGIN
    DECLARE valor_cuadrado BIGINT;
    DECLARE valor_cubo BIGINT;
    DECLARE valor_raiz REAL;
    DECLARE suma_tot REAL;

    SET valor_cuadrado = POWER(NEW.numero,2);
    SET valor_cubo = POWER(NEW.numero,3);
    SET valor_raiz = sqrt(NEW.numero);
    SET suma_tot =valor_cuadrado+valor_cubo+valor_raiz+new.numero;

    SET NEW.cuadrado = valor_cuadrado;
    SET NEW.cubo = valor_cubo;
    SET NEW.raiz_cuadrada = valor_raiz;
    SET NEW.suma_total = suma_tot;
END;

drop trigger t_completa_datos_V2;
TRUNCATE TABLE numeros;

INSERT INTO Numeros (numero) VALUES (8);
INSERT INTO Numeros (numero) VALUES (3);
INSERT INTO Numeros (numero) VALUES  (4);

SELECT * FROM Numeros;

ALTER TABLE numeros
ADD COLUMN suma_total REAL;

# ====================================

# METODO DEL INGE
CREATE OR REPLACE TRIGGER t_completa_datos_V2
    BEFORE INSERT
    ON Numeros
FOR EACH ROW
BEGIN
    SET NEW.cuadrado = POWER(NEW.numero,2);
    SET NEW.cubo = POWER(NEW.numero,3);
    SET NEW.raiz_cuadrada = sqrt(NEW.numero);
    SET NEW.suma_total =new.numero + NEW.cuadrado + NEW.cubo + NEW.raiz_cuadrada;
END;

INSERT INTO Numeros (numero) VALUES (5);
INSERT INTO Numeros (numero) VALUES (2);
INSERT INTO Numeros (numero) VALUES  (9);

SELECT * FROM Numeros;

# ============================
# GENERAR CONTRASEÑAS

CREATE TABLE usuarios(
    id_usr INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(100) NOT NULL ,
    apellidos VARCHAR(100) NOT NULL ,
    edad INT NOT NULL ,
    correo VARCHAR (200) NOT NULL ,
    password varchar(200)
);

DROP TABLE usuarios;

# TRIGGER PARA GENERAR LA CONTRASEÑA
CREATE OR REPLACE TRIGGER gen_password
 BEFORE INSERT ON usuarios
 FOR EACH ROW
 BEGIN
  SET NEW.password = LOWER(CONCAT
      (SUBSTR(NEW.nombre,1,2),
      SUBSTR(NEW.apellidos,1,2),
      NEW.edad));
 END;

truncate table usuarios;

INSERT INTO usuarios (nombre, apellidos, edad, correo)
VALUES ('Edson','Condori',19,'correo1@gmail.com');

select * from usuarios;

DROP TRIGGER gen_password;

# CLASE 20/02/2023
# LAB 2 HITO 4

CREATE TABLE usuarios_v2(
    id_usr INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(100) NOT NULL ,
    apellidos VARCHAR(100) NOT NULL ,
    fecha_nac DATE NOT NULL,
    correo VARCHAR (200) NOT NULL ,
    password varchar(200),
    edad INT
);
DROP TRIGGER gen_password;

#LOWER sirve para convertir mayusculas en minusculas
CREATE OR REPLACE TRIGGER tr_calcula_pass_eda
BEFORE INSERT
ON usuarios_v2
FOR EACH ROW
    BEGIN
      SET NEW.password = LOWER(CONCAT
      (
      SUBSTR(NEW.nombre,1,2),
      SUBSTR(NEW.apellidos,1,2),
      SUBSTR(NEW.correo,1,2)
      ));
      SET NEW.edad = TIMESTAMPDIFF(YEAR, NEW.fecha_nac, CURDATE());
    END;

INSERT INTO usuarios_v2 (nombre, apellidos, fecha_nac, correo)
VALUES ('EDSON', 'CONDORI','2004-04-01','eddfs@gmail.com');

select * from usuarios_v2;

SELECT TIMESTAMPDIFF(YEAR , '2004-04-01',CURDATE()) AS edad;

DROP TRIGGER tr_calcula_pass_eda;

# EJERCICIO 3
# CREAR UN TRIGGER QUE CUANDO LA CONTRASEÑA SEA
# NEMOR DE 10 CARRACTERES GENERE UNO NUEVO
# PERO SI ES MAYOR A DIEZ LO DEJE AHI
# PRIMERO CALCULAR LA EDAD
# PARA LA CONTRA NUEVA PONER LOS 2 CARACTERES FINALES DE
# NOMBRE - APELLIDO Y LA EDAD

CREATE TABLE usuarios_v3(
    id_usr INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(100) NOT NULL ,
    apellidos VARCHAR(100) NOT NULL ,
    fecha_nac DATE NOT NULL,
    correo VARCHAR (200) NOT NULL ,
    password varchar(200),
    edad INT
);

CREATE OR REPLACE TRIGGER calcula_pass
BEFORE INSERT
ON usuarios_v3
FOR EACH ROW
    BEGIN
        # PRIMERO CALCULAMOS LA EDAD
      SET NEW.edad = TIMESTAMPDIFF(YEAR, NEW.fecha_nac, CURDATE());

      IF CHAR_LENGTH(NEW.password) < 10 THEN
          SET NEW.password = LOWER(CONCAT
          (
          SUBSTR(NEW.nombre,-2,2),
          SUBSTR(NEW.apellidos,-2,2),
          (NEW.edad)
          ));
      END IF;
    END;

TRUNCATE usuarios_v3;

INSERT INTO usuarios_v3(nombre, apellidos, fecha_nac, correo, password)
VALUES ('ANDRES','LOPEZ','2001-02-12','andreslop@gmail.com','lopeas45'),
     ('CARLOS','PEREZ','2005-05-28','carloper@gmail.com','carlosperez5945');

SELECT * FROM usuarios_v3;

DROP TRIGGER calcula_pass;

# PARTA SABER EL DIA DE LA SEMANA USAMOS
SELECT DAYNAME(CURRENT_DATE);

# PARA SABER LA FECHA DE HOY
SELECT CURRENT_DATE;

# EJERCICO 4

CREATE TABLE usuarios_v4(
    id_usr INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(100) NOT NULL ,
    apellidos VARCHAR(100) NOT NULL ,
    fecha_nac DATE NOT NULL,
    correo VARCHAR (200) NOT NULL ,
    password varchar(200),
    edad INT
);

CREATE OR REPLACE TRIGGER tr_usuario_mantenimineto
BEFORE INSERT
ON usuarios_v4
FOR EACH ROW
    BEGIN
        DECLARE dia_senama TEXT DEFAULT '';
        SET dia_senama = DAYNAME(CURRENT_DATE);

    IF dia_senama = 'Wednesday' THEN
        SIGNAL SQLSTATE '45000'
        SET  MESSAGE_TEXT = 'Base de datos en Mantenimiento';
    end if;
    END;

TRUNCATE usuarios_v4;

INSERT INTO usuarios_v4(nombre, apellidos, fecha_nac, correo, password)
VALUES ('ANDRES','LOPEZ','2001-02-12','andreslop@gmail.com','lopeas45'),
     ('CARLOS','PEREZ','2005-05-28','carloper@gmail.com','carlosperez5945');

SELECT * FROM usuarios_v4;

DROP TRIGGER tr_usuario_mantenimineto;


# EJER 5

ALTER TABLE usuarios_v4
ADD COLUMN  nacionalidad VARCHAR(20);

SELECT * FROM usuarios_v4;

CREATE OR REPLACE TRIGGER error_de_usuario
BEFORE INSERT
ON usuarios_v4
FOR EACH ROW
BEGIN

    IF (new.nacionalidad = 'BOLIVIA' OR  new.nacionalidad  = 'ARGENTINA' OR new.nacionalidad  = 'URUGUAY') THEN
        #copia gen edad y password
        SET NEW.edad = TIMESTAMPDIFF(YEAR, NEW.fecha_nac, CURDATE());
    ELSE
        SIGNAL SQLSTATE '45000'
        SET  MESSAGE_TEXT = 'NACIONALIDAD NO DISPONIBLE EN ESTE MOMENTO';
    end if;
END;

truncate usuarios_v4;

INSERT INTO usuarios_v4(nombre, apellidos, fecha_nac, correo, password,nacionalidad)
VALUES ('CARLOS','PEREZ','2005-05-28','carloper@gmail.com','carlosperez5945','URUGUAY');

INSERT INTO usuarios_v4(nombre, apellidos, fecha_nac, correo, password,nacionalidad)
VALUES ('CARLOS','PEREZ','2005-05-28','carloper@gmail.com','carlosperez5945','Paraguay');

INSERT INTO usuarios_v4(nombre, apellidos, fecha_nac, correo, password,nacionalidad)
VALUES ('CARLOS','PEREZ','2005-05-28','carloper@gmail.com','carlosperez5945','BOLIVIA');

INSERT INTO usuarios_v4(nombre, apellidos, fecha_nac, correo, password,nacionalidad)
VALUES ('CARLOS','PEREZ','2005-05-28','carloper@gmail.com','carlosperez5945','BRAZIL');

select * from usuarios_v4;




