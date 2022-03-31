<nav class="navbar navbar-expand-lg navbar-light bg-dark fixed-top">
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarheader" aria-controls="navbarTogglerDemo03" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <a class="navbar-brand" href="#"><img src="images/imagen%20logo.png" class="mb-3" alt="logo" style="width:40px;"> <span class="mt-5 text-warning">Hola, ${sessionScope.usuario.user}!</span></a>

  <div class="collapse navbar-collapse justify-content-center" id="navbarheader">
    <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
      <li class="nav-item">
        <form action="ServletController" method="post">
        <input class="btn btn-warning mt-3" type="submit" value="Mi perfil" name="miperfil">
        </form>
      </li>
      <li class="nav-item">
        <a class="nav-link mt-2" href="ServletDesconexion"><span class="btn btn-warning">Cerrar sesion</span></a>
      </li>
    </ul>
    <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2 btn-outline-warning" id="buscador"type="search" placeholder="Search" aria-label="Search">
      <!-- <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>-->
    </form>
  </div>
</nav>