package dominio;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class CarritoLikes {

    private HashMap <String, Integer> carrito;

    public CarritoLikes ()
    {
        carrito = new HashMap <String, Integer>();
    }

    public void addLike(String usuario)
    {
       carrito.put(usuario,1);
    }

    public void removeLike(String usuario)
    {
       carrito.remove(usuario);
    }


    public void clear()
    {
        carrito.clear();
    }

    public Set<String> getUsuariosLikes()
    {
        return carrito.keySet();
    }


    public HashMap <String, Integer> getMap()
    {
        return carrito;
    }

    public int getSize()
    {
        return carrito.size();
    }
}
