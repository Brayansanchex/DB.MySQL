/*E l DML nos permite manipula  la base de datos en 4 acciones crear, modificar, eliminar
realizar consultar con select*/
INSERT into categorias (nombre, descripcion) 
VALUES 

('tecnologia', 'computadores, perisfericos, accesorios');

('hogar', 'electrodomesticos, articulos para el hogar');
('papeleria', 'utiles escolares, oficina'); 
('deportes', 'implementos deportivos');
('juguetes', 'categoria nueva, aun sin productos');

/*insertar datos en una tabla con relacion*/
INSERT into productos (id_categoria, nombre, precio, stock)
VALUES 
(1, 'portatil lenovo ideapad', 2500000, 15),
(1, 'mouse inalambrico', 45000, 120),
(1, 'teclado mecanico', 180000, 40),
(1, 'monitor 24 pulgadas', 650000, 25),
(2, 'licuadora oster', 220000, 30),
(2, 'juego de ollas', 310000, 18),
(2, 'licuadora oster', 220000, 30),
(2, 'juego de ollas', 310000, 18),
(2, 'lampara led', 60000, 75),
(3, 'cuaderno 100 hojas', 8500, 500),
(3, 'resma de papel carta', 22000, 200),
(3, 'kit de marcadores', 15000, 150),
(4, 'balon de fútbol', 85000, 60),
(4, 'bicicleta estatica', 120000, 5);

/*insertar datos de clientes el ultimo no tiene telefono*/
INSERT into cliente (tipo_documento, numero_documento, nombres, apellidos, email, telefono, ciudad)
VALUES
('cc', '10010010001', 'ana maria', 'gomez ruiz', 'ana.gomez@correo.com', '3001112233', 'medellin'),
('cc', '10020020002', 'carlos andres', 'perez diaz', 'carlos.perez@correo.com', '3002223344', 'bogota'),
('cc', '10030030003', 'luisa fernanda', 'martinez rios', 'luisa.martinez@correo.com', '3023334455', 'cali'),
('TI', '10040040004', 'juan david', 'restrepo toro', 'juan.restrepo@correo.com', '3034445566', 'medellin'),
('CE', '10050050005', 'valentina', 'herrera lopez', 'valentina.herrera@correo.com', '3045556677', 'barranquilla'),
('CC', '10060060006', 'santiago', 'ramirez castro', 'santiago.ramirez@correo.com', '3056667788', 'bogota'),
('CC', '10070070007', 'daniela', 'ospina vargas', 'daniela.ospina@correo.com', '3067778899', 'medellin'),
('CC', '10080080008', 'mateo', 'londoño giraldo', 'mateo.londoño@correo.com', null, 'bogota');


--Pedidos vamos a realizar pedidos con relacion con cliente
INSERT INTO pedidos (id_cliente, fecha_pedido, estado)VALUES
(1, '2026-08-01 10:15:00', 'PAGADO'),
(2, '2026-08-03 14:30:00', 'ENVIADO'),
(1, '2026-08-10 09:00:00', 'ENVIADO'),
(3, '2026-08-15 16:45:00', 'PAGADO'),
(4, '2026-08-20 11:20:00', 'CANCELADO'),
(5, '2026-09-02 08:10:00', 'PENDIENTE'),
(6, '2026-09-05 19:00:00', 'PAGADO'),
(2, '2026-09-12 12:00:00', 'PAGADO'),
(7, '2026-09-20 17:30:00', 'ENVIADO'),
(3, '2026-09-28 10:05:00', 'PENDIENTE');


--ajuestes de tabla pedidos
ALTER TABLE pedidos MODIFY COLUMN total DECIMAL(12,2) NOT NULL DEFAULT 0;


ALTER TABLE pedidos DROP CONSTRAINT IF EXISTS ck_pedidos_total;


ALTER TABLE pedidos ADD CONSTRAINT ck_pedidos_total CHECK (total >=0);


--Detalle de pedidos se maneja con 2 relaciones con productos y pedidos
INSERT INTO  detalle_pedido (id_pedido, id_producto, cantidad, precio_unitario) VALUES
    (1, 1, 1, 2500000), (1, 2, 2, 45000),
    (2, 4, 2, 650000), (2, 3, 1, 45000),
    (3, 8, 10, 8500), (3, 9, 2, 45000),
    (4, 5, 1, 220000), (4, 7, 2, 60000),
    (5, 11, 1, 85000),
    (6, 6, 1, 3100000), (6, 2, 2, 45000),
    (7, 1, 1, 2500000), (7, 4, 1, 65000), (7, 2, 1, 45000),
    (8, 10, 5, 15000), (8, 8, 20, 8500),
    (9, 3, 2, 180000), (9, 7, 1, 60000),
    (10, 11, 2, 2500000), (10, 9, 3, 22000);


