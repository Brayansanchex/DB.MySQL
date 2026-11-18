/*export default function NotFoundPage() {
  return (
    <div className="container py-5 text-center">
      <h1 className="display-4">404</h1>
      <p className="text-muted">Página no encontrada</p>
    </div>
  );
}
____________________ESTO FUE,LO QUE DIO LA IA________________________*/


/**
 * pagina que muestra cuando la URL no coincide con ninguna
 * ruta definida por App.jsx
 */

//link crea una navegacion interna sin recargar la pagina
import { link } from 'react-router-dom';

//no recibe props es el element de la nueva ruta comodin en app.jsx
function NotFoundPage() {
  return (
  <div className='d-felx flex-column align-items-center justify-content-center vh-100 text-center px-3'>
    <h1 className='display-4 fw-bold text-primary'>404</h1>
    <p className='text-muted mb-4'>La pagina que buscas no existe</p>
    <link to="/" className='btn btn-primary'>
    volver al inicio
    </link>
  </div>
  );
}
export default NotFoundPage;