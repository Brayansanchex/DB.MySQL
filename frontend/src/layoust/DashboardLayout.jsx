/**
 * esqueleto visual que comparten TODAS las paginas del 
 * (inicio, usuarios, categorias, subcategorias, productos):
 * sidebar a la izquierda + topbar arriba + el contenido de la 
 * pagina actual en el medio (a travez de <Outle/>)
 */
//Outlet marca el unto de donde se pinta la ruta hija activa 
import { Outle } from "react-router-dom";
//menu lateral de navegacion
import Sidebar from '../components/common/Sidebar.jsx';
//barra superior con usuario y boton de salir
import Topbar  from '../components/common/topbar.jsx';

//No recibe props: se usa como "element" de la ruta / dashboard en App.jsx
function DeshboardLayout() {
    return (
        <div className="d-flex">
            <sidebar/>
            {/**Flex-grow-1 hace que esta columna ocupe todo el espacio restante despues del ancho fijo del sidebar */}
            <div className="flex-grow-1 d-flex flex-column" style={{ minHeight: '100vh', backgroundColor: '#f4f6f9'}}>
                <Topbar />

                <main className="p-4">
                    {/*Outlet renderiza la ruta hija activa DashboardHome, usuariosPage, categoriaPage, .....segun la url */}
                </main>
            </div>
        </div>
    )
}

*//exportamos el layout para usarlo en la ruta / dashboard de App.jsx
export default DashboardLayout;