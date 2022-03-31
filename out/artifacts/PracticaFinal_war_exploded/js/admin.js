var userGestion

function abrirModal(usuario, ajustes){
	
	userGestion = usuario;
	
	switch(ajustes){
	case "permisos":
		$('#modalPermisos').modal('toggle');
		break;
	case "eliminar":
		$('#modalEliminar').modal('toggle');
		break;
	default:
		break;
	}

}

function submitAjustes(){
	$('#formpermisos').append('<input type="hidden" name="userPrivado" value="'+userGestion+'" />');;
}