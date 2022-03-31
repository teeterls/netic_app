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
    <link rel="stylesheet" href="css/listado.css" type="text/css"/>
    <title>Hola,${sessionScope.usuario.user}</title>
</head>
<style>

</style>
<body>
<br><br><br><br>
<h5 style="color:white" class="ml-2">Resumen de tu actividad,<c:out value="${sessionScope.usuario.user}"></c:out></h5>
<br>
<div class="container-fluid bg-warning">
<ul>
<c:if test="${not empty sessionScope.visita}">
<c:if test="${ not empty sessionScope.carritovisitas.map}">
   <div id="visitas">
    <br>
    <span style="font-size: larger; font-weight: bold">Tu registro de visitas<a href="javascript:peticionAsincrona('ServletAjax?opcion=borrarvisitas','visitas');" class="close">&times;</a></span>
    <br><br>
    <table class="table table-responsive-sm" border="1">
        <tr>
            <td><strong>Perfil</strong></td>
            <td><strong>Número de visitas</strong></td>
        </tr>
        <c:forEach var="visitaCarrito" items="${sessionScope.carritovisitas.map}">
            <tr>
                <td> <c:out value="${visitaCarrito.key}"></c:out></td>
                <td><c:out value="${visitaCarrito.value}"></c:out></td>
            </tr>
        </c:forEach>
    </table>

    <span style="font-size: larger; font-weight: bold">Resumen de visitas</span>
    <br><br>
    <p class="ml-3">  Has visitado <b><c:out value="${sessionScope.carritovisitas.size}"></c:out></b> perfiles distintos durante la sesión, siendo <b><c:out value="${sessionScope.carritovisitas.visitasTotales}"></c:out></b> el número de visitas totales.
    <br>
        El perfil más visitado: <b><c:out value="${sessionScope.carritovisitas.masVisitado}"></c:out></b>
  </p>
   </div>

</c:if>

<c:if test="${empty sessionScope.carritovisitas}">
   <span style="font-size: larger"><b>Registro de visitas vacío. Comienza a visitar otros perfiles!</b></span>
</c:if>
</c:if>

<c:if test="${not empty sessionScope.busqueda}">
<c:if test="${ not empty sessionScope.carritobusquedas.map}">
    <div id="busquedas">
    <br>
    <span style="font-size: larger; font-weight: bold">Tu registro de búsquedas<a href="javascript:peticionAsincrona('ServletAjax?opcion=borrarbusquedas','busquedas');" class="close">&times;</a></span>
    <br><br>
    <table class="table table-responsive-sm" border="1">
        <tr>
            <td><strong>Búsqueda</strong></td>
            <td><strong>Usuarios compatibles</strong></td>
        </tr>

    <c:forEach var="busquedaCarrito" items="${sessionScope.carritobusquedas.map}">
       <tr>
      <td>
          <ul>
              <c:if test="${ not empty busquedaCarrito.key.edad1 and not empty busquedaCarrito.key.edad2 }">
                  <li>Edad entre <c:out value="${busquedaCarrito.key.edad1}"></c:out> y <c:out value="${busquedaCarrito.key.edad2}"></c:out>
              </li>
              </c:if>


        <c:if test="${ not empty busquedaCarrito.key.ciudad}">
              <li> Ciudad:<br> <c:out value="${busquedaCarrito.key.ciudad}"></c:out>
              </li>
        </c:if>

        <c:if test="${ not empty busquedaCarrito.key.altura1 and not empty busquedaCarrito.key.altura2 }">
              <li> Estatura entre <c:out value="${busquedaCarrito.key.altura1}"></c:out> y <c:out value="${busquedaCarrito.key.altura2}"></c:out>
              </li>
        </c:if>

     <c:if test="${ not empty busquedaCarrito.key.hijos }">
              <li> Hijos:<br> <c:out value="${busquedaCarrito.key.hijos}"></c:out>
              </li>
        </c:if>
              <c:if test="${ not empty busquedaCarrito.key.civil}">
              <li>   Estado civil:<br><c:out value="${busquedaCarrito.key.civil}"></c:out>
              </li>
        </c:if>
              <c:if test="${ not empty busquedaCarrito.key.fisico}">
              <li>  Condición física: <br><c:out value="${busquedaCarrito.key.fisico}"></c:out>
              </li>
        </c:if>

       <c:if test="${ not empty busquedaCarrito.key.aficiones}">
              <li> Aficiones:
            <br>
            <ul>
            <c:forEach var="a" items="${busquedaCarrito.key.aficiones}">
               <li><c:out value="${a}"></c:out> </li>
            </c:forEach>
            </ul>
              </li>
              </c:if>

          </ul>
      </td>

       <td>
           <c:forEach  var="u" items="${busquedaCarrito.value}">
          <c:out value="${u.user}"></c:out> <br>
       </c:forEach>
       </td>
       </tr>
    </c:forEach>
