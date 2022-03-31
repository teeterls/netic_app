package dominio;

import java.util.*;

public class CarritoBusquedas {
    private HashMap<Busqueda, Collection<Usuario>> carrito;

    public CarritoBusquedas ()
    {
        carrito = new HashMap <Busqueda, Collection<Usuario>>();
    }

   public void addBusqueda(Busqueda busqueda, Collection<Usuario> usuariosbusqueda)
    {

        carrito.put(busqueda, usuariosbusqueda); //añade nueva busqueda con los usuarios
    }

    public void removeBusqueda(Busqueda busqueda)
    {
        carrito.remove(busqueda); //borra par key value
    }


    public void clear()
    {
        carrito.clear(); //borra el map entero
    }

    public Set<Busqueda> getBusquedas()
    {
        return carrito.keySet(); //muestra busquedas
    }

    public Collection<Collection<Usuario>> getUsuariosBuscados()
    {
        return carrito.values(); //muestra usuarios buscados
    }

    public HashMap <Busqueda, Collection <Usuario>> getMap()
    {
        return carrito;
    }

    public int getSize()
    {
        return carrito.size();
    }
}
