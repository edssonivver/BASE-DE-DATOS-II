CREATE DATABASE defensa_hito3_2023;
USE defensa_hito3_2023;


#   EJERCICO 1


CREATE OR REPLACE FUNCTION nueva_Cadena_con_vocales(cadena1 TEXT)
RETURNS TEXT
BEGIN

    DECLARE response TEXT DEFAULT '';
    DECLARE cadena_concatenada TEXT DEFAULT CONCAT(cadena1);
    DECLARE puntero CHAR;
    DECLARE contador INTEGER DEFAULT 1;

    #El bucle se ejecuta si el cont sea menor o igual a la longitud de la cadena concatenada
        WHILE contador <=CHAR_LENGTH(cadena_concatenada) DO
            SET puntero = SUBSTRING(cadena_concatenada,contador,1);

            # FIND_IN_SET() Permite buscar un valor dentro de una cadena/lista separada por comas
            # ademas de que nos debuelve la posicion
            # entonces si la posicion es mayor a 0 entonces existe una vocal
                IF FIND_IN_SET(puntero, 'a,e,i,o,u, ,') = 0  THEN
                    SET contador = contador + 1;
                    ELSE # si no encuentra vocal sigue avanzando
                        SET contador  = contador + 1;
                        SET response = CONCAT(response,puntero,' ');
                END IF;
        END WHILE;

    RETURN response;
END;

SELECT nueva_Cadena_con_vocales('BASE DE DATOS II 2023');
SELECT nueva_Cadena_con_vocales('BDFGHJKLMNP');
SELECT nueva_Cadena_con_vocales('A E I O U');


# EJERCICIO 2
/*
CREATE TABLE clientes(
    id_client INT PRIMARY KEY AUTO_INCREMENT NOT NULL ,
    fullname VARCHAR(20) NOT NULL ,
    lastnname VARCHAR(20) NOT NULL ,
    age INT NOT NULL ,
    genero CHAR NOT NULL
);

INSERT INTO clientes (fullname, lastnname, age, genero)
VALUES ('Roberto','Choque',25,'M'),
         ('Carla','Ramos',20,'F'),
         ('Juan','Condori',32,'M'),
         ('Jhonatan','Alanoca',22,'M'),
         ('Ximena','Ortis',18,'F');

# BUSCANDO LA EDAD MAX
CREATE OR REPLACE FUNCTION edad_MAX_cliente()
RETURNS INT
BEGIN
    DECLARE response INTEGER;
    SELECT MAX(age) FROM clientes INTO response;
RETURN response;
END;

SELECT edad_MAX_cliente();


CREATE OR REPLACE FUNCTION Edad_Maxima_client_loop()
RETURNS TEXT
BEGIN

    DECLARE response TEXT DEFAULT '';
    DECLARE limite INTEGER;
    DECLARE num INTEGER;
    SELECT MAX(age) FROM clientes INTO limite;

    IF limite%2=0 THEN
        pares: LOOP
            IF num = limite THEN
                 LEAVE pares;  #LEAVE SALE DEL BUCLE
            END IF;
                SET response =  CONCAT(response,num,',');
                SET num = num +2;
            ITERATE pares;

        end loop pares;
    end if;
*/

/*    ELSE
        SET num = 1;

        impares:LOOP
                  IF num <= limite THEN
                 LEAVE impares;  #LEAVE SALE DEL BUCLE
                 END IF;

                SET response =  CONCAT(num,',',response);
                SET num = num + 2;
             end loop impares;
    END IF;*/
    /*
RETURN response;
END;

Select Edad_Maxima_client_loop();
*/

# EJERCICIO 3

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

SELECT fibonacci(10);

# EJERCICIO 4



CREATE OR REPLACE FUNCTION remplazar_palabras (cad1 TEXT,cad2 TEXT,cad3 TEXT)
RETURNS TEXT
BEGIN

    DECLARE response text DEFAULT '';
    DECLARE contador INT DEFAULT 0;
    DECLARE cad TEXT DEFAULT concat(cad1,cad2,cad3);
    DECLARE puntero CHAR DEFAULT '';

          WHILE contador <= char_length(cad) DO
                    SET puntero = substr(cad,contador,1);
                        IF puntero = cad1 THEN
                             SET contador = contador + 1;
                        ELSE IF
                        puntero = cad2 THEN;
                    SET contador = contador +1;
                    SET response = CONCAT(response,puntero,' ');
                    ELSE IF puntero = cad3 THEN
                        SET contador = contador +1;
                        SET response = CONCAT(response,puntero);
                        end if;
                    END IF;
                    END IF;
            END WHILE;
RETURN response;
END;
SELECT remplazar_palabras('Bienvenidos a UNIFRANZ, UNIFRANZ tiene 10 carreras','UNIFRANZA','UNIVALLE');


# EJERCICIO 5
CREATE FUNCTION retorna_reves (cadena text)
RETURNS text
BEGIN
    DECLARE response TEXT DEFAULT '';
    SET response= reverse(cadena);

    RETURN response;
end;

select retorna_reves ('pablo');

# USANDO EL REVERSE
CREATE OR REPLACE FUNCTION revertir_cadena(Cadena TEXT)
RETURNS TEXT
BEGIN
   DECLARE response TEXT DEFAULT '';
   DECLARE contador INTEGER DEFAULT 0;
   DECLARE puntero TEXT DEFAULT '';

   REPEAT
       SET puntero = substr(Cadena,contador);
       SET response = CONCAT(response,puntero,',');
       SET contador = contador - 1;
   until contador > CHAR_LENGTH(Cadena) end repeat;
  RETURN response;
END;

SELECT reversa_cadena('BDAII-2023');

