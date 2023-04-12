CREATE DATABASE Hito_3_2023;
USE Hito_3_2023;

# ========================================================================= #
#                   DECLARACION DE VARIABLES
# ========================================================================= #


SET @usuario = 'GUEST';
SET @locacion = 'EL ALTO';

SELECT @usuario;
SELECT @locacion;

# ========================================================================= #
#                   DECLARACION DE VARIABLES EN FUNCIONES
# ========================================================================= #


CREATE OR REPLACE FUNCTION variable()
RETURNS TEXT
BEGIN
    RETURN @usuario;
END;

SELECT variable();

-- CREAR UNA VARIABLE GLOBAL DE NOMBRE HITO_3
-- A ESTA VARIABLE ASIGNARLE EL VALOR ADMIN
-- CREAR UNA FUNCION QUE MANEJE ESTA VARIABLE GLOBAL
-- LA FUNCION VERIFICA LO SIGUINETE
-- SI El VALOR DE LA VARIABLE GLOBAL ES ADMIN
-- RETORNA UN MENSAJE QUE DIGA "usuario ADMIN"
-- SI ES DISTINTO DE ADMIN RETORNAR "usuario INVITADO"

SET @Hito_3 = 'ADMIN';
SELECT @Hito_3;

CREATE OR REPLACE FUNCTION varhit3()
RETURNS VARCHAR (50)
BEGIN
    DECLARE response VARCHAR (50);

    IF @Hito_3 = 'ADMIN' THEN
        SET  response = 'usuario admin';
    ELSE
        SET response = 'usuario Invitado';
    end if;

    RETURN response;
END;

SELECT varhit3();


# ========================================================================= #
#               RETORNAR SI ES ADMIN O INVITADO
# ========================================================================= #


CREATE OR REPLACE FUNCTION varhit3_v2()
RETURNS VARCHAR (50)
BEGIN
    DECLARE response VARCHAR (50);
        CASE
            WHEN @Hito_3 = 'ADMIN' THEN
                SET  response = 'usuario admin';
            ELSE
                SET response = 'usuario Invitado';
        end case;
    RETURN response;
END;

SELECT varhit3_v2();

# ========================================================================= #
# ========================================================================= #
#                                BUCLES
# ========================================================================= #
# ========================================================================= #

# GENEREAR LOS PRIMEROS 10 MUNEROS NATURALES

CREATE OR REPLACE  FUNCTION  numeros_naturales(limite INT)
RETURNS TEXT
BEGIN
   DECLARE contador int DEFAULT 1;
   DECLARE response TEXT DEFAULT ' ';

   WHILE contador <= limite DO
       SET response = CONCAT(response, contador ,',');
       SET contador = contador + 1;
    END WHILE;

    RETURN response;
END;

SELECT numeros_naturales(10);

# ========================================================================= #
#
# ========================================================================= #


CREATE OR REPLACE  FUNCTION  numeros_pares_impares(limite INT)
RETURNS TEXT
BEGIN
   DECLARE contadoruno INT DEFAULT 2;
   DECLARE contadordos int DEFAULT 1;
   DECLARE response TEXT DEFAULT ' ';


    WHILE contadoruno <= limite DO
       SET response = CONCAT(response, contadoruno ,',',contadordos,',');
       SET contadoruno = contadoruno + 2;
       SET contadordos = contadordos + 2;
    END WHILE;

    RETURN response;
END;

SELECT numeros_pares_impares(10);




# REVISAR

CREATE FUNCTION pares_impares(limit integer)
RETURNS TEXT
BEGIN
    DECLARE pares int default 2;
    DECLARE impares int default 1;
    DECLARE contuno INT DEFAULT 1;
    DECLARE response TEXT DEFAULT ?;

    WHILE contuno <= limit DO
        IF contuno % 2 = 1 THEN
            SET response = CONCAT(response, pares, ' , ');
            SET pares = pares +2;
        ELSE
            SET response = CONCAT(response, impares,' ,');
            SET impares = impares +2;
        end if;
        SET contuno = contuno +1;
        end while;
    RETURN response;
end;