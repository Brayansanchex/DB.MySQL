/**
 * Muestra una etiqueta de color de bootstrap que dice aactivo o incativo
 * para las tablas de usuarios categorias subcategorias y productos
 */

//recibe una sola prop boolenana Activo= true/false
function EstadoBadge({ activo }) {
    const clase = activo ? 'badge bg-success' : 'badge bg-danger';

    const texto = activo ? 'Activo' : 'Inactivo';

    return <span className={clase}>{texto}</span>;
}

export default EstadoBadge;