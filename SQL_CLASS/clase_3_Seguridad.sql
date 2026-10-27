/*
Clase 3 seguridad en base de datos
Objetivo: Evidenciar que las contraseñas esten ENCRIPTADAS (HASH y SALT) y aplicar de seguridad sobre los datos
1. hash vs cifrado
2. Constraseñas con HASH + SALT (SHA2)
3 Procedimiento para registrar usuarios, hacer login y cambiar clave
4. Cifrado Reversible para datos sensibles (AES)
5. Auiditorias con TRIGGER
6. Vistas que ocultan datos sensibles
7. Usuarios y roles de MYSQL con minimo privilegio (GRANT / REVOKE)
8. Prevencion de sql Injeccion con consultas preparadas
*/


/*
1- HASH vs CIFRADO para contraseñas
-Convierte un texto en una huella de longitud fija
- No se puede revertir, para validar el longin se calcula el hash de la clave escrita y se compra con el guardado
- Salt texto aletorio distinto para cada usuario que se mezcla con la clave antes de hash asi dos usuarios con la misma clave tienen hashes diferentes y se frustala rebundacia en las tablas


- cifrado ( dos vias ) Para datos sensibles que hay que volver a leer
-Con una llave se cifra y con la misma llave se descifra


* nunca guarda contraseñas en segundo plano */


--Demostracion del texto siempre da el mismo hash
SELECT SHA2 ('Clave123*', 256) AS hash_1;
SELECT SHA2 ('Clave123*', 256) AS hash_2;


-- Demostracion utilizando SALT misma clave salt distinto = hash distinto
SELECT SHA2(CONCAT('a1b2c3', 'Clave123*'),256) AS hash_usuario_A;
SELECT SHA2(CONCAT('a9y8x7', 'Clave123*'),256) AS hash_usuario_B;


--Generar un salt aleatorio de 32 caracteres Hexadecimal
--Mezclamos UUID (identificador unico) + RAND() (numero al azar) + la horacon milisegundos
-- tomamos los 32 caracteres del resultado
-- En MYSQL 8 existe HEX (RANDOM_BYTES(16)) mas robusto pero mariadb no lo tiene
SELECT LEFT(SHA2(CONCAT(UUID(), RAND(), NOW(6)), 256), 32) AS salt_aleatorio;


/*2 LO QUE NUNCA SE DEBE HACER CON CONTRASEÑAS(solo para mostrar el riesgo)
Si alguien roba la base de datos o un empleado curioso consulta la tabla veria las claves de todos
INSERT INTO usuarios (...) VALUES(...,'Miclave123, ...'); -- ¡MAL!
*/


/* 3. Procedimientos almacenados de autenticacion
- Centralizamos la logica de seguridad en procedimientos la aplicacion nunca toca directamente el hash solo llama a estosn procedimientos
DELIMITTER cambia el fin de la sentencia a // para poder usar ; dentro del procedimiento*/



DROP PROCEDURE IF EXISTS sp_registrar_ususario;
DROP PROCEDURE IF EXISTS sp_login_usuario;
DROP PROCEDURE IF EXISTS sp_cambiar_password;


DELIMITER //


--3.1 Registrar usuario: valida la politica de contraseñas genera salt y guarda el hash
DELIMITER //
CREATE PROCEDURE sp_registrar_usuario(
    IN p_nombre_usuario VARCHAR (50),
    IN p_email VARCHAR (100),
    IN p_password VARCHAR (100),
    IN p_rol VARCHAR (20),
    IN p_id_cliente INT
)
BEGIN
    DECLARE v_salt CHAR(32);

-- Politica de contraseñas minimo 8 caracteres una mayuscula y un  numero
-- tiene mayuscula si la clave es igual a su version en minuscula, no tiene
-- se compara en BINARY por que la collation "ci" considera iguales A y a 

IF CHAR_LENGTH(p_password) < 8
OR CAST(p_password AS BINARY) = CAST(LOWER(p_password)AS BINARY)
OR p_password NOT REGEXP '[0-9]' THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'la contraseña debe tener minimo 8, caractreres, una mayuscula y un numero';
END IF;