/*Trabajo con los datos de una base de datos
Calcular el total de cada pedido cn un UPDATE + consultas correlacionada
Para cada pedido "p" suma cantidad * precio de detalles*/
UPDATE pedidos p
SET p.total = (SELECT sum(d.cantidad * d.precio_unitario)
FROM detalle_pedido d
WHERE d.id_pedido = p.id_pedido);


--mostrar de manemar mas facil las columnas
SELECT id_pedido, id_cliente, estado, total FROM  pedidos;


/*CONSULTAS BASICAS READ DE UNA BASE DE DATOS
1. Columnas especificas con alias AS para nombrarlas mejor*/


SELECT nombre AS producto, precio AS precio_venta, stock AS unidades FROM productos;
-- WHERE con operadores de compraracion y logicos ADN OR NOT
SELECT nombre, precio, stock

FROM productos
WHERE precio > 100000 AND stock >= 20;


--BETWEEN (RANGO, INCLUYE LOS EXTREMOS)
SELECT nombre, precio FROM  productos
WHERE precio BETWEEN 20000 AND 200000;

--lista de valores con IN 
SELECT nombres, apellidos, ciudad FROM clientes 
WHERE ciudad in ('medellin', 'bogota');

--LIKE: $ = cualquir cantidad de caracteres, exactamente un caracter 
select nombres, apellidos, email FROM clientes
WHERE apellidos LIKE 'R%';

--IS NULL / IS NOT PULL  no se consideran el valor nulo en las comparaciones
select nombres, apellidos FROM clientes 
WHERE telefono is null;

--ORDER BY ordena los resultados de una consulta de manera ascendente o descendente 
SELECT nombre, precio from productos 
ORDER BY  precio desc 
limit 3;

-- DISTINCT: elimina los registros duplicados de una consulta 
SELECT DISTINCT ciudad from clientes ORDER BY ciudad;

-- columnas calculada y funcion de texto 
SELECT CONCAT(nombres, '', apellidos) AS cliente_completo,
UPPER(ciudad) AS ciudad_mayuscula,
char_length(email) AS largo_email
FROM clientes;

--CASE: logica condicional dentro de la consulta 
SELECT nombre, stock,
CASE
   when stock < 20 then 'stock bajo'
   when stock < 100 then 'stock medio'
   else 'stock alto'
   END AS nivel_stock
   FROM productos;


/*JOINs CONSULTAS ENTRE VARIAS TABLAS 
RIGHT JOIN: devuelve todos los registros de la tabla derecha y los registros coincidentes de la tabla izquierda 
FULL JOIN: devuelve todos los registros cuando hay */

/* JOINs CONSULTAS ENTRE VARIAS TABLAS
RIGHT JOIN: devuelve todos los registros de la tabla derecha y los registros conincidentes de la tabla izquierda
FULL JOIN: devulve todos los registros cuando hay
*/


--INNER JOIN: Productos con el mismo nomre en la categoria
SELECT p.nombre AS producto, c.nombre AS categoria, p.precio
FROM productos p
INNER JOIN categorias c ON c.id_categoria = p.id_categoria
ORDER BY c.nombre, p.nombre;


--INNER JOIN pedidos con el mismo nombre de cliente
SELECT pe.id_pedido, pe.fecha_pedido, pe.estado, pe.total,
CONCAT(cl.nombres, '', cl.apellidos) AS cliente
FROM pedidos pe
INNER JOIN clientes cl ON cl.id_cliente = pe.id_cliente
ORDER BY pe.fecha_pedido;


-- factura detallada de un pedido con INNER JOIN entre 4 tablas
SELECT pe.id_pedido,
CONCAT(cl.nombres, '', cl.apellidos) AS cliente,
pr.nombre AS producto,
d.cantidad,
d.precio_unitario,
d.cantidad * d.precio_unitario AS subtotal
FROM pedidos pe
INNER JOIN clientes cl ON cl.id_cliente = pe.id_cliente
INNER JOIN detalle_pedido d ON d.id_pedido = pe.id_pedido
INNER JOIN productos pr ON pr.id_producto = d.id_producto
ORDER BY pe.id_pedido, pr.nombre;


