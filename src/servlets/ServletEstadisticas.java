package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.AdminDAO;
import dao.UsuarioDAO;
import dominio.Usuario;
import dominio.AdminInfo;

/**
 * Servlet implementation class ServletEstadisticas
 */

public class ServletEstadisticas extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletEstadisticas() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String vista = "/admin.jsp";
    	
    	HttpSession sesion = request.getSession();
        Usuario usuario=(Usuario) sesion.getAttribute("usuario");
        ArrayList<AdminInfo> actividad = new ArrayList<AdminInfo>();
        boolean existe;
        String mensajeError="";
        if(usuario.getUser()!= null && usuario.getPwd()!=null && usuario.getTipo().equals("administrador"))
        {
            usuario=new Usuario(usuario.getUser(),usuario.getPwd());
            existe= UsuarioDAO.buscarUsuario(usuario);
            if (existe){
            	actividad = AdminDAO.getActividad();
            	request.setAttribute("actividad", actividad);
            } else {
            	vista = "/error.jsp";
            }

        } else {
        	vista = "/error.jsp";
        }
        request.getRequestDispatcher(vista).forward(request, response);
        
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
		//processRequest(request, response);
	}

}
