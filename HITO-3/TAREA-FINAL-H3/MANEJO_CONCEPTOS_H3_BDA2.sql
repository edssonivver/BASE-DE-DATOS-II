
CREATE DATABASE ManejoConceptos_H3_BDA2;
USE ManejoConceptos_H3_BDA2;


CREATE OR REPLACE FUNCTION nombre_de_funcion ()
RETURNS TEXT
BEGIN
   #Lo que se quier realizar

RETURN /*lo que se desea retornar*/;
END;

DROP FUNCTION nombre_de_funcion;

# ===================================
#            PREGUNTA 5
# ===================================

# USO DEL CONCAT
CREATE OR REPLACE FUNCTION uso_de_concat(cad1 text,cad2 text,cad3 text)
RETURNS TEXT
BEGIN
    DECLARE response TEXT DEFAULT '';
    SET response = concat(cad1,' ',cad2,' ',cad3);
    RETURN response;
END;
SELECT uso_de_concat('Bienvenidos','a','BDA-II');

# ===================================
#            PREGUNTA 6
# ===================================

CREATE OR REPLACE FUNCTION Uso_de_substring(cad text)
RETURNS TEXT
BEGIN
    DECLARE response TEXT DEFAULT ' ';
    DECLARE contador INTEGER DEFAULT locate(' ',cad);
    SET response = SUBSTRING(cad,1,contador);

    RETURN response;
END;

SELECT Uso_de_substring('Ximena Condori Mar');

# ===================================
#            PREGUNTA 7
# ===================================

CREATE OR REPLACE FUNCTION Uso_de_strcmp(cad TEXT,cad2 TEXT,cad3 TEXT)
RETURNS TEXT
BEGIN
    DECLARE response TEXT DEFAULT ' ';

    CASE
        WHEN  STRCMP(cad,cad2) = 0
            THEN SET response = CONCAT('La cadena 1: ',cad, ' y la cadena 2: ',cad2,' son iguales');
        WHEN STRCMP(cad2,cad3) = 0
            THEN SET response = CONCAT('La cadena 2: ',cad2, ' y la cadena 3: ',cad3,' son iguales');
        WHEN STRCMP(cad,cad3)=0
            THEN SET response = CONCAT('Las cadenas 1: ',cad, ' y la cadena 3: ',cad3,' son iguales');
    ELSE SET response = 'Ninguna de las cadenas son iguales';
    END CASE;
    RETURN response;
END;

SELECT Uso_de_strcmp('BDAII','BDAII','EDD');

# ===================================
#            PREGUNTA 8
# ===================================

CREATE OR REPLACE FUNCTION uso_charleng_locate(cadena VARCHAR(50),letra CHAR)
RETURNS TEXT
BEGIN
    DECLARE response TEXT DEFAULT 'La letra no se encuentra en la cadena';
    DECLARE contador INT DEFAULT 1;
    DECLARE nVeces INT DEFAULT 0;
    DECLARE puntero CHAR;
    IF LOCATE(letra,cadena) > 0 THEN
            WHILE contador <= char_length(cadena) DO
            SET puntero = substr(cadena,contador,1);
                IF puntero = letra THEN
                     SET nVeces = nVeces + 1;
                END IF;
            SET contador = contador +1;
            END WHILE;
    SET response = CONCAT('La letra " ', letra , ' " se repite ', nVeces, ' veces');
    END IF;
    RETURN response;
END;

SELECT uso_charleng_locate('HOLA MUNDO', 'A');