<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="dominio.Usuario"%>
<jsp:include page="header2.jsp"></jsp:include>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <!-- Popper JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <script src="js/perfil.js"></script>
    <link rel="stylesheet" href="css/perfil.css" type="text/css"/>
    <title>Hola,${sessionScope.usuario.user}</title>
</head>
<body>
<br><br><br><br><br><br>
<div class="container">
	<c:choose>
		<c:when test="${sessionScope.usuario.tipo == 'administrador' }">
			<c:set var="usuario" value="${usuarioPrivado }"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="usuario" value="${sessionScope.usuario}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${not empty usuario.imagen }">
			<c:set var="imagen" scope="session" value="data:image/*;base64,${usuario.imagen }"></c:set>
		</c:when>
		<c:otherwise>
			<c:if test="${sessionScope.usuario.tipo == 'usuario'}">
				<h5 class="mt-3 mr-4 mb-3">¡Añade tu foto!</h5>
				<c:set var="imagen" scope="session" value="images/avatar.png"></c:set>
			</c:if>
		</c:otherwise>
	</c:choose>

<c:if test="${sessionScope.usuario.tipo == 'usuario'}">
	<div class="btn-group float-right border-dark">
		<form action="ServletCarrito" method="post" enctype="multipart/form-data">
		<button type="submit"name="vervisitas" class="btn btn-warning"><i class="fas fa-eye "></i> <span class="badge badge-light">${sessionScope.carritovisitas.visitasTotales}</span></button>
		<button type="submit" name="verlikes" class="btn btn-warning"><i class="fas fa-heart "></i> <span class="badge badge-light">${sessionScope.carritolikes.size}</span></button>
		<button type="submit" name="vermensajes" class="btn btn-warning"><i class="fas fa-envelope "></i> <span class="badge badge-light">${sessionScope.carritomensajes.mensajesTotales}</span></button>
		<button type="submit" name="verbusquedas" class="btn btn-warning"><i class="fas fa-search"></i><span class="badge badge-light">${sessionScope.carritobusquedas.size}</span></button>
			<input type="submit" name="borrarperfil" value="Borrar mi perfil" class="btn btn-warning">
		</form>
	</div>
