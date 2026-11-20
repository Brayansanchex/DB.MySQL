/** 
 * Hook personalizado y Rutilizable que simula el crud completo
 * usando solo javascript en el navegador sin el backend ni base de datois lo una las 4 pantallas
 * usuarios categorias subcategorias y productos ademas de mantener el estado de la memoria
 * lo sincronia con el local storage para que la informacion no se pierda al recargar la pagina
 */
import useCrudSimulado(claveStorage, datosIniciales) {
    //estado con la lista de registros el valor inicialice calcula
    //una sola vez, si hay datos guardados en localStorage los usa si no arranca con datos iniciales

    const [lista, setLista] = useState(() => {
        const guardado = localStorage.getItem(claveStorage);

        return guardado ? JSON.parse(guardado) : datosIniciales;
    });

    //cada vez que lista cambia la devolvemos a guardar en localStorage
    //para no perder los cambios al recargar la pagina
    useEffect(() => {
        localStorage.setItem(claveStorage, JSON.stringify(lista));
    }, [lista, claveStorage]);

    //Create: agrega un registro nuevo calculando un id autoincremental
    //(el maximo id actual + 1 igual que haria un autoincremental en DB mysql)
    function agregar(datosNuevoRegistro) {
        setlista((listaActual) => {
            const nuevoId = listaActual.length > 0 ? Math.max(...listaActual.map((item) => item.id)) + 1 : 1;
            
            const registroNuevo = {id: nuevoId, activo: true, ...datosNuevoRegistro};
            return [...listaActual, registroNuevo];
        });
    }

    //UPDATE busca el registro por id y le mezcla los campos nuevos
    //dejando el resto igual conserva lo que no se cambia
    function actualizar(id, cambios) {
        setLista((listaActual) => {
            listaActual.map((registro) => (registro.id === id ? { ...registro, ...cambios } : registro));
        };
    }
    //DELETE logico no borra el registro de la lista sino lo desactiva en lugar y eliminar
    function alternarEstado(id) {
        setLista((listaActual) => {
            listaActual.map((registro) => (registro.id === id ? { ...registro, activo: !registro.activo } : registro));
        });
    }
    

    //Devolvemos todo lo que una pagina necesita los datos y las 3 acciones
    return {lista, agregar, actualizar, alternarEstado};


}
export default useCrudSimulado;



}