<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bienvenido ${sessionScope.usuario.user }</title>
<meta charset="UTF-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <!-- Popper JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <script src="js/admin.js"></script>
    <link rel="stylesheet" href="css/admin.css" type="text/css"/>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-dark fixed-top">
    <a class="navbar-brand" href="#"><img src="images/imagen%20logo.png" class="mb-3" alt="logo" style="width:40px;"> <span class="mt-5 text-warning">Hola, ${sessionScope.usuario.user}!</span></a>
	<a class="nav-link mt-2" href="ServletDesconexion"><span class="btn btn-warning">Cerrar sesion</span></a>
</nav>
<br><br><br><br>
<div class="container">
	<div>
		<ul class="nav nav-tabs">
		  <li class="nav-item">
		    <a class="nav-link active" data-toggle="pill" href="#verPerfil">Mi perfil</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" data-toggle="pill" href="#listaUsuarios">Lista de usuarios</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" data-toggle="pill" href="#estadisticas">Estadísticas</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" data-toggle="pill" href="#ajustes">Ajustes</a>
		  </li>
		</ul>
	</div>
</div>
<div class="tab-content">
  <div class="tab-pane container active" id="verPerfil">
  <c:choose>
    <c:when test="${not empty sessionScope.usuario.imagen }">
        <c:set var="imagen" scope="session" value="data:image/*;base64,${sessionScope.usuario.imagen }"></c:set>
    </c:when>
    <c:otherwise>
        <c:set var="imagen" scope="session" value="images/avatar.png"></c:set>
    </c:otherwise>
    </c:choose>

<div class="container bg-warning">

    <div class="row">
        
        <div class="col-1 mr-4 mb-2">
            <img src="${imagen}" id="blah" style= "border-radius: 50%"width="100px" height="100px" alt="Tu imagen" />
        </div>
    <div class="ml-3 col-8">
        <div class="container">
            <h5 class="mt-2"><c:out value="${sessionScope.usuario.nombre} ${sessionScope.usuario.apellidos}"></c:out></h5>
               <br>
               <ul>
			<li> <h6>Sexo: </h6>
				<div class="ml-2"> <c:out value="${sessionScope.usuario.sexo}"></c:out></div> </li>
           <br> <li><h6> Edad: </h6>
			<div class="ml-2"><c:out value="${sessionScope.usuario.edad}"></c:out> años </div></li>
		 <li><h6> Información de acceso </h6>
			<div class="ml-2">Usuario: <c:out value="${sessionScope.usuario.user}"></c:out> </div>
