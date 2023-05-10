
# ===================================================================
# ============== BASE DE DATOS II - Ing. William Barra ==============
# ================= Est. Edson Iver Condori Condori =================
# ===================================================================

CREATE DATABASE Universidad2;
USE Universidad2;

# ===================================
#            EJERCICIO 1
# ===================================
# RECREAR LA BASE DE DATOS

CREATE TABLE estudiantes (
    id_est Integer AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombres VARCHAR (50) NOT NULL,
    apellidos VARCHAR(50)NOT NULL,
    edad INTEGER NOT NULL,
    fono INTEGER NOT NULL,
    email VARCHAR(100),
    direccion VARCHAR(100),
    genero VARCHAR(10)
);

INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, genero)
VALUES ('Miguel','Gonzale Veliz',20,2832115,'miguel@gmail.com','Av. 6 de Agosto','masculino'),
       ('Sandra','Mavir Uria',25,2832116,'sandra@gmail.com','Av. 6 de Agosto','femenino'),
       ('Joel','Aduviri Mondar',30,2832117,'joel@gmail.com','Av. 6 de Agosto','masculino'),
       ('Andrea','Arias Ballesteros',21,2832118,'andrea@gmail.com','Av. 6 de Agosto','femenino'),
       ('Santos','Montes Valenzuela',24,2832119,'santos@gmail.com','Av. 6 de Agosto','masculino');

CREATE TABLE materias(
    id_mat INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre_mat VARCHAR (100) NOT NULL ,
    cod_mat VARCHAR (100) NOT NULL
);

INSERT INTO materias (nombre_mat, cod_mat)
VALUES ('Introduccion a la Arquitectura','ARQ-101'),
       ('Urbanismo y Diseño','ARQ-102'),
       ('Dibujo y Pintura Arquitectonico','ARQ-103'),
       ('Matematica Discreta','ARQ-104'),
       ('Fisica Basica','ARQ-105');


CREATE TABLE inscripcion (
    id_inscripcion INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    semestre VARCHAR(20) NOT NULL ,
    gestion INTEGER NOT NULL,

    id_est INTEGER NOT NULL ,
    id_mat INTEGER NOT NULL ,

    FOREIGN KEY (id_est) REFERENCES estudiantes(id_est),
    FOREIGN KEY (id_mat) REFERENCES materias(id_mat)
);

INSERT INTO inscripcion (semestre, gestion, id_est, id_mat)
VALUES  ('1er Semestre',2018,1,1),
        ('2do Semestre',2018,1,2),
        ('1er Semestre',2019,2,4),
        ('2do Semestre',2019,2,3),
        ('2do Semestre',2020,3,3),
        ('3er Semestre',2020,3,1),
        ('4to Semestre',2021,4,4),
        ('5to Semestre',2021,5,5);


# ===================================
#            EJERCICIO 2
# ===================================

# Crear una función que genere la serie Fibonacci.
# La función recibe un límite(number)
# ○ La función debe de retornar una cadena.
# ○ Ejemplo para n=7. OUTPUT: 0, 1, 1, 2, 3, 5, 8,

CREATE OR REPLACE FUNCTION fibonacci(NumerLimit INT)
RETURNS TEXT
BEGIN

  DECLARE num1 INT DEFAULT 0;
  DECLARE cont INT DEFAULT 1;
  DECLARE num2 INT DEFAULT 1;
  DECLARE result TEXT DEFAULT '';

  SerieFigonaci: LOOP
      #verifica si se seguira cumpliendo la secuencia
     IF cont > NumerLimit THEN
          LEAVE SerieFigonaci;  #LEAVE SALE DEL BUCLE
    END IF;

    SET result = CONCAT(result, num2, ',');
    SET num2 = num1 + num2;
    SET num1 = num2 - num1;
    SET cont = cont + 1;

  END LOOP SerieFigonaci;

    #RETURN SUBSTRING(result, 1/*,LENGTH(result) - 1*/);
    RETURN result;
end;

SELECT fibonacci(7);

# ===================================
#            EJERCICIO 3
# ===================================

# 13.Crear una variable global a nivel BASE DE DATOS.
# ○ Crear una función cualquiera.
# ○ La función debe retornar la variable global.

SET @Variable_gloval = 'HOLA MI NOMBRE ES EDSON';
SELECT @Variable_gloval;

CREATE OR REPLACE FUNCTION retorna_el_nombre()
RETURNS TEXT
BEGIN
    RETURN SUBSTR(@Variable_gloval ,-5);
END;

SELECT retorna_el_nombre();


# ● Crear una variable global de nombre LIMIT.
# ● Este valor debe almacenar un valor entero.
SET @Limit = 10;
SELECT @Limit;

