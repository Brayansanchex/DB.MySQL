/**
 * Se crea uan instancia configurada de axios para habalr con el
 * Backend (node/express) en vez de escribir la url completa 
 * cada peticion la dejamos configurada una sola vez aqui
 */

//liberia para hacer peticiones HTTP (GET POST)
import axios from 'axios';

/**
 * url base del backend en un proyecto real esto vendria de una
 * variable de entorno de vite (import.meta.env.VITE_API_URL)
 * pero la vamos a dejar fija apuntando al backend
 */
const API_URL = 'http://localhost:4000/api';

//axios.create genera una instacia propia distinta de axios global
//con configuracion ya lista para usar en tod la aplicacion 
const axiosClient = axios.create ({
    baseURL: API_URL, // se antepone automaticamete a cada ruta relativa ej:/auth/login
    headers: {
        'Content-Type': 'application/json',//le avisamos al backend que mandamos el json
    }
});

/**
 * Interceptor de peticiones se ejecuta antes de enviar cada
 * peticion aqui aprovechamos para agregar automaticamente el
 * token JWT guardado en localStortage (si exite) al header
 * Authorization para no tener que repetirlo en cada llamada
 */
axiosClient.interceptors.request.use
((config) => {
    //Revisamos si hay un token guardado de una sesion iniciado
    const token = localStorage.getItem('token');

    if (token){
        //Lo agregamos al header en el formato que esperar el backend:
        //Authorization: Bearer <token>
        config.headers.Authorization = `Bearer ${token}`;
    }
    //Siempre hay que devolver "config" si o no la peticion nunca se envia
    return config;
});
//Exportamos la instancia ya configurada para usarla en toda la app
export default axiosClient;