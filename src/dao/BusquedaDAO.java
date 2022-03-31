package dao;

import dominio.Usuario;
import dominio.Busqueda;
import java.sql.*;
import java.time.Year;
import java.util.*;
public class BusquedaDAO {


    private static String QUERY_INICIOUSUARIO_AMBOS = "SELECT user,nombre, apellidos, fecha, ciudad, tipo_user FROM pat_3.usuario U , pat_3.usr_extra E where U.user= E.userextra and U.user!= ? and (U.preferencia=? or U.preferencia=?)";
    private static String QUERY_INICIOUSUARIO_HOMBRE = "SELECT user, nombre, apellidos, fecha, ciudad, tipo_user FROM pat_3.usuario U , pat_3.usr_extra E where U.user= E.userextra and U.user!= ? and (U.preferencia=? or U.preferencia=?) and U.sexo=\"hombre\"";
    private static String QUERY_INICIOUSUARIO_MUJER = "SELECT user, nombre, apellidos, fecha, ciudad, tipo_user FROM pat_3.usuario U , pat_3.usr_extra E where U.user= E.userextra and U.user!= ? and (U.preferencia=? or U.preferencia=?) and U.sexo=\"mujer\"";
    
    

    //recibe usuario de la sesion
    public static Collection<Usuario> InicioUsuarios(Usuario usuario) {
        Usuario u=null;
        ArrayList<Usuario> lista = new ArrayList<Usuario>();
        try {
            Conexion c = new Conexion();
            Connection con = c.getConexion();
            if (con != null) {
                if (usuario.getPreferencia().equals("hombre")) {
                    PreparedStatement ps = con.prepareStatement(QUERY_INICIOUSUARIO_HOMBRE);
                    ps.setString(1, usuario.getUser());
                    ps.setString(2, usuario.getSexo());
                    ps.setString(3, "ambos");
                    ResultSet rs = ps.executeQuery();
                    while (rs.next()) //devuelve muchos usuarios
                    {
                        String user = rs.getString("user");
                        String nombre = rs.getString("nombre");
                        String apellidos = rs.getString("apellidos");
                        String fecha = rs.getString("fecha");
                        String ciudad = rs.getString("ciudad");
                        String tipo=rs.getString("tipo_user");

                        u=new Usuario(user, nombre, apellidos, fecha, ciudad,tipo);
                        u.setImagen(UsuarioDAO.getImagenPerfil(u));
                        lista.add(u);
                    }
                    rs.close();
                    ps.close();
                } else if (usuario.getPreferencia().equals("mujer")) {
                    PreparedStatement ps = con.prepareStatement(QUERY_INICIOUSUARIO_MUJER);
                    ps.setString(1, usuario.getUser());
                    ps.setString(2, usuario.getSexo());
                    ps.setString(3, "ambos");
                    ResultSet rs = ps.executeQuery();
                    while (rs.next()) //devuelve muchos usuarios
                    {
                        String user = rs.getString("user");
                        String nombre = rs.getString("nombre");
                        String apellidos = rs.getString("apellidos");
                        String fecha = rs.getString("fecha");
                        String ciudad = rs.getString("ciudad");
                        String tipo = rs.getString("tipo_user");

                        u=new Usuario(user, nombre, apellidos, fecha, ciudad,tipo);
                        u.setImagen(UsuarioDAO.getImagenPerfil(u));
                        lista.add(u);
                    }
                    rs.close();
                    ps.close();
                } else {
                    PreparedStatement ps = con.prepareStatement(QUERY_INICIOUSUARIO_AMBOS);
                    ps.setString(1, usuario.getUser());
                    ps.setString(2, usuario.getSexo());
                    ps.setString(3, "ambos");

                    ResultSet rs = ps.executeQuery();
                    while (rs.next()) //devuelve muchos usuarios
                    {
                        String user = rs.getString("user");
                        String nombre = rs.getString("nombre");
                        String apellidos = rs.getString("apellidos");
                        String fecha = rs.getString("fecha");
                        String ciudad = rs.getString("ciudad");
                        String tipo = rs.getString("tipo_user");

                        u=new Usuario(user, nombre, apellidos, fecha, ciudad,tipo);
                        u.setImagen(UsuarioDAO.getImagenPerfil(u));
                        lista.add(u);
                    }
                    rs.close();
                    ps.close();
                }
            }
            con.close();
        } catch (SQLException e) {
            lista = null;
            e.printStackTrace();
        }
        return lista;
    }

