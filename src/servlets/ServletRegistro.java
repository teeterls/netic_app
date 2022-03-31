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



public class ServletRegistro extends HttpServlet {
    private static final long serialVersionUID= 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String user= request.getParameter("user");
        String pwd= request.getParameter("pwd");
        String nombre=request.getParameter("nombre");
        String apellidos=request.getParameter("apellido");
        String sexo=request.getParameter("sexo");
        String fecha=request.getParameter("fecha");
        String email=request.getParameter("mail");
        String preferencia=request.getParameter("preferencia");
        String descripcion=request.getParameter("descripcion");
        
        String altura=request.getParameter("altura");
        String fisico=request.getParameter("fisico");
        String ciudad=request.getParameter("ciudad");
        String hijos=request.getParameter("hijos");
        String civil=request.getParameter("civil");
        
        Usuario usuario=null;
        boolean existe;
        boolean agregado;
        boolean infoExtra;
        String mensajeError="";
        if(user!= null && pwd!=null)
        {
            usuario=new Usuario(user,pwd);
            existe= UsuarioDAO.buscarUsuario(usuario);

            if (existe){

                    mensajeError = "Ya se ha registrado anteriormente como usuario de la app. Acceda a la app.";
                    request.setAttribute("mensajeError", mensajeError);
                    request.getRequestDispatcher("error.jsp").forward(request,response);
                }else {
                	Usuario usuarioCompleto= new Usuario(user,pwd,nombre,apellidos,sexo,fecha,email,preferencia,descripcion);
                   usuarioCompleto.setTipo("usuario");
                    agregado=UsuarioDAO.agregarUsuario(usuarioCompleto);

                    if (agregado) {
                    	usuarioCompleto.setInfoExtra(altura, fisico, ciudad, hijos, civil);
                    	infoExtra =UsuarioDAO.insertarInfoExtra(usuarioCompleto);
                        HttpSession sesion = request.getSession();
                        sesion.setAttribute("usuario", usuarioCompleto);
                        response.sendRedirect("ServletController");
                    } else {
                        mensajeError = "Error al registrarse en la BBDD. Vuelva a intentarlo.";
                        request.setAttribute("mensajeError", mensajeError);
                        request.getRequestDispatcher("error.jsp").forward(request,response);
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
