<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="dominio.Usuario"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.Period" %>
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
    <title>Hola,${sessionScope.usuario.user}</title>
</head>
<body>
<br><br><br>
<div class="container">
    <ul class="nav nav-pills" role="tablist">
        <li class="nav-item">
            <a class="nav-link active btn btn-outline-warning" data-toggle="pill" href="#home">Inicio</a>
        </li>
        <li class="nav-item">
            <a class="nav-link btn btn-outline-warning" data-toggle="pill" href="#menu1">Búsqueda</a>
        </li>
    </ul>

    <div class="tab-content">
        <div id="home" class="container tab-pane active"><br>
            <div id="myDIV">
                <div class="row">
                    <c:forEach var="u" items="${sessionScope.usuariosinicio}">
                        <c:if test = "${u.tipo == 'usuario'}">
                        <c:choose>
                            <c:when test="${not empty u.imagen}">
                                <c:set var="imagen" scope="session" value="data:image/*;base64,${u.imagen }"></c:set>
                            </c:when>
                            <c:otherwise>
                                <c:set var="imagen" scope="session" value="images/avatar.png"></c:set>
                            </c:otherwise>
                        </c:choose>
                        <div class="col-sm-3">
                            <form id="formcarrito" method="post" action= "ServletCarrito" enctype="multipart/form-data">
                            <div class="card ml-2 w-100">
                                <img class="card-img-top" src="${imagen}" alt="Card image" style="width:100%;height:50%">
                                <div class="card-body">
                                    <h5 class="text-center">
                                       ${u.nombre} ${u.apellidos}
                                    </h5>
                                    <input class="card-text text-center container-sm"type="text" id="user" name="userpublico" value="${u.user}" readonly>
                                    <p class="card-text text-center"> ${u.fecha} años <br> ${u.ciudad}</p>
                                    <button type="button" name="like"class="btn btn-warning float-left" onclick="getDatos('ServletAjax?opcion=like&user=${u.user}', 'mensaje1')"> <i class="fa fa-heart"></i></button>
                                    <button type="submit" name="verperfil" class="ml-3 text-center  btn btn-warning">Ver perfil </button>
                                    <button type="button" name="msg"class="btn btn-warning float-right"  onclick="getDatos('ServletAjax?opcion=msg&user=${u.user}', 'mensaje1')"> <i class="fas fa-comment"></i></button>
                                </div>
                            </div>


                            <div id="mensaje1" style="color:deeppink; font-size: larger"></div>
                            </form>
                        </div>
                    </c:if>
                    </c:forEach>
                </div>


        </div>
        </div>

        <div id="menu1" class="container tab-pane fade"><br>
            <div id="myDIV2">
                <form action="ServletBusqueda" method="post" enctype="multipart/form-data" id="formbusqueda" onsubmit=" return validar()">
                    <h4>Guarda tus búsquedas para encontrar las personas afines a ti</h4>
                    <div class="form-group float-right">
                        <input type="submit" class="btn btn-outline-warning" value="Guardar Búsqueda" id="guardar"name="guardar">
                        <input type ="reset" class="btn btn-outline-warning" value="Borrar Búsqueda" id="borrar" name="borrar">
                    </div>
                    <div id="Error" style="color:deeppink; font-weight: bold"></div>
                    <div class="col-8">
                        <select multiple class="form-control" id="selectbusqueda" name="busqueda" required oninvalid="setCustomValidity('Debe seleccionar algún criterio de búsqueda')"
                                oninput="setCustomValidity('')">
                            <option value="criterioedad" name="criterio">Edad</option>
                            <option value="criteriociudad" name="criterio">Ciudad</option>
                            <option value="criterioaltura" name="criterio">Altura</option>
                            <option value="criteriohijos" name="criterio">Hijos</option>
                            <option value="criteriocivil" name="criterio">Estado civil</option>
                            <option value="criteriofisico" name="criterio">Físico</option>
                            <option value="criterioaficiones" name="criterio">Aficiones</option>
                        </select>
                    </div>
                    <br>
                    <div class="row jumbotron bg-warning" style="border-color: black;border-radius: 10px">
                        <div class="col-4">
                            <div id="divcriterioedad" class="criterio form-group">
                                <strong>Entre</strong> <input type="number" class="form-control-sm" id="edad1" name="edad1" placeholder="18" min="18" max="99">
                                <strong>y</strong> <input type="number" class="form-control-sm"id="edad2" name="edad2" placeholder="99" min="18" max="99"> <strong>años.</strong>
                            </div>
                        </div>
                        <br><br>
                        <div class="col-4">
                            <div id="divcriteriociudad" class="criterio form-group">
                                <strong>Ciudad </strong><input type="text" class="form-control-sm" id="ciudad" name="ciudad">
                            </div>
                        </div>
                        <br>
                        <div class="col-4">
                            <div id="divcriterioaltura" class="criterio form-group">
                                <strong> Entre</strong> <input type="number" class="form-control-sm" id="altura1" name="altura1" placeholder="140" min="140" max="210">
                                <strong>y</strong> <input type="number" class="form-control-sm"id="altura2" name="altura2" placeholder="210" min="140" max="210"> <strong>cms.</strong>
                            </div>
                        </div>
                        <div class="col-4">
                            <div id="divcriteriohijos" class="criterio form-group">
                                <strong>¿Tiene hijos?</strong>
                                <div class="custom-control custom-radio">
                                    <input type="radio" class="custom-control-input" id="hijosSi" name="hijos" value ="Si">
                                    <label class="custom-control-label" for="hijosSi">Si</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" class="custom-control-input" id="hijosNo" name="hijos" value ="No">
                                    <label class="custom-control-label" for="hijosNo">No</label>
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="col-4">
                            <div id="divcriteriocivil" class="criterio form-group">
                                <strong>Estado civil</strong>
                                <div class="custom-control custom-radio">
                                    <input type="radio" class="custom-control-input" id="soltero" name="estadocivil" value ="Soltero">
                                    <label class="custom-control-label" for="soltero">Soltero</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" class="custom-control-input" id="separado" name="estadocivil" value ="Separado">
                                    <label class="custom-control-label" for="separado">Separado</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" class="custom-control-input" id="divorciado" name="estadocivil" value ="Divorciado">
                                    <label class="custom-control-label" for="divorciado">Divorciado</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" class="custom-control-input" id="viudo" name="estadocivil" value ="Viudo">
                                    <label class="custom-control-label" for="viudo">Viudo</label>
                                </div>
                            </div>
                        </div>
                        <br>
                        <br>
                        <div class="col-4">
                            <div id="divcriteriofisico" class="criterio form-group">
                                <strong>Condición física</strong>
                                <div class="custom-control custom-radio">
                                    <input type="radio" class="custom-control-input" id="delgada" name="fisico" value ="Delgada">
                                    <label class="custom-control-label" for="delgada">Delgada</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" class="custom-control-input" id="atletica" name="fisico" value ="Atletica">
                                    <label class="custom-control-label" for="atletica">Atletica</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" class="custom-control-input" id="normal" name="fisico" value ="Normal">
                                    <label class="custom-control-label" for="normal">Normal</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" class="custom-control-input" id="kilosdemas" name="fisico" value ="Kilos de mas">
                                    <label class="custom-control-label" for="kilosdemas">Algunos kilos de más</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" class="custom-control-input" id="corpulenta" name="fisico" value ="Corpulenta">
                                    <label class="custom-control-label" for="corpulenta">Corpulenta</label>
                                </div>
                            </div>
                        </div>
                        <br><br>
                        <div class="col-4 mx-auto">
                            <div id="divcriterioaficiones" class="criterio">
                                <strong>Lista de aficiones</strong>
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input type="checkbox" class="form-check-input af" name="aficiones" value="Deporte">Deporte
                                    </label>
                                </div>
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input type="checkbox" class="form-check-input af" name="aficiones" value="Lectura">Lectura
                                    </label>
                                </div>
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input type="checkbox" class="form-check-input af" name="aficiones" value="Cine">Cine
                                    </label>
                                </div>
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input type="checkbox" class="form-check-input af" name="aficiones" value="Viajes">Viajes
                                    </label>
                                </div>
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input type="checkbox" class="form-check-input af" name="aficiones" value="Musica">Música
                                    </label>
                                </div>
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input type="checkbox" class="form-check-input af"  name="aficiones"value="Cocina">Cocina
                                    </label>
                                </div>
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input type="checkbox" class="form-check-input af" name="aficiones" value="Videojuegos">Videojuegos
                                    </label>
                                </div>
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input type="checkbox" class="form-check-input af" name="aficiones" value="Naturaleza">Naturaleza
                                    </label>
                                </div>
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input type="checkbox" class="form-check-input af" name="aficiones" value="Animales">Animales
                                    </label>
                                </div>

                            </div>
                        </div>
                    </div>
          <input type="hidden" id="secbusqueda" name="secbusqueda">
                </form>
                <c:if test="${not empty sessionScope.usuariosbusqueda}">
                    <div class="row" id="usuariosbusqueda">
                        <c:forEach var="u" items="${usuariosbusqueda}">
                                <c:if test="${u.tipo == 'usuario'}">
                            <c:choose>
                                <c:when test="${not empty u.imagen}">
                                    <c:set var="imagen" scope="session" value="data:image/*;base64,${u.imagen }"></c:set>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="imagen" scope="session" value="images/avatar.png"></c:set>
                                </c:otherwise>
                            </c:choose>
                            <div class="col-sm-3">
                                <form  method="post" action= "ServletCarrito" enctype="multipart/form-data">
                                <div class="card ml-2 w-100">
                                    <img class="card-img-top" src="${imagen}" alt="Card image" style="width:100%;height:50%">
                                    <div class="card-body">
                                        <h5 class="text-center">
                                                ${u.nombre} ${u.apellidos}
                                        </h5>
                                        <input class="card-text text-center container-sm"type="text" name="userpublico" value="${u.user}" readonly>
                                        <p class="card-text text-center">${u.fecha}<br> ${u.ciudad}</p>
                                        <button type="button" class="btn btn-warning float-left like" onclick="getDatos('ServletAjax?opcion=like&user=${u.user}', 'mensaje2')"> <i class="fa fa-heart"></i></button>
                                        <button type="submit" name="verperfil" class="ml-3 text-center  btn btn-warning">Ver perfil </button>
                                        <button type="button"  class="btn btn-warning float-right msg" onclick="getDatos('ServletAjax?opcion=msg&user=${u.user}', 'mensaje2')"> <i class="fas fa-comment"></i></button>

                                    </div>
                                </div>

                                    <div id="mensaje2" style="color:deeppink; font-size: larger"></div>

                                </form>
                            </div>
                        </c:if>
                        </c:forEach>
                    </div>
                </c:if>
