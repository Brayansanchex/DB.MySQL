//configura y exporta un pool de conexiones hacia mysql 
//un pool es un grupo de conexiones que se reutilizan en cada
//consulta den lugar de abrir y cerrar un conexion nuva cada vez 
//eso hace que la aplicacion responda mas rapido

//mysql2/promise nos permite usar async/await en las consultas 
//en lugar de trabajar callbacks 

const mysql = require('mysql2/promise');

// cargamos las variables definidas en el archivo .env
//(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME)
require('dotenv').config();

//createPool crea un conjunto de conexiones reutilizables 
const pool = mysql.createPool({
    host: process.env.DB_HOST || 'localhost',
    port: Number(process.env.DB_PORT) || 3306,
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME || 'inventario_react',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0,
});

//exportamos el pool para poder hacer el pool.query desde 
//cualquier controlador
module.exports = pool;