--LEFT JOIN TODOS LOS CLIENTES TENGAN O NO PEDIDOS
SELECT cl.nombres, cl.apellidos, pe.id_pedido, pe.total
FROM clientes cl
LEFT JOIN pedidos pe ON pe.id_cliente = cl.id_cliente
ORDER BY cl.id_cliente


--left join + IS NULL productos que nunca se han vendido
SELECT pr.nombre, pr.stock
FROM productos pr
LEFT JOIN detalle_pedido d ON d.id_producto = pr.id_producto
WHERE d.id_detalle IS NULL;


--rIGHT JOIN todas las categorias aunque no tengan productos
SELECT c.nombre AS categoria, p.nombre AS producto
FROM productos p  
RIGHT JOIN categorias c ON c.id_categoria = p.id_categoria
ORDER BY c.nombre; --juguetes debe aparecer




--FULL OUTER JOIN emulado es decir una /left join y rigt join
SELECT c.nombre AS categoria, p.nombre AS producto
FROM categorias c LEFT JOIN productos p ON p.id_categoria = c.id_categoria
UNION
SELECT c.nombre, p.nombre
FROM categorias c RIGHT JOIN productos p ON p.id_categoria = c.id_categoria;

--5.1Resumen general de productos

SELECT COUNT(*) AS total_productos, 
SUM(stock) AS unidades_en_bodega, 
ROUND (AVG(precio), 2) AS precio_promedio, 
MIN(precio) AS precio_minimo, 
MAX(precio) AS precio_maximo 
FROM productos; 

-- 5.2 Cantidad de productos y valor del inventario por categoría 
SELECT c.nombre AS categoria, 
COUNT(p.id_producto) AS cantidad_productos, 
SUM(p.precio * p.stock) AS valor_inventario 
FROM categorias c 
LEFT JOIN productos p ON p.id_categoria = c.id_categoria 
GROUP BY c.nombre 
ORDER BY valor_inventario DESC; 

-- 5.3 Total comprado por cliente (sin pedidos cancelados) 
SELECT CONCAT(cl.nombres, '', cl.apellidos) AS cliente, 
COUNT(pe.id_pedido) AS numero_pedidos,
SUM(pe.total)  AS total_comprado 
FROM clientes cl 
INNER JOIN pedidos pe ON pe.id_cliente = cl.id_cliente 
WHERE pe.estado <> 'CANCELADO'  --WHERE:filtra filas antes de agrupar
GROUP BY cl.id_cliente, cl.nombres, cl.apellidos 
ORDER BY total_comprado DESC; 

|-- 5.4 HAVING: clientes que han comprado más de 1.000.000 
SELECT CONCAT(cl.nombres, '', cl.apellidos) AS cliente, 
SUM(pe.total) AS total_comprado 
FROM clientes cl 
INNER JOIN pedidos pe ON pe.id_cliente = cl.id_cliente 
WHERE pe.estado <> 'CANCELADO' 
GROUP BY cl.id_cliente, cl.nombres, cl.apellidos
HAVING SUM(pe.total) > 1000000; 


--5.5 Ventas por mes 
SELECT DATE_FORMAT(fecha_pedido, '%Y-%m') AS mes, 
COUNT(*) AS pedidos, 
SUM(total) AS ventas 
FROM pedidos 
WHERE estado <> 'CANCELADO' 
GROUP BY DATE_FORMAT(fecha_pedido, '%Y-%m')
ORDER BY mes; 

5.6 Unidades vendidas por producto 
SELECT pr.nombre, SUM(d.cantidad) AS unidades_vendidas 
FROM detalle_pedido d 
INNER JOIN productos pr ON pr.id_producto = d.id_producto 
INNER JOIN pedidos pe ON pe.id_pedido = d.id_pedido
WHERE pe.estado <> 'CANCELADO' 
GROUP BY pr.id_producto, pr.nombre 
ORDER BY unidades_vendidas DESC; 

-- 5.7 Pedidos por estado 
SELECT estado, COUNT(*) AS cantidad, SUM(total) AS valor 
FROM pedidos 
GROUP BY estado; 


--subconsultas una consulta dentro de otra
--subconsulta en where (valor unico) productos mas caros que el promedio


SELECT nombre, precio
FROM productos
WHERE precio > (SELECT AVG(precio) FROM productos);


--Subconsulta con IN (lista) clientes que han hecho al menos un pedido
SELECT nombres, apellidos
FROM clientes
WHERE id_cliente IN (SELECT id_cliente FROM pedidos);


