Use Hito_4;
# QUE ES UNA ADITORIA
# Permite monitoriar todos los cambios que se realizan en una tabla.

# PERMITE OBTENER LA FECHA ACTUAL
SELECT CURRENT_DATE;
# PERMITE VER LA FECHA Y HORA ACTIAL
SELECT NOW();
# PERMITE VER EL USUARIO LOGEADO
SELECT USER(); #nombre del usuario @ direccion ip
# PERMITE OBTENER EL HOSTNAME
SELECT @@HOSTNAME; #nombre del equipo
# ESTE COMANDO PERMITE VER TODAS LAS VARIABLES DE LA BASE DE DATOS
SHOW VARIABLES;

# CREANDO LA TABLA PARA LA AUDITORIA
CREATE TABLE audit_usuario_rrhh(
    # DATOS QUE NOS MUESTRA LA AUDITORIA
  fecha_mod TEXT NOT NULL,
  usuario_log TEXT NOT NULL,
  hostname TEXT NOT NULL,
  accion TEXT NOT NULL,

  # DATOS QUE SUFRIERON CAMBIOS
  id_usr TEXT NOT NULL,
  nombre_completo TEXT NOT NULL,
  password TEXT NOT NULL
);

# CREANDO LA TABLA DE USUARIOS
CREATE TABLE usuarios_rrhh(
    id_usr INT PRIMARY KEY NOT NULL,
    nombre_completo VARCHAR(50) NOT NULL ,
    fecha_nac DATE NOT NULL ,
    correo VARCHAR (100) NOT NULL ,
    password varchar(200)
);

SELECT CURRENT_DATE;

INSERT INTO usuarios_rrhh(id_usr, nombre_completo, fecha_nac, correo, password)
VALUES (123456,'Edson Iver Condori Condori','2004-01-04','edson@gmail.com','123456');

SELECT * FROM usuarios_rrhh;



# TRIGGER PARA ELIMINAR
# cuando es un trigger de eliminacion usamos el OLD
CREATE  OR REPLACE TRIGGER tr_audit_usuarios_rrhh
    AFTER DELETE
    ON usuarios_rrhh
    FOR EACH ROW
    BEGIN
        DECLARE id_usuario TEXT;
        DECLARE nombres TEXT;
        DECLARE usr_password TEXT;

        SET id_usuario = OLD.id_usr;
        SET nombres = OLD.nombre_completo;
        SET usr_password = OLD.password;

        INSERT INTO audit_usuario_rrhh(fecha_mod, usuario_log, hostname, accion, id_usr, nombre_completo, password)
        SELECT NOW(),user(),@@HOSTNAME, 'DELETE',id_usuario,nombres,usr_password;
    END;


INSERT INTO usuarios_rrhh(id_usr, nombre_completo, fecha_nac, correo, password)
VALUES (654321,'Mijail Oliver Choque Amaro','2006-02-05','mija@gmail.com','654321');

# LLAMANDO A LA TABLA LUEGO AL TRIGGER
SELECT * from usuarios_rrhh;
SELECT * FROM audit_usuario_rrhh;


# TRIGGER INSERTANDO DATOS
CREATE  OR REPLACE TRIGGER tr_audit_usuarios_rrhh_insert
    BEFORE INSERT
    ON usuarios_rrhh
    FOR EACH ROW
    BEGIN
         INSERT INTO audit_usuario_rrhh(fecha_mod, usuario_log, hostname, accion, id_usr, nombre_completo, password)
        SELECT NOW(),user(),@@HOSTNAME, 'INSERT',NEW.id_usr,NEW.nombre_completo,NEW.password;
    END;


INSERT INTO usuarios_rrhh
    (id_usr, nombre_completo, fecha_nac, correo, password)
VALUES (654623,'Javier Oscar Choque Blanco','2006-02-05','mija@gmail.com','654321');

