<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="dominio.Usuario"%>
<jsp:include page="header.jsp"></jsp:include>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
    <html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
    <link rel="stylesheet" href="./css/estilo.css" type="text/css">
    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <!-- Popper JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <script src="js/perfil.js"></script>
    <title>Hola,${sessionScope.usuario.user}</title>
</head>
<body>

<div id="myDIV" class="mt-3">
    <p>I am a paragraph.</p>
    <div>I am a div element inside div.</div>
    <button class="btn">I am a button</button>
    <button class="btn btn-info">Another button</button>
    <p>Another paragraph.</p>
</div>
</div>

<script>
    $(document).ready(function(){
        $("#buscador").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("#myDIV *").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    });
</script>
</body>
</html>
