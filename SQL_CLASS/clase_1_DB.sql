-- ELIMINAR BASE DATOS EXISTENTE CON SU CONTENIDO
DROP DATABASE IF EXISTS tienda_adso;

-- CREAR BASE DE DATOS 
CREATE DATABASE tienda_adso
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- ABRIR LA BASE DE DATOS 
USE tienda_adso;

-- INFORMACION
    ON DELETE RESTRICT --RESTRICION PARA ELIMINAR
    ON UPDATE CASCADE  --AL HACER UNA ACTUALIZACION SE ACOMODA EN CASCADA

-- CREAR TABLA PRODUCTOS PRIMARY KEY
CREATE TABLE productos (
    id_producto INT NOT NULL AUTO_INCREMENT,
    id_categoria INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(12,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
	fecha_registro  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT pk_productos PRIMARY KEY (id_producto),
	CONSTRAINT ck_productos_precio CHECK (precio > 0),
    CONSTRAINT ck_productos_stock CHECK (stock>=0),
	
    CONSTRAINT fk_productos_categorias FOREIGN KEY (id_categoria)
	REFERENCES categorias (id_categoria) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
	)	ENGINE = InnoDB;


    CREATE TABLE clientes (
    id_cliente INT NOT NULL, 
    nombres VARCHAR(100) NOT NULL,
	apellidos VARCHAR(100) NOT NULL,  
    tipo_documento VARCHAR(10),
	numero_documento VARCHAR(20)DATE UNIQUE,
	email VARCHAR(100) DATE UNIQUE,
	telefono VARCHAR(20),
	ciudad VARCHAR (50),
     activo BOOLEAN NOT NULL DEFAULT TRUE,
	fecha_registro  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT pk_clientes PRIMARY KEY (id_cliente),
    
    
    ON DELETE RESTRICT
    ON UPDATE CASCADE
	)	ENGINE = InnoDB;

_________________________________________________________________________________________________________________________________________
    
-- CREAR TABLA CLIENTES

    CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    tipo_documento VARCHAR(10) NOT NULL DEFAULT 'CC',
    numero_documento VARCHAR(20) NOT NULL,
    nombres VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(20),
    ciudad VARCHAR(50),
    fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_clientes PRIMARY KEY (id_cliente),
    CONSTRAINT uq_clientes_documento UNIQUE (numero_documento), 
    CONSTRAINT uq_clientes_email UNIQUE (email),
    
    CONSTRAINT ck_clientes_tipo_doc CHECK (tipo_documento IN ('CC', 'TI', 'CE', 'PASS'))
)	ENGINE = InnoDB

_________________________________________________________________________________________________________________________________________

-- CREAR TABLA PEDIDOS

CREATE TABLE pedidos (
    id_pedido INT NOT NULL AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    fecha_pedido DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20) NOT NULL DEFAULT 'Pendiente',
    total VARCHAR(60) NOT NULL DEFAULT 0,
    CONSTRAINT pk_pedidos PRIMARY KEY (id_pedido),
    CONSTRAINT ck_pedidos_estado CHECK (estado IN ('Pendiente', 'Pagado', 'Enviado', 'Cancelado')), 
    CONSTRAINT ck_pedidos_total CHECK (total > 0),
    CONSTRAINT fk_pedidos_clientes FOREIGN KEY (id_cliente)
    	REFERENCES clientes (id_cliente)
    	ON DELETE RESTRICT
    	ON UPDATE CASCADE
)	ENGINE = InnoDB

_________________________________________________________________________________________________________________________________________

-- CREAR TABLA DETALLE_PEDIDO

CREATE TABLE detalle_pedido (
    id_detalle INT NOT NULL AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(12,2) NOT NULL,
	CONSTRAINT pk_detalle_pedido PRIMARY KEY (id_detalle),
    CONSTRAINT ck_detalle_cantidad CHECK (cantidad > 0),
    CONSTRAINT ck_detalle_precio CHECK (precio_unitario > 0),
    CONSTRAINT uq_detalle_pedido_producto UNIQUE (id_pedido, id_producto),
	CONSTRAINT fk_detalle_pedidos FOREIGN KEY (id_pedido)
        REFERENCES pedidos (id_pedido)
        ON DELETE CASCADE,
	CONSTRAINT fk_detalle_producto FOREIGN KEY (id_producto)
        REFERENCES productos (id_producto)
        ON DELETE RESTRICT
)	ENGINE = InnoDB
_________________________________________________________________________________________________________________________________________

-- CREAR TABLA USUAROS ENCRIPTED

