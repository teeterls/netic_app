<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="dominio.Usuario"%>
<jsp:include page="header3.jsp"></jsp:include>
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
    <link rel="stylesheet" href="css/perfil.css" type="text/css"/>
    <title>Hola,${sessionScope.usuario.user}</title>
</head>
<body>
<br><br><br><br>

<c:choose>
    <c:when test="${not empty sessionScope.usuariopublico.imagen }">
        <c:set var="imagen" scope="session" value="data:image/*;base64,${sessionScope.usuariopublico.imagen }"></c:set>
    </c:when>
    <c:otherwise>
        <c:set var="imagen" scope="session" value="images/avatar.png"></c:set>
    </c:otherwise>
    </c:choose>

<div class="container bg-warning">
			<c:if test="${usuario.tipo == 'usuario'}">
	            <div class="btn-group float-right border-dark">
	                <h6 class="mr-2 mt-1"> ¿Quieres contactar con <c:out value="${sessionScope.usuariopublico.nombre}"></c:out>?</h6>
	                <button type="button" name="like"class="btn btn-warning" onclick="getDatos('ServletAjax?opcion=like&user=${sessionScope.usuariopublico.user}','mensaje')"><i class="fas fa-heart "></i></button>
	                <button type="button" name="msg" class="btn btn-warning"onclick="getDatos('ServletAjax?opcion=msg&user=${sessionScope.usuariopublico.user}', 'mensaje')"><i class="fas fa-envelope "></i></button>
	               <br>
	                <div id="mensaje" style="color:deeppink;font-size: larger"></div>
	            </div>
            </c:if>

    <div class="row">
        <h6>Su foto</h6>
        <div class="col-1 mr-4 mb-2">
            <img src="${imagen}" id="blah" style= "border-radius: 50%"width="100px" height="100px" alt="Tu imagen" />
        </div>
    <div class="ml-3 col-8">
        <div class="container">
        <ul>
            <h5 class="mt-2"><c:out value="${sessionScope.usuariopublico.nombre} ${sessionScope.usuariopublico.apellidos}"></c:out></h5>
               <br><li> <h6>Sexo: </h6><div class="ml-2"> <c:out value="${sessionScope.usuariopublico.sexo}"></c:out></div> </li>
           <br> <li><h6> Tiene </h6><div class="ml-2"><c:out value="${sessionScope.usuariopublico.fecha}"></c:out> años </div></li>
           <br> <li><h6>Vive en </h6><div class="ml-2"> <c:out value="${sessionScope.usuariopublico.ciudad}"></c:out> <c:if test="${empty sessionScope.usuariopublico.ciudad}">No especificado</c:if></div></li>
          <br>  <li><h6>Busca...</h6><div class="ml-2"> <c:out value=" ${sessionScope.usuariopublico.preferencia}"></c:out></div></li>
          <br>  <li><h6>Mide (en cms) </h6><div class="ml-2"><c:out value="${sessionScope.usuariopublico.altura}"></c:out><c:if test="${empty sessionScope.usuariopublico.altura}">No especificado</c:if></div></li>
          <br>  <li><h6>Su físico es...</h6><div class="ml-2"><c:out value="${sessionScope.usuariopublico.fisico}"></c:out> <c:if test="${empty sessionScope.usuariopublico.fisico}">No especificado</c:if></div></li>
           <br> <li><h6>Su estado civil actual es... </h6><div class="ml-2"><c:out value="${sessionScope.usuariopublico.civil}"></c:out> <c:if test="${empty sessionScope.usuariopublico.civil}">No especificado </c:if></div></li>
          <br><li><h6>¿Tiene hijos?</h6><div class="ml-2"><c:out value="${sessionScope.usuariopublico.hijos}"></c:out> <c:if test="${empty sessionScope.usuariopublico.hijos}">No especificado</c:if></div></li>
            <br>  <li><h6>Conoce más sobre <c:out value="${sessionScope.usuariopublico.nombre}"></c:out>:</h6>
                   <div class="ml-4" style="font-style: italic"><c:out value="${sessionScope.usuariopublico.descripcion}"></c:out></div></li>
                </ul>

        </div>
        </div>
    </div>
        </div>

</body>
<script>

    //AJAX
    var XHRObject = false;
    //comprobar versiones
    if (window.XMLHttpRequest) {
        XHRObject = new XMLHttpRequest();
    } else if (window.ActiveXObject) {
        XHRObject = new ActiveXObject("Microsoft.XMLHTTP");
    }

    function getDatos (fuenteDatos, divID) {
        if (XHRObject) {
            var obj = document.getElementById(divID);
            XHRObject.open("GET", fuenteDatos);
            XHRObject.onreadystatechange = function(){
                if (XHRObject.readyState == 4 && XHRObject.status == 200) {
                    obj.innerHTML = XHRObject.responseText;
                }
            }
            XHRObject.send(null);
        }
    }
</script>


</html>
