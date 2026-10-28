//ayuda a detectar errores comunes en el desarrollo
import { StrictMode } from 'react'
//es la funcion moderna de react 18+ para montar la aplicacion en el DOM
import { createRoot } from 'react-dom/client'
//habilita el manejo de rutas basado en la URL del navegador  
import { BrowserRouter } from 'react-router-dom';

//estilos de bootstrap clases como btn, container, table y demas
import 'bootstrap/dist/css/bootstrap.min.css';
//iconos de bootstrap clases como bi bi-trash 
import 'bootstrap-icons/font/bootstrap-icons.css';
//javascript de bootstrap necesario para que funcionen los modales 
//dropdowns y el menu de navegacion responsive
import 'bootstrap/dist/js/bootstrap.bundle.min.js';
//estilos propíos del proyecto se cargan solos despues del bootstrap
//describe detalles puntuales de la aplicacion
import './index.css'

//componente raiz con todas las rutaaas de la aplicacion 
import App from './App.jsx'

//proveedor del contexto de sesion (ver context/ authContext.jsx
import { AuthProvider } from './context/authContext.jsx'

//busca el <div id="root"> de index.html y engancha react ahi adentro 
createRoot(document.getElementById('root')).render(
  <StrictMode>
    {/*BrowserRouter habilita la navegacion por un URL(react-roter-dom)
    */}
    <BrowserRouter>
      {/*AuthProvider comparte con toda la aplicacion  quien es usuario logueado*/}
      <AuthProvider>
        <App />
      </AuthProvider>
    </BrowserRouter>
  </StrictMode>,
);