# Crear una función que genere la serie fibonacci hasta ese valor LIMIT.
# ○ Note que el valor LIMIT debe ser usado en la función
# ○ La función no recibe ningún parámetro
    # ○ Ejemplo, LIMIT = 7
    # ○ OUTPUT: 0,1,1,2,3,5,8

CREATE OR REPLACE FUNCTION figonaci_v2()
RETURNS TEXT
BEGIN
  DECLARE num1 INT DEFAULT 0;
  DECLARE cont INT DEFAULT 1;
  DECLARE num2 INT DEFAULT 1;
  DECLARE result TEXT DEFAULT '';

  SerieFigonaci: LOOP
      #verifica si se seguira cumpliendo la secuencia
     IF cont > @Limit THEN
          LEAVE SerieFigonaci;  #LEAVE SALE DEL BUCLE
        END IF;
    SET result = CONCAT(result, num2, ',');
    SET num2 = num1 + num2;
    SET num1 = num2 - num1;
    SET cont = cont + 1;
  END LOOP SerieFigonaci;
    #RETURN SUBSTRING(result, 1/*,LENGTH(result) - 1*/);
    RETURN result;
END;

SELECT figonaci_v2();

# ===================================
#            EJERCICIO 4
# ===================================

# 14.Crear una función no recibe parámetros (Utilizar WHILE, REPEAT o LOOP).

# ○ Previamente deberá de crear una función que obtenga la edad mínima de los estudiantes
    # ■ La función no recibe ningún parámetro.
    # ■ La función debe de retornar un número.(LA EDAD MÍNIMA).

# BUSCANDO LA EDAD MINIMA
CREATE OR REPLACE FUNCTION edad_Minima_Est()
RETURNS INT
BEGIN
    DECLARE response INTEGER;
    SELECT MIN(edad) FROM estudiantes INTO response;
RETURN response;
END;

SELECT edad_Minima_Est();

# ○ Si la edad mínima es PAR mostrar todos los pares empezando desde 0 hasta
# ese valor de la edad mínima.

# ○ Si la edad mínima es IMPAR mostrar descendentemente todos los impares
# hasta el valor 0.
# ○ Retornar la nueva cadena concatenada

CREATE OR REPLACE FUNCTION Edad_Minima_est_bucle()
RETURNS TEXT
BEGIN

    DECLARE response TEXT DEFAULT '';
    DECLARE limite INTEGER;
    #DECLARE limite INTEGER DEFAULT 19; #SI LA EDAD MIN FUERA IMPAR
    DECLARE num INTEGER;

    #Llamando a la funcion anterior y alamacenando en una variable
    # cOMENTAR LA LINEA DE ABAJO PARA HACER LA PRUEBA CON UN MIN EDAD IMPAR
    SELECT MIN(edad) FROM estudiantes INTO limite;

    IF limite%2<=0
    THEN
        SET num = 0;
            WHILE num <= limite DO
                SET response =  CONCAT(response,num,',');
                SET num = num +2;
            end while;
    ELSE # para los impares
        SET num = 1;
             WHILE num <= limite DO
                SET response =  CONCAT(num,',',response);
                SET num = num + 2;
            end while;
    END IF;
RETURN response;
END;

Select Edad_Minima_est_bucle();

# ===================================
#            EJERCICIO 5
# ===================================

# 15.Crear una función que determina cuantas veces se repite las vocales.
# ○ La función recibe una cadena y retorna un TEXT.
# ○ Retornar todas las vocales ordenadas e indicando la cantidad de veces que
# se repite en la cadena.

CREATE OR REPLACE FUNCTION cuenta_vocales_cad(Cadena TEXT)
    RETURNS TEXT
BEGIN

    DECLARE puntero CHAR;
    DECLARE x Int DEFAULT 1; #nos permitira avanzar a la sig letra de la cadena
    DECLARE cont Int DEFAULT 0; #a
    DECLARE cont2 Int DEFAULT 0; #e
    DECLARE cont3 Int DEFAULT 0; #i
    DECLARE cont4 Int DEFAULT 0;# o
    DECLARE cont5 Int DEFAULT 0;# u


    WHILE x <= CHAR_LENGTH(Cadena) DO

        SET puntero = SUBSTR(Cadena, x, 1);
            IF puntero = 'a' THEN
                SET cont = cont + 1;
            end if;

            IF puntero = 'e' THEN
                SET cont2 = cont2 + 1;
            END IF;

            IF puntero = 'i' THEN
                SET cont3 = cont3 + 1;
            END IF;

            IF puntero = 'o' THEN
                SET cont4 = cont4 + 1;
            END IF;

            IF puntero = 'u' THEN
                SET cont5 = cont5 + 1;
            END IF;

            SET X = X + 1; #nos permitira avanzar a la sig letra/caracter de la cadena
        end while;

    RETURN CONCAT('a:', cont , ' e:', cont2 , ' i:', cont3 , ' o:', cont4 , ' u:',cont5);
