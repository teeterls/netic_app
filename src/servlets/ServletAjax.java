package servlets;

import dao.AdminDAO;
import dao.UsuarioDAO;
import dominio.*;
import dominio.Usuario;
import servicios.CarritoServicio;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@MultipartConfig

public class ServletAjax extends HttpServlet {
    private static final long serialVersionUID= 1L;
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       String mensajeError="";
        HttpSession sesion = request.getSession();
        Usuario usuario = (Usuario) sesion.getAttribute("usuario");  //devuelve usuario completo
        if (usuario == null) {
            mensajeError = "No se ha registrado ni ha accedido";
            request.setAttribute("mensajeError", mensajeError);
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }


        //PARTE AJAX QUE NO REDIRIJE A NINGUNA PARTE
        String opcion = request.getParameter("opcion");

        String user= request.getParameter("user"); //nombre user
       // System.out.println(opcion);
        if (opcion != null) {
            if (opcion.equals("like"))
            {
                response.getWriter().print("Acabas de dar 1 like!");
                if (user!=null) {
                    new CarritoServicio(request).gustar(user);
                }
            } else if (opcion.equals("msg"))
            {
                response.getWriter().print("Acabas de enviar 1 mensaje!");
                if (user!=null) {
                    new CarritoServicio(request).escribir(user);
                }
            }

        //OPCIONES DE BORRAR CARRITOS EN EL LISTADO
            if (opcion.equals("borrarvisitas"))
            {
                CarritoVisitas cv= (CarritoVisitas) sesion.getAttribute("carritovisitas");
                cv.clear();
                sesion.removeAttribute("carritovisitas");

            }
            if (opcion.equals("borrarbusquedas"))
            {
                CarritoBusquedas cb= (CarritoBusquedas) sesion.getAttribute("carritobusquedas");
                cb.clear();
                sesion.removeAttribute("carritobusquedas");
            }
            if (opcion.equals("borrarlikes"))
            {
                CarritoLikes cl= (CarritoLikes) sesion.getAttribute("carritolikes");
                cl.clear();
                sesion.removeAttribute("carritolikes");
            }
            if (opcion.equals("borrarmensajes"))
            {
                CarritoMensajes cm= (CarritoMensajes) sesion.getAttribute("carritomensajes");
                cm.clear();
                sesion.removeAttribute("carritomensajes");
            }
            if (opcion.equals("borrarestadisticas"))
            {
               boolean borrado= AdminDAO.borrarActividad();
               if (borrado==false)
               {
                   mensajeError = "No se ha podido borrar la actividad";
                   request.setAttribute("mensajeError", mensajeError);
                   request.getRequestDispatcher("errorbusqueda.jsp").forward(request, response);
               }

            }

        }



    }
}
