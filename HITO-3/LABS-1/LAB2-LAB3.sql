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


## do while en una base de datos

# repeat
# LOGICA
# until CONDICION
# end repeat;

##APLICANDO EL WHILE(REPEAT)
# CREANDO LA SOGUIENTE SERIE : 10,9,8,7,6,5,4,3,2,1,
CREATE OR REPLACE FUNCTION EJEMPLOWHILE(x INT)
RETURNS TEXT
BEGIN
   DECLARE str TEXT DEFAULT '';
     repeat
        set str = CONCAT(str,x,',');
        set x = x - 1;
        until x <= 0
     end repeat;
   RETURN str;
end;
select EJEMPLOWHILE(10);
##EJERCICIO 2 DO WHILE GENERAR LA SIGUIENTE SERIE:
# 10 -AA-,9 -BB-,8 -AA-,7 -BB-,6 -AA-,5 -BB-,4 -AA-,3 -BB-,2 -AA-,1 -BB-,
CREATE OR REPLACE FUNCTION EJEMPLOWHILE2(x INT)
RETURNS TEXT
BEGIN
   DECLARE str TEXT DEFAULT '';
   DECLARE A TEXT DEFAULT '-AA-';
   DECLARE B TEXT DEFAULT '-BB-';
   repeat
       IF x % 2 = 1 THEN
           SET str = CONCAT(str,x,' ',B,'' );
       ELSE
           SET str = CONCAT(str,x,' ',A,' ');
           END IF;
        set x = x - 1;
        until x <= 0
     end repeat;
   RETURN str;
end;
SELECT EJEMPLOWHILE2(10);
## LOOP (LEAVE-ITERATE)

# LOOP_LABEL:LOOP
     # condicion
#    IF X > 0
#        THEN
#            LEAVE LOOP_LABEL;
#    end if; fin de la condicion
#    SET str = CONCAT(str,x,',');
#    SET x = x +1;
#    ITERATE LOOP_LABEL; nos dice que vuelva a iterar
# end loop;

CREATE OR REPLACE FUNCTION MANEJOLOOP(x INT)
RETURNS TEXT
BEGIN
    DECLARE str text default ' ';
    bdaii:LOOP
    IF X > 0
    THEN
            LEAVE bdaii;
    end if;
    SET str = CONCAT(str,x,',');
    SET x = x + 1;
    ITERATE bdaii;
end loop;
   RETURN str;
end;
select MANEJOLOOP(-10);

##EJERCICIO 2 LOOP GENERAR LA SIGUIENTE SERIE:
# 10 -AA-,9 -BB-,8 -AA-,7 -BB-,6 -AA-,5 -BB-,4 -AA-,3 -BB-,2 -AA-,1 -BB-,
CREATE OR REPLACE FUNCTION MANEJOLOOPV2(x INT)
RETURNS TEXT
BEGIN
    DECLARE str text default ' ';
    DECLARE A TEXT DEFAULT '-AA-';
    DECLARE B TEXT DEFAULT '-BB-';
    bdaii:LOOP
    IF x<0 THEN
             LEAVE bdaii;
       END IF;
      IF x % 2 = 1 THEN
           SET str = CONCAT(str,x,' ',B,'' );
       ELSE
           SET str = CONCAT(str,x,' ',A,' ');
           END IF;
    SET x = x - 1;
    ITERATE bdaii;
end loop;
   RETURN str;
end;
SELECT MANEJOLOOPV2(10);

##EJERCICIOS DE LOOP Y DO WHILE

CREATE OR REPLACE FUNCTION LAB1(CreateNumber INT)
RETURNS TEXT
BEGIN
    declare resp text default 'NONE';
    if CreateNumber > 50000 then set resp = 'PLATINIUM';
    end if;
     if CreateNumber >= 10000 AND CreateNumber <= 50000 then set resp = 'GOLD';
    end if;
    if CreateNumber < 10000 AND CreateNumber >=0 then set resp = 'SILVER';
    end if;
    RETURN RESP;
end;
SELECT LAB1(50000);
#FUNCIONES DE LA BASE DE DATOS
#1) CHAR_LENGTH= NOS PERMITE DETERMINAR CUANTOS CARACTERES TIENE UAN PALABRA
#EJEMPLO
SELECT CHAR_LENGTH(' bdaii ') ;# se cuenta al espacio dentro de las comillas como un caracter
#ejemplo en ejercicio
CREATE OR REPLACE FUNCTION valido_length_7(password TEXT)
returns text
begin
    declare resp text default '';
    if char_length(password)>7 then
        set resp = 'PASED';
        else
        set resp = 'FAILED';
    end if;
    RETURN resp;
end;
SELECT valido_length_7('BDAIIAVG');
#COMPARACION DE CADENAS
#STRCMP
#EL OBJETIVO ES SABER SI DOS CADENAS SON IGUALES
#BDAII = BDAII ? TRUE
#BDAII = BDAII 2023? FALSE
#EN MySQL O MARIADB
#SI SON IGUALES LA FUNCION ME RETOMA 0
#SI SON DISTINTOS LA FUNCION ME RETORNA -1
#EJEMPLO
SELECT STRCMP('bdaii','BDAII');
SELECT STRCMP('bdaii','BDAII2023');
#EJEMPLO EN FUNCION
CREATE OR REPLACE FUNCTION COMPARARCADENAS(CADENA1 TEXT,CADENA2 TEXT)
returns text
begin
    declare resp text default '';
    if STRCMP(CADENA1,CADENA2) = 0 then
        set resp = 'CADENAS IGUALES';
        else
        set resp = 'CADENAS DISTINTAS';
    end if;
    RETURN resp;
