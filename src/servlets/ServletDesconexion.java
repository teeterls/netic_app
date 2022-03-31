package servlets;

import dao.*;
import dominio.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.*;
import java.util.Date;
import java.util.Set;


public class ServletDesconexion extends HttpServlet {
    private static final long serialVersionUID= 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sesion = request.getSession();
        int visitas=0;
        int busquedas=0;
        int likes=0;
        int mensajes=0;
        String masvisitado=null;
        String mascontactado=null;
        String likeados=null;
        String visitados= null;
        String contactados=null;

        if (sesion.getAttribute("carritovisitas")==null && sesion.getAttribute("carritobusquedas")==null && sesion.getAttribute("carritolikes")==null && sesion.getAttribute("carritomensajes")==null)
        {
            sesion.invalidate();
            response.sendRedirect("index.html");
        }else
            {
                //comun para todos los casos
                Usuario usuario = (Usuario) sesion.getAttribute("usuario");
                String user = usuario.getUser();
                

                if (sesion.getAttribute("carritovisitas")!=null)
                {
                    CarritoVisitas cv = (CarritoVisitas) sesion.getAttribute("carritovisitas");
                    visitas = cv.getVisitasTotales();
                    masvisitado = cv.getMasVisitado();
                    visitados = cv.getUsuariosVisitados().toString();

                }
                if (sesion.getAttribute("carritobusquedas")!=null)
                {
                    CarritoBusquedas cb = (CarritoBusquedas) sesion.getAttribute("carritobusquedas");
                    busquedas = cb.getSize();
                }
                if (sesion.getAttribute("carritolikes")!=null)
                {
                    CarritoLikes cl = (CarritoLikes) sesion.getAttribute("carritolikes");
                    likes = cl.getSize();
                    likeados = cl.getUsuariosLikes().toString();
                }
                if (sesion.getAttribute("carritomensajes")!=null)
                {
                    CarritoMensajes cm = (CarritoMensajes) sesion.getAttribute("carritomensajes");
                    mensajes = cm.getMensajesTotales();
                    mascontactado = cm.getMasContactado();
                    contactados = cm.getUsuariosMensajes().toString();

                }


               /* if (sesion.getAttribute("carritovisitas")!=null && sesion.getAttribute("carritobusquedas")!=null && sesion.getAttribute("carritolikes")!=null && sesion.getAttribute("carritomensajes")!=null) {
                    CarritoVisitas cv = (CarritoVisitas) sesion.getAttribute("carritovisitas");
                    CarritoBusquedas cb = (CarritoBusquedas) sesion.getAttribute("carritobusquedas");
                    CarritoLikes cl = (CarritoLikes) sesion.getAttribute("carritolikes");
                    CarritoMensajes cm = (CarritoMensajes) sesion.getAttribute("carritomensajes");


                    visitas = cv.getVisitasTotales();
                    busquedas = cb.getSize();
                    likes = cl.getSize();
                    mensajes = cm.getMensajesTotales();
                    masvisitado = cv.getMasVisitado();
                    mascontactado = cm.getMasContactado();
                    likeados = cl.getUsuariosLikes().toString();
                    visitados = cv.getUsuariosVisitados().toString();
                    contactados = cm.getUsuariosMensajes().toString();
                }*/

                //GUARDAR DAO LA ACTIVIDAD DEL USUARIO

            boolean agregado;
            String mensajeError = "";

            agregado = AdminDAO.agregarActividad(user, visitas, busquedas, likes, mensajes, masvisitado,mascontactado,likeados,contactados,visitados);
            if (agregado) {
                sesion.invalidate();
                response.sendRedirect("index.html");
            } else {
                mensajeError = "No ha sido posible cerrar sesión, inténtelo de nuevo";
                request.setAttribute("mensajeError", mensajeError);
                request.getRequestDispatcher("errorbusqueda.jsp").forward(request, response);
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
