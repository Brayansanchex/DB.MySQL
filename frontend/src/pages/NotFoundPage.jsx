export default function NotFoundPage() {
  return (
    <div className="container py-5 text-center">
      <h1 className="display-4">404</h1>
      <p className="text-muted">Página no encontrada</p>
    </div>
  );
}
____________________________________________
/** 
 * componente guardian de ruta que se usa envolviendo las rutas del 
 * dashboard en App.jsx. Si el usuario no esta iniciando sesion lo redirige 
 * automaticamente a /login en vez de mostrar el contenido
 *  
 */
//Navigate redirige a otra ruta; outlet renderiza la ruta hija activa 
import { Navigate, Outlet } from 'react-router-dom';
//Hook para leer el estado de sesion (usuario, cargando ....)
import { useAuth } from '../context/authContext';
