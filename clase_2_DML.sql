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



