CREATE DATABASE defensa_hito_2;
USE defensa_hito_2;

CREATE TABLE autor(
    id_autor    INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    name        VARCHAR(100),
    nacionality VARCHAR(50)
);

CREATE TABLE book(
    id_book   INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    codigo    VARCHAR(25)                        NOT NULL,
    isbn      VARCHAR(50),
    title     VARCHAR(100),
    editorial VARCHAR(50),
    pages     INTEGER,
    id_autor  INTEGER,
    FOREIGN KEY (id_autor) REFERENCES autor (id_autor)
);

CREATE TABLE category(
    id_cat  INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    type    VARCHAR(50),
    id_book INTEGER,
    FOREIGN KEY (id_book) REFERENCES book (id_book)
);

CREATE TABLE users(
    id_user  INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    ci       VARCHAR(15)                        NOT NULL,
    fullname VARCHAR(100),
    lastname VARCHAR(100),
    address  VARCHAR(150),
    phone    INTEGER
);

CREATE TABLE prestamos(
    id_prestamo    INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    id_book        INTEGER,
    id_user        INTEGER,
    fec_prestamo   DATE,
    fec_devolucion DATE,
    FOREIGN KEY (id_book) REFERENCES book (id_book),
    FOREIGN KEY (id_user) REFERENCES users (id_user)
);


INSERT INTO autor (name, nacionality)
VALUES ('autor_name_1', 'Bolivia'),
       ('autor_name_2', 'Argentina'),
       ('autor_name_3', 'Mexico'),
       ('autor_name_4', 'Paraguay');

INSERT INTO book (codigo, isbn, title, editorial, pages, id_autor)
VALUES ('codigo_book_1', 'isbn_1', 'title_book_1', 'NOVA', 30, 1),
       ('codigo_book_2', 'isbn_2', 'title_book_2', 'NOVA II', 25, 1),
       ('codigo_book_3', 'isbn_3', 'title_book_3', 'NUEVA SENDA', 55, 2),
       ('codigo_book_4', 'isbn_4', 'title_book_4', 'IBRANI', 100, 3),
       ('codigo_book_5', 'isbn_5', 'title_book_5', 'IBRANI', 200, 4),
       ('codigo_book_6', 'isbn_6', 'title_book_6', 'IBRANI', 85, 4);

INSERT INTO category (type, id_book)
VALUES ('HISTORIA', 1),
       ('HISTORIA', 2),
       ('COMEDIA', 3),
       ('MANGA', 4),
       ('MANGA', 5),
       ('MANGA', 6);

INSERT INTO users (ci, fullname, lastname, address, phone)
VALUES ('111 cbba', 'user_1', 'lastanme_1', 'address_1', 111),
       ('222 cbba', 'user_2', 'lastanme_2', 'address_2', 222),
       ('333 cbba', 'user_3', 'lastanme_3', 'address_3', 333),
       ('444 lp', 'user_4', 'lastanme_4', 'address_4', 444),
       ('555 lp', 'user_5', 'lastanme_5', 'address_5', 555),
       ('666 sc', 'user_6', 'lastanme_6', 'address_6', 666),
       ('777 sc', 'user_7', 'lastanme_7', 'address_7', 777),
       ('888 or', 'user_8', 'lastanme_8', 'address_8', 888);


INSERT INTO prestamos (id_book, id_user, fec_prestamo, fec_devolucion)
VALUES (1, 1, '2017-10-20', '2017-10-25'),
       (2, 2, '2017-11-20', '2017-11-22'),
       (3, 3, '2018-10-22', '2018-10-27'),
       (4, 3, '2018-11-15', '2017-11-20'),
       (5, 4, '2018-12-20', '2018-12-25'),
       (6, 5, '2019-10-16', '2019-10-18');

-- ================================================= --
-- ================ EJERCICIO 1 ================= --
-- ================================================= --

