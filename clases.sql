
/* DDL= lenguaje de definicion de datos son los datos que nos pemiten crear, modificar, eliminar y consultar la estructura de la base de datos, no los datos que se registran en ella
-alter modificar la estructura de una tabla
-create crear una tabla
-drop eliminar una tabla o base de datos 
-truncate vaciar una tabla de datos y reinicia el contador de auto increment
-rename cambiar el nombre de una tabla

/*base de datos si existe con todo
y su contenido*/
DROP DATABASE IF EXISTS tienda_adso;


-- crear base de datos
CREATE DATABASE tienda_adso
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

--UTILIZAR base creada
USE tienda_adso;

--crear tabla categorias
CREATE TABLE categorias (
    id_categoria INT NOT NULL AUTO_INCREMENT,
    Nombre VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(255) NULL,
    CONSTRAINT 	pk_categorias PRIMARY KEY (id_categoria),
    CONSTRAINT uq_categorias_nombre UNIQUE (Nombre)
    ) ENGINE = INNODB;

    --crear tabla productos

    CREATE TABLE productos (
    id_producto INT NOT NULL AUTO_INCREMENT,
    id_categoria INT NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Precio DECIMAL(12,2) NOT NULL,
    STOCK INT NOT NULL DEFAULT 0,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_productos PRIMARY KEY (id_producto),
    CONSTRAINT ck_productos_precio CHECK (precio > 0),
    CONSTRAINT ck_productos_stock CHECK (stock >= 0),
    
    CONSTRAINT fk_productos_categorias FOREIGN KEY (id_categoria)
    REFERENCES categorias (id_categoria)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
    ) ENGINE = INNODB;

    --CREAR TABLA CLIENTES
    CREATE TABLE cliente (
    id_cliente INT NOT NULL AUTO_INCREMENT,
    tipo_documento VARCHAR(10) NOT NULL DEFAULT "CC",
    numero_documento VARCHAR(20) not null,
    nombres VARCHAR(50) NOT NULL,
    apellidos VARCHAR(70) NOT NULL,
    email VARCHAR(170) NOT NULL,
    Telefono VARCHAR(20) NOT NULL,
    ciudad VARCHAR(20) 	NOT NULL,
    Fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_cliente PRIMARY KEY (id_cliente),
    CONSTRAINT uq_cliente_documento UNIQUE (numero_documento),
    CONSTRAINT uq_cliente_email UNIQUE (email),
    --CAMPO PARA OPCIONES DE TIPO DE DOCUMENTOS
    CONSTRAINT ck_cliente_tipo_doc CHECK (tipo_documento IN ("CC","TI","CE", "PASS"))
    ) ENGINE = INNODB

 --crear tabla pedidos
CREATE TABLE pedidos (
    id_pedido INT NOT NULL AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    Fecha_pedido DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20) NOT NULL DEFAULT "Pendiente",
    total VARCHAR(60) NOT NULL DEFAULT 0,
    CONSTRAINT pk_pedidos PRIMARY KEY (id_pedido),
    CONSTRAINT ck_pedidos_estado CHECK (estado IN ("Pendiente", "pagado", "enviado", "cancelado")),
    CONSTRAINT ck_pedidos_total CHECK (total > 0),
    CONSTRAINT cfk_pedidos_clientes FOREIGN KEY (id_cliente)
    	REFERENCES clientes (id_cliente)
    	ON DELETE RESTRICT
    	ON UPDATE CASCADE
) ENGINE = INNODB
    
-- CREAR TABLA DETALLE PEDIDOS
    CREATE TABLE detalle_pedido (
    id_detalle INT NOT NULL AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    Cantidad INT NOT NULL,
    Precio_unitario DECIMAL(12,2) NOT NULL,
    CONSTRAINT pk_detalle_pedido PRIMARY KEY (id_detalle),
    CONSTRAINT ck_detalle_cantidad CHECK (cantidad > 0),
    CONSTRAINT ck_detalle_precio CHECK (precio_unitario > 0),
    CONSTRAINT uq_detalle_pedido_producto UNIQUE (id_pedido, id_producto),
    CONSTRAINT fk_detalle_pedidos FOREIGN KEY (id_pedido)
    	REFERENCES pedidos (id_pedido)
    	ON DELETE CASCADE,
CONSTRAINT fk_detalle_productos FOREIGN KEY (id_producto)
    	REFERENCES productos (id_producto)
    	ON DELETE RESTRICT
) ENGINE = INNODB

