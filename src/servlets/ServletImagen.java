package servlets;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;

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
 * Servlet implementation class ServletImagen
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024,
				maxFileSize = 1024 * 1024 * 5, 
				maxRequestSize = 1024 * 1024 * 5 * 5)

public class ServletImagen extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletImagen() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	String vista="/perfil.jsp";
    	String mensajeError;
        HttpSession sesion = request.getSession();
        Usuario user = (Usuario) sesion.getAttribute("usuario");
        
        String userName = request.getParameter("userName");
        String pwd = request.getParameter("prevPwd");    
        
        
        Part img = request.getPart("foto");
        
        
        
        boolean updated;
        if(user != null) {
        	//Como comprobación
        	Usuario usrPrueba = new Usuario(userName, pwd);
            boolean existe = UsuarioDAO.buscarUsuario(usrPrueba);
            if(existe) {
                    
            	updated = UsuarioDAO.updateFoto(img, usrPrueba);
            	if(updated) {
            		Usuario nuevoUserCompleto= UsuarioDAO.getInfoCompleta(usrPrueba);
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
        	mensajeError = "Error al registrarse en la BBDD. Vuelva a intentarlo.";
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
	}

}
