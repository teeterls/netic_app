package servlets;

import dao.AdminDAO;
import dao.BusquedaDAO;
import dao.UsuarioDAO;
import dominio.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.Year;
import java.util.Collection;
import java.util.Date;
import java.util.logging.Logger;

import static java.util.logging.Level.SEVERE;

public class ServletController extends HttpServlet {
    private static final long serialVersionUID= 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String mensajeError = "";
        String vista = "/principal.jsp";

        HttpSession sesion = request.getSession();
        Usuario usuario = (Usuario) sesion.getAttribute("usuario");  //devuelve usuario completo
        if (usuario == null) {
            mensajeError = "No se ha registrado ni ha accedido";
            request.setAttribute("mensajeError", mensajeError);
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }

        //collection que se muestra en principal-> pestaña inicio
        Collection<Usuario> usuariosinicio = null;
        usuariosinicio = BusquedaDAO.InicioUsuarios(usuario);
        for (Usuario u : usuariosinicio) //recorrer el vector de usuarios
        {
            int fecha = Integer.parseInt(u.getFecha().substring(0, 4)); //YYYY-MM-DD
            int year = Year.now().getValue();
            u.setFecha(String.valueOf(year - fecha));
        }
        request.setAttribute("usuariosinicio", usuariosinicio);
        sesion.setAttribute("usuariosinicio", usuariosinicio);
       
        
        if(usuario.getTipo().equals("administrador")) {

            Collection<Usuario> usuariosadmin= null;
            usuariosadmin = AdminDAO.AdminUsuarios(usuario);
            for (Usuario u : usuariosadmin) //recorrer el vector de usuarios
            {
                int fecha = Integer.parseInt(u.getFecha().substring(0, 4)); //YYYY-MM-DD
                int year = Year.now().getValue();
                u.setFecha(String.valueOf(year - fecha));
            }
            request.setAttribute("usuariosadmin", usuariosadmin);
            sesion.setAttribute("usuariosadmin", usuariosadmin);
            int fecha = Integer.parseInt(usuario.getFecha().substring(0, 4)); //YYYY-MM-DD
            int year = Year.now().getValue();
            usuario.setEdad(year - fecha);
        	vista = "/ServletEstadisticas";
        	//esponse.sendRedirect();
        	
        }

       if (request.getParameter("miperfil") != null) {
    	   if(usuario.getTipo().equals("administrador")) {
    		   vista = "/ServletEstadisticas";
    	   } else {
            vista = "/perfil.jsp";
    	   }
            request.setAttribute("infousuario", usuario);
        }

        request.getRequestDispatcher(vista).forward(request, response);
       //response.sendRedirect("ServletEstadisticas");
    }

        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        processRequest(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        processRequest(request,response);
    }
}