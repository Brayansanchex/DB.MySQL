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

      {/*rutas privadas, solo accesibles si estas logueado*/}
      <Route
        path="/dashboard"
        element={
          <ProtectedRoute>
            <DashboardDemo />
          </ProtectedRoute>
        }
      />

      {/*cualquier otra url q que no coincida con las anteriores */}
      <Route path="*" element={<NotFoundPage />} />
    </Routes>
  );
}

export default App;