<c:if test="${ empty sessionScope.usuariosbusqueda}">
    Ningún resultado


</c:if>
        </div>
    </div>
</div>
</div>

<script>

    function validar() {
        var resultado=false;
        if ($("#divcriterioedad").is(':visible')&& $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':hidden')&& $("#divcriteriofisico").is(':hidden') && $("#divcriterioaficiones").is(':hidden') ) {
            if ($("#edad1").val() != "" && $("#edad2").val() != "") {
                resultado= true;
                $("#secbusqueda").val("1");
            }
        }
        if ($("#divcriteriociudad").is(':visible')&& $("#divcriterioedad").is(':hidden') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':hidden')&& $("#divcriteriofisico").is(':hidden') && $("#divcriterioaficiones").is(':hidden') ) {
            if ($("#ciudad").val() != "" ) {
                resultado=true;
                $("#secbusqueda").val("2");
            }
        }
        if ($("#divcriterioaltura").is(':visible')&& $("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':hidden') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':hidden')&& $("#divcriteriofisico").is(':hidden') && $("#divcriterioaficiones").is(':hidden') ) {
            if ($("#altura1").val() != "" && $("#altura2").val() != "") {
                resultado= true;
                $("#secbusqueda").val("3");
            }
        }
        if ($("#divcriteriohijos").is(':visible')&& $("#divcriterioedad").is(':hidden') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriociudad").is(':hidden') && $("#divcriteriocivil").is(':hidden')&& $("#divcriteriofisico").is(':hidden') && $("#divcriterioaficiones").is(':hidden') ) {
            if (document.querySelector('input[name="hijos"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("4");
            }
        }
        if ($("#divcriteriocivil").is(':visible')&& $("#divcriterioedad").is(':hidden') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriociudad").is(':hidden')&& $("#divcriteriofisico").is(':hidden') && $("#divcriterioaficiones").is(':hidden') ) {
            if (document.querySelector('input[name="estadocivil"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("5");
            }
        }
        if ($("#divcriteriofisico").is(':visible')&& $("#divcriterioedad").is(':hidden') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':hidden')&& $("#divcriteriociudad").is(':hidden') && $("#divcriterioaficiones").is(':hidden') ) {
            if (document.querySelector('input[name="fisico"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("6");
            }
        }
        if ($("#divcriterioaficiones").is(':visible')&& $("#divcriterioedad").is(':hidden') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':hidden')&& $("#divcriteriofisico").is(':hidden') && $("#divcriteriociudad").is(':hidden') ) {
            if (document.querySelector('input[name="aficiones"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("7");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#ciudad").val() != "" && $("#edad1").val() != "" && $("#edad2").val() != "") {
                resultado=true;
                $("#secbusqueda").val("8");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#altura1").val() != "" && $("#altura2").val() != "" && $("#edad1").val() != "" && $("#edad2").val() != "") {
                resultado=true;
                $("#secbusqueda").val("9");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':hidden')) {
            if (document.querySelector('input[name="hijos"]:checked') && $("#edad1").val() != "" && $("#edad2").val() != "") {
                resultado=true;
                $("#secbusqueda").val("10");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':hidden')) {
            if (document.querySelector('input[name="estadocivil"]:checked') && $("#edad1").val() != "" && $("#edad2").val() != "") {
                resultado=true;
                $("#secbusqueda").val("11");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':hidden')) {
            if (document.querySelector('input[name="fisico"]:checked') && $("#edad1").val() != "" && $("#edad2").val() != "") {
                resultado=true;
                $("#secbusqueda").val("12");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':visible')) {
            if (document.querySelector('input[name="aficiones"]:checked') && $("#edad1").val() != "" && $("#edad2").val() != "") {
                resultado=true;
                $("#secbusqueda").val("13");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#ciudad").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != "") {
                resultado=true;
                $("#secbusqueda").val("14");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#ciudad").val() != ""&& document.querySelector('input[name="hijos"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("15");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#ciudad").val() != ""&& document.querySelector('input[name="estadocivil"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("16");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#ciudad").val() != ""&& document.querySelector('input[name="fisico"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("17");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#ciudad").val() != ""&& document.querySelector('input[name="aficiones"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("18");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#altura1").val() != "" && $("#altura2").val() != "" &&document.querySelector('input[name="hijos"]:checked') ) {
                resultado=true;
                $("#secbusqueda").val("19");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#altura1").val() != "" && $("#altura2").val() != "" &&document.querySelector('input[name="estadocivil"]:checked') ) {
                resultado=true;
                $("#secbusqueda").val("20");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#altura1").val() != "" && $("#altura2").val() != "" &&document.querySelector('input[name="fisico"]:checked') ) {
                resultado=true;
                $("#secbusqueda").val("21");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#altura1").val() != "" && $("#altura2").val() != "" &&document.querySelector('input[name="aficiones"]:checked') ) {
                resultado=true;
                $("#secbusqueda").val("22");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':hidden')) {
            if (document.querySelector('input[name="hijos"]:checked')&& document.querySelector('input[name="estadocivil"]:checked') ) {
                resultado=true;
                $("#secbusqueda").val("23");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':hidden')) {
            if (document.querySelector('input[name="hijos"]:checked')&& document.querySelector('input[name="fisico"]:checked') ) {
                resultado=true;
                $("#secbusqueda").val("24");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':visible')) {
            if (document.querySelector('input[name="hijos"]:checked')&& document.querySelector('input[name="aficiones"]:checked') ) {
                resultado=true;
                $("#secbusqueda").val("25");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':hidden')) {
            if (document.querySelector('input[name="fisico"]:checked')&& document.querySelector('input[name="estadocivil"]:checked') ) {
                resultado=true;
                $("#secbusqueda").val("26");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':visible')) {
            if (document.querySelector('input[name="aficiones"]:checked')&& document.querySelector('input[name="estadocivil"]:checked') ) {
                resultado=true;
                $("#secbusqueda").val("27");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':visible')) {
            if (document.querySelector('input[name="aficiones"]:checked')&& document.querySelector('input[name="fisico"]:checked') ) {
                resultado=true;
                $("#secbusqueda").val("28");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#ciudad").val() != "" && $("#edad1").val() != "" && $("#edad2").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != ""){
                resultado=true;
                $("#secbusqueda").val("29");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#ciudad").val() != "" && $("#edad1").val() != "" && $("#edad2").val() != "" && document.querySelector('input[name="hijos"]:checked')){
                resultado=true;
                $("#secbusqueda").val("30");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#ciudad").val() != "" && $("#edad1").val() != "" && $("#edad2").val() != "" && document.querySelector('input[name="estadocivil"]:checked')){
                resultado=true;
                $("#secbusqueda").val("31");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#ciudad").val() != "" && $("#edad1").val() != "" && $("#edad2").val() != "" && document.querySelector('input[name="fisico"]:checked')){
                resultado=true;
                $("#secbusqueda").val("32");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#ciudad").val() != "" && $("#edad1").val() != "" && $("#edad2").val() != "" && document.querySelector('input[name="aficiones"]:checked')){
                resultado=true;
                $("#secbusqueda").val("33");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':hidden')) {
            if (document.querySelector('input[name="hijos"]:checked') && $("#edad1").val() != "" && $("#edad2").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != ""){
                resultado=true;
                $("#secbusqueda").val("34");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':hidden')) {
            if (document.querySelector('input[name="estadocivil"]:checked') && $("#edad1").val() != "" && $("#edad2").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != ""){
                resultado=true;
                $("#secbusqueda").val("35");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':hidden')) {
            if (document.querySelector('input[name="fisico"]:checked') && $("#edad1").val() != "" && $("#edad2").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != ""){
                resultado=true;
                $("#secbusqueda").val("36");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':visible')) {
            if (document.querySelector('input[name="aficiones"]:checked') && $("#edad1").val() != "" && $("#edad2").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != ""){
                resultado=true;
                $("#secbusqueda").val("37");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':hidden')) {
            if (document.querySelector('input[name="hijos"]:checked') && $("#edad1").val() != "" && $("#edad2").val() != "" && document.querySelector('input[name="estadocivil"]:checked')){
                resultado=true;
                $("#secbusqueda").val("38");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':hidden')) {
            if (document.querySelector('input[name="hijos"]:checked') && $("#edad1").val() != "" && $("#edad2").val() != "" && document.querySelector('input[name="fisico"]:checked')){
                resultado=true;
                $("#secbusqueda").val("39");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':visible')) {
            if (document.querySelector('input[name="hijos"]:checked') && $("#edad1").val() != "" && $("#edad2").val() != "" && document.querySelector('input[name="aficiones"]:checked')){
                resultado=true;
                $("#secbusqueda").val("40");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':hidden')) {
            if (document.querySelector('input[name="estadocivil"]:checked') && $("#edad1").val() != "" && $("#edad2").val() != "" && document.querySelector('input[name="fisico"]:checked')){
                resultado=true;
                $("#secbusqueda").val("41");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':visible')) {
            if (document.querySelector('input[name="estadocivil"]:checked') && $("#edad1").val() != "" && $("#edad2").val() != "" && document.querySelector('input[name="aficiones"]:checked')){
                resultado=true;
                $("#secbusqueda").val("42");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':visible')) {
            if (document.querySelector('input[name="fisico"]:checked') && $("#edad1").val() != "" && $("#edad2").val() != "" && document.querySelector('input[name="aficiones"]:checked')){
                resultado=true;
                $("#secbusqueda").val("43");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#ciudad").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="hijos"]:checked')){
                resultado=true;
                $("#secbusqueda").val("44");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#ciudad").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="estadocivil"]:checked')){
                resultado=true;
                $("#secbusqueda").val("45");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#ciudad").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="fisico"]:checked')){
                resultado=true;
                $("#secbusqueda").val("46");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#ciudad").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="aficiones"]:checked')){
                resultado=true;
                $("#secbusqueda").val("47");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#ciudad").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="estadocivil"]:checked')){
                resultado=true;
                $("#secbusqueda").val("48");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#ciudad").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="fisico"]:checked')){
                resultado=true;
                $("#secbusqueda").val("49");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#ciudad").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="aficiones"]:checked')){
                resultado=true;
                $("#secbusqueda").val("50");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#ciudad").val() != "" && document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="fisico"]:checked')){
                resultado=true;
                $("#secbusqueda").val("51");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#ciudad").val() != "" && document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="aficiones"]:checked')){
                resultado=true;
                $("#secbusqueda").val("52");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#ciudad").val() != "" && document.querySelector('input[name="fisico"]:checked') && document.querySelector('input[name="aficiones"]:checked')){
                resultado=true;
                $("#secbusqueda").val("53");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="estadocivil"]:checked')){
                resultado=true;
                $("#secbusqueda").val("54");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="fisico"]:checked')){
                resultado=true;
                $("#secbusqueda").val("55");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="aficiones"]:checked')){
                resultado=true;
                $("#secbusqueda").val("56");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="fisico"]:checked')){
                resultado=true;
                $("#secbusqueda").val("57");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="aficiones"]:checked')){
                resultado=true;
                $("#secbusqueda").val("58");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="fisico"]:checked') && document.querySelector('input[name="aficiones"]:checked')){
                resultado=true;
                $("#secbusqueda").val("59");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':hidden')) {
            if ( document.querySelector('input[name="hijos"]:checked')&& document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="fisico"]:checked')){
                resultado=true;
                $("#secbusqueda").val("60");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':visible')) {
            if ( document.querySelector('input[name="hijos"]:checked')&& document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="aficiones"]:checked')){
                resultado=true;
                $("#secbusqueda").val("61");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':visible')) {
            if ( document.querySelector('input[name="hijos"]:checked')&& document.querySelector('input[name="fisico"]:checked') && document.querySelector('input[name="aficiones"]:checked')){
                resultado=true;
                $("#secbusqueda").val("62");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':visible')) {
            if ( document.querySelector('input[name="estadocivil"]:checked')&& document.querySelector('input[name="fisico"]:checked') && document.querySelector('input[name="aficiones"]:checked')){
                resultado=true;
                $("#secbusqueda").val("63");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#ciudad").val() != "" && $("#edad1").val() != "" && $("#edad2").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != ""&& document.querySelector('input[name="hijos"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("64");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#ciudad").val() != "" && $("#edad1").val() != "" && $("#edad2").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != ""&& document.querySelector('input[name="estadocivil"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("65");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#ciudad").val() != "" && $("#edad1").val() != "" && $("#edad2").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != ""&& document.querySelector('input[name="fisico"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("66");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#ciudad").val() != "" && $("#edad1").val() != "" && $("#edad2").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != ""&& document.querySelector('input[name="aficiones"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("67");
            }
        }

        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#ciudad").val() != "" && $("#edad1").val() != "" && $("#edad2").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="estadocivil"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("68");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#ciudad").val() != "" && $("#edad1").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="fisico"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("69");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#ciudad").val() != "" && $("#edad1").val() != "" && $("#edad2").val() != "" &&  document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="aficiones"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("70");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#ciudad").val() != "" && $("#edad1").val() != "" && $("#edad2").val() != "" && document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="fisico"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("71");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#ciudad").val() != "" && $("#edad1").val() != "" && $("#edad2").val() != ""&& document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="aficiones"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("72");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#ciudad").val() != "" && $("#edad1").val() != "" && $("#edad2").val() != "" && document.querySelector('input[name="fisico"]:checked') && document.querySelector('input[name="aficiones"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("73");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':hidden')) {
            if ( $("#edad1").val() != "" && $("#edad2").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != ""&& document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="estadocivil"]:checked')){
                $("#secbusqueda").val("74");
            }
        }

        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#edad1").val() != "" && $("#edad2").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != ""&& document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="fisico"]:checked')){
                $("#secbusqueda").val("75");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':visible')) {
            if ( $("#edad1").val() != "" && $("#edad2").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != ""&& document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="aficiones"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("76");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':visible')) {
            if ( $("#edad1").val() != "" && $("#edad2").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != ""&& document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="aficiones"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("77");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':visible')) {
            if ( $("#edad1").val() != "" && $("#edad2").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != ""&& document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="aficiones"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("78");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':visible')) {
            if ( $("#edad1").val() != "" && $("#edad2").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != ""&& document.querySelector('input[name="fisico"]:checked') && document.querySelector('input[name="aficiones"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("79");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':hidden')) {
            if ( $("#edad1").val() != "" && $("#edad2").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="fisico"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("80");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':visible')) {
            if ( $("#edad1").val() != "" && $("#edad2").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="aficiones"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("81");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':visible')) {
            if ( $("#edad1").val() != "" && $("#edad2").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="aficiones"]:checked')&& document.querySelector('input[name="fisico"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("82");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':visible')) {
            if ( $("#edad1").val() != "" && $("#edad2").val() != "" && document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="aficiones"]:checked') && document.querySelector('input[name="fisico"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("83");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':hidden')) {
            if ( $("#ciudad").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="estadocivil"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("84");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':hidden')) {
            if ( $("#ciudad").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="fisico"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("85");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':visible')) {
            if ( $("#ciudad").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="aficiones"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("86");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':hidden')) {
            if ( $("#ciudad").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="fisico"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("87");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':visible')) {
            if ( $("#ciudad").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="aficiones"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("88");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':visible')) {
            if ( $("#ciudad").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="fisico"]:checked') && document.querySelector('input[name="aficiones"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("89");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':hidden')) {
            if ( $("#ciudad").val() != ""  && document.querySelector('input[name="fisico"]:checked') && document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="hijos"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("90");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':visible')) {
            if ( $("#ciudad").val() != ""  && document.querySelector('input[name="aficiones"]:checked') && document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="hijos"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("91");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':visible')) {
            if ( $("#ciudad").val() != ""  && document.querySelector('input[name="aficiones"]:checked') && document.querySelector('input[name="fisico"]:checked') && document.querySelector('input[name="hijos"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("92");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':visible')) {
            if ( $("#ciudad").val() != ""  && document.querySelector('input[name="aficiones"]:checked') && document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="fisico"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("93");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':hidden')) {
            if ( $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="fisico"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("94");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':visible')) {
            if ( $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="aficiones"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("95");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':visible')) {
            if ( $("#altura1").val() != "" && $("#altura2").val() != ""  && document.querySelector('input[name="aficiones"]:checked') && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="fisico"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("96");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':visible')) {
            if ( $("#altura1").val() != "" && $("#altura2").val() != ""  && document.querySelector('input[name="aficiones"]:checked') && document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="fisico"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("97");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':visible')) {
            if (  document.querySelector('input[name="aficiones"]:checked')&& document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="fisico"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("98");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#edad1").val() != "" && $("#edad2").val() != "" && $("#ciudad").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="estadocivil"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("99");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':hidden')) {
            if ( $("#edad1").val() != "" && $("#edad2").val() != "" && $("#ciudad").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="fisico"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("100");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#edad1").val() != "" && $("#edad2").val() != "" && $("#ciudad").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="aficiones"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("101");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#edad1").val() != "" && $("#edad2").val() != "" && $("#ciudad").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="fisico"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("102");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#edad1").val() != "" && $("#edad2").val() != "" && $("#ciudad").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="aficiones"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("103");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#edad1").val() != "" && $("#edad2").val() != "" && $("#ciudad").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="fisico"]:checked') && document.querySelector('input[name="aficiones"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("104");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#edad1").val() != "" && $("#edad2").val() != "" && $("#ciudad").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="fisico"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("105");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#edad1").val() != "" && $("#edad2").val() != "" && $("#ciudad").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="estadocivil"]:checked')&& document.querySelector('input[name="aficiones"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("106");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#edad1").val() != "" && $("#edad2").val() != "" && $("#ciudad").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name=fisico"]:checked')&& document.querySelector('input[name="aficiones"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("107");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#edad1").val() != "" && $("#edad2").val() != "" && $("#ciudad").val() != "" && document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="fisico"]:checked')&& document.querySelector('input[name="aficiones"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("108");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#edad1").val() != "" && $("#edad2").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="estadocivil"]:checked')&& document.querySelector('input[name="fisico"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("109");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#edad1").val() != "" && $("#edad2").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="estadocivil"]:checked')&& document.querySelector('input[name="aficiones"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("110");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#edad1").val() != "" && $("#edad2").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="fisico"]:checked')&& document.querySelector('input[name="aficiones"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("111");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#edad1").val() != "" && $("#edad2").val() != "" && document.querySelector('input[name="hijos"]:checked')&& document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="fisico"]:checked')&& document.querySelector('input[name="aficiones"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("112");
            }
        }

        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#edad1").val() != "" && $("#edad2").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="fisico"]:checked')&& document.querySelector('input[name="aficiones"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("113");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#ciudad").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="estadocivil"]:checked')&& document.querySelector('input[name="fisico"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("114");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#ciudad").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="estadocivil"]:checked')&& document.querySelector('input[name="aficiones"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("115");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#ciudad").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="fisico"]:checked')&& document.querySelector('input[name="aficiones"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("116");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is('hidden') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#ciudad").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="fisico"]:checked')&& document.querySelector('input[name="aficiones"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("117");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#ciudad").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="fisico"]:checked')&& document.querySelector('input[name="aficiones"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("118");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="hijos"]:checked')&& document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="fisico"]:checked')&& document.querySelector('input[name="aficiones"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("119");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':hidden')) {
            if ($("#edad1").val() != "" && $("#edad2").val() != "" && $("#ciudad").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="hijos"]:checked')&& document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="fisico"]:checked')) {
                resultado=true;
                $("#secbusqueda").val("120");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':hidden')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#edad1").val() != "" && $("#edad2").val() != "" && $("#ciudad").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="aficiones"]:checked')) {
                resultado = true;
                $("#secbusqueda").val("121");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':hidden') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#edad1").val() != "" && $("#edad2").val() != "" && $("#ciudad").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="fisico"]:checked') && document.querySelector('input[name="aficiones"]:checked')) {
                resultado = true;
                $("#secbusqueda").val("122");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':hidden') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#edad1").val() != "" && $("#edad2").val() != "" && $("#ciudad").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="fisico"]:checked') && document.querySelector('input[name="aficiones"]:checked')) {
                resultado = true;
                $("#secbusqueda").val("123");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':hidden') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#edad1").val() != "" && $("#edad2").val() != "" && $("#ciudad").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="fisico"]:checked') && document.querySelector('input[name="aficiones"]:checked')) {
                resultado = true;
                $("#secbusqueda").val("124");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':hidden') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#edad1").val() != "" && $("#edad2").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="fisico"]:checked') && document.querySelector('input[name="aficiones"]:checked')) {
                resultado = true;
                $("#secbusqueda").val("125");
            }
        }
        if ($("#divcriterioedad").is(':hidden') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#ciudad").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="fisico"]:checked') && document.querySelector('input[name="aficiones"]:checked')) {
                resultado = true;
                $("#secbusqueda").val("126");
            }
        }
        if ($("#divcriterioedad").is(':visible') && $("#divcriteriociudad").is(':visible') && $("#divcriterioaltura").is(':visible') && $("#divcriteriohijos").is(':visible') && $("#divcriteriocivil").is(':visible') && $("#divcriteriofisico").is(':visible')&& $("#divcriterioaficiones").is(':visible')) {
            if ($("#edad1").val() != "" && $("#edad2").val() != "" && $("#ciudad").val() != "" && $("#altura1").val() != "" && $("#altura2").val() != "" && document.querySelector('input[name="hijos"]:checked') && document.querySelector('input[name="estadocivil"]:checked') && document.querySelector('input[name="fisico"]:checked') && document.querySelector('input[name="aficiones"]:checked')) {
                resultado = true;
                $("#secbusqueda").val("127");
            }
        }
        if (resultado==false)
            document.getElementById('Error').innerHTML="Debe rellenar todos los criterios seleccionados."

    return resultado;
    }

    $( "select" )
        .change(function() {
            $('.jumbotron').hide();
            $('.criterio').hide();
            $( "select option:selected" ).each(function() {
                document.getElementById('Error').innerHTML="";
                $('.jumbotron').show();
                $('#div' + $(this).val()).show();

            });
        })
        .trigger( "change" );

    var limit = 2;
    var count = 0;

    $(document).ready(function() {
        $("#borrar").on("click", function () {
            $('.jumbotron').hide();
            $('.criterio').hide();
            count = 0;
            $('#usuariosbusqueda').hide();

        });
        $('.af').click(function () {
            if ($(this).is(':checked')) {
                count++;
            } else
                count--;
            if (count > limit) {
                document.getElementById('Error').innerHTML = "Solo puede seleccionar 2 aficiones!";
                $("#borrar").click();
            }
        });
    });

    $(document).ready(function(){
        $("#buscador").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("#myDIV *").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
            $("#myDIV2 *").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });

        });
    });

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
                    intervalo(obj);
                }
            }
            XHRObject.send(null);
        }
    }

    function intervalo(div)
    {
        var op=1;
        var timer;
        timer = setInterval(function () {
            if (op <= 0.1){
                div.style.display = 'none';
                op=1;
              location.reload();

            }
            div.style.opacity = op;
            op -= op * 0.1;
        }, 200);

    }

</script>
</body>
</html>
