/**
 * barra superior del dashboard muestra el nombre del usuario
 * logueado (viene del AuthContext) y un boton para cerrar sesion
 */

//hook para navegar programaticamente (sin que el usuario haga click en un <Link>)
import { useNavigate } from 'react-router-dom';
//Hook para leer el usuario loguado y la funcion logout
import { useAuth } from '../../context/AuthContext.jsx';

//no recibe props toma todo lo que necesita del AuthContext 
function Topbar() {
    //Usuario datos de quien inicio sesion; logout borra la sesion 
    const { usuario, logout } = useAuth();
    //funcion para cambiar de url desde javascript 
    const navigate = useNavigate();

    //al cerrar sesion limpiamos el contexto / localStore y 
    //mandamos al usuario de vuelta a la pantalla login 
    function manejarLogouth() {
        logout();
        navigate('/login', { replace: true });
    }

    return (
        <nav className='navbar navbar-light bg-white borer-bottom px-4 py-3'>
            <span className='navbar-brand mb-0 h1 fs-6 txt-muted'>Panel de administracion</span>
            <div className='d-flex align-items-center gap-3'>
                <div className='text-end d-none d-sm-block'>
                    <div className='fw-semibold'>{usuario?.nombre}</div>
                    <small className='text-muted text-capitalize'>{usuario?.rol}</small>
                </div>

                <button className='btn btn-outline-danger btn-sm d-flex align-items-center gap-1' onClick={manejarLogouth}>
                    <i className='bi bi-box-arrow-right '></i>
                </button>
            </div>
            </nav>
    );
} 

export default Topbar;