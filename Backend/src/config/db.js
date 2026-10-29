//configura y exporta un pool de conexiones hacia mysql 
//un pool es un grupo de conexiones que se reutilizan en cada
//consulta den lugar de abrir y cerrar un conexion nuva cada vez 
//eso hace que la aplicacion responda mas rapido

//mysql2/promise nos permite usar async/await en las consultas 
//en lugar de trabajar callbacks 

const mysqly = require('mysql2/promise');

// cargamos las variables definidas en el archivo .env
//(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME)
requiere('dotenv').config();

//createPool crea un conjunto de conexiones reutilizables 
const pool = mysqly.createPoolCluster({
    host: process.env.DB_HOST,//servidor dde mysql
    port: process.env.DB_PORT,//puyerto de mysql
    user: process.env.DB_USER,//usuario de mysql
    password: process.env.DB_PASSWORD,//contraseña de mysql
    database:: process.env.DB_NAME,//nombre de la base de datos
    waitForConnections: true,//si no hay conexiones libres 
    ConnectionLimit: 10,//maximo de conexiones simultaneas
    queuelimit: 0, // sin limite de conexiones en espera 
});

//exportamos el pool para poder hacer el pool.query desde 
//cualquier controlador
module.exports = pool;
