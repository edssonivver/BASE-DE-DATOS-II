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

CREATE TABLE usuarios(
    id_usr INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(100) NOT NULL ,
    apellidos VARCHAR(100) NOT NULL ,
    edad INT NOT NULL ,
    correo VARCHAR (200) NOT NULL ,
    password varchar(200)
);

CREATE OR REPLACE TRIGGER gen_password
 BEFORE INSERT ON usuarios
 FOR EACH ROW
 BEGIN
  SET NEW.password = LOWER(CONCAT(SUBSTR(NEW.nombre,1,2),SUBSTR(NEW.apellidos,1,2),NEW.edad));
 END;

truncate table usuarios;
INSERT INTO usuarios (nombre, apellidos, edad, correo)
VALUES ('Edson','Condori',19,'correo1@gmail.com');

select * from usuarios