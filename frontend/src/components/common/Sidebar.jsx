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