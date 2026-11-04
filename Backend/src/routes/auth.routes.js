/** 
 * Define las URLs (endpoints) relacionadas con la autenticacion de usuarios correspondiente
 */

//Framework del Servidor
const express = require('express');
//Router in mini servidor de rutas que despues se montan en server.js
//con una app.use(api/auth), authRoutes 
const authRoutes = express.Router();

//Funciones controladas con la logica real de cada endpoint
const {login, perfil} = require('../controllers/auth.controller');
//middleware que protege rutas exigiendo un token JWT valido 
const verificarToken = require('../middlewares/verificartoken');
//POST/api/auth/login= iniciar sesion (ruta publica)
authRoutes.post('/login', login);

//GET/api/auth/perfil = devuelvo los datos del usuario logueado
//ruta protegida pasa primero por la verificarToken
authRoutes.get('/perfil', verificarToken, perfil);
module.exports = authRoutes;
