package servlets;

import dao.UsuarioDAO;
import dominio.Usuario;
import dominio.CarritoBusquedas;
import servicios.CarritoServicio;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.Year;

@MultipartConfig

public class ServletCarrito extends HttpServlet {
    private static final long serialVersionUID= 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException, ClassNotFoundException {

        String mensajeError = "";
        String vista = "";

        HttpSession sesion = request.getSession();
        Usuario usuario = (Usuario) sesion.getAttribute("usuario");  //devuelve usuario completo
        if (usuario == null) {
            mensajeError = "No se ha registrado ni ha accedido";
            request.setAttribute("mensajeError", mensajeError);
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
        System.out.println("Llega aquí");
        //se utiliza para todos
        Usuario usuariopublico = null;
        if (request.getParameter("userpublico") != null) {
        	System.out.println("tiene user");
            String userpublico = request.getParameter("userpublico");
            usuariopublico = UsuarioDAO.verPerfil(userpublico); //recibe informacion publica
            int fecha = Integer.parseInt(usuariopublico.getFecha().substring(0, 4)); //YYYY-MM-DD
            int year = Year.now().getValue();
            usuariopublico.setFecha(String.valueOf(year - fecha));
            request.setAttribute("usuariopublico", usuariopublico);
            sesion.setAttribute("usuariopublico", usuariopublico);
        }
        if (request.getParameter("verperfil") != null) {
            vista = "/verperfil.jsp";
            //enviar carrito visitas: usuario
            new CarritoServicio(request).visitar(usuariopublico.getUser());

        } else if(usuario.getTipo().equals("administrador")) {
        	if(request.getParameter("perfil").equals("verperfil"))
        		vista = "/verperfil.jsp";
        }

        //se muestran los distintos carritos
        if (request.getParameter("vervisitas")!=null) {
            vista = "/listadoCarrito.jsp";
            sesion.setAttribute("visita", "visita");
        }

        if (request.getParameter("verlikes")!=null)
        {
            vista = "/listadoCarrito.jsp";
            sesion.setAttribute("like", "like");
        }

        if (request.getParameter("vermensajes")!=null)
        {
            vista = "/listadoCarrito.jsp";
            sesion.setAttribute("mensaje", "mensaje");
        }

        //mis busquedas desde perfil.jsp
        if (request.getParameter("verbusquedas") != null) {
            if (sesion.getAttribute("carritobusquedas")!= null) {
                vista="/listadoCarrito.jsp";
                sesion.setAttribute("busqueda", "busqueda");
            } else {
                mensajeError = "No ha realizado ninguna busqueda";
                request.setAttribute("mensajeError", mensajeError);
                request.getRequestDispatcher("errorbusqueda.jsp").forward(request, response);
            }

        }
        //borrarperfil
        if (request.getParameter("borrarperfil")!=null)
        {
            boolean borrado;
            borrado=UsuarioDAO.eliminarUsuario(usuario);
            if (borrado==false)
            {
                mensajeError = "Ha ocurrido un error al intentar borrar su perfil. Vuelva a intentarlo";
                request.setAttribute("mensajeError", mensajeError);
                request.getRequestDispatcher("errorbusqueda.jsp").forward(request, response);
            }
            response.sendRedirect("ServletDesconexion");
        }


        request.getRequestDispatcher(vista).forward(request, response);
    }
        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

            try {
                processRequest(request,response);
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
        }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            processRequest(request,response);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}
