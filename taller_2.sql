--1inserte 3 proveedores y asignelos con UPDATE: proveedor 1 a los productos de tecnologia, proveedor 2 a hogar y proveedor 3 a papeleria 
INSERT INTO proveedores
(id_proveedor,  nit,    razon_social,   telefono, email, ciudad, activo)
VALUES
(1, "2002002002", "Proveedor 1", "3111111112", "proveedor1@correo.com", "ibague", 1),
(2, "3003003003", "Proveedor 2", "3222222223", "proveedor2@correo.com", "cali", 1),
(3, "4004004004", "Proveedor 3", "3333333334", "proveedor3@correo.com", "bogota", 1);

UPDATE productos
SET id_proveedor = 1
WHERE categoria = (SELECT id_categoria FROM categorias WHERE nombre = "tecnologia");
UPDATE productos
SET id_proveedor = 2
WHERE categoria = (SELECT id_categoria FROM categorias WHERE nombre = "hogar");
UPDATE productos
SET id_proveedor = 3
WHERE categoria = (SELECT id_categoria FROM categorias WHERE nombre = "papeleria");

--2.liste TODOS los productos con su categoria y el nombre de su proveedor (los que no tienen proveedor deben aparecer igual)
SELECT 
 p.nombre AS producto,
 c.nombre AS categoria,
COALESCE(pr.razon_social, 'sin proveedor'AS proveedor
FROM productos p
LEFT JOIN categorias c 
ON p.id_categoria = c.id_categoria
LEFT JOIN proveedores pr
ON p.id_proveedor = pr.id_proveedor
ORDER BY c.nombre, p.nombre;

--3. muestre el total vendido ppor ciudad del cliente (sin cancelados), ordenado de mayor a menor
SELECT c.ciudad, SUM(dp.cantidad * dp.precio_unitario) AS total_vendido
FROM clientes c
JOIN pedidos p ON c.id_cliente = p.id_cliente
JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido
WHERE p.estado != "CANCELADO"
GROUP BY c.ciudad
ORDER BY total_vendido DESC;



--4. Muestre el producto más vendido (por cantidad) y el total vendido de ese producto