end;
SELECT COMPARARCADENAS('bdaii','BDAII');




#EN BASE A LAS 2 FUNCIONES ANTERIORES DETERMINAR LO SIGUIENTE
#RECIDIR 2 CADENAS, SI LAS 2 SON IGUALES Y ADEMAS EL LENGTH ES
#MAYOR A 15 RETORNAR EL MENSAJE "VALIDO"
#CASO CONTRARIO RETORNA "NO VALIDO"



CREATE OR REPLACE FUNCTION CADLAB1(CAD1 TEXT,CAD2 TEXT)
returns text
begin
    DECLARE resp text DEFAULT '';
    DECLARE UNIT TEXT DEFAULT CONCAT(CAD1,CAD2);
    if STRCMP(CAD1,CAD2) = 0 then
        if char_length(UNIT)>15 then
            set resp = 'VALIDO';
            else
        set resp = 'NO VALIDO';
        end if;
    else
        set resp ='NO VALIDO';
    end if;

    RETURN resp;
end;

SELECT CADLAB1('A','A');

# ===============================================================
# ===============================================================

# LABS 3 - CLAS 26/04/23
# MANEJO DE SUBSTRING  O SUBCADENAS   SUBSRT

# ==============================================================
# ==============================================================

#substr permite cortar la cadena (OBTIENE UNA SUBCADENA DE UNA CADENA MAS GRANDE)

# CONRTANDO DESDE LA DERE
# FORMA SENSILLA (AMBAS HACEN LO MISMO)
    SELECT substr('DBAII 2023 Unifranz',7);

# FORMA COMPLEJA (AMBAS HACEN LO MISMO)
    SELECT substr('DBAII 2023 Unifranz' FROM 7 FOR 4);

# PARA SACAR SOLO 2023 DE3SPUES DE DETERMINAR EL PRIMER INICIO SE CUENTA DE NUEVO
    SELECT substr('DBAII 2023 Unifranz',7,4);

# CONTANDO UNA MAS ADELANTE
    SELECT substr('HOLA',3);


# CONTANDO DESDE LA DERECHA (SI PONGO NEGATIVO VA DESDE LA DERECHA <---)
    SELECT substr('DBAII 2023 Unifranz',-8);

    SELECT substr('DBAII 2023 Unifranz',-13,4);

# PARA SACAR  SOLO LA D DEBO CONTAL LAS POSICIONES Y SUMAR 1 PARA Q ME MUESTRE
    SELECT substr('DBAII 2023 Unifranz',-19,1);

# ===============================================================
# ===============================================================
                        # EJERCICIOS
# ===============================================================
# ===============================================================

# BASE DE DATOS II, gestion 2023 Unifranz
# 27

# locate (permi8te busccar una cadena y te manda la pocision en la que se encuentra)
# PERO SOLO BUSCA LA PRIMERA PALABRA QUE APARECE
SELECT locate('2023','BASE DE DATOS II, gestion 2023 Unifranz');

# PRIMERO SE MANDA LO QUE BUSCAMOS Y LUEGO LA CADENA DE ESTA MANERA MOS RETORNA LA POSICION EN LA QUE ESTA

# EJEMPLO de DOS 2023 solo retornara la posicion de la primera palabra quese busca
SELECT locate('2023','BASE DE DATOS II, gestion 2023 Unifranz 2023');

# Si queremos saber la posicion de la
# siguiente palabra a buscar debemos poner al final la posicion de la primera palabr0a
SELECT locate('2023','BASE DE DATOS II, gestion 2023 Unifranz 2023',30);


# EJERCICIOS

CREATE or REPLACE FUNCTION BUSCAR_EXT_Y_POSCICIONV1(CAD1 TEXT, EXTEN TEXT)
RETURNS TEXT
BEGIN
    declare resp text default '';
    DECLARE busca_cadena INT DEFAULT  locate(EXTEN,CAD1);

    if LOCATE(EXTEN,CAD1)  > 0 then
        set resp = concat('SI EXISTE: ',busca_cadena);
        else
        set resp = 'NO EXISTE';
    end if;

    RETURN resp;
END;

SELECT BUSCAR_EXT_Y_POSCICIONV1('2365894LP','LP');


CREATE OR REPLACE  FUNCTION  numero_limit(limite INT)
RETURNS TEXT
BEGIN
   DECLARE contador int DEFAULT 0;
   DECLARE response TEXT DEFAULT ' ';

   WHILE contador <= limite DO
       SET response = CONCAT(response, contador ,',');
       SET contador = contador + 2;
    END WHILE;

    RETURN response;
END;

select numero_limit(9 );

# repertir n veces la caderna que se manda
CREATE or REPLACE FUNCTION REPETIR_N_VECES_CADENA(CAD1 TEXT , NUM1 INT)
RETURNS TEXT
BEGIN
     DECLARE response TEXT DEFAULT '';
     repeat
        set response = CONCAT(response,CAD1,',');
        set NUM1 = NUM1 - 1;
        until NUM1 <= 0
     end repeat;
   RETURN response;

end;

select REPETIR_N_VECES_CADENA ('bdaii',5);


