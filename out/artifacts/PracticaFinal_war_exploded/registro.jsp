<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <!-- Popper JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <link href="css/estilo.css" rel=StyleSheet type="text/css"> <!--link CSS StyleSheet-->
    <script src="js/registro.js" type="text/javascript"></script>
    <title>Registrate en ${initParam.titulo}</title>
  </head>
 <body>
 

  <div class="container">
    <h1 class="display-5">Regístrate ya! <img src="images/logo%20entero.png" width="150px"></h1>
  </div>
  <div class="container">
    <form action="ServletRegistro" id="formulario" method="POST" class="formulario">

      <h3 style="color:deeppink">Información general</h3>
      <div class="form-group">

        <label for="nombre" style="font-weight: bold">Nombre</label><input class="form-control "type="text" id="nombre" name="nombre" />
        <br>
        <label for="apellido" style="font-weight: bold">Apellidos</label><input type="text" class="form-control"id="apellido" name="apellido" />
      </div>

      <strong>Sexo</strong>
      <div class="custom-control custom-radio">
        <input type="radio" class="custom-control-input" id="hombre" name="sexo" value ="hombre">
        <label class="custom-control-label" for="hombre">Hombre</label>
      </div>
      <div class="custom-control custom-radio">
        <input type="radio" class="custom-control-input" id="mujer" name="sexo" value ="mujer">
        <label class="custom-control-label" for="mujer">Mujer</label>
      </div>
      <br>
      <div class="form-group">
        <label for="fecha"style="font-weight: bold">Fecha de nacimiento</label><input type="date" max="2002-01-01" id="fecha" class="form-control" required pattern="[0-9]{4}-[0-9]{2}-[0-9]{2}" name="fecha">
      </div>
      <div class="text-center" id='errorFecha' style="color:deeppink; font-weight: bold"></div>

      <br>
      <h3 style="color:deeppink">Datos de acceso</h3>

      <div class="form-group">
        <label for="usuario" style="font-weight: bold">Usuario</label> <input type="text" class="form-control"id="usuario" name="user" />

        <label for="password" style="font-weight: bold">Contraseña</label> <input type="password" class="form-control"id="password" name="pwd" />
        <label for="password">Confirmar contraseña:</label> <input type="password" class="form-control"id="password2" name="pwd2" />

        <label for="correo" style="font-weight: bold">Correo electronico</label> <input type="email" class="form-control"id="correo" name="mail" pattern=".+@gmail.com" placeholder="emailusuario@gmail.com"/>
      </div>
      <br>
      <h3 style="color:deeppink">Intereses generales</h3>

      <div class="form-group">
        <strong>Busco...</strong>
        <div class="custom-control custom-radio">
          <input type="radio" class="custom-control-input" id="hombre1" name="preferencia" value ="hombre">
          <label class="custom-control-label" for="hombre1">Hombre</label>
        </div>
        <div class="custom-control custom-radio">
          <input type="radio" class="custom-control-input" id="mujer1" name="preferencia" value ="mujer">
          <label class="custom-control-label" for="mujer1">Mujer</label>
        </div>
        <div class="custom-control custom-radio">
          <input type="radio" class="custom-control-input" id="ambos" name="preferencia" value ="ambos">
          <label class="custom-control-label" for="ambos">Ambos</label>
        </div>
      </div>

      <div class="form-group">
        <label for="texto" style="font-weight: bold">Cuéntanos algo de ti </label>
        <textarea class="form-control" name="descripcion" id="texto" rows="4" cols="50" onkeyup="LimiteCaracteres()"></textarea><br>
        <p id="numCaracteres"><strong>0/200</strong></p> <p id="LimiteBox"></p>
      </div>
      <div class="text-center errorType" id='Error'></div>

      <input type="button" class="btn btn-outline-danger" name="registrarse" value="Registrar" onclick="ValidarRegistro()"/>
      <input type="reset" class="btn btn-outline-dark" value="Borrar" onclick="Clear()"/>
      
    