    public static Collection<Usuario> BusquedaUsuarios(Usuario usuario, Busqueda busqueda) {
        ArrayList<Usuario> lista = new ArrayList<Usuario>();
        Usuario u=null;
        String query_busqueda = "SELECT user, nombre, apellidos, fecha, ciudad, tipo_user, user_img FROM pat_3.usuario U , pat_3.usr_extra E where U.user= E.userextra and U.user!= ? and U.sexo= ? and ( U.preferencia=? or U.preferencia=?) and ";
        ArrayList <String> params = new ArrayList<String>();
        int iBusqueda = 5;
        boolean ultimo = false;
        //sacamos la fecha de nacimiento (año) con la edad -> busqueda.getEdad1/2
        try {
            Conexion c = new Conexion();
            Connection con = c.getConexion();
            if (con != null) {
                PreparedStatement ps=null;
                if (busqueda.getCiudad()!=null){
                	query_busqueda += "E.ciudad = ?";
                	params.add(busqueda.getCiudad());
                	iBusqueda++;
                	ultimo = true;
                }
                if(busqueda.getFisico()!=null) {
                	if(ultimo) {
                		query_busqueda += " and ";
                	} else {
                		ultimo = true;
                	}
                	query_busqueda += "E.fisico = ?";
                	params.add(busqueda.getFisico());
                	iBusqueda++;
                }
                if(busqueda.getHijos()!=null) {
                	if(ultimo) {
                		query_busqueda += " and ";
                	} else {
                		ultimo = true;
                	}
                	query_busqueda += "E.hijos = ?";
                	params.add(busqueda.getHijos());
                	iBusqueda++;
                }
                if(busqueda.getCivil()!=null) {
                	if(ultimo) {
                		query_busqueda += " and ";
                	} else {
                		ultimo = true;
                	}
                	query_busqueda += "E.civil = ?";
                	params.add(busqueda.getCivil());
                	iBusqueda++;
                }
                if(busqueda.getAltura1()!=null && busqueda.getAltura2()!=null) {
                	if(ultimo) {
                		query_busqueda += " and ";
                	} else {
                		ultimo = true;
                	}
                	query_busqueda += "E.estatura between ? and ?";
                	params.add(busqueda.getAltura1());
                	params.add(busqueda.getAltura2());
                	iBusqueda+=2;
                }
                if(busqueda.getEdad1()!=null && busqueda.getEdad2()!=null) {
                	if(ultimo) {
                		query_busqueda += " and ";
                	} else {
                		ultimo = true;
                	}
                	int anoActual =  Year.now().getValue();
                	int anoMin = anoActual - Integer.parseInt(busqueda.getEdad1());
                	int anoMax = anoActual - Integer.parseInt(busqueda.getEdad2());

                	query_busqueda += "U.fecha between ? and ?";

                    params.add(String.valueOf(anoMax));
                	params.add(String.valueOf(anoMin));
                	iBusqueda+=2;
                }

                if (busqueda.getAficiones()!=null) {
                    if (ultimo) {
                        query_busqueda += " and ";
                    } else {
                        ultimo = true;
                    }
                    String[] aficiones = busqueda.getAficiones();
                    //1 o 2 aficiones solamente permitidas
                    if (aficiones.length == 1) {
                        query_busqueda += "U.descripcion like ?";
                        params.add("%" + aficiones[0].substring(0,4) + "%");
                        iBusqueda++;
                    } else
                    {
                        query_busqueda += "U.descripcion like ? and U.descripcion like ? ";
                        params.add("%"+ aficiones[0].substring(0,4) + "%");
                        params.add("%"+ aficiones[1].substring(0,4) + "%");
                        iBusqueda+=2;
                    }

                }
                ps = con.prepareStatement(query_busqueda);
                ps.setString(1, usuario.getUser());
                ps.setString(2, usuario.getPreferencia());
                ps.setString(3, usuario.getSexo());
                ps.setString(4,"ambos");
                for(int i = 5; i < iBusqueda; i++) {
                	ps.setString(i, params.get(i-5));
                }
                ResultSet rs = ps.executeQuery();
                while (rs.next()) //devuelve muchos usuarios
                {
                    String user = rs.getString("user");
                    String nombre = rs.getString("nombre");
                    String apellidos = rs.getString("apellidos");
                    String fecha = rs.getString("fecha");
                    String ciudad = rs.getString("ciudad");
                    String tipo = rs.getString("tipo_user");

                    u=new Usuario(user, nombre, apellidos, fecha, ciudad,tipo);
                    u.setImagen(UsuarioDAO.getImagenPerfil(u));
                    lista.add(u);
                }
                rs.close();
                ps.close();


             
            }
            con.close();

        }catch (SQLException e) {
            lista = null;
            e.printStackTrace();
        }
        return lista;
    }









}

