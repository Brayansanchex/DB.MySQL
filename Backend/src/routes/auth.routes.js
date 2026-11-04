/** 
 * Define las URLs (endpoints) relacionadas con la autenticacion de usuarios correspondiente
 */

//Framework del Servidor
const express = require('express');
//Router in mini servidor de rutas que despues se montan en server.js
//con una app.use(api/auth), authRoutes 
const authRoutes = express.Router();

//Funciones controladas con la logica real de cada endpoint