
CREATE DATABASE biblioteca;
USE biblioteca;

CREATE TABLE autor (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  nacionalidad VARCHAR(50),
  fecha_nacimiento DATE
);

CREATE TABLE usuario (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL,
  fecha_nacimiento DATE,
  direccion VARCHAR(100)
);

CREATE TABLE libro (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(100) NOT NULL,
  isbn VARCHAR(20),
  fecha_publicacion DATE,
  autor_id INTEGER,
  FOREIGN KEY (autor_id) REFERENCES autor(id)
);

CREATE TABLE prestamo (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NOT NULL,
  libro_id INTEGER REFERENCES libro(id) ON DELETE CASCADE,
  usuario_id INTEGER REFERENCES usuario(id) ON DELETE CASCADE
);

CREATE TABLE categoria (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL
);

CREATE TABLE libro_categoria (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  libro_id INTEGER REFERENCES libro(id) ON DELETE CASCADE,
  categoria_id INTEGER REFERENCES categoria(id) ON DELETE CASCADE
);


INSERT INTO autor (nombre, nacionalidad, fecha_nacimiento) VALUES
('Gabriel Garcia Marquez', 'Colombiano', '1927-03-06'),
('Mario Vargas Llosa', 'Peruano', '1936-03-28'),
('Pablo Neruda', 'Chileno', '1904-07-12'),
('Octavio Paz', 'Mexicano', '1914-03-31'),
('Jorge Luis Borges', 'Argentino', '1899-08-24');


INSERT INTO libro (titulo, isbn, fecha_publicacion, autor_id) VALUES
('Cien años de soledad', '978-0307474728', '1967-05-30', 1),
('La ciudad y los perros', '978-8466333867', '1962-10-10', 2),
('Veinte poemas de amor y una canción desesperada', '978-0307477927', '1924-08-14', 3),
('El laberinto de la soledad', '978-9681603011', '1950-01-01', 4),
('El Aleph', '978-0307950901', '1949-06-30', 5);




INSERT INTO usuario (nombre, email, fecha_nacimiento, direccion) VALUES
('Juan Perez', 'juan.perez@gmail.com', '1985-06-20', 'Calle Falsa 123'),
('Maria Rodriguez', 'maria.rodriguez@hotmail.com', '1990-03-15', 'Av. Siempreviva 456'),
('Pedro Gomez', 'pedro.gomez@yahoo.com', '1982-12-10', 'Calle 7ma 789'),
('Laura Sanchez', 'laura.sanchez@gmail.com', '1995-07-22', 'Av. Primavera 234'),
('Jorge Fernandez', 'jorge.fernandez@gmail.com', '1988-04-18', 'Calle Real 567');


INSERT INTO prestamo (fecha_inicio, fecha_fin, libro_id, usuario_id) VALUES
('2022-01-01', '2022-01-15', 1, 1),
('2022-01-03', '2022-01-18', 2, 2),
('2022-01-05', '2022-01-20', 3, 3),
('2022-01-07', '2022-01-22', 4, 4),
('2022-01-09', '2022-01-24', 5, 5);

INSERT INTO categoria (nombre) VALUES
('Novela'),
('Poesía'),
('Ensayo'),
('Ciencia Ficción'),
('Historia');

INSERT INTO libro_categoria (libro_id, categoria_id) VALUES
(1, 1),
(1, 3),
(2, 1),
(2, 5),
(3, 2),
(4, 3),
(5, 4);

ALTER TABLE libro ADD COLUMN paginas INTEGER DEFAULT 20;

ALTER TABLE libro ADD COLUMN editorial VARCHAR (20) DEFAULT 'DON BOSCO';


-- EJERCICIO CONSULTAS

-- 1)
-- MOSTRAR EL NOMBRE DEL AUTOR ARGENTINO
SELECT aut.nombre , aut.nacionalidad , lib.titulo
FROM autor as aut
INNER JOIN libro as lib on aut.id = lib.autor_id
WHERE aut.nacionalidad = 'Argentino';

-- 2)
-- mostrar los libros de la categoria ciencia ficcion

SELECT lib.titulo , cat.nombre FROM libro as lib
             INNER JOIN libro_categoria as libcat on lib.id = libcat.libro_id
             INNER JOIN categoria as cat on libcat.categoria_id = cat.id
             WHERE cat.nombre = 'ciencia ficcion';


