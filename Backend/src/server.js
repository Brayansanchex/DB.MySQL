/**
 * punto de entrada del backend aqui se crea la aplicacion de express
 * y se configuran los middlewares globales (cors, json)
 * y se montan las rutas al final el servidor que esta 
 * escuchando peticiones por el puerto definido el env 
 * (por defecto el 4000)
 */
//framework para crear en servidor HTTP y definir rutas 
const express = require ('express');
//middleware que habilita CORS  (Peticiones desde otro orifen/o puerto)
const cors = require ('cors');
//lee el archivo .env y carga sus valores en process.env

require('dotenv').config();
//Importamos el router con los enhpoints de autenticacion  (login y perfil)
const authRoutes = require('./routes/auth.routes');
//cr4eamos la aplicacion express
const app= express();
//cors() permite que el frontend (que corre en otro puerto)
//pueda hacer peticiones a es backend sin que el navegador lo bloquee
app.use(cors());

//express.json() le enseña a expres a leer el ody de las peticiones 
//cuando viene en formato json asi podemos leer req.body.email, etc
app.use(express.json());

//ruta de salud simple; util para probar que el servidor esta vacio 
app.get('/', (req, res ) => {
    res.json({mensaje: 'api de inventario react funcionando correctamente'});

});

//todas las rutas que empiecen con api/auth se resuelven en authroutes.js
app.use('/api/auth', authRoutes);
//middleware para rutas que no existen (404)
app.use((req, res) => {
    res.status(404).json({mensaje:'ruta no encontrada'});
});

//tomamos el puerto desde .env o 4000 si no esta definido 
const PORT = process.env.PORT || 4000;

//arranca el servidor apartir de aqui express queda escuchando
//petiviones HTTP en el puerto indicado hasta que se detenca el proceso

app.listen(PORT, () => {
    //este callback se ejecuta una vez cuando el vercidor este listo 
    console.log('servidor backend escuchando en http://localhost:${PORT}');
    
})