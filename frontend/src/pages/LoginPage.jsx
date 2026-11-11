/**
 * Pantalla login funcional
 *
 * Pantalla publica de incio de sesion Es la unica parte del sistema
 * que habla con la base de datos MYSQL real a travez del backend
 * Node/Express si las credencialesson correctas redirige al 
 * usuaro son correctas redirige al usuario al dashboard
 */

//Hook del estado local para los campos del formulario
import { useState } from 'react';
//Hook para redirigir por codigo despues de iniciar sesion
import { useNavigate } from 'react-router-dom';
//Hook para llamar a login() del contexto global de sesion
import { useAuth } from '../context/authContext';

//no recibe props es el element de la ruta publica/ login en App.jsx
export default function LoginPage() {
    //Traemos sola la funcion login() del contexto no se necesita mas 
    const { login } = useAuth();
    //Funcion parqa cambiar la url una vez el login sea exitoso
    const navigate = useNavigate();

    //estado del formulario controlado
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');

    //Estado para demostrar el error que devuelva el backend crdenciales
    //invalidas, usuario desactivado servidor caido o demas
    const [error, setError] = useState('');

    //estado para deshabilitar el boton mientras espera la respuesta
    //del servidor y evitar que el usuario haga doble click
    const [enviado, setEnviado] = useState(false);

    //Se ejecuta cuando el ususario envia el formulario boton o enter
    async function manejarEnvio(evento) {
        evento.preventDefault(); //Evita que el navegador recarge la pagimna
        setError(''); //limpia cualquier error de un intento anterior
        setEnviado(true);

        try {
            //login() esta definido en AuthContext: llama al backend
            //Guarda el token/usuario y actualiza el estado global
            await login(email, password);

            //si no lanzo error, la credenciales fuyeron correctas
            navigate('/dashboard', { replace: true });
        } catch (err) {
            //si el backend respondio un mensaje error (401, 403...)
            //axios lo deja disponible en err.response.data.mensaje
            const mensajeBackend = err?.response?.data?.mensaje;
            setError(mensajeBackend || 'No se puedo conectar con el servidor. Verifica que el backend este corriendo');
        } finally {
            //finally se ejecuta Siempre (haya exitido o error) reactivamos el boton
            setEnviado(false);
        }
    }

    return (
        <div className="login-wraper">
            <div className="card shadow-lg border-0" style={{ width: '100%', maxWidth: 400 }}>
                <div className="card-body p-4 p-md-5">
                    <div className="text-center mb-4">
                        <i className="bi bi-boxes text-primary" style={{ fontSize: '2.5rem' }}></i>
                        <h1 className="h4 mt-2 mb-0">Inventario react</h1>
                        <p className="text-muted small">Ingresa con tu cuenta registrada</p>
                    </div>

                    {error && <div className="alert alert-danger py-2">{error}</div>}

                    <form onSubmit={manejarEnvio}>
                        <div className="mb-3">
                            <label className="form-label">correo electronico</label>
                            <input
                                type="email"
                                className="form-control"
                                placeholder="admin@inventario.com"
                                value={email}
                                onChange={(e) => setEmail(e.target.value)}
                                required
                                autoFocus
                            />
                        </div>

                        <div className="mb-3">
                            <label className="form-label">contraseña</label>
                            <input
                                type="password"
                                className="form-control"
                                placeholder="••••••••"
                                value={password}
                                onChange={(e) => setPassword(e.target.value)}
                                required
                            />
                        </div>

                        <button type="submit" className="btn btn-primary w-100" disabled={enviado}>
                            {enviado ? 'Iniciando sesión...' : 'Iniciar sesión'}
                        </button>
                    </form>
                </div>
            </div>
        </div>
    );
}
