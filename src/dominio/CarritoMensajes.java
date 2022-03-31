package dominio;

import java.util.*;

public class CarritoMensajes {
    private HashMap<String, Integer> carrito;

    public CarritoMensajes ()
    {
        carrito = new HashMap <String, Integer>();
    }

    public void addMensaje(String usuario)
    {
        Integer unidades = carrito.get(usuario);
        if(unidades!=null)
            carrito.put(usuario, unidades + 1);
        else
            carrito.put(usuario, 1);
    }

    public void removeMensaje(String usuario)
    {
        Integer unidades = carrito.get(usuario);
        if(unidades==1)
            carrito.remove(usuario);
        else
            carrito.put(usuario, unidades - 1);
    }

    public int getMensajes(String usuario)
    {
        Integer unidades = carrito.get(usuario);
        if(unidades != null)
            return unidades;
        else
            return 0;
    }

    public void clear()
    {
        carrito.clear();
    }

    public Set<String> getUsuariosMensajes()
    {
        return carrito.keySet();
    }

    public int getMensajesTotales()
    {
        int total=0;
        for (Map.Entry<String, Integer> entry : carrito.entrySet()) {  // Itrate through hashmap
            total+=entry.getValue();
        }
        return total;
    }

    public HashMap <String, Integer> getMap()
    {
        return carrito;
    }

    public int getSize()
    {
        return carrito.size();
    }

    public String getMasContactado() {
        String buscado = null;
        if(carrito.values()!=null && carrito.size()>0) {
        	int maxValueInMap = (Collections.max(carrito.values()));  // This will return max value in the Hashmap
            for (Map.Entry<String, Integer> entry : carrito.entrySet()) {  // Itrate through hashmap
                if (entry.getValue() == maxValueInMap) {
                    buscado = entry.getKey();
                }
            }
        }

        return buscado;
    }
}