CREATE OR REPLACE VIEW Mostrar_categoria as
SELECT us.ci as CI_USER,
    CONCAT(us.fullname,' ',us.lastname) as NOMBRE_COMPLETO,
    bo.title as LIBRO_PRESTADO,
    cat.type as CATEGORIA
FROM users as us
INNER JOIN prestamos as pres on us.id_user = pres.id_prestamo
INNER JOIN category as cat on pres.id_prestamo = cat.id_cat
INNER JOIN book as bo on cat.id_cat = bo.id_book
WHERE cat.type = 'COMEDIA' or cat.type = 'MANGA';

SELECT * FROM Mostrar_categoria;

-- ================================================= --
-- ================ EJERCICIO 2 ================= --
-- ================================================= --

SELECT COUNT(us.ci)
FROM users as us
INNER JOIN prestamos as pres on us.id_user = pres.id_prestamo
INNER JOIN category as cat on pres.id_prestamo = cat.id_cat
INNER JOIN book as bo on cat.id_cat = bo.id_book
WHERE bo.editorial = 'IBRANI' and bo.pages > 90;

-- AGREGANDO LA CONSULTA ANTERIOR A UNA FUNCION
CREATE OR REPLACE FUNCTION userIBRANIand90 (editorial VARCHAR(50), paginas INTEGER)
RETURNS VARCHAR(100)
BEGIN

    DECLARE response INT;

    SELECT COUNT(us.ci)

FROM users as us
INNER JOIN prestamos as pres on us.id_user = pres.id_prestamo
INNER JOIN category as cat on pres.id_prestamo = cat.id_cat
INNER JOIN book as bo on cat.id_cat = bo.id_book
WHERE bo.editorial = editorial and bo.pages > paginas

INTO response;

    RETURN response;
end;

--
SELECT userIBRANIand90 ('IBRANI',90);

-- ================================================= --
-- ================ EJERCICIO 3 ================= --
-- ================================================= --

-- CONSULTA
select description(bo.editorial, cat.type) as DESCRIPTION, NUMERO(bo.pages) as PAGES
from users as us
inner join prestamos as pres on pres.id_user = us.id_user
inner join book as bo on bo.id_book = pres.id_book
inner join category as cat on cat.id_book = bo.id_book
where bo.editorial = 'IBRANI' and cat.type = 'MANGA' ;

-- ESTO SEGUNDO
CREATE or REPLACE FUNCTION description(editorial varchar(50), categoria varchar(50))
    returns varchar(100)
    begin
        declare resp varchar(100);

        set resp = concat('Editorial: ', editorial, ', Categoria: ', categoria);

        return resp;
    end;

-- ESTO PRIMERO
create or replace function NUMERO(page integer)
returns varchar(100)
begin
    declare respuesta varchar(30);

    if page %2 = 0 then
        set respuesta = concat('Par: ', page);

    end if;
    if page %2 = 1 then
         set respuesta = concat('Impar: ', page);
    end if;

    return respuesta;
end;

-- ================================================= --
-- ================ EJERCICIO 4 ================= --
-- ================================================= --

SELECT COUNT(pres.fec_prestamo)
FROM users as us
INNER JOIN prestamos as pres on us.id_user = pres.id_prestamo
INNER JOIN book as bo on pres.id_prestamo = bo.id_book
WHERE pres.fec_prestamo like '%2017%' or pres.fec_prestamo like '%2018%';


CREATE OR REPLACE FUNCTION usuarioGEstion2017_2018()
RETURNS INTEGER
BEGIN

    DECLARE responde INTEGER;
        SELECT COUNT(pres.fec_prestamo)
        FROM users as us
        INNER JOIN prestamos as pres on us.id_user = pres.id_prestamo
        INNER JOIN book as bo on pres.id_prestamo = bo.id_book
        WHERE pres.fec_prestamo like '%2017%' or pres.fec_prestamo like '%2018%'
    INTO responde;
    RETURN responde;
END;

SELECT usuarioGEstion2017_2018();

