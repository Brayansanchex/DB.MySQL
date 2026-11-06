/**
 * contexto global de autenticacion permite que CUALQUIER
 * componente de la app (Sidebar, Navbar, paginas protegidas y demas)
 * sepa si hay un usuario logeado quien es y pueda cerrar sesion sin
 * tener que pasar esa informacion "a mano " der componente en
 * componente (eso se llama "prop drilling" y el Context lo envita)
 */

//createContext: crea el contexto; use Context: lo consume; useEffect:
//codigo que corre en momentos especificos del ciclo de vida; useState
//estado local del componente
import { createContext, useContext, useEffect, useState } from 'react';
//Funcion que llama al backend para validar email/password
import { iniciarSesion } from '../api/authService';

//1) creamos el contexto (una especioa de caja compartida)
const AuthContext = createContext(null);

//2) Componente proveedor: envuelve la app y la de sus hijos
//acceso al valor de autenticacion actual
export function AuthProvider({ children}) {
    //usuario: datos publicos del ususario logeado (o null si no hay sesion)
    const [usuario, setUsuario] = useState (null);


//cargando: true mientras revisamos si ya habia una sesion guardada
//en el localStorage ( por ejemplo al recargar la pagina con f5)
const [cargando, setCargando] = useState (true);

//Justo cuando la app arranca
useEffect(() => {
    const usuarioGuardado = localStorage.getItem('usuario');
    const tokenGuardado = localStorage.getItem('token');

// si en el localstorage hay usuario y token de una sesion anterior, restauramos
//esa sesion sin obligar a volvar a hacer login
if (usuarioGuardado && tokenGuardado)
{
    setUsuario(JSON.parse(usuarioGuardado));
}

setGuardado(false);
}, []);

//funcion de login: lo llama LoginPage cuano el usarioenvia el formulario
async function login(email, password) {
    //puede lanzar un error (por ejemplo credenciales invalidas)
    //dejamos que LoginPage lo capture con try/catch para mostrar el mensaje
const { token, usuario: UsuarioRecibido } = await iniciarSesion (email, password)

// Guardamos la sesion en el localStorage para que sobreviva a un F5
localStorage.setItem('token',token);
localStorage.setItem('usuario',JSON.stringify (UsuarioRecibido));

//Actualizamos el estado en meoria para la UI reacciones al instante
setUsuario(UsuarioRecibido)
}

//Funcion de logout borra la sesion tant del localStorage como el estado
function logout() {
    localStorage.removeItem('token');
    localStorage.removeItem('usuario');
    setUsuario(null);
}

//valor que va a estar disponible para cualquier componente que use useAuth()
const value = {
    usuario,
    cargando,
    estaAutenticado: !!usuario,
// convierte usuario (objeto o null) en true o false
    login,
    logout,
};

//todo lo que esta dentro del <AuthProvider>...</AuthProvider> osea
//Children, toda la app pede leer value con useAuth()
return <AuthContext.Provider value = {value} ></AuthContext.Provider>;
}

/**
 * Hooke personalizado para consumir el contexto mas facil:
 * en vez de useContext(AuthContext) los componentes hacen useAuth()
 */
export Function useAuth() {
    //lee el valor actual del contexto (Usuario, cargando, login, logout)
const contexto = useContext (AuthContext);
//Si alguine usa useAuth() fuera de <AuthProvider> contexto seria null:
//avisamos con un error claro en vez de fallar mas adelante en forma confunsa
if(!contexto) {
    throw new Error('useAuth debe usarse dentro de un <authProvider>');
}
}