SELECT * from usuarios_rrhh;
SELECT * FROM audit_usuario_rrhh;

drop trigger tr_audit_usuarios_rrhh_insert;

# NOTA: para ver los registros de insersion modificacion etc solo llamamos al primer trigger
# que creamos  de auditoria.


# ======================================================================================
# ============================== EJERCICIOS =================================
# ======================================================================================

CREATE OR REPLACE TABLE audit_usuario_rrhh_v2(
  # DATOS QUE NOS MUESTRA LA AUDITORIA
  fecha_mod TEXT NOT NULL,
  usuario_log TEXT NOT NULL,
  hostname TEXT NOT NULL,
  accion TEXT NOT NULL,

  # DATOS QUE SUFRIERON CAMBIOS
  antes_del_cambio TEXT NOT NULL,
  despues_del_cambio TEXT NOT NULL
);


# INSERTANDO DATOS
CREATE  OR REPLACE TRIGGER tr_audit_usuarios_rrhh
    AFTER UPDATE
    ON usuarios_rrhh
    FOR EACH ROW
    BEGIN
        DECLARE ANTES_CAMBI TEXT DEFAULT ' ';
        DECLARE DESPUES_CAMBI TEXT DEFAULT ' ';

        SET ANTES_CAMBI= CONCAT(OLD.id_usr, ' - ', OLD.nombre_completo, ' - ', OLD.fecha_nac);
        SET  DESPUES_CAMBI = CONCAT(NEW.id_usr, ' - ', NEW.nombre_completo, ' - ', NEW.fecha_nac);

         INSERT INTO audit_usuario_rrhh_v2(fecha_mod, usuario_log, hostname, accion, antes_del_cambio,despues_del_cambio)
        SELECT NOW(),user(),@@HOSTNAME, 'UPDATE',ANTES_CAMBI, DESPUES_CAMBI;
    END;

INSERT INTO usuarios_rrhh
    (id_usr, nombre_completo, fecha_nac, correo, password)
VALUES (65623,'Javier Oscar Choque Blanco','2006-02-05','mija@gmail.com','654321');

select * from usuarios_rrhh;
select * from audit_usuario_rrhh_v2;

# ============================== PROCEDIMIENTOS ALMACENADOS =================================

 # PROCEDIMIENTOS ALMACENADOS

 CREATE OR REPLACE PROCEDURE inserta_datos(
    fecha TEXT,
    usuario TEXT,
    hostname TEXT,
    accion TEXT,
    ANTES_CAMBI TEXT,
    DESPUES_CAMBI TEXT
)
    BEGIN
        INSERT INTO audit_usuario_rrhh_v2(fecha_mod, usuario_log, hostname, accion, antes_del_cambio,despues_del_cambio)
        VALUES (fecha,usuario,hostname,accion,ANTES_CAMBI,DESPUES_CAMBI);
    END;


CREATE  OR REPLACE TRIGGER tr_audit_usuarios_rrhh
    AFTER UPDATE
    ON usuarios_rrhh
    FOR EACH ROW
    BEGIN
        DECLARE ANTES_CAMBI TEXT DEFAULT ' ';
        DECLARE DESPUES_CAMBI TEXT DEFAULT ' ';

        SET ANTES_CAMBI= CONCAT(OLD.id_usr, ' - ', OLD.nombre_completo, ' - ', OLD.fecha_nac);
        SET  DESPUES_CAMBI = CONCAT(NEW.id_usr, ' - ', NEW.nombre_completo, ' - ', NEW.fecha_nac);

        # con el comando CALL llamamos al procedimiento almacenado
        CALL inserta_datos(
        NOW(),USER(),@@HOSTNAME,'UPDATE',ANTES_CAMBI,DESPUES_CAMBI
    );
    END;

select * FROM usuarios_rrhh;
select * from audit_usuario_rrhh_v2;

TRUNCATE TABLE audit_usuario_rrhh_v2;
