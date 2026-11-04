/*
*Verificar token utilizando funcion:
* Middleware de express. es una funcion que se ejecuta ANTES de llegar a las rutas protegidas por ejemplo un get
* su trabajo es revisar que  la peticion triaga un token JWT valido si no lo trae corta la peticion con un error 401
*/
//Libreria para crear y verificar tokens JWT
const jwt = require('jsonwebtoken');
require('dotenv').config();

//req la peticion entrante; res: la respuesta; next funcion que continua la cadena de middlewares/controlador si tdo esta bien
function verificarToken(req, res, next) {
    //el frondtend debe enviar el token en header
    //Authorization: Bearer <token>
    const authHeader = req.headers['authorization'];

    //si no viene el header no hay sesion -> rechazamos la peticion
    if (!authHeader) {
        return res.status(401).json({ mensaje: 'No se envio un token de autenticacion' });
    }

    //authHeader tiene el formato "Bearer eyJhbGciOi", nos quedamos solo con las segunda parte del token real
    const token = authHeader.split(' ')[1];

    //si el header vino mal formado por ejemplo son la palabra Bearer el token queda undefined y tampoco dejamos pasar la peticion
    if (!token) {
        return res.status(401).json({ mensaje: 'Formato de token invalido' });
    }

    //todo lo que pueda fallar (token invalido expirado)se maneja dentro de este try/catch
    try {
        //jwt.verify valida la firma del token con el mismo secreto que uso para crearlo (JWT_SECRET)
        //y revisa que haya expirado.
        const datosUsuario = jwt.verify(token, process.env.JWT_SECRET);

        //Guardamos los datos decodificados del usuario en req.usuario para que la siguiente funcion (el controlador) pueda usarlos
        req.usuario = datosUsuario;

        //next() le dice al Express todo esta bien  continua con la siguiente funcion 
        next();
    } catch (error) {
        //si el token esta vencido o fue alterado, jwt.verify lanza un error
        return res.status(401).json({ mensaje: 'Token de autenticacion invalido o expirado' });
    }
}

//Exportamos
module.exports = verificarToken;