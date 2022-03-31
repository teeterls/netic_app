package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dao.UsuarioDAO;
import dominio.Usuario;

/**
 * Servlet implementation class ServletUpdateUsuario
 */

public class ServletUpdateUsuario extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletUpdateUsuario() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	String vista="/perfil.jsp";
    	String mensajeError;
    	
        HttpSession sesion = request.getSession();
        Usuario user = (Usuario) sesion.getAttribute("usuario");
        
        String username = request.getParameter("username");
        String sexo = request.getParameter("sexo");
        String prevPwd = request.getParameter("prevPwd");
        
        
        
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String pwd = request.getParameter("pwd");
        String desc = request.getParameter("descripcion");
        String pref = request.getParameter("preferencia");
        String email = request.getParameter("email");
        
        String ciudad = request.getParameter("ciudad");
        String altura = request.getParameter("altura");
        String fisico = request.getParameter("fisico");
        String civil = request.getParameter("civil");
        String hijos = request.getParameter("hijos");
        
        
        boolean updated;
        if(user != null && username != null) {
        	//Como comprobación
        	Usuario usrPrueba = new Usuario(username, prevPwd);
            boolean existe = UsuarioDAO.buscarUsuario(usrPrueba);
            Usuario userPrevio = UsuarioDAO.getInfoCompleta(usrPrueba);
            if(existe) {
            	
            	Usuario newUsuario = new Usuario(username, pwd, nombre, apellidos, sexo,
            			userPrevio.getFecha(), email, pref, desc, userPrevio.getTipo(), altura, fisico,
            			ciudad, hijos, civil);
                    
            	updated = UsuarioDAO.updateUsuario(newUsuario);
            	if(updated) {
            		Usuario usr_vacio = new Usuario(username, pwd);
            		Usuario nuevoUserCompleto= UsuarioDAO.getInfoCompleta(usr_vacio);
            		if(user.getTipo().equals("administrador")) {
            			request.setAttribute("usuarioPrivado", nuevoUserCompleto);
            		} else {
            			sesion.setAttribute("usuario", nuevoUserCompleto);
            		}
                
            	} else {
            		mensajeError = "Error al actualizar su perfil. Por favor, vuelva a intentarlo.";
                    request.setAttribute("mensajeError", mensajeError);
            		vista = "error.jsp";
            	}
            } else {
            	mensajeError = "Error: el usuario no existe.";
                request.setAttribute("mensajeError", mensajeError);
            	vista = "error.jsp";
            }
        } else {
        	mensajeError = "Error: no se han recibido correctamente los datos del usuario. Vuelva a intentarlo.";
            request.setAttribute("mensajeError", mensajeError);
        	vista = "error.jsp";
        }
        request.getRequestDispatcher(vista).forward(request,response);
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		processRequest(request, response);
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
