# PROYECTO EN REACT SISITEMA DE INVENTARIO
elaborado en react+ bootstrap mysql

El sistema de inventario contara con inicio de sesion con base de datos en mysql con contraseña encriptada y JWT

El dashboar contara con gestion CRUD de **usuarios, categorias, subcategoria, productos** usando datos simulados en JavaScript 

# Stack Usado
ronted = react 19 + vite + bootstrap 5 + react router Backend (solo para login) = node.js + express + jwt
Base de datos = MySQL (XAMPP) + inventario_react
encriptacion de contraseña = bcrypt (bcryptjs)
Gestiones = usuarios, categorias, subcategorias, productos/ datos simulados en JS (useStage + localStorege)
Automatizacion npm scripsts + concurrently 

Pre Requisitos 
 # 1 
 instalar node.js verificar desde cmd con node -v

 # 2
 tener XAMPP instalado con MySQL en ouerto 3306

 # 3 
 tener un editor de codigo 


 # conocimientos previos

 **componente**
 la pantalla se divide en piezas pequeñas y reutilizables 
 (un boton, una tabla, un formulario, un menu) cada componente es
 una funcion de javaScript  que devuelve lo que tiene que mostrar 
 **JSX** una sintaxis que permite escribir algo parecido en html dentro de JacaScript por eso ,os achivos terminan con extension .jsx ejemplo

```jsx
 function saluido () {
    return <h1 classname="text-primary"> hola, react <h1/>
 } 

 ```
 -**Estado (stage)** cada componente puede guardar datos que cambian por ejemplo, lo que el usuario escribe en un input, cuando el estado cambia React vuelve a dibujar automaticamente 
 solo lo necesario sin recargar la pagina

**SPA** la aplicacion se carga uan sola vez en el navegadro y luego cambia de pagona sin recargar para esto usamos `react-router-dom`


React solo se encarga de la interfaz grafica para el resto utilizamos:
**vite** para crear y correr el proyecto
**Bootstrap** para los estilos
**axios** para hablar entre frontend y backend
**react-router-dom** para las rutas


# pasos para crear el proyecto
- 1 verifique que tenga node.js (node -v)cmd
- 2 Desde la raiz de proyecto crea el proyecto con react y vite
`npm create vite@latest frontend -- -- template react`
- 3 entre a carpeta fronted con `cd frontend` y instale npm `npm install`
- 4 instale la librerias: `npm install bootstrap bootstrap-icons react-router-dom axios`
- 5 empaquetador optimisa y junta todo el css en un solo archivo al hacer `npm run build`
- 6 instalar las dependencias del backend t frontend al tiempo `npm run install:all`
- 7 ingresar la carpeta backend y colocar `npm init -y`
- 8 instalar dependencias
- 8.1 `npm install express mysql2 bcryptjs jsonwebtoken cors dotenv`
- 8.2 crea  .env  dentro de backend para las variables de entorno
- 8.3 crea src/config/db.js  conexion con DB
- 8.4 crea src/middlewares/verificartoken.js valida el token JWT en rutas protegidas 
- 8.5 crea src/controllers/auth.controller.js es la logica de inicio de sesion
- 8.6 crea src/routes/auth.routes.js 
- 8.7 crea src/server.js  arma la app de express
- 8.8 crea en backend seed.js crea el usuario administradora