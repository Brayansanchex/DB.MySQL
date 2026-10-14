-----1. crear tabla "proveedores"
CREATE TABLE proveedores (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nit VARCHAR(20) NOT NULL UNIQUE,
    razon_social VARCHAR(150) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    ciudad VARCHAR (50),
    activo BOOLEAN DEFAULT TRUE
)ENGINE = InnoDB;


------2. agregar a profuctos la columna id_proveedor 
ALTER TABLE productos
ADD COLUMN id_proveedor INT NULL;

ALTER TABLE productos
ADD CONSTRAINT fk_productos_proveedores
FOREIGN KEY (id_proveedor)
REFERENCES proveedores(id_proveedor)
ON DELETE SET NULL;


-------3. 
CREATE TABLE direcciones_envio (
    id_direccion int AUTO_INCREMENT,
    id_cliente int NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    barrio VARCHAR(100),
    ciudad VARCHAR (100) NOT NULL,
    es_principal BOOLEAN DEFAULT FALSE,
    CONSTRAINT pk_direcciones_envio PRIMARY KEY (id_direccion),
    CONSTRAINT fk_direcciones_clientes FOREIGN KEY (id_cliente)
    REFERENCES clientes(id_cliente)
    ON DELETE CASCADE
)ENGINE = InnoDB;


------4.

ALTER TABLE productos
ADD CONSTRAINT ck_productos_precio_max
CHECK (precio <= 50000000);


-----5. 
CREATE index idx_clientes_ciudad
ON clientes(ciudad);


----6.
-- Crear la tabla con dos columnas
CREATE TABLE puebas (
id_prueba INT NOT NULL AUTO_INCREMENT,
   verificacion VARCHAR (50) NOT NULL,
    CONSTRAINT pk_pruebas PRIMARY KEY (id_prueba)
)ENGINE = InnoDB;


-- renombrar 
rename table pruebas to pruebas_old;
--- eliminar tabla
drop table pruebas_old