--NOT EXISTS: categorias que no tienen productos
SELECT c.nombre
FROM categorias c
WHERE NOT EXISTS (SELECT 1 FROM productos p 
WHERE p.id_categoria = c.id_categoria);


--Subconsulta escalar en el select: numero de pedidos de cada cliente
SELECT cl.nombres, cl.apellidos,
(SELECT COUNT(*) FROM pedidos pe WHERE pe.id_cliente = cl.id_cliente) AS cantidad_pedidos
FROM clientes cl;


--subconsulta en from (tabla derivada) promedio de compra por cliente
SELECT ROUND(AVG(t.total_cliente), 2) AS 
promedio_compra_por_cliente
FROM (SELECT id_cliente, SUM(total) AS total_cliente
FROM pedidos
WHERE estado <> 'CANCELADO'
GROUP BY id_cliente) AS t;
--en mysql una tabla derivada necesita un alias en este caso "t" y no se puede usar el alias en la misma consulta, por eso se hace uan subconsulta en from

--subconsulta correlacionada producttos mas caros que el promedio de su categoria 
SELECT p.nombre, p.precio, p.id_categoria
FROM productos p  
WHERE p.precio > (SELECT AVG(p2.precio)
FROM productos p2
WHERE p2.id_categoria = p.id_categoria)

--subconsulta el pedido de mayor valor con MAX 
SELECT id_pedido, id_cliente, total
FROM pedidos 
WHERE total = (SELECT MAX(total) FROM pedidos);

*/ 
CRUD COMPLETO + TRANSACCIONES 
una TRANSACCION agrupa varias sentencias en una sola unidad o se guardan TODAS en un commit o no guarda ninguna ninguna ROLLBACK
propiedade: ACID: Atomicidad, consistencia, Aislamiento, Durabilidad*/

--C= create registrar un cliente nuevo
INSERT INTO clientes ( tipo_documento, numero_documento, nombres, apellidos, email, telefono, ciudad)
VALUES ('CC', '1009009009', 'Sofia', 'Cardona Mejia', 'sofia.cardona@correo.com', '3109990000', 'Manizales');

--R= read consultarlo 
SELECT * FROM clientes WHERE numero_documento = '1009009009'

--U= UPDATE modificar un cliente existente
UPDATE clientes
SET telefono = '3201234567',
ciudad = 'Armenia'
WHERE numero_documento = '1009009009';

SELECT * FROM clientes WHERE numero_documento = '1009009009'


--DELETE Eliminar siempre con WHERE porque sin WHERE elimina toda la tabla
DELETE FROM clientes WHERE numero_documento = '1009009009';

-- transacciones: con rollback simulamos una venta y nos arrepentimos de la venta y no se guarda nafda en la base de datos 
START TRANSACTION;
INSERT INTO pedidos (id_cliente, estado) VALUES (8, 'pendiente');

SET @nuevo_pedido_id = LAST_INSERT_ID(); -- ID generado por el ultimo INSERT

INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, precio_unitario)
VALUES (@nuevo_pedido, 12, 1, 1200000);

UPDATE productos SET stock = stock -1 WHERE id_producto = 12;

SELECT * FROM pedidos WHERE id_pedido = @nuevo_pedido_id;
-- dentro de la transaccion se puede consultar lo que se ha hecho pero no se ve desde afuera 

ROLLBACK; -- deshacer la transaccion y no se guarda nada en la base de datos 

--Tansaccion con COMMIT: subir 5% el precio de deportes
START TRANSACTION;
UPDATE productos
SET precio = ROUND(precio * 1.05, 0)
WHERE id_categoria = (SELECT id_categoria FROM categorias WHERE nombre = 'Deportes');
COMMIT;


--confirma el cambio de forma permanente
SELECT nombre, precio FROM productos WHERE id_categoria = 4;


--DELETE en cascada: al borrar un pedido se borran sus detalles
INSERT INTO pedidos (id_cliente, estado)
VALUES (8, 'Pendiente');
SET @pedido_tem = LAST_INSERT_ID();
INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, precio_unitario)
VALUES (@pedido_tem,2 ,1, 45000);


SELECT COUNT(*) AS detalles_antes FROM detalle_pedido
WHERE id_pedido = @pedido_tem; --1
DELETE FROM pedidos WHERE id_pedido = @pedido_tem;
SELECT COUNT(*) AS detalles_despues FROM detalle_pedido WHERE id_pedido = @pedido_tem; --0