SET v_salt = LEFT(SHA2(CONCAT(UUID(), NOW(6)),
256), 32); --Gener un salt aleatorio de 32 caracteresADD

INSERT INTO usuarios (id_cliente, nombre_usuario, email, password_hash, salt, rol)
VALUES (p_id_cliente,
        p_nombre_usuario,
        p_email,
        SHA2(CONCAT(v_salt, p_password), 256), -- se guarda el hash no la clave )
        v_salt,
        p_rol);
END//

--3.2 login compara hashes cuenta intentos fallidos y bloquea el 3 intento 

DELIMITER //

CREATE PROCEDURE sp_login(
    IN p_nombre_usuario VARCHAR(50),
    IN p_password VARCHAR(100),
    OUT p_resultado VARCHAR(100)
)
BEGIN
    DECLARE v_id INT DEFAULT NULL;
    DECLARE v_hash CHAR(64);
    DECLARE v_salt CHAR(32);
    DECLARE v_bloqueado BOOLEAN DEFAULT FALSE;
    DECLARE v_intentos INT DEFAULT 0;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_id = NULL;

    SELECT id_usuario, password_hash, salt,
           bloqueado, intentos_fallidos
    INTO v_id, v_hash, v_salt,
         v_bloqueado, v_intentos
    FROM usuarios
    WHERE nombre_usuario = p_nombre_usuario
      AND activo = TRUE
    LIMIT 1;

    IF v_id IS NULL THEN

        SET p_resultado =
            'Usuario o contraseña incorrectos';

    ELSEIF v_bloqueado = TRUE THEN

        SET p_resultado =
            'Usuario bloqueado. Contacte al administrador';

    ELSEIF v_hash = SHA2(
        CONCAT(v_salt, p_password), 256
    ) THEN

        UPDATE usuarios
        SET intentos_fallidos = 0,
            ultimo_acceso = NOW()
        WHERE id_usuario = v_id;

        SET p_resultado = 'Acceso concedido';

    ELSE

        UPDATE usuarios
        SET intentos_fallidos = v_intentos + 1,
            bloqueado = IF(v_intentos + 1 >= 5, TRUE, FALSE)
        WHERE id_usuario = v_id;

        SET p_resultado =
            'Usuario o contraseña incorrectos';

    END IF;

END //

DELIMITER ;


--3.3 cambiar contraseña:exige la clave actual y genera salt nuevo 
CREATE PROCEDURE sp_cambiar_password(
    IN p_nombre_usuario VARCHAR(50);
    IN p_password_actual VARCHAR(100);
    in p_password_nueva VARCHAR(100);
    OUT p_resultado VARCHAR(100)
    )
    BEGIN 
    DECLARE v_salt_nuevo CHAR(32);

    IF NOT EXISTS (SELECT 1 FROM usuarios
    WHERE nombre_usuario = p_nombre_usuario
    AND password_hash = SHA (CONCAT(salt, p_password_actual), 256)) THEN 
    SET p_resultado = 'la contraseña actual no es correcta';
    ELSEIF  CHAR_LENGTH(p_password_nueva) < 8
    OR CAST(p_password_nueva AS BINARY) = CAST(LOWER
    (p_password_nueva) AS BINARY)
    OR p_password_nueva NOT REGEXP '[0-9]' THEN 
    SET p_resultado = 'la nueva contraseña no cumple la politica';
    SET v_salt_nuevo = LEFT(SHA2(CONCAT(UUDI(), RAND(), NOW (6)), 256)32);
    UPDATE usuarios 
    SET salt = v_salt_nuevo,
    password_hash = SHA2(CONCAT(v_salt_nuevo, p_password_nueva), 256)
    WHERE nombre_usuario = p_nombre_usuario;
    SET p_resultado = 'contraseña actulizada';
    END IF;
    END //
    DELIMITER;
    