</c:if>
    
        <div class="row bg-warning rounded">
            <div class="col-1 mr-4 mb-2">
            
            <img src="${imagen}" id="blah" style= "border-radius: 50%"width="100px" height="100px" alt="Tu imagen" />
                
            </div>
            
            <div class="col-2  mt-2 mx-5">
            <form id="formImagen" action="ServletImagen" method="POST" enctype="multipart/form-data">
	            
	                <div class="subirfoto">
	                    <input type="file" name="foto" id="foto" accept="image/x-png, image/gif, image/jpeg" onchange="filePreview(this)"/>
	                </div>
	                <br>
	                <div id="actualizarFoto" style="display:none">
	                	<input type="submit" class="btnImagen" value="Actualizar imagen" onclick="return confirmarCambios('imagen','${usuario.pwd}','${usuario.user }')"/>
	                </div>
	        
            </form>
            
            </div> 
            <div class="ml-3 col-6">
            <form id="uploadForm" action="ServletUpdateUsuario" method="POST">
            
            
			<div class="container">

                    <h3>Información general<input class="btn btn-warning ml-2 btnPerfil" type="submit" value="Editar perfil" name="editarperfil" onclick="return editarPerfil(true);"></h3>
                    <ul> <li><h4>Nombre y Apellidos: </h4><c:out value="${usuario.nombre} ${usuario.apellidos }"></c:out>
                    		<div class="campoEditable" style="display:none">
                    			Nombre: <input type="text" class="form-control"id="nombre" name="nombre" value = "${usuario.nombre }" /><br>
                    			Apellidos: <input type="text" class="form-control"id="apellidos" name="apellidos" value = "${usuario.apellidos }"/><br>
                    		</div>
                    </li>
                        <li> <h5>Sexo: </h5> <c:out value="${usuario.sexo }"></c:out>
                        	<div class="campoEditable" style="display:none">
	                        		<div class="custom-control custom-radio">
						        		<input type="radio" name="sexo" class="custom-control-input" id="hombre" value ="hombre">
						        		<label class="custom-control-label" for="hombre">Hombre</label>
					      			</div>
					      			<div class="custom-control custom-radio">
						        		<input type="radio" name="sexo" class="custom-control-input" id="mujer" value ="mujer">
						        		<label class="custom-control-label" for="mujer">Mujer</label>
					      			</div>
		      				</div>
                        </li>
                        <li>Ciudad: <c:out value="${usuario.ciudad }"></c:out>
                        	<div class="campoEditable" style="display:none">
							<input type="text" class="form-control" name="ciudad" value = "${usuario.ciudad }<c:if test="${empty usuario.ciudad}">No especificado</c:if> "/>
			      			</div>
                        </li>
                    </ul>
                    <h3>Información de acceso</h3>
                    <ul>
                        <li>username: <c:out value="${usuario.user }"></c:out>
                        <div class="campoEditable" style="display:none"><input type="text" value="${usuario.user }" class="field left" name="username" readonly></div></li>
                        <li>pwd: <span class="campoEsp">Campo oculto</span>
	                        <div class="campoEditable" style="display:none">
	                        	<input type="password" class="form-control"id="pwd" name="pwd" value = "${usuario.pwd }" /> <input type="checkbox" onclick="mostrarPassword()"> Mostrar contraseña
	                        </div>
                        </li>
                        <li>correo: <c:out value="${usuario.email }"></c:out>
                        <div class="campoEditable" style="display:none">
	                        	<input type="text" class="form-control"id="email" name="email" value = "${usuario.email }" />
	                    </div></li>
                    </ul>

                    <h3>Información personal</h3>
                    <ul>
                        <li> <h5>Fecha de nacimiento: </h5> <c:out value="${usuario.fecha}"></c:out></li>
                        <li> Preferencia: <c:out value="${usuario.preferencia }"></c:out>
                        <div class="campoEditable" style="display:none">
	                        		<div class="custom-control custom-radio">
						        		<input type="radio" name="preferencia" class="custom-control-input" id="hombrePref" value ="hombre">
						        		<label class="custom-control-label" for="hombrePref">Hombre</label>
					      			</div>
					      			<div class="custom-control custom-radio">
						        		<input type="radio" name="preferencia" class="custom-control-input" id="mujerPref" value ="mujer">
						        		<label class="custom-control-label" for="mujerPref">Mujer</label>
					      			</div>
					      			<div class="custom-control custom-radio">
						        		<input type="radio" name="preferencia" class="custom-control-input" id="ambos" value ="ambos">
						        		<label class="custom-control-label" for="ambos">Ambos</label>
					      			</div>
		      					</div>
                        <li>Estatura: <c:out value="${usuario.altura}"></c:out> <c:if test="${empty usuario.altura}"><span class="campoEsp">No especificado</span></c:if>
                        <div class="campoEditable" style="display:none;color:grey">
                        	<div class="range-field" style="text-align: center">
								140 <input type="range" id="sliderAlt" name="altura" min="140" max="210" value="${usuario.altura }" oninput="valorSlider(this.value);"/> 210<p><span id="altura">${sessionScope.usuario.altura}</span></p>
			      			</div>
                        </div></li>
                        <li>Complexión física: <c:out value="${usuario.fisico}"></c:out> <c:if test="${empty usuario.fisico}"><span class="campoEsp">No especificado</span></c:if>
	                        	<div class="campoEditable" style="display : none">
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
	                        	</div></li>
                        <li>Estado civil: <c:out value="${usuario.civil}"></c:out> <c:if test="${empty usuario.civil}"><span class="campoEsp">No especificado</span></c:if>
                        		<div class="campoEditable" style="display:none">
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
                        </li>
                        <li>Hijos: <c:out value="${usuario.hijos}"></c:out> <c:if test="${empty usuario.hijos}"><span class="campoEsp">No especificado</span></c:if>
                        	<div class="campoEditable" style ="display:none">
	                        	<div class="custom-control custom-radio">
			        				<input type="radio" name="hijos" class="custom-control-input" id="hijosSi" value ="Si">
			        				<label class="custom-control-label" for="hijosSi">Sí</label>
		      					</div>
				      			<div class="custom-control custom-radio">
					        		<input type="radio" name="hijos" class="custom-control-input" id="hijosNo" value ="No">
					        		<label class="custom-control-label" for="hijosNo">No</label>
				      			</div>
				      		</div>
                        </li>
                        <li>Descripcion: <c:out value="${usuario.descripcion }"></c:out>
                        <div class="campoEditable" style="display:none">
                        	<div class="form-group">
						        <label for="texto" style="font-weight: bold">Cuéntanos algo de ti </label>
						        <textarea class="form-control" name="descripcion" id="texto" rows="4" cols="50" onkeyup="LimiteCaracteres()">${usuario.descripcion}</textarea><br>
						        <p id="numCaracteres"><strong>0/200</strong></p> <p id="LimiteBox"></p>
					      	</div>
					    </div></li>
                    </ul>
                     <div class="text-center" id='Error' style="color:deeppink; font-weight: bold"></div>
                    <div id="guardarCambios" style="display:none">
                    <input class="btn btn-warning ml-2 btnPerfil" type="submit" value="Guardar cambios" name="editarperfil" onclick="return Verificar('${usuario.pwd}');">
                    </div>
                </div>
                </form>
            </div>
        	
        </div>


    


</div>

</body>
</html>
