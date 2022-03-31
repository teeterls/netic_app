package servlets;
import dao.UsuarioDAO;
import dominio.Usuario;

import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


public class ServletAcceso extends HttpServlet {
    private static final long serialVersionUID= 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user = request.getParameter("user");
        String pwd = request.getParameter("pwd");
        Usuario usuario = null;
        Usuario usuarioCompleto= null;
        boolean existe;
        String mensajeError = "";
        if (user != null && pwd != null) {
            usuario = new Usuario(user, pwd);
            existe = UsuarioDAO.buscarUsuario(usuario);

            if (request.getParameter("acceder") != null) //click boton acceder
            {
                if (existe) {
                    usuarioCompleto=UsuarioDAO.getInfoCompleta(usuario);
                    HttpSession sesion = request.getSession(); //sesion
                    sesion.setAttribute("usuario", usuarioCompleto);
                    response.sendRedirect("ServletController");
                    
                    
                    /*System.out.println(usuarioCompleto.getTipo());
                    switch(usuarioCompleto.getTipo()) {
                    case "usuario":
                    	response.sendRedirect("ServletController");
                    	break;
                    	
                    case "administrador":
                    	response.sendRedirect("admin.jsp");
                    	break;
                    	
                    default:
                    	mensajeError = "Error al identificar el usuario";
                        request.setAttribute("mensajeError", mensajeError);
                        request.getRequestDispatcher("error.jsp").forward(request, response);
                    	break;
                    }*/
                    

                } else {
                    mensajeError = "Todavía no se ha registrado como usuario de la app. Regístrese como usuario.";
                    request.setAttribute("mensajeError", mensajeError);
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                }
            }
        }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        processRequest(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        processRequest(request, response);
    }
}
