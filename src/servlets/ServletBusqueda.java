package servlets;

import dominio.Usuario;
import dominio.Busqueda;
import dao.UsuarioDAO;
import dao.BusquedaDAO;
import servicios.CarritoServicio;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.Year;
import java.util.*;

import static java.lang.Integer.parseInt;

//tratar con imagenes.
@MultipartConfig
@WebServlet(name="ServletBusqueda")

public class ServletBusqueda extends HttpServlet {
    private static final long serialVersionUID= 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException, ClassNotFoundException {

        String mensajeError = "";
        HttpSession sesion = request.getSession();
        Usuario usuario = (Usuario) sesion.getAttribute("usuario"); //obtener usuario
        Busqueda busqueda = null;
        int secuencia = 0;

        if (usuario == null) {
            mensajeError = "No se ha registrado ni ha accedido";
            request.setAttribute("mensajeError", mensajeError);
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }

        if (request.getParameter("secbusqueda") != null) {
            secuencia = Integer.parseInt(request.getParameter("secbusqueda")); //convertir a numero
            //busquedas según el caso de la secuencia
            if (request.getParameter("guardar") != null) {
                busqueda = new Busqueda(); //nueva instancia, la usaremos para ir rellenando con getters, y setters
                String edad1 = request.getParameter("edad1");
                String edad2 = request.getParameter("edad2");
                String ciudad = request.getParameter("ciudad");
                String altura1 = request.getParameter("altura1");
                String altura2 = request.getParameter("altura2");
                String hijos = request.getParameter("hijos");
                String estadocivil = request.getParameter("estadocivil");
                String fisico = request.getParameter("fisico");
                String[] aficiones = request.getParameterValues("aficiones"); //devuelve un vector porque check multiple
                    busqueda.setSecuencia(secuencia);
                if (secuencia == 1) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                }
                if (secuencia == 2) {
                    busqueda.setCiudad(ciudad);
                }
                if (secuencia == 3) {
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                }
                if (secuencia == 4) {
                    busqueda.setHijos(hijos);
                }
                if (secuencia == 5) {
                    busqueda.setCivil(estadocivil);
                }
                if (secuencia == 6) {
                    busqueda.setFisico(fisico);
                }
                if (secuencia == 7) {
                    busqueda.setAficiones(aficiones);
                }
                if (secuencia == 8) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCiudad(ciudad);

                }
                if (secuencia == 9) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);

                }
                if (secuencia == 10) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setHijos(hijos);

                }
                if (secuencia == 11) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCivil(estadocivil);
                }
                if (secuencia == 12) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setFisico(fisico);
                }
                if (secuencia == 13) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setAficiones(aficiones);
                }
                if (secuencia == 14) {
                    busqueda.setCiudad(ciudad);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                }
                if (secuencia == 15) {
                    busqueda.setCiudad(ciudad);
                    busqueda.setHijos(hijos);
                }
                if (secuencia == 16) {
                    busqueda.setCiudad(ciudad);
                    busqueda.setCivil(estadocivil);
                }
                if (secuencia == 17) {
                    busqueda.setCiudad(ciudad);
                    busqueda.setFisico(fisico);

                }
                if (secuencia == 18) {
                    busqueda.setCiudad(ciudad);
                    busqueda.setAficiones(aficiones);
                }
                if (secuencia == 19) {
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setHijos(hijos);
                }
                if (secuencia == 20) {
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setCivil(estadocivil);
                }
                if (secuencia == 21) {
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setFisico(fisico);
                }
                if (secuencia == 22) {
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setAficiones(aficiones);
                }
                if (secuencia == 23) {
                    busqueda.setHijos(hijos);
                    busqueda.setCivil(estadocivil);
                }
                if (secuencia == 24) {
                    busqueda.setHijos(hijos);
                    busqueda.setFisico(fisico);
                }
                if (secuencia == 25) {
                    busqueda.setHijos(hijos);
                    busqueda.setAficiones(aficiones);
                }
                if (secuencia == 26) {
                    busqueda.setCivil(estadocivil);
                    busqueda.setFisico(fisico);
                }
                if (secuencia == 27) {
                    busqueda.setCivil(estadocivil);
                    busqueda.setAficiones(aficiones);
                }
                if (secuencia == 28) {
                    busqueda.setFisico(fisico);
                    busqueda.setAficiones(aficiones);
                }
                if (secuencia == 29) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCiudad(ciudad);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                }
                if (secuencia == 30) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCiudad(ciudad);
                    busqueda.setHijos(hijos);
                }
                if (secuencia == 31) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCiudad(ciudad);
                    busqueda.setCivil(estadocivil);
                }
                if (secuencia == 32) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCiudad(ciudad);
                    busqueda.setFisico(fisico);
                }
                if (secuencia == 33) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCiudad(ciudad);
                    busqueda.setAficiones(aficiones);
                }

                if (secuencia == 34) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura1(altura2);
                    busqueda.setHijos(hijos);

                }
                if (secuencia == 35) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura1(altura2);
                    busqueda.setCivil(estadocivil);
                }
                if (secuencia == 36) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura1(altura2);
                    busqueda.setFisico(fisico);
                }
                if (secuencia == 37) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura1(altura2);
                    busqueda.setAficiones(aficiones);

                }
                if (secuencia == 38) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setHijos(hijos);
                    busqueda.setCivil(estadocivil);

                }
                if (secuencia == 39) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setHijos(hijos);
                    busqueda.setFisico(fisico);
                }
                if (secuencia == 40) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setHijos(hijos);
                    busqueda.setAficiones(aficiones);
                }
                if (secuencia == 41) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCivil(estadocivil);
                    busqueda.setFisico(fisico);

                }
                if (secuencia == 42) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCivil(estadocivil);
                    busqueda.setAficiones(aficiones);

                }
                if (secuencia == 43) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setFisico(fisico);
                    busqueda.setAficiones(aficiones);
                }
                if (secuencia == 44) {
                    busqueda.setCiudad(ciudad);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setHijos(hijos);

                }
                if (secuencia == 45) {
                    busqueda.setCiudad(ciudad);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setCivil(estadocivil);
                }
                if (secuencia == 46) {
                    busqueda.setCiudad(ciudad);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setFisico(fisico);
                }
                if (secuencia == 47) {
                    busqueda.setCiudad(ciudad);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setAficiones(aficiones);
                }
                if (secuencia == 48) {
                    busqueda.setCiudad(ciudad);
                    busqueda.setHijos(hijos);
                    busqueda.setCivil(estadocivil);

                }
                if (secuencia == 49) {
                    busqueda.setCiudad(ciudad);
                    busqueda.setHijos(hijos);
                    busqueda.setFisico(fisico);

                }
                if (secuencia == 50) {
                    busqueda.setCiudad(ciudad);
                    busqueda.setHijos(hijos);
                    busqueda.setAficiones(aficiones);

                }
                if (secuencia == 51) {
                    busqueda.setCiudad(ciudad);
                    busqueda.setCivil(estadocivil);
                    busqueda.setFisico(fisico);
                }
                if (secuencia == 52) {
                    busqueda.setCiudad(ciudad);
                    busqueda.setCivil(estadocivil);
                    busqueda.setAficiones(aficiones);
                }
                if (secuencia == 53) {
                    busqueda.setCiudad(ciudad);
                    busqueda.setFisico(fisico);
                    busqueda.setAficiones(aficiones);

                }
                if (secuencia == 54) {
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setHijos(hijos);
                    busqueda.setCivil(estadocivil);

                }
                if (secuencia == 55) {
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setHijos(hijos);
                    busqueda.setFisico(fisico);
                }
                if (secuencia == 56) {
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setHijos(hijos);
                    busqueda.setAficiones(aficiones);

                }
                if (secuencia == 57) {
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setCivil(estadocivil);
                    busqueda.setFisico(fisico);
                }
                if (secuencia == 58) {
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setCivil(estadocivil);
                    busqueda.setAficiones(aficiones);
                }
                if (secuencia == 59) {
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setFisico(fisico);
                    busqueda.setAficiones(aficiones);

                }
                if (secuencia == 60) {
                    busqueda.setHijos(hijos);
                    busqueda.setCivil(estadocivil);
                    busqueda.setFisico(fisico);

                }
                if (secuencia == 61) {

                    busqueda.setHijos(hijos);
                    busqueda.setCivil(estadocivil);
                    busqueda.setAficiones(aficiones);

                }
                if (secuencia == 62) {
                    busqueda.setHijos(hijos);
                    busqueda.setFisico(fisico);
                    busqueda.setAficiones(aficiones);
                }

                if (secuencia == 63) {
                    busqueda.setCivil(estadocivil);
                    busqueda.setFisico(fisico);
                    busqueda.setAficiones(aficiones);

                }
                if (secuencia == 64) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCiudad(ciudad);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setHijos(hijos);

                }
                if (secuencia == 65) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCiudad(ciudad);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setCivil(estadocivil);
                }
                if (secuencia == 66) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCiudad(ciudad);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setFisico(fisico);


                }
                if (secuencia == 67) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCiudad(ciudad);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setAficiones(aficiones);

                }
                if (secuencia == 68) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCiudad(ciudad);
                    busqueda.setHijos(hijos);
                    busqueda.setCivil(estadocivil);
                }
                if (secuencia == 69) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCiudad(ciudad);
                    busqueda.setHijos(hijos);
                    busqueda.setFisico(fisico);
                }
                if (secuencia == 70) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCiudad(ciudad);
                    busqueda.setHijos(hijos);
                    busqueda.setAficiones(aficiones);
                }
                if (secuencia == 71) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCiudad(ciudad);
                    busqueda.setCivil(estadocivil);
                    busqueda.setFisico(fisico);
                }
                if (secuencia == 72) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCiudad(ciudad);
                    busqueda.setCivil(estadocivil);
                    busqueda.setAficiones(aficiones);
                }
                if (secuencia == 73) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCiudad(ciudad);
                    busqueda.setFisico(fisico);
                    busqueda.setAficiones(aficiones);
                }
                if (secuencia == 74) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setHijos(hijos);
                    busqueda.setCivil(estadocivil);

                }
                if (secuencia == 75) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setHijos(hijos);
                    busqueda.setFisico(fisico);
                }
                if (secuencia == 76) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setHijos(hijos);
                    busqueda.setAficiones(aficiones);
                }
                if (secuencia == 77) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setCivil(estadocivil);
                    busqueda.setFisico(fisico);


                }
                if (secuencia == 78) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setCivil(estadocivil);
                    busqueda.setAficiones(aficiones);

                }
                if (secuencia == 79) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setFisico(fisico);
                    busqueda.setAficiones(aficiones);
                }
                if (secuencia == 80) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setHijos(hijos);
                    busqueda.setCivil(estadocivil);
                    busqueda.setFisico(fisico);
                }
                if (secuencia == 81) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setHijos(hijos);
                    busqueda.setCivil(estadocivil);
                    busqueda.setAficiones(aficiones);

                }
                if (secuencia == 82) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setHijos(hijos);
                    busqueda.setFisico(fisico);
                    busqueda.setAficiones(aficiones);

                }
                if (secuencia == 83) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCivil(estadocivil);
                    busqueda.setFisico(fisico);
                    busqueda.setAficiones(aficiones);

                }
                if (secuencia == 84) {
                    busqueda.setCiudad(ciudad);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setHijos(hijos);
                    busqueda.setCivil(estadocivil);
                }
                if (secuencia == 85) {
                    busqueda.setCiudad(ciudad);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setHijos(hijos);
                    busqueda.setFisico(fisico);
                }
                if (secuencia == 86) {
                    busqueda.setCiudad(ciudad);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setHijos(hijos);
                    busqueda.setAficiones(aficiones);
                }
                if (secuencia == 87) {
                    busqueda.setCiudad(ciudad);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setCivil(estadocivil);
                    busqueda.setFisico(fisico);

                }
                if (secuencia == 88) {
                    busqueda.setCiudad(ciudad);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setCivil(estadocivil);
                    busqueda.setAficiones(aficiones);
                }
                if (secuencia == 89) {
                    busqueda.setCiudad(ciudad);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setFisico(fisico);
                    busqueda.setAficiones(aficiones);

                }
                if (secuencia == 90) {
                    busqueda.setCiudad(ciudad);
                    busqueda.setHijos(hijos);
                    busqueda.setCivil(estadocivil);
                    busqueda.setFisico(fisico);
                }
                if (secuencia == 91) {
                    busqueda.setCiudad(ciudad);
                    busqueda.setHijos(hijos);
                    busqueda.setCivil(estadocivil);
                    busqueda.setAficiones(aficiones);
                }
                if (secuencia == 92) {
                    busqueda.setCiudad(ciudad);
                    busqueda.setHijos(hijos);
                    busqueda.setFisico(fisico);
                    busqueda.setAficiones(aficiones);
                }
                if (secuencia == 93) {
                    busqueda.setCiudad(ciudad);
                    busqueda.setCivil(estadocivil);
                    busqueda.setFisico(fisico);
                    busqueda.setAficiones(aficiones);
                }
                if (secuencia == 94) {
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setHijos(hijos);
                    busqueda.setCivil(estadocivil);
                    busqueda.setFisico(fisico);
                }
                if (secuencia == 95) {
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setHijos(hijos);
                    busqueda.setCivil(estadocivil);
                    busqueda.setAficiones(aficiones);
                }
                if (secuencia == 96) {
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setHijos(hijos);
                    busqueda.setFisico(fisico);
                    busqueda.setAficiones(aficiones);
                }
                if (secuencia == 97) {
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setCivil(estadocivil);
                    busqueda.setFisico(fisico);
                    busqueda.setAficiones(aficiones);

                }
                if (secuencia == 98) {
                    busqueda.setHijos(hijos);
                    busqueda.setCivil(estadocivil);
                    busqueda.setFisico(fisico);
                    busqueda.setAficiones(aficiones);
                }

                if (secuencia == 99) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCiudad(ciudad);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setHijos(hijos);
                    busqueda.setCivil(estadocivil);

                }
                if (secuencia == 100) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCiudad(ciudad);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setHijos(hijos);
                    busqueda.setFisico(fisico);

                }
                if (secuencia == 101) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCiudad(ciudad);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setHijos(hijos);
                    busqueda.setAficiones(aficiones);

                }
                if (secuencia == 102) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCiudad(ciudad);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setCivil(estadocivil);
                    busqueda.setFisico(fisico);
                }
                if (secuencia == 103) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCiudad(ciudad);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setCivil(estadocivil);
                    busqueda.setAficiones(aficiones);

                }
                if (secuencia == 104) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCiudad(ciudad);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setFisico(fisico);
                    busqueda.setAficiones(aficiones);

                }
                if (secuencia == 105) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCiudad(ciudad);
                    busqueda.setHijos(hijos);
                    busqueda.setCivil(estadocivil);
                    busqueda.setFisico(fisico);


                }
                if (secuencia == 106) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCiudad(ciudad);
                    busqueda.setHijos(hijos);
                    busqueda.setCivil(estadocivil);
                    busqueda.setAficiones(aficiones);

                }
                if (secuencia == 107) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCiudad(ciudad);
                    busqueda.setHijos(hijos);
                    busqueda.setFisico(fisico);
                    busqueda.setAficiones(aficiones);

                }
                if (secuencia == 108) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCiudad(ciudad);
                    busqueda.setCivil(estadocivil);
                    busqueda.setFisico(fisico);
                    busqueda.setAficiones(aficiones);

                }
                if (secuencia == 109) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setHijos(hijos);
                    busqueda.setCivil(estadocivil);
                    busqueda.setFisico(fisico);


                }
                if (secuencia == 110) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setHijos(hijos);
                    busqueda.setCivil(estadocivil);
                    busqueda.setAficiones(aficiones);

                }
                if (secuencia == 111) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setCivil(estadocivil);
                    busqueda.setFisico(fisico);
                    busqueda.setAficiones(aficiones);

                }
                if (secuencia == 112) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setHijos(hijos);
                    busqueda.setCivil(estadocivil);
                    busqueda.setFisico(fisico);
                    busqueda.setAficiones(aficiones);

                }
                if (secuencia == 113) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setHijos(hijos);
                    busqueda.setFisico(fisico);
                    busqueda.setAficiones(aficiones);

                }
                if (secuencia == 114) {
                    busqueda.setCiudad(ciudad);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setHijos(hijos);
                    busqueda.setCivil(estadocivil);
                    busqueda.setFisico(fisico);


                }
                if (secuencia == 115) {
                    busqueda.setCiudad(ciudad);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setHijos(hijos);
                    busqueda.setCivil(estadocivil);
                    ;
                    busqueda.setAficiones(aficiones);

                }
                if (secuencia == 116) {
                    busqueda.setCiudad(ciudad);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setHijos(hijos);
                    busqueda.setFisico(fisico);
                    busqueda.setAficiones(aficiones);

                }
                if (secuencia == 117) {
                    busqueda.setCiudad(ciudad);
                    busqueda.setHijos(hijos);
                    busqueda.setCivil(estadocivil);
                    busqueda.setFisico(fisico);
                    busqueda.setAficiones(aficiones);

                }
                if (secuencia == 118) {
                    busqueda.setCiudad(ciudad);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setCivil(estadocivil);
                    busqueda.setFisico(fisico);
                    busqueda.setAficiones(aficiones);

                }
                if (secuencia == 119) {

                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setHijos(hijos);
                    busqueda.setCivil(estadocivil);
                    busqueda.setFisico(fisico);
                    busqueda.setAficiones(aficiones);

                }
                if (secuencia == 120) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCiudad(ciudad);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setHijos(hijos);
                    busqueda.setCivil(estadocivil);
                    busqueda.setFisico(fisico);
                }

                if (secuencia == 121) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCiudad(ciudad);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setHijos(hijos);
                    busqueda.setCivil(estadocivil);
                    busqueda.setAficiones(aficiones);
                }

                if (secuencia == 122) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCiudad(ciudad);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setHijos(hijos);
                    busqueda.setFisico(fisico);
                    busqueda.setAficiones(aficiones);
                }
                if (secuencia == 123) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCiudad(ciudad);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setCivil(estadocivil);
                    busqueda.setFisico(fisico);
                    busqueda.setAficiones(aficiones);
                }
                if (secuencia == 124) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCiudad(ciudad);
                    busqueda.setHijos(hijos);
                    busqueda.setCivil(estadocivil);
                    busqueda.setFisico(fisico);
                    busqueda.setAficiones(aficiones);
                }
                if (secuencia == 125) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setHijos(hijos);
                    busqueda.setCivil(estadocivil);
                    busqueda.setFisico(fisico);
                    busqueda.setAficiones(aficiones);
                }
                if (secuencia == 126) {

                    busqueda.setCiudad(ciudad);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setHijos(hijos);
                    busqueda.setCivil(estadocivil);
                    busqueda.setFisico(fisico);
                    busqueda.setAficiones(aficiones);
                }
                if (secuencia == 127) {
                    busqueda.setEdad1(edad1);
                    busqueda.setEdad2(edad2);
                    busqueda.setCiudad(ciudad);
                    busqueda.setAltura1(altura1);
                    busqueda.setAltura2(altura2);
                    busqueda.setHijos(hijos);
                    busqueda.setCivil(estadocivil);
                    busqueda.setFisico(fisico);
                    busqueda.setAficiones(aficiones);
                }

                //collection que se muestra en principal-> pestaña busqueda
                Collection<Usuario> usuariosbusqueda = null;
                usuariosbusqueda = BusquedaDAO.BusquedaUsuarios(usuario, busqueda);
                if (usuariosbusqueda != null) {
                    for (Usuario u : usuariosbusqueda) //recorrer el vector de usuarios
                    {

                        Collection<String> cookiesOrdenadas = (Collection<String>)request.getSession().getAttribute("cookiesBusqueda");
                        if(cookiesOrdenadas==null){
                            Cookie cookies[] = request.getCookies();
                            cookiesOrdenadas = new TreeSet<String>();
                            if(cookies!=null)
                            {
                                for(Cookie c:cookies)
                                {
                                    if(c.getName().equals("usuariosBuscados"))
                                    {
                                        String usuariosBuscados = c.getValue();
                                        String palabras[] = usuariosBuscados.split(":");
                                        for(String palabra:palabras)
                                            cookiesOrdenadas.add(palabra);
                                    }
                                }
                                request.getSession().setAttribute("cookiesBusqueda", cookiesOrdenadas);
                            }
                        }


                            cookiesOrdenadas.add(u.getUser().toLowerCase());

                            StringBuffer cookieSB = new StringBuffer();
                            for(String b:cookiesOrdenadas)
                                cookieSB.append(b + ":");

                            cookieSB.deleteCharAt(cookieSB.length()-1);

                            Cookie cookieBusqueda = new Cookie("usuariosBuscados", cookieSB.toString());

                            cookieBusqueda.setHttpOnly(true);
                            cookieBusqueda.setPath("/");
                            cookieBusqueda.setMaxAge(Integer.MAX_VALUE);
                            response.addCookie(cookieBusqueda);

                        int fecha = Integer.parseInt(u.getFecha().substring(0, 4)); //YYYY-MM-DD
                        int year = Year.now().getValue();
                        u.setFecha(String.valueOf(year - fecha));
                    }
                }

                //carrito busqueda en el momento en el que se guarda la busqueda!!
                new CarritoServicio(request).guardar(busqueda, usuariosbusqueda);


                request.setAttribute("usuariosbusqueda", usuariosbusqueda);
                sesion.setAttribute("usuariosbusqueda", usuariosbusqueda);
                response.sendRedirect("ServletController");
            }
        }

        }









    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            processRequest(request,response);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            processRequest(request,response);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}
