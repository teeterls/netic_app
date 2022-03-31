var actualModal = 0;
var caracteres = /^[0-9a-zA-Z]+$/;
var formatoFecha = /([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))/;

function LimiteCaracteres() {
    var texto = document.getElementById("texto").value;
    document.getElementById("numCaracteres").innerHTML = "" + texto.length + "/200";
    if (texto.length > 200) {
        document.getElementById("LimiteBox").innerHTML = "Wow, amig@, no te emociones!";
    } else {
        document.getElementById("LimiteBox").innerHTML = "";
    }
}

function ValidarRegistro() {
    var nombre = document.getElementById("nombre").value;
    var usuario = document.getElementById("usuario").value;
    var password = document.getElementById("password").value;
    var confPwd = document.getElementById("password2").value;
    var apellido = document.getElementById("apellido").value;
    var fecha = document.getElementById("fecha").value;
    var texto = document.getElementById("texto").value;
    var correo= document.getElementById("correo").value;
    if (nombre == "" || usuario == "" || password == "" || apellido == "" || fecha == null || texto == "" || correo=="" || !(document.querySelector('input[name="preferencia"]:checked')) || !(document.querySelector('input[name="sexo"]:checked'))) {
        document.getElementById('Error').innerHTML = "Debe rellenar todos los campos para poder registrarse.";
    } else if(obtenerEdad(fecha)<18){
    	document.getElementById('Error').innerHTML = "Lo sentimos, debe ser mayor de edad para poner usar netic";
    } else if (password.localeCompare(confPwd)!=0){
    	document.getElementById('Error').innerHTML = "Las contraseñas no coinciden";
    } else if (texto.length > 200){
    	document.getElementById('Error').innerHTML = "Tu biografía es demasiado larga";
    } else {
    	if(caracteres.test(usuario)){
    		if(formatoFecha.test(fecha)){
		    	InicializaModal();
		    	$('#miModal').modal('toggle');
    		} else {
    			document.getElementById('errorFecha').innerHTML = "El formato de fecha debe ser YYYY-MM-DD";
    			document.getElementById('Error').innerHTML = "Se han introducido caracteres no válidos en el registro";
    		}
    	} else {
    		document.getElementById('Error').innerHTML = "Se han introducido caracteres no válidos en el registro";
    	}
    }
}

function SiguientePregunta(){
	actualModal++;
	
	switch(actualModal){
	case 0:
		$('#modal-p3').hide();
	case 1:
		$('#modal-p1').show();
		$('#modal-p0').hide();
		$('#modal-intro-btn').hide();
		$('#cuestionarioExtra').show();
		$('div.progress').show();
		$('#progreso').attr("aria-valuenow", "0").css("width", 0 + "%").text(0 + "%");
		break;
	case 2:
		$('#modal-p2').show();
		$('#modal-p1').hide();
		$('#progreso').attr("aria-valuenow", "20").css("width", 20 + "%").text(20 + "%");
		break;
	case 3:
		$('#modal-p3').show();
		$('#modal-p2').hide();
		$('#progreso').attr("aria-valuenow", "40").css("width", 40 + "%").text(40 + "%");
		break;
	case 4:
		$('#modal-p4').show();
		$('#modal-p3').hide();
		$('#progreso').attr("aria-valuenow", "60").css("width", 60 + "%").text(60 + "%");
		break;
	case 5:
		$('#modal-p5').show();
		$('#modal-p4').hide();
		$('#progreso').attr("aria-valuenow", "80").css("width", 80 + "%").text(80 + "%");
		break;
	case 6:
		$('#modal-p5').hide();
		$('#modal-p6').show();
		$('#cuestionarioExtra').hide();
		$('#finCuestionario').show();
		$('#progreso').attr("aria-valuenow", "100").css("width", 100 + "%").text("¡Registro completado!");
		break;
	case 7:
		$('#modal-p6').hide();
		$('#formulario').submit();
		return true;
		break;
	default:
		actualModal = 0;
		break;
	}
	return false;
}

function AnteriorPregunta(){
	actualModal--;
	switch(actualModal){
	case 0:
		return InicializaModal();
	case 1:
		$('#modal-p1').show();
		$('#modal-p2').hide();
		$('#modal-intro-btn').hide();
		$('#cuestionarioExtra').show();
		$('#progreso').attr("aria-valuenow", "0").css("width", 0 + "%").text(0 + "%");
		break;
	case 2:
		$('#modal-p2').show();
		$('#modal-p3').hide();
		$('#progreso').attr("aria-valuenow", "20").css("width", 20 + "%").text(20 + "%");
		break;
	case 3:
		$('#modal-p3').show();
		$('#modal-p4').hide();
		$('#progreso').attr("aria-valuenow", "40").css("width", 40 + "%").text(40 + "%");
		break;
	case 4:
		$('#modal-p4').show();
		$('#modal-p5').hide();
		$('#progreso').attr("aria-valuenow", "60").css("width", 60 + "%").text(60 + "%");
		break;
	case 5:
		$('#modal-p5').show();
		$('#modal-p6').hide();
		$('#progreso').attr("aria-valuenow", "80").css("width", 80 + "%").text(80 + "%");
		break;
	case 6:
		$('#modal-p5').hide();
		$('#modal-p6').show();
		$('#cuestionarioExtra').hide();
		$('#finCuestionario').show();
		break;
	case 7:
		$('#modal-p6').hide();
		$('#formulario').submit();
		return true;
		break;
	default:
		InicializaModal();
		break;
	}
	return false;
}

function InicializaModal(){
	actualModal= 0;
	$('#modal-p2').hide();
	$('#modal-p3').hide();
	$('#modal-p4').hide();
	$('#modal-p5').hide();
	$('#modal-p6').hide();
	$('#modal-p1').hide();
	$('#modal-p0').show();
	$('#modal-intro-btn').show();
	$('#cuestionarioExtra').hide();
	$('#finCuestionario').hide();
	$('div.progress').hide();
	$('#progreso').attr("aria-valuenow", "0").css("width", 0 + "%");
	return false;
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

function valorSlider(valor){
	document.getElementById("altura").innerHTML =valor;
}

function Clear(){
    document.getElementById('Error').innerHTML = "";
}
