/**
 * Pagina de bienvenidadel dashboard (ruta/dashboard) muestra
 * un resumen rapido con tarjetas Bootstrap usando la cantidad
 * de registros activos de cada modulo simulado
 */


//hook para leer el usuario logueado (mostrar su nombre en el saludo)
import { useAuth } from '../context/AuthContext.jsx';
//Hook generico curd simulado (solo usamos listas)
import useCrudSimulado from 'hooks/useCrudSimulado';
//datos iniciales de cada modulo
import mockUsuarios from '../data/mockUsuarios'
import mockCategorias from '../data/mockCategorias'
import mockSubcategorias from '../data/mockSubcategorias'
import mockProductos from '../data/mockProductos'


//tarjeta reutilizable para mostrar un numero grande con su etiqueta
//Recibe Icono ( clase de dashboard-icons ) titulo total (numero) y color
function TarjetaResumen({ icono, titulo, total, color}) {
    return (
        <div className='col-sm-6 col-lg-3'>
            <div className={`card border-0 shadow-sm border-start border-4 border-${color}`}>
                <div className='card-body d-flex align-items-center gap-3'>
                <i className={`bi ${icono} fs-1 text-${color}`}></i>
                <div>
                  <div className='fs-3 fw-bold'>{total}</div>
                  <div className='text-muted small'>{titulo}</div>
                </div>
                </div>
        </div>
        </div>
    );
}

// no recibe props: es el "element" de la ruta index de /dashboard en App.jsx
function DashboardHome() {
    //solo necesitamos el usuario logueado para mostrar su nombre 
    const { usuario } = useAuth();
    /**
     * Reutilizamos el mismo hook que usan las paginas de gestion para 
     * leer la cantidad de registros guardados o los datos iniciales
     * si todavia no se ah guardado nada en localStorage.
     */
    //const { lista: usuarios } = useCrudSimulado('usuarios', mockUsuarios);
    //const { lista: categorias } = useCrudSimulado('categorias', mockCategorias);
    //const { lista: subcategorias } = useCrudSimulado('subcategorias', mockSubcategorias);
    //const { lista: productos } = useCrudSimulado('productos', mockProductos);
    return(
        <div>
            <h2 className='h4 mb-1'> Hola, {usuario?.nombre}</h2>
            <p className='text-muted mb-4'>Este es el resumen general del sistema de inventario</p>

            <div className='row g-3'>
                <TarjetaResumen
                icono="bi-people"
                titulo="Usuarios activos"
                total={usuarios.filter((u)=> u.activo).length}
                color="primary"
                />

                <TarjetaResumen
                icono="bi-tags"
                titulo="Categorias activas"
                total={usuarios.filter((c)=> c.activo).length}
                color="success"
                />

                <TarjetaResumen
                icono="bi-diagram-3"
                titulo="Subcategorias activas"
                total={usuarios.filter((s)=> s.activo).length}
                color="warning"
                />

                <TarjetaResumen
                icono="bi-tags"
                titulo="Productos activos"
                total={usuarios.filter((c)=> c.activo).length}
                color="danger"
                />
            </div>
            <div className='alert alert-info mt-4 mb-0'>
                <i className='bi bi-info-circle me-2'></i>
                Los datos de usuario categorias subcategorias y productos de este panel
                son <strong>Simulados con javascript</strong>(Se guardan en el localStorage
                del navegador).
                solo el inicio de sesion esta conectado a la base de datos real
                <code>inventario_react</code>
            </div>
        </div>
    );
}
export default DashboardHome;