-- ==================================================
-- MISMOS EJERCICOS CON MANEJO DE VISTAS
-- ==================================================

-- 1)
-- MOSTRAR EL NOMBRE DEL AUTOR ARGENTINO
CREATE or REPLACE VIEW libros_argentino as
SELECT aut.nombre , aut.nacionalidad , lib.titulo
FROM autor as aut
INNER JOIN libro as lib on aut.id = lib.autor_id
WHERE aut.nacionalidad = 'Argentino';

-- 2)
-- mostrar los libros de la categoria ciencia ficcion

CREATE or REPLACE VIEW libro_ciencia_ficcion as
SELECT lib.titulo , cat.nombre FROM libro as lib
             INNER JOIN libro_categoria as libcat on lib.id = libcat.libro_id
             INNER JOIN categoria as cat on libcat.categoria_id = cat.id
             WHERE cat.nombre = 'ciencia ficcion';


-- =============================
-- LABORATORIO 3
-- =============================

-- CREATE OR REPLACE VIEW bookContent as

SELECT lib.titulo as titlebook,
       lib.editorial as editorialbook,
       lib.paginas as pagebook
FROM libro AS lib;

-- MANEJO DE VISTAS Y USO DE CASE

CREATE OR REPLACE VIEW contentBook as
SELECT lib.titulo as titlebook,
       lib.editorial as editorialbook,
       lib.paginas as pagebook,
       (CASE
           WHEN lib.paginas > 0 AND lib.paginas <=30 THEN 'CONTENIDO BASICO'
           WHEN lib.paginas > 30 AND lib.paginas <=80 THEN 'CONTENIDO MEDIANO'
           WHEN lib.paginas > 80 AND lib.paginas <=150 THEN 'CONTENIDO SUPERIOR'
           ELSE 'CONTENIDO AVANZADO'

           END
           ) AS typecontentBook
FROM libro AS lib;

-- DE ACUERDO A LA VISTA CREADA CONTAR CUNATOS LIBROS SON DE CONTENIDO MEDIO

SELECT count (*) as 'CATIDAD DE LIBROS SEGUN SU CONTENIDO MEDIANO'
from contentBook as cbk
where cbk.typecontentBook = 'CONTENIDO MEDIANO';

--

CREATE OR REPLACE VIEW book_And_Autor as
SELECT concat ('TITULO: ',lib.titulo,' - EDITORIAL: ',lib.editorial,' - CATEGORAIA: ', cat.nombre) as BookDetail,
       concat (' AUTOR: ',aut.nombre ,' - NACIONALIDAD: ', aut.nacionalidad) as AutorDetail
FROM libro AS lib
INNER JOIN libro_categoria lc on lib.id = lc.libro_id
INNER JOIN categoria cat on lc.categoria_id = cat.id
INNER JOIN autor aut on lib.autor_id = aut.id;


-- DEACUERDO A LAVITA CREADA SIE LBOOK DEATAIL ESTA LA EDITORIA LNOVA GENERARA UNA COLUNMA QUE DIGA EN VENTA
-- CASO CONTRARIO COLOCAR EN PROCESO
CREATE OR REPLACE VIEW OFERTAS AS
SELECT (CASE
    WHEN ba.BookDetail like '%NOVA%' THEN 'EN VENTA'
    ELSE 'EN PROCESO'
    END)
FROM book_And_Autor AS ba;

-- ==========================================================
            -- CLASE 5 - USO DE FUNCIONES
-- ==========================================================


CREATE OR REPLACE VIEW AUTORE_PERU_HITORIA AS
SELECT
    cat.nombre as CATEGORY,
    aut.nombre as AUTOR,
    aut.nacionalidad as NACIONALIDAD
FROM libro as lib
INNER JOIN autor as aut on lib.autor_id = aut.id
INNER JOIN libro_categoria as libcat on lib.id = libcat.libro_id
INNER JOIN categoria AS cat on libcat.categoria_id = cat.id
WHERE aut.nacionalidad = 'Peruano' and cat.nombre = 'Historia';


-- CREACION DE FUNCIONES

-- ============================================

-- FUNCIONM QUE RETORNA MI NOMBRE
CREATE or REPLACE FUNCTION ejemplo1()
RETURNS VARCHAR (30)
    BEGIN
        RETURN 'EDSON CONDORI';
    END;

