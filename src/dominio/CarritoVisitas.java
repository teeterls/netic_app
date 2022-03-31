package dominio;

import java.util.*;


public class CarritoVisitas {

    private HashMap<String, Integer> carrito;

    public CarritoVisitas() {
        carrito = new HashMap<String, Integer>();
    }

    public void addVisita(String usuariopublico) {

                Integer unidades = carrito.get(usuariopublico);
                if (unidades!=null)
                carrito.put(usuariopublico, unidades+1); //existente usuario
             else
                carrito.put(usuariopublico, 1); //nuevo usuario
        }


    public void removeVisita(String usuario) {
        Integer unidades = carrito.get(usuario);
        if (unidades == 1)
            carrito.remove(usuario);
        else
            carrito.put(usuario, unidades - 1);
    }

   /* public int getVisitas(Usuario usuario)
    {
        Integer unidades = carrito.get(usuario);
        if(unidades != null)
            return unidades;
        else
            return 0;
    }*/

    public void clear() {
        carrito.clear();
    }

    public Set<String> getUsuariosVisitados() {
        return carrito.keySet();
    }

    public int getVisitasTotales() {
        int total=0;
        for (Map.Entry<String, Integer> entry : carrito.entrySet()) {  // Itrate through hashmap
          total+=entry.getValue();
        }
        return total;
    }

    public HashMap<String, Integer> getMap() {
        return carrito;

    }

    public int getSize() {
        return carrito.size();
    }

    public String getMasVisitado() {
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
