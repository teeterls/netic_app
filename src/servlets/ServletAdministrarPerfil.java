package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UsuarioDAO;
import dominio.Usuario;

/**
 * Servlet implementation class ServletAdministrarPerfil
 */

public class ServletAdministrarPerfil extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletAdministrarPerfil() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String mensaje = "";
    	String vista = "/verPerfil";
    	
    	HttpSession sesion = request.getSession();
    	Usuario admin = (Usuario) sesion.getAttribute("usuario");
    	String user = request.getParameter("userpublico");
    	Usuario usuario = new Usuario(user, "");
    	
    	
    	String perfil = request.getParameter("perfil");
    	
    	System.out.println("Perfil: " + perfil);
    	
    	
    	
    	if(admin.getTipo().contentEquals("administrador")) {
    		switch(perfil) {
    		case "verperfil":
    			vista = "ServletCarrito";
    			//response.sendRedirect("CarritoServicio");
    			break;
    		case "ajustes":
    			vista = "/perfil.jsp";
    			Usuario usuarioPrivado = UsuarioDAO.getInfoCompleta(usuario);
    			request.setAttribute("usuarioPrivado", usuarioPrivado);
    			break;
    		default:
    			mensaje = "Lo sentimos, no tiene los permisos para acceder al recurso solicitado";
        		request.setAttribute("mensajeError", mensaje);
        		vista = "/error.jsp";
    			break;
    		}
    	} else {
    		mensaje = "Lo sentimos, no tiene los permisos para acceder al recurso solicitado";
    		request.setAttribute("mensajeError", mensaje);
    		vista = "/error.jsp";
    	}
    	request.getRequestDispatcher(vista).forward(request,response);
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		//processRequest(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		processRequest(request, response);
	}

}