-- consulta de la funcion
SELECT ejemplo1();



-- ============================================

-- Funcion que retorna un numero

CREATE OR REPLACE FUNCTION numero()
Returns INTEGER
BEGIN
    RETURN 10;
END;

SELECT numero();


-- CREEAR UNA FUNCION QUE RECIBA UN PARAMETRO DE TIPO CADENA


-- CREACIO NDE LA FUNCION
CREATE OR REPLACE FUNCTION getNombreCompleto(nombres VARCHAR(30))
RETURNS VARCHAR (30)
BEGIN
    RETURN nombres;
END;

-- CONSULTA A LA FUNCION Y LLENADO DEL PARAMETRO
select getNombreCompleto('Edson Iver Condori Condori');


-- CREAR UNA FUNCION QUE SUME TRES NUMEROS
-- LA FUNCION RECIBE TRES PARAMETROS ENTEROS TIPO INT

CREATE OR REPLACE FUNCTION sumaNumeros3(num1 INTEGER,num2 INTEGER, num3 INTEGER)
RETURNS VARCHAR (50)
BEGIN
    DECLARE resp INTEGER;
    set resp = num1+num2+num3;
   RETURN resp;
END;

-- CONSULA Y LLENADO DE DATOS A LA FUNCION
SELECT sumaNumeros3(4 ,5,5);

-- CREAR UN AFUNCIO DE NOMBRE CALCULADORA LA FUNCION RECIBE TRES PRARMETROS
-- EL PRIMERTO UN NUMERO TIPO INTEGER
-- EL SEGUNDO OTRO NUMERO TIPO INTEGER
-- EL TERCERO UNA CADENA TIPO VARCAHR

CREATE OR REPLACE FUNCTION calculadora(numero1 integer, numero2 integer, accion varchar(20))
returns integer
begin

declare resultado integer;

if (accion = 'Sumar') THEN
set resultado = numero1 + numero2;
END IF;
if (accion = 'Restar') THEN
set resultado = numero1 - numero2;
END IF;
if (accion = 'Multiplicar') THEN
set resultado = numero1 * numero2;
END IF;
if (accion = 'Dividir') THEN
set resultado = numero1/numero2;
END IF;
return resultado;

END;

select calculadora(4,8,'Sumar') Suma;
select calculadora(8,2,'Restar') Resta;
select calculadora(3,5,'Multiplicar') Multiplicacion;
select calculadora(10,2,'Dividir') Division;


-- ===============================================
-- LA MISMA FUNCION PERO CON USO DE CASE
-- ===============================================

CREATE OR REPLACE FUNCTION calculadora2(n1 int , n2 int, tipo varchar(30))
RETURNS INT
BEGIN
    DECLARE respuesta integer default 0;

    case tipo
        WHEN 'suma' THEN SET respuesta = n1 + n2;
        WHEN 'resta' THEN SET respuesta = n1 - n2;
        WHEN 'multiplicacion' THEN SET respuesta = n1 * n2;
        WHEN 'division' THEN SET respuesta = n1 / n2;
    end case ;
    RETURN respuesta;
END;

select calculadora2(1,2,'suma') Suma;
select calculadora2(3,2,'resta') Resta;
select calculadora2(5,5,'multiplicacion') Multiplicacion;
select calculadora2(15,3,'division') Division;


-- EJERCICIO 2
-- CON LA CONSULTA DE ARRIBA

CREATE OR REPLACE FUNCTION valida_historia(cat VARCHAR(30), nac VARCHAR(30))
RETURNS BOOL
BEGIN
    DECLARE resultado BOOL DEFAULT FALSE;

    IF cat = 'Historia' and nac = 'Peruano'
    THEN SET resultado = TRUE;
    END IF;

    RETURN resultado ;
END;

-- CONSULTA
Select valida_historia('Historia','Peruano');


-- ======================================
-- DE OTRA FORMA DE CONSULTA
-- ======================================

   SELECT
    cat.nombre as CATEGORY,
    aut.nombre as AUTOR,
    aut.nacionalidad as NACIONALIDAD
FROM libro as lib
INNER JOIN autor as aut on lib.autor_id = aut.id
INNER JOIN libro_categoria as libcat on lib.id = libcat.libro_id
INNER JOIN categoria AS cat on libcat.categoria_id = cat.id
WHERE valida_historia(cat.nombre,aut.nacionalidad)=true;


