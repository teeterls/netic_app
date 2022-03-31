package servicios;
import dominio.*;
import dao.*;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import java.sql.SQLException;
import javax.servlet.http.HttpSession;

public class CarritoServicio {

    private HttpServletRequest request;
    private CarritoBusquedas cbusquedas;
    private CarritoLikes clikes;
    private CarritoMensajes cmensajes;
    private CarritoVisitas cvisitas;

    public CarritoServicio (HttpServletRequest request)
    {
        this.request = request;
        cbusquedas = this.getCarritoBusquedas();
        clikes=this.getCarritoLikes();
        cmensajes=this.getCarritoMensajes();
        cvisitas= this.getCarritoVisitas();

    }

    private CarritoBusquedas getCarritoBusquedas()
    {
        HttpSession sesion = request.getSession();
        cbusquedas = (CarritoBusquedas) sesion.getAttribute("carritobusquedas");

        if (cbusquedas==null)
        {
            cbusquedas= new CarritoBusquedas();
            sesion.setAttribute("carritobusquedas", cbusquedas);
        }

        return cbusquedas;
    }

    public void setCarritoBusquedas(CarritoBusquedas cbusquedas) {
        this.cbusquedas = cbusquedas;
    }

    public CarritoLikes getCarritoLikes() {
        HttpSession sesion = request.getSession();
        clikes = (CarritoLikes) sesion.getAttribute("carritolikes");

        if (clikes==null)
        {
            clikes= new CarritoLikes();
            sesion.setAttribute("carritolikes", clikes);
        }

        return clikes;
    }

    public void setCarritoLikes(CarritoLikes clikes) {
        this.clikes = clikes;
    }

    public CarritoMensajes getCarritoMensajes() {
        HttpSession sesion = request.getSession();
        cmensajes = (CarritoMensajes) sesion.getAttribute("carritomensajes");

        if (cmensajes==null)
        {
            cmensajes= new CarritoMensajes();
            sesion.setAttribute("carritomensajes", cmensajes);
        }

        return cmensajes;
    }

    public void setCarritoMensajes(CarritoMensajes cmensajes) {
        this.cmensajes = cmensajes;
    }

    public CarritoVisitas getCarritoVisitas() {

        HttpSession sesion = request.getSession();
        cvisitas = (CarritoVisitas) sesion.getAttribute("carritovisitas");

        if (cvisitas==null)
        {
            cvisitas= new CarritoVisitas();
            sesion.setAttribute("carritovisitas", cvisitas);
        }

        return cvisitas;
    }


    public void setCarritoVisitas(CarritoVisitas cvisitas) {
        this.cvisitas = cvisitas;
    }

    //distintos servicios de los carritos, segun su funcionalidad
    public void visitar (String usuariopublico) throws ClassNotFoundException, SQLException
    {
        getCarritoVisitas().addVisita(usuariopublico);
    }
    public void guardar (Busqueda busqueda, Collection<Usuario> usuariosbusqueda) throws ClassNotFoundException, SQLException
    {
        getCarritoBusquedas().addBusqueda(busqueda, usuariosbusqueda);
    }

    public void gustar (String usuariopublico)
    {
        getCarritoLikes().addLike(usuariopublico);
    }

    public void escribir (String usuariopublico)
    {
        getCarritoMensajes().addMensaje(usuariopublico);
    }



}
