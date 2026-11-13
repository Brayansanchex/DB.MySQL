import { Navigate } from 'react-router-dom';
import { useAuth } from '../context/authContext';

export default function ProtectedRoute({ children }) {
  const { estaAutenticado, cargando } = useAuth();

  if (cargando) {
    return <div className="text-center py-5">Cargando...</div>;
  }

  if (!estaAutenticado) {
    return <Navigate to="/login" replace />;
  }

  return children;
}

____________________________________

/**
 * Componente que guardian la ruta se usa envolviendo las rutas de dashboard en App.jsx si el usuario no a iniciado sesion lo redirige 
 * automaticamente a /login en vez de mostrar en contenido
 */

//navigate redirige a otra ruta; outlet renderiza la ruta hija activa 
import { Navigate, Outlet } from 'react-router-dom'
//Hook para leer el estado de sesion (usuario, cargando ..)
import { useAuth } from '../context/AuthContext.jsx';
//no recibe props: se usa como elemento envolvente en App.jsx
function ProtectedRoute() {
  //leemos del contexto si hay sesion activa y si todavia se esta verificando
  const { estaAutenticado, cargando } = useAuth();

  //Mientras se revisa  su habia una sesion guardado en local}Storage,
  //mostramos un mensaje corto en vez de parpadear hacia /login
  if (cargando) {
    return(
      <div className="d-flex justify-contet-center aling-items-center vh-100">
        <div className="spinner-border text-primry" role="status">
          <span className="visually-hidden">Cargando ...</span>
        </div>
      </div>
    )
  }

  // si no hay sesion activa, <Navigate> redirige a /login 
  if (!estaAutenticado) {
    return <Navigate to="/login" replace />;
  }

  //<Outlet /> renderiza la ruta hija que corresponda
  //(por ejemplo DashboardLayout con sus paginas internas)
  return <Outlet/>
}

//exportamos el componente para usarlo en App.jsx
export default ProtectedRoute;