<div class="ml-2">Contraseña: <c:out value="${sessionScope.usuario.pwd}"></c:out> </div>
       	</ul>

        </div>
        </div>
    </div>
        </div>
  </div>
  <div class="tab-pane container fade" id="listaUsuarios">
	  <span style="font-size: larger; font-weight: bold; color:deeppink"> Listado de usuarios registrados</span>
	 <br><br>
	  <div class="row">
                    <c:forEach var="u" items="${usuariosadmin}">
                        <div class="col-sm-3">
                            <form id="formusuario" method="POST" action= "ServletAdministrarPerfil">
                            <c:choose>
                            <c:when test="${not empty u.imagen}">
                                <c:set var="imagen" scope="session" value="data:image/*;base64,${u.imagen }"></c:set>
                            </c:when>
                            <c:otherwise>
                                <c:set var="imagen" scope="session" value="images/avatar.png"></c:set>
                            </c:otherwise>
                        	</c:choose>
                            <div class="card ml-2 w-100">
                                <img class="card-img-top" src="${imagen }" alt="Card image" style="width:100%;height:50%">
                                <div class="card-body">
                                    <h5 class="text-center">
                                       ${u.nombre} ${u.apellidos}
                                    </h5>
                                    <input class="card-text text-center container-sm"type="text" id="user" name="userpublico" value="${u.user}" readonly>
                                    <p class="card-text text-center"> ${u.fecha} años <br> ${u.ciudad}</p>
                                    
                                    <button type="submit" name="perfil" value = "verperfil" class="ml-3 text-center  btn btn-warning">Perfil </button>
                                    <button type="submit" name="perfil" value = "ajustes" class="ml-3 text-center  btn btn-warning">Ajustes</button>
									
                                </div>
                            </div>


                            <div id="mensaje1" style="color:deeppink; font-size: larger"></div>
                            </form>
                        </div>
                    </c:forEach>
                </div>


        </div>
  <div class="tab-pane container fade" id="estadisticas">
	  <span style="font-size: larger; font-weight: bold; color:deeppink">Última actividad de los usuarios </span> <a href="javascript:peticionAsincrona('ServletAjax?opcion=borrarestadisticas', 'id_estadisticas');" class="close">&times;</a></span>
  <br><br>
	  <div id="id_estadisticas">
	  <table class="table table-responsive-sm">
	  <thead class="thead-dark">
	    <tr>
	      <th scope="col">Fecha</th>
	      <th scope="col">Usuario</th>
	      <th scope="col">Visitas</th>
	      <th scope="col">Búsquedas</th>
	      <th scope="col">Likes</th>
	      <th scope="col">Mensajes</th>
			<th scope="col"> Likeados</th>
			<th scope="col">+ Contactados</th>
			<th scope="col">+ Visitados</th>
	    </tr>
	  </thead>


		<tbody>

	  	<c:forEach var="act" items="${actividad}">
		    <tr>
		      <th scope="row">${act.fecha }</th>
		      <td>${act.usuario}</td>
		      <td>${act.visitas }</td>
		      <td>${act.busquedas}</td>
		      <td>${act.likes}</td>
		      <td>${act.mensajes}</td>
                <td>${act.likeados}</td>
                <td>${act.mascontactado}</td>
                <td>${act.masvisitado}</td>
		    </tr>
	    </c:forEach>

	  </tbody>

	</table>
  </div>
  </div>
  <div class="tab-pane container fade" id="ajustes">
	  
		  <span style="font-size: larger; font-weight: bold; color:deeppink"> Listado de usuarios registrados</span>
  			<br><br>
  			<form id="formpermisos" action="ServletPermisos" method="POST">
	<table class="table">
	  <thead class="thead-dark">
	    <tr>
	      <th scope="col">Usuario</th>
	      <th scope="col">Tipo</th>
	      <th scope="col">Estado</th>
			<th scope="col">Fecha de alta</th>
	      <th scope="col"></th>
	      <th scope="col"></th>
	    </tr>
	  </thead>
	  <tbody>
	  	<c:forEach var="u" items="${usuariosadmin}">
	  		
		    <tr>
		    	
		      <th scope="row"><c:out value="${u.nombre}"></c:out></th>
		      <td><c:out value="${u.tipo}"></c:out></td>
		      <td>Activo</td>
				<td><c:out value="${u.fecha_alta}"></c:out></td>
				
		      <td><button type="button" class="btn btn-warning" name="userbtn" value = "${u.user }" onclick="abrirModal('${u.user}','permisos');">Gestionar permisos</button></td>
		      <td><button type="button" class="btn btn-danger" name="userbtn" value = "${u.user }" onclick="abrirModal('${u.user}','eliminar');">Eliminar</button></td>
		    	
		    </tr>
		    
	    </c:forEach>
	  </tbody>
	</table>
	


	<div class="modal fade" id="modalPermisos" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					
					<h4 class="modal-title" id="myModalLabel">Gestion de permisos</h4>
					<span class="form-control-static pull-right"><button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          			<span aria-hidden="true">&times;</span>
	        		</button></span>
	        		
					
				</div>
				<div class="modal-body">
					
					<div id="modal-p0">
					<h5 style="align-content: center">¿Qué permisos quiere darle al usuario?</h5>
						<div class="custom-control custom-radio">
			        		<input type="radio" name="permisos" class="custom-control-input" id="permisoadmin" value ="administrador">
			        		<label class="custom-control-label" for="permisoadmin">Administrador</label>
		      			</div>
		      			<div class="custom-control custom-radio">
			        		<input type="radio" name="permisos" class="custom-control-input" id="permisousuario" value ="usuario">
			        		<label class="custom-control-label" for="permisousuario">Usuario</label>
		      			</div>
					</div>
					
				</div>
				<div class="modal-footer">
					
					<div id="modal-intro-btn" class="justify-content-between">
						
						<button class="btn btn-secondary" data-dismiss="modal">
							Cancelar
						</button>
						
						
						<button type="submit" class="btn btn-primary "  name="gestion" value="Permisos" onclick="return submitAjustes();">
							Aceptar
						</button>
						
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="modalEliminar" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					
					<h4 class="modal-title" id="myModalLabel">Advertencia</h4>
					<span class="form-control-static pull-right"><button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          			<span aria-hidden="true">&times;</span>
	        		</button></span>
	        		
					
				</div>
				<div class="modal-body">
					
					<div id="modal-p0">
					<h5 style="align-content: center">¿Está seguro de que desea eliminar el perfil?</h5>
					<p>Esta operación no se puede deshacer</p>
					</div>
					
				</div>
				<div class="modal-footer">
					<div id="modal-eliminar-btn" class="justify-content-between">
						
						<button class="btn btn-secondary" data-dismiss="modal">
							Cancelar
						</button>
						
						
						<button type="submit" class="btn btn-danger " name="gestion" value="Eliminar" onclick="return submitAjustes();">
							Eliminar
						</button>
						
					</div>
				</div>
			</div>
		</div>
		
	</div>
</form>
</div>
</div>
</body>
<script>

	function peticionAsincrona(url, div)
	{
		//AJAX
		var XHRObject = false;
		//comprobar versiones
		if (window.XMLHttpRequest) {
			XHRObject = new XMLHttpRequest();
		} else if (window.ActiveXObject) {
			XHRObject = new ActiveXObject("Microsoft.XMLHTTP");
		}
		if (XHRObject) {
			var obj = document.getElementById(div);
			XHRObject.open("GET", url);
			XHRObject.onreadystatechange = function(){
				if (XHRObject.readyState == 4 && XHRObject.status == 200) {
					obj.innerHTML = "Registro borrado con éxito!";
					obj.style.color = "deeppink";
					obj.style.fontsize="larger";
					obj.style.fontWeight="bold";
				}
			}
			XHRObject.send(null);
		}

	}
</script>
</html>