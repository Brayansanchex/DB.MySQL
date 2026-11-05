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
})

}