<div class="modal fade" id="miModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				
				<h4 class="modal-title" id="myModalLabel">Unos últimos retoques...</h4>
				<span class="form-control-static pull-right"><button type="button" class="close" data-dismiss="modal" aria-label="Close">
          			<span aria-hidden="true">&times;</span>
        		</button></span>
        		
				
			</div>
			<div class="modal-body">
				
				<div id="modal-p0">
				<h5 style="align-content: center">Estás a un paso de tener el perfil que mejor te defina</h5>
				<p>No es obligatorio que respondas a todo para el registro, pero te lo
				 recomendamos para encontrar a personas más afines a ti.</p>
				<p>Podrás rellenar los datos más adelante en tu perfil.</p>
				</div>
				<div id="modal-p1" style="display : none">
					<h5>¿Cuál es tu estatura (en cm)?</h5>
					<br>
					<div class="range-field" style="text-align: center">
						140 <input type="range" id="sliderAlt" name="altura" min="140" max="210" value="170" oninput="valorSlider(this.value);"/> 210<p><span id="altura">170</span></p>
	      			</div>
	      			
				</div>
				<div id="modal-p2" style="display : none">
					<h5>Tu silueta es más bien...</h5>
					<div class="custom-control custom-radio">
		        		<input type="radio" name="fisico" class="custom-control-input" id="01" value ="Delgada">
		        		<label class="custom-control-label" for="01">Delgada</label>
	      			</div>
	      			<div class="custom-control custom-radio">
		        		<input type="radio" name="fisico" class="custom-control-input" id="02" value ="Atletica">
		        		<label class="custom-control-label" for="02">Atlética</label>
	      			</div>
	      			<div class="custom-control custom-radio">
		        		<input type="radio" name="fisico" class="custom-control-input" id="03" value ="Normal">
		        		<label class="custom-control-label" for="03">Normal</label>
	      			</div>
	      			<div class="custom-control custom-radio">
		        		<input type="radio" name="fisico" class="custom-control-input" id="04" value ="Kilos de mas">
		        		<label class="custom-control-label" for="04">Algunos kilos de más</label>
	      			</div>
	      			<div class="custom-control custom-radio">
		        		<input type="radio" name="fisico" class="custom-control-input" id="05" value ="Corpulenta">
		        		<label class="custom-control-label" for="05">Corpulenta</label>
	      			</div>
				</div>
				
				<div id="modal-p3" style="display : none">
					<h5>¿De dónde eres?</h5>
					<div>
					<input type="text" name="ciudad" placeholder="Madrid"/>
	      			</div>
				</div>
				
				<div id="modal-p4" style="display : none">
					<h5>¿Tienes hijos?</h5>
					<div class="custom-control custom-radio">
		        		<input type="radio" name="hijos" class="custom-control-input" id="hijosSi" value ="Si">
		        		<label class="custom-control-label" for="hijosSi">Sí</label>
	      			</div>
	      			<div class="custom-control custom-radio">
		        		<input type="radio" name="hijos" class="custom-control-input" id="hijosNo" value ="No">
		        		<label class="custom-control-label" for="hijosNo">No</label>
	      			</div>
				</div>
				
				<div id="modal-p5" style="display : none">
					<h5>¿Cuál es tu estado civil?</h5>
					<div class="custom-control custom-radio">
		        		<input type="radio" name="civil" class="custom-control-input" id="soltero" value ="Soltero">
		        		<label class="custom-control-label" for="soltero">Soltero</label>
	      			</div>
	      			<div class="custom-control custom-radio">
		        		<input type="radio" name="civil" class="custom-control-input" id="separado" value ="Separado">
		        		<label class="custom-control-label" for="separado">Separado</label>
	      			</div>
	      			<div class="custom-control custom-radio">
		        		<input type="radio" name="civil" class="custom-control-input" id="divorciado" value ="Divorciado">
		        		<label class="custom-control-label" for="divorciado">Divorciado</label>
	      			</div>
	      			<div class="custom-control custom-radio">
		        		<input type="radio" name="civil" class="custom-control-input" id="viudo" value ="Viudo">
		        		<label class="custom-control-label" for="viudo">Viudo</label>
	      			</div>
				</div>
				
				<div id="modal-p6" style="display : none">
					<h5>Ya puedes disfrutar de tu perfil en netic</h5>
				</div>
				<br>
				<div class="progress">
        		<div class="progress-bar" id="progreso" role="progressbar" style="width:0%" aria-valuemin="0" aria-valuenow="50" aria-valuemax="100"></div>
        		</div>
			</div>
			<div class="modal-footer">
				
				<div id="modal-intro-btn" class="justify-content-between">
					
					<button class="btn btn-secondary" data-dismiss="modal">
						¡Aún no!
					</button>
					
					
					<button class="btn btn-primary " onclick="return SiguientePregunta();">
						¡Adelante!
					</button>
					
				</div>
				<div id="cuestionarioExtra" class="justify-content-between" style="display : none">
					
						<button class="btn btn-secondary" onclick="return AnteriorPregunta()">
							Atrás
						</button>
					
					
						<button class="btn btn-primary" onclick="return SiguientePregunta();">
							Siguiente
						</button>
					
				</div>
				<div id="finCuestionario" style="display:none">
					
						<button class="btn btn-primary" onclick="return SiguientePregunta();">
							Crear perfil
						</button>
					
				</div>
			</div>
			
		</div>
	</div>
	
</div>

</form>

    
    
    



  </div>
  </body>
</html>