</table>
    <span style="font-size: larger; font-weight: bold">Resumen de búsquedas</span>
    <br><br>
    <p class="ml-3">  Has realizado <b><c:out value="${sessionScope.carritobusquedas.size}"></c:out></b>  busquedas! Sigue buscando para conseguir tu pareja ideal.
    </p>
    </div>

</c:if>
</c:if>
<br><br>
<c:if test="${not empty sessionScope.like}">
<c:if test="${ not empty sessionScope.carritolikes.map}">
<div id="likes">
    <span style="font-size: larger; font-weight: bold">Tu registro de likes<a href="javascript:peticionAsincrona('ServletAjax?opcion=borrarlikes','likes');" class="close">&times;</a></span>
   <br><br>
    <table class="table table-responsive-sm" border="1">
        <tr>
            <td><strong>Perfil</strong></td>
        </tr>
    <c:forEach var="likeCarrito" items="${sessionScope.carritolikes.map}">

        <tr> <td><c:out value="${likeCarrito.key}"></c:out></td></tr>
    </c:forEach>
    </table>

    <span style="font-size: larger; font-weight: bold">Resumen de likes</span>
    <br><br>
    <span class="ml-3">Has dado like a <b><c:out value="${sessionScope.carritolikes.size}"></c:out></b> perfiles!</span>
</div>
</c:if>

<c:if test="${empty sessionScope.carritolikes}">
    <span style="font-size: larger"><b>Registro de likes vacío. ¿A qué esperas para dar like a ese usuario que tanto te gusta?</b></span>
</c:if>
</c:if>
<br><br>
<c:if test="${not empty sessionScope.mensaje}">
<c:if test="${ not empty sessionScope.carritomensajes.map}">
<div id="mensajes">
    <span style="font-size: larger; font-weight: bold">Tu registro de mensajes<a href="javascript:peticionAsincrona('ServletAjax?opcion=borrarmensajes', 'mensajes');" class="close">&times;</a></span>
    <br><br>

    <table class="table table-responsive-sm" border="1">
        <tr>
            <td><strong>Perfil</strong></td>
            <td><strong>Número de mensajes</strong></td>
        </tr>
        <c:forEach var="mensajeCarrito" items="${sessionScope.carritomensajes.map}">
            <tr>
                <td> <c:out value=" ${mensajeCarrito.key}"></c:out></td>
                <td><c:out value="${mensajeCarrito.value}"></c:out></td>
            </tr>
        </c:forEach>
    </table>

    <span style="font-size: larger; font-weight: bold">Resumen de mensajes</span>
    <br><br>
    <p class="ml-3">  Has contactado con <b><c:out value="${sessionScope.carritomensajes.size}"></c:out></b> perfiles distintos durante la sesión, siendo <b><c:out value="${sessionScope.carritomensajes.mensajesTotales}"></c:out></b> el número de mensajes totales.
        <br>
        El perfil más contactado: <b><c:out value="${sessionScope.carritomensajes.masContactado}"></c:out></b>
    </p>
</div>
</c:if>

<c:if test="${empty sessionScope.carritomensajes}">
    <span style="font-size: larger"><b> Registro de mensajes vacío. Ponte en contacto con los usuarios que te interesen!</b></span>
</c:if>
</c:if>
</ul>
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
