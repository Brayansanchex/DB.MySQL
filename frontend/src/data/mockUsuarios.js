/**
 * Datos simulados no vienen de mysql se usan solo para pantalla
 * de getion de usuarios dentro del dahsboard son el estado
 * inicialcon lo que arranca la talbla despues el hooklos guarda
 * en localStorage para quye los cambios no se pierdan al recargar la pagina
 */

//arreglo de objetos cada objeto es una fila simulada de la tabla de usuarios
const usuariosSimulados = [
  { id: 1, nombre: 'Mauricio Lara', email: 'mauricio@inventario.com', rol: 'admin', activo: true },
  { id: 2, nombre: 'Yuri Casas', email: 'yuri@example.com', rol: 'vendedor', activo: true },
  { id: 3, nombre: 'Carlos Herrera', email: 'carlos@example.com', rol: 'bodeguero', activo: false }
];