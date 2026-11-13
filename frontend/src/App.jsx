//piezas de react-router-dom routes/route define el mapa de rutas
//Navigate sirve para redirigirde una url a otra
import { Navigate, Route, Routes } from 'react-router-dom';
//Guardian que protege las rutas privadas del dashboard
import ProtectedRoute from './routes/ProtectedRoute';
//Paginas publicas y privadas de la aplicacion 
import LoginPage from './pages/LoginPage';
import NotFoundPage from './pages/NotFoundPage';

function DashboardDemo() {
  return (
    <div className="container py-5">
      <h1 className="mb-3">Dashboard</h1>
      <p className="text-muted">Bienvenido al sistema de inventario.</p>
    </div>
  );
}

function App() {
  return (
    <Routes>
      {/* Ruta raiz: manda directo al login (si ya hay sesion,
      protectedRoute se encargara de dejarlo pasar al dashboard)*/}
      <Route path="/" element={<Navigate to="/login" replace />} />

      {/*ruta publica cualquiera puede entrar a / login*/}
      <Route path="/login" element={<LoginPage />} />
      
      {/*cualquier otra url q que no coincida con las anteriores */}
      <Route path="*" element={<NotFoundPage />} />

      {/*grupo de rutas protegidas: todo lo que este dentro este
      route solo se muestra si ProtectedRoute confirma que hay sesion activa; si no, redirige a /login */}
      <Route element={<ProtectedRoute/>}>
      <Route path="/dashboard" element={<DashboardLayout /> }>
      <Route index element={<DashboardHome/>}/>
      <Route path="usuarios" element={<UsuariosPage/>}/>

      </Route>
    </Route>
  </Routes>
  )
}

export default App;
