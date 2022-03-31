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
 * Servlet implementation class ServletPermisos
 */

public class ServletPermisos extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletPermisos() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String vista = "/ServletController";
    	String mensaje;
    	HttpSession sesion = request.getSession();
    	Usuario admin = (Usuario) sesion.getAttribute("usuario");
    	String username = request.getParameter("userPrivado");
    	Usuario userPrivado = new Usuario(username, null);
    	
    	
    	if(admin.getTipo().equals("administrador")) {
    		String opcion = request.getParameter("gestion");
    		switch(opcion) {
    		case "Permisos":
    			String tipoPermiso = request.getParameter("permisos");
    			if(tipoPermiso!=null) {
    				boolean cambioPermiso = false;
    				cambioPermiso = UsuarioDAO.permisoUsuario(userPrivado, tipoPermiso);
    				if(!cambioPermiso) {
    					vista="/error.jsp";
        				mensaje = "No han podido asignarse los permisos al usuario";
        				request.setAttribute("mensajeError", mensaje);
    				}
    			} else {
    				vista="/error.jsp";
    				mensaje = "No se ha seleccionado el tipo de permiso para el usuario";
    				request.setAttribute("mensajeError", mensaje);
    			}
    			break;
    		case "Eliminar":
    			boolean eliminado = false;
    			eliminado = UsuarioDAO.eliminarUsuario(userPrivado);
    			if(!eliminado) {
    				vista="/error.jsp";
    				mensaje = "El usuario no ha podido eliminarse correctamente";
    				request.setAttribute("mensajeError", mensaje);
    			}
    			break;
    		default:
    			vista="/error.jsp";
    			mensaje = "No se ha recibido ninguna opción";
        		request.setAttribute("mensajeError", mensaje);
    			break;
    		}   		
    	} else {
    		vista="/error.jsp";
    		mensaje = "No tiene los permisos para realizar esa acción";
    		request.setAttribute("mensajeError", mensaje);
    	}
    request.getRequestDispatcher(vista).forward(request, response);
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		processRequest(request, response);
	}

}
