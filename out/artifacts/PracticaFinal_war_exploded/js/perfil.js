var editar = true;
var caracteres = /^[0-9a-zA-Z]+$/;

function filePreview(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#blah').attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
            $("#actualizarFoto").show();
        }
    }

    $("#foto").change(function () {
    	
        filePreview(this);
    });

function editarPerfil(){
	if(editar){
		$(".campoEditable").show();
		$("#guardarCambios").show();
		editar = false;
	} else {
		$(".campoEditable").hide();
		$("#guardarCambios").hide();
		editar = true;
	}
	return false;
}

function valorSlider(valor){
	document.getElementById("altura").innerHTML =valor;
}

function LimiteCaracteres() {
    var texto = document.getElementById("texto").value;
    document.getElementById("numCaracteres").innerHTML = "" + texto.length + "/200";
    if (texto.length > 200) {
        document.getElementById("LimiteBox").innerHTML = "Wow, amig@, no te emociones!";
    } else {
        document.getElementById("LimiteBox").innerHTML = "";
    }
}

function obtenerEdad(fecha){
	var hoy = new Date();
	var fechaNacimiento = new Date(fecha);
	var edad = hoy.getFullYear() - fechaNacimiento.getFullYear();
	var mes = hoy.getMonth() - fechaNacimiento.getMonth();
	if(mes < 0 || (mes == 0 && hoy.getDate() < fechaNacimiento.getDate()))
		edad--;
	return edad;
}

function Verificar(pwd){
	var nombre = document.getElementById("nombre").value;
    
    var password = document.getElementById("pwd").value;
    var apellido = document.getElementById("apellidos").value;
    
    var texto = document.getElementById("texto").value;
    var correo= document.getElementById("email").value;
    if (nombre == "" || password == "" || apellido == "" || texto == "" || correo=="" || !(document.querySelector('input[name="preferencia"]:checked'))|| !(document.querySelector('input[name="sexo"]:checked'))) {
        document.getElementById('Error').innerHTML = "Los campos obligatorios no pueden quedar vacíos";
        return false;
    } else if (!caracteres.test(password)){
		document.getElementById('Error').innerHTML = "Se han introducido caracteres no válidos en el registro";
	} else {
    	confirmarCambios("datos",pwd, null);
    	return true;
    }
    return false;
}

function mostrarPassword(){
	var x = document.getElementById("pwd");
	if (x.type === "password") {
		x.type = "text";
	} else {
		x.type = "password";
	}
	return false;
}

function confirmarCambios(form,pwd,user){
	editarPerfil(false);
	document.getElementById('Error').innerHTML = "";
	switch(form){
	case "datos":
		$('#uploadForm').append('<input type="hidden" name="prevPwd" value="'+pwd+'" />');
		break;
	case "imagen":
		$('#formImagen').append('<input type="hidden" name="userName" value="'+user+'" />');
		$('#formImagen').append('<input type="hidden" name="prevPwd" value="'+pwd+'" />');
		break;
	default:
		return false;
		break;
	}
	
	return true;
}
