/**
 * menu lateral del dashboard Usa <NavLink> de react-router-dom
 * en vez de <link> porque <NavLink> sabe automaticamente cuando su ruta esta activa (la URL actual coincide ) y nos deja pitarla 
 * distinto (clase "active")
 */
//lista de items del menu mientras mas crece el dashboard, solo
//hay que agregar un objeto aca (evita repetir el mismo <NavLink> 5 veces)
const opcionesMenu= [
    {texto: 'inicio', ruta:'/dashboard', icono: 'bi-house-door', fin: true},
    {texto: 'usuarios', ruta:'/dashboard/usuarios', icono: 'bi-people'},
    {texto: 'categorias', ruta:'/dashboard/categorias', icono: 'bi-tags'},
    {texto: 'subcategorias', ruta:'/dashboard/subcategorias', icono: 'bi-diagram-3'},
    {texto: 'productos', ruta:'/dashboard/productos', icono: 'bi-box-seam'},
];

//No recibe props la lista de opciones esta fija en opciones menu
function sidebar(){
    return (
        <aside className="bg-dark text-white d-flex flex-column p-3" style={{width: 240, minHeight: '100vh'}}>
            <div className="d-flex align-items-center gap-2 mb-4 px-2">
                <i className="bi bi-boxes fs-4">
                    <span className="fs-5 fw-semibold">Inventario React</span>
                </i>
            </div>

            <nav className="nav nav-pills flex-column gap-1">
                {/*recorremos el arreglo de opcionesMenu y generamos un Nanlink por cada item */}
                {opcionesMenu.map((opcion) => (
                    <NavLink
                        key={opcion.ruta}
                        to={opcion.ruta}
                        // end evita que /dashboard se marque activo cuando en 
                        // realidad estamos en /dashboard/usuarios
                        end={opcion.fin}
                        //react-router-dom permite pasar una funcion al className, 
                        //que recibe { isActive } para saber si esta ruta es la actual
                        className={({ isActive }) => 
                            'nav-link- d-flex align-items-center gap-2 text-white' + (isActive ? 'active bg-primary': '')
                        }
                        >
                        <i className={`bi ${opcion.icono}`}></i>
                        {opcion.texto}
                    </NavLink>
                ))}
            </nav>
        </aside>
    );
}

//Exportamos
export default sidebar;