end;

select cuenta_vocales_cad('TALLER DE BASE DE DATOS');
SELECT cuenta_vocales_cad('EDSON IVER CONDORI CONDORI');

# ===================================
#            EJERCICIO 6
# ===================================

# 16.Crear una función que recibe un parámetro INTEGER

# ○ La función debe de retornar un texto(TEXT) como respuesta.
# ○ El parámetro es un valor numérico credit_number.
# ○ Si es mayor a 50000 es PLATINIUM.
# ○ Si es mayor igual a 10000 y menor igual a 50000 es GOLD.
# ○ Si es menor a 10000 es SILVER
# ○ La función debe retornar indicando si ese cliente es PLATINUM, GOLD o
# SILVER en base al valor del credit_number.
# ○ Para resolver debe de utilizar la instrucción CASE - WHEN.

CREATE OR REPLACE FUNCTION Categoria_cliente(credit_number INT)
RETURNS TEXT
BEGIN
    declare response text default '';
        CASE
        WHEN credit_number > 50000
            THEN SET response = 'PLATINIUM';
        WHEN credit_number >= 10000 AND credit_number <= 50000
            THEN SET response = 'GOLD';
        WHEN credit_number < 10000 AND credit_number >=0
            THEN SET response = 'SILVER';
        END CASE;
    RETURN response;
END;

SELECT Categoria_cliente(50225);

# ===================================
#            EJERCICIO 7
# ===================================

# 17. Crear una función que recibe 2 parámetros VARCHAR(20), VARCHAR(20).
# ● La función debe de retornar un texto TEXT como respuesta.
# ● Si las cadenas fueran “TALLER DBA II” y la segunda cadena fuese “GESTION 2023”.
# ● La nueva cadena debería ser “TLLR DB -GSTN 2023”.
# ● La nueva cadena es resultado de la concatenación de todos los valores
# distintos a las vocales.
# ● Retornar la nueva cadena concatenada.

CREATE OR REPLACE FUNCTION nueva_Cadena_sin_vocales(cadena1 VARCHAR(200), cadena2 VARCHAR(200))
RETURNS TEXT
BEGIN

    DECLARE response TEXT DEFAULT '';
    DECLARE cadena_concatenada TEXT DEFAULT CONCAT(cadena1, '-', cadena2);
    DECLARE puntero CHAR;
    DECLARE contador INTEGER DEFAULT 1;

    #El bucle se ejecuta si el cont sea menor o igual a la longitud de la cadena concatenada
        WHILE contador <=CHAR_LENGTH(cadena_concatenada) DO
            SET puntero = SUBSTRING(cadena_concatenada,contador,1);

            # FIND_IN_SET() Permite buscar un valor dentro de una cadena/lista separada por comas
            # ademas de que nos debuelve la posicion
            # entonces si la posicion es mayor a 0 entonces existe una vocal
                IF FIND_IN_SET(puntero, 'a,e,i,o,u') > 0  THEN
                    SET contador = contador + 1;
                ELSE # osi no encuentra vocal sigue avanzando per  verifica si existe espacios
                    IF puntero = ' ' THEN
                        SET contador = contador +1;
                        SET response = CONCAT(response,puntero,' ');
                    ELSE # si no encuentra vocal sigue avanzando
                        SET contador  = contador +1;
                        SET response = CONCAT(response,puntero);
                    END IF;
                END IF;
        END WHILE;

    RETURN response;
END;

SELECT nueva_Cadena_sin_vocales('TALLER DBA II','GESTION 2023');

# ===================================
#            EJERCICIO 8
# ===================================

# 18.Crear una función que reciba un parámetro TEXT
# ○ En donde este parámetro deberá de recibir una cadena cualquiera y retorna
# un TEXT de respuesta.
# ○ Concatenar N veces la misma cadena reduciendo en uno en cada iteración
# hasta llegar a una sola letra.
# ○ Utilizar REPEAT y retornar la nueva cadena concatenada.

CREATE OR REPLACE FUNCTION reducir_cadena(Cadena TEXT)
RETURNS TEXT
BEGIN
   DECLARE response TEXT DEFAULT '';
   DECLARE contador INTEGER DEFAULT 0;
   DECLARE puntero TEXT DEFAULT '';

   REPEAT
       SET puntero = substr(Cadena,contador);
       SET response = CONCAT(response,puntero,',');
       SET contador = contador + 1;
   until contador > CHAR_LENGTH(Cadena) end repeat;
  RETURN response;
END;

SELECT reducir_cadena('BDAII');

# By: Edson Iver Condori Condori