-- CREAR TABLA DE USUARIOS
CREATE TABLE usuarios (
    id_usuario INT NOT NULL AUTO_INCREMENT,
    id_cliente INT NULL,
    nombre_usuario VARCHAR(50),
    email VARCHAR(100),
    pasword_hash CHAR(64) NOT NULL,
    salt CHAR(32) NOT NULL,
    rol VARCHAR(20) NOT NULL DEFAULT"CLIENTE",
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    intentos_fallidos INT NOT NULL DEFAULT 0,
    bloqueado BOOLEAN NOT NULL DEFAULT FALSE,
    ultimo_acceso DATETIME NULL,
    fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_usuarios PRIMARY KEY (id_usuario),
    CONSTRAINT uq_usuarios_nombre UNIQUE (nombre_usuario),
    CONSTRAINT uq_usuarios_email UNIQUE (email),
    CONSTRAINT ck_usuarios_rol CHECK (rol IN ("ADMIN", "VENDEDOR", "CLIENTE")),
    CONSTRAINT fk_usuarios_clientes FOREIGN KEY (id_cliente)
    REFERENCES clientes (id_cliente)
    ON DELETE SET NULL
    ) ENGINE = INNODB;
--mirar la tabla de una base de datos 
show tables;

--describir la estructura de una tabla 
describe productos;

--codigo para ver el script de creacion de la tabla 
show create table productos;

--forma de sacar diccionario de datos
SELECT TABLE_NAME, constraint_name, constraint_type
FROM information_schema.table_constraints
WHERE table_schema= 'tienda_adso'
ORDER BY TABLE_NAME, constraint_type;

--agregar una columna a una tabla existente 
ALTER TABLE clientes
ADD COLUMN fecha_nacimiento DATE NULL AFTER apellidos;

--cambiar el tipo / tamaño de una columna
ALTER TABLE clientes
MODIFY COLUMN telefono VARCHAR(50) NULL;

--renombrar un columna chage column pide nombre viejo y nombre nuevo
--y la definicion de la columna completa 
ALTER TABLE clientes
CHANGE COLUMN ciudad ciudad_residencia VARCHAR(50) NOT NULL;

--eliminar una columna de una tabla
ALTER TABLE clientes
DROP COLUMN fecha_nacimiento;

--agregar una descripcion a una columna existente
ALTER TABLE productos
ADD CONSTRAINT uq_productos_nombre UNIQUE (nombre);

--eliminar una restriccion de una tabla existente
ALTER TABLE productos
DROP INDEX uq_productos_nombre;

--crear indices para busqueda rapida de datos
CREATE INDEX idx_productos_nombre ON productos(nombre);
CREATE INDEX idx_pedidos_precio ON pedidos (fecha_pedido);
CREATE INDEX idx_clientes_apellidos ON clientes(apellidos,nombres); --indice compuesta por dos columnas 
--mirar los indices de una tabla
SHOW INDEX FROM productos;

--haga el codigo para crear un tabla llamada tabla_practica campos id y detalle
CREATE TABLE tabla_practica (
    id int AUTO_INCREMENT PRIMARY KEY,
    detalle varchar(255)
)

--insertar datos en la tabla_practica
INSERT INTO tabla_practica (detalle) VALUES ('fila 1'), ('fila 2');

--borrar todas las filas de golpe y reinicie el auto increment
TRUNCATE TABLE tabla_practica;

--cambiar el nombre de la tabla
RENAME TABLE tabla_practica TO tabla_borrar;

--eliminar tabla
DROP TABLE tabla_borrar;