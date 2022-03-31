<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>Error</title>
</head>
<body>
<h3 class="ml-4 mt-3"style="color:deeppink">Error en la aplicación</h3>
<hr />
<span class="ml-4 mt-3" style="font-weight: bold; font-size: medium">${mensajeError}</span>
<br><br>
<a href="index.html" class="btn btn-warning justify-content-center ml-4 mr-4">Volver a página de inicio</a>
<a href="registro.jsp" class="btn btn-warning justify-content-center mr-4">Volver a registro</a>
</body>
</html>
