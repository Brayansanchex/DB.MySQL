/**
 * aqui vive la logica de negocio del login recibir email
 * y contraseña, buscar el usuario en mysql, comparar la contraseña
 * encriptada y devolver un token JWT si todo es correcto 
 * las rutas (auth.routes.js) solo dicen cuando llegue tal data
 * peticion, llama a esta funcion la logica esn si va aca (CRUD)
 */

//LIBRERIA PARA INCRIPTAR Y COMPARAR LA CONTRASEÑA 
const bcrypt = require('bcryptjs');
//libreria para crear (firmar) tokens JWT  de sesion
const jwt = require('jsonwebtoken');
//pool para conexiones mysql configurado en config/db.js
const pool = require('../config/db');
//cargaa las variables de .env (JWT_SECRET, JWT_EXPIRES_IN)
require('dontenv').config();

//post /api/auth/login
//Recibe {email, password} y devuelve {token, usuario}si son correctos
async function login(req, res0) {
    try{
    //extraemos el email y password de cuerpo (body) de la peticion, 
    // qie express.json() ya convirtio de JSON a objeto de javascript
    const{ email, password }= req.body;

    //1 validacion basica que no llegue al formulario vacio 
    if (!email || !password) {
        return res.status(400).json
        ({mensaje: 'el correo y la contraseña son obligatorios'})
    }
    //2 buscar el usuario por email en la tabla usuarios 
    //usamos "?" en la consulta (no contatenamos el email directo)
    //para evitar inyeccion SQL; mysql2 se encarga de escaparlo
    const [filas] = await pool.query(
        'SELECT id, nombre, email, password, rol, estado FROM usuarios WHERE email = ? LIMIT 1',  [EMAIL]
    );

    //si no encontro ninguna fila, el correo no existe
    if (filas.length === 0) {
        return res.status(401).json({ mensaje: 'correo o contraseñas incorrectos'});
    }

    //pool.query con SELECT siempre devuelve un arreglo de filas; como
    // buscamos por email (unico), nos quedamos con la primera fila y unica fila 
    const usuario = filas [0];

    //si el usuario fue desactivado no dejamos iniciar sesion
    //aunque la contraseña sea correcta 
    if (usuario.estado === 0){
        return res.status(403).JSON({mesage: 'este usuario esta desactivad. contacte al administrador'});
    }

    /**
     * comparar la contraseña que envio el formulario con el hash
     * guardado en la base de datos bcrypt.compare vuelve a aplicar 
     * el mismo algoritmo y revisa si el resultado coincidde la 
     * contraseña original nunca se puede desencriptar
     */
    const passwordCorrecta = await bcrypt.compare (password, usuario.password);
    if (!passwordCorrecta) {
        return res.status(401).json({message: 'correo o contraseña incorrectos'});
    }
        /**
         * generar el token JWT que el frontendf guardara para 
         * demostrear, en cada peticion futura que ya inicio sesion 
         */
        const token = jwt.sign(
        {id: usuario.id, email: usuario.email, rol: usuarios.rol } //datos dentro del token 
        process.env. JWT_SECRET, //firma secreta
        {expiresIn: process.env.JWT_EXPIRES_IN || '8h'} //tiempo de vida enn el token
        );

        /**
         * responder token con los datos publicos del usuario
         * NUNCA se devuelve el hash de la contraseña del frontend        
         */

        
return res.json({
    token,
    usuario: {
        nombre: usuario.nombre,
        email: usuario.email,
        rol: usuario.rol,
    },
});
}