CREATE TABLE usuarios (
	id_usuarios INT NOT NULL AUTO_INCREMENT,	
    id_cliente INT NULL,
    nombre_usuario VARCHAR(50),
    email VARCHAR(100),
    -- ENCRIPTAR CONTRASEÑA--
    password_hash CHAR(64) NOT NULL,
    -- CONTRASEÑA DIFERENTE -- 
    salt CHAR(32) NOT NULL,
    rol VARCHAR(20) NOT NULL DEFAULT 'CLIENTE',
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    intentos_fallidos INT NOT NULL DEFAULT 0,
    bloqueado BOOLEAN NOT NULL DEFAULT FALSE,
    ulimo_acceso DATETIME NULL,
    fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_usuarios PRIMARY KEY (id_usuario),
    CONSTRAINT uq_usuarios_nombre UNIQUE (nombre_usuario),
    CONSTRAINT uq_usuarios_email UNIQUE (email),
    CONSTRAINT ck_usuarios_rol CHECK (rol IN('ADMIN','VENDEDOR','CLIENTE')), 
    CONSTRAINT fk_usuarios_clientes FOREIGN KEY (id_cliente)
    REFERENCES clientes (id_cliente)
    ON DELETE SET NULL 
    ) ENGINE = InnoDB

_________________________________________________________________________________________________________________________________________

-- VER TABLAS DE DATOS
    SHOW TABLES;
_________________________________________________________________________________________________________________________________________

-- DESCRIBIR UNA TABLA
DESCRIBE productos;
_________________________________________________________________________________________________________________________________________

--VER CODIGO DE LA TABLA
SHOW CREATE TABLE pedidos;

_________________________________________________________________________________________________________________________________________

--VER DICCIONARIO DE DATOS 
SELECT table_name, constraint_name, constraint_type
FROM information_schema.table_constraints
WHERE table_schema = 'tienda_adso'
ORDER  BY table_name, constraint_type;

_________________________________________________________________________________________________________________________________________

--AGEGAR UNA COLUMNA A UNA TABLA EXISTENTE 
ALTER TABLE clientes
ADD COLUMN fecha_nacimiento DATE NULL AFTER apellidos;
_________________________________________________________________________________________________________________________________________

-- CAMBIAR EL TIPO / TAMAÑO DE UNA COLUMNA 
ALTER TABLE clientes 
MODIFY COLUMN telefono VARCHAR(50) NULL;
_________________________________________________________________________________________________________________________________________

-- RENOMBRAR UNA COLUMNA CHANGE COLUMN PIDE NOMBRE VIEJO , NUEVO NOMBRE 
-- Y LA DEFINICION DE LA COLUMNA COMPLETA 
ALTER TABLE clientes 
CHANGE COLUMN ciudad ciudad_residencia VARCHAR(50) NOT NULL;

_________________________________________________________________________________________________________________________________________

--LA DEVOLVEMOS A LA TABLA ORIGINAL
ALTER TABLE clientes 
CHANGE COLUMN ciudad_residencia ciudad VARCHAR(50) NOT NULL;
________________________________________________________________________________________________________________________________________

--ELIMINAR UNA COLUMNA DE UNA TABLA 
ALTER TABLE clientes
DROP COLUMN fecha_nacimiento;

_________________________________________________________________________________________________________________________________________

-- AGREGAR UNA DESCIPCION A UNA TABLA EXISTENTE 
ALTER TABLE productos
ADD CONSTRAINT uq_productos_nombre UNIQUE (nombre);
_________________________________________________________________________________________________________________________________________

-- ELIMINAR UNA RESTRICCION DE UNA TABLA EXISTENTE 
ALTER TABLE productos 
DROP INDEX uq_productos_nombre; 

_________________________________________________________________________________________________________________________________________

-- CREAR INDICES PARA BUSQUEDAS MAS RAPIDAS 
CREATE INDEX idx_productos_nombre ON productos (nombre); 
CREATE INDEX idx_pedidos_fecha ON pedidos (fecha_pedido);
CREATE INDEX idx_clientes_apellidos ON clientes (apellidos , nombres); -- INDICE COMPUEST POR DOS COLUMNAS 

_________________________________________________________________________________________________________________________________________

-- MIRAR LOS INDICES DE UNA TABLA 
SHOW INDEX FROM productos; 
_________________________________________________________________________________________________________________________________________

-- haga el codigo para crear una tabla llamada tabla_practica vampos id y detalle

CREATE TABLE tabla_practica (
    id INT AUTO_INCREMENT PRIMARY KEY, 
    detalle VARCHAR(50)
);

_________________________________________________________________________________________________________________________________________

-- Insertar datos en la tabla_practica
INSERT INTO tabla_practica (detalle) VALUES ('fila 1'), ('fila 2');

_________________________________________________________________________________________________________________________________________

-- borrar todas las filas de golpe y reinicia el Auto Increment 
TRUNCATE TABLE tabla_practica;
_________________________________________________________________________________________________________________________________________

-- cambiar el nombre de una tabla 
RENAME TABLE tabla_practica TO tabla_borrar;

_________________________________________________________________________________________________________________________________________

-- eliminar tabla 
DROP TABLE tabla_borrar;

_________________________________________________________________________________________________